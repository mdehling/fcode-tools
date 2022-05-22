/**
 * FCode detokenizer.
 *
 * Copyright (C) 2022 Malte Dehling.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "detokenize.h"

#include "ast.h"
#include "fcode.h"
#include "fstring.h"
#include "compat_asprintf.h"


#define FCODE8(x)       (fcode[(x)])
#define FCODE16(x)      (FCODE8(x)<<8|FCODE8(x+1))
#define FCODE32(x)      (FCODE16(x)<<16|FCODE16(x+2))


/**
 * Detokenize FCode and construct its AST representation.
 *
 * @param fcode     Pointer to the FCode.
 *
 * @return          The AST representation of the FCode.
 */
ast_t *detokenize(uint8_t *fcode) {
    ast_t *T0, **Tp;

    uint32_t fcode_size, total_size, i = 0;
    uint32_t length;

    int16_t offset_size = 1;

    int fcode_end = 0;


    T0 = ast_new();
    Tp = &T0;


    if (fcode[0x00] == 0x55 && fcode[0x01] == 0xaa) {
        /* Note that PCI byte order is little endian! */
        ast_insert(&Tp, AST_BM_DEFAULT, AST_PCI_HEADER,
            fcode[0x20]|fcode[0x21]<<8,                 /* vendor-id */
            fcode[0x22]|fcode[0x23]<<8,                 /* device-id */
            fcode[0x29]|fcode[0x2a]<<8|fcode[0x2b]<<16, /* class-code */
            fcode[0x24]|fcode[0x25]<<8,                 /* vendor-prod-data */
            fcode[0x2e]|fcode[0x2f]<<8,                 /* code-rev */
            fcode[0x2c]|fcode[0x2d]<<8                  /* size */
            );

        i = PCI_HEADER_SIZE;
    };


    switch ( FCODE8(i+0x00) ) {

    /*
     * These indicate version 2 or 3 FCode.  I _think_ the second (magic) byte
     * should distinguish between FCode version 2 and version 3, but I can't
     * find a definitive answer in the documentation.
     *
     * Both, version 2 and version 3 use 16 bit offsets.  The startN byte
     * indicates how to read successive FCode bytes: the memory address is
     * increased by `N` between reads.  This is relevant for reading FCode but
     * it doesn't affect how we detokenize it.
     */
    case 0xf0: /* start0 */
    case 0xf1: /* start1 */
    case 0xf2: /* start2 */
    case 0xf3: /* start4 */
        offset_size = 2;

    /*
     * This is the FCode version 1 start byte.  Version 1 uses 8 bit offsets
     * by default.
     */
    case 0xfd: /* version1      fd ?? xx xx yy yy yy yy */
        fcode_size = FCODE32(i+0x04);

        ast_insert(&Tp, AST_BM_BEGIN, AST_HEADER, FCODE8(i+0x00), FCODE8(i+0x01),
            FCODE16(i+0x02), fcode_size);
        break;

    default:
        fprintf(stderr, "detokenize(): No FCode header found\n");
        return T0;
    };


    total_size = i + fcode_size;

    for (i = i + FCODE_HEADER_SIZE; i < total_size && !fcode_end; i += length) {

#ifdef DEBUG
        fprintf(stderr, "%08x: ", i);
#endif

        switch ( FCODE8(i) ) {
        case 0x00: /* end0 */
        case 0xff: /* end1 */
            ast_insert(&Tp, AST_BM_END, AST_END, FCODE8(i));

            fcode_end = 1;

            length = 1;
            break;

        case 0x10: /* literal       10 b1 b2 b3 b4 */
            ast_insert(&Tp, AST_BM_DEFAULT, AST_LITERAL, FCODE32(i+0x01));

            length = 5;
            break;

        case 0x11: /* acf           11 b1 ( b2 ) */
        {   uint16_t code = ( FCODE8(i+0x01) == 0x00 || FCODE8(i+0x01) > 0x0f
                                ? FCODE8(i+0x01) : FCODE16(i+0x01) );

            ast_insert(&Tp, AST_BM_DEFAULT, AST_ACF, code);

            length = ( code < 0x0100 ? 2 : 3 );
        };  break;

        case 0x12: /* string        12 N s1 s2 ... sN */
        {   fstring_t *fstr = (fstring_t *)&FCODE8(i+0x01);

            ast_insert(&Tp, AST_BM_DEFAULT, AST_STRING, fstr);

            length = 2 + fstr->length;
        };  break;

        case 0xb5: /* new-token */
        {   uint16_t tokcode = FCODE16(i+0x01);
            uint8_t toktype = FCODE8(i+0x03);
            char *name;

            asprintf(&name, "token-%04x", tokcode);

            ast_insert(&Tp, (toktype == 0xb7 ? AST_BM_BEGIN : AST_BM_DEFAULT),
                AST_TOKEN, TOKEN_NOHEADER, name, tokcode, toktype);

            length = 4;
        };  break;

        case 0xb6: /* named-token */
        case 0xca: /* external-token */
        {   uint8_t strlen = FCODE8(i+0x01);
            char *name = fidentifier((fstring_t *)&FCODE8(i+1));
            uint16_t tokcode = FCODE16(i+0x02+strlen);
            uint8_t toktype = FCODE8(i+2+strlen+2);

            ast_insert(&Tp, (toktype == 0xb7 ? AST_BM_BEGIN : AST_BM_DEFAULT),
                    AST_TOKEN, (FCODE8(i) == 0xb6 ? TOKEN_HEADER : TOKEN_EXTERNAL),
                    name, tokcode, toktype);

            length = 2 + strlen + 3;
        };  break;

        case 0xc2: /* ; */
            ast_insert(&Tp, AST_BM_END, AST_ENDDEF);

            length = 1;
            break;

        case 0xb1: /* <mark */
            ast_insert(&Tp, AST_BM_BEGIN, AST_BEGIN);

            length = 1;
            break;

        case 0xb2: /* >resolve */
            /* end 'if' or 'else' block with 'then' */
            ast_insert(&Tp, AST_BM_END, AST_THEN);

            length = 1;
            break;

        case 0x13: /* bbranch offset */
        {   int16_t offset = ( offset_size == 1
                    ? (int8_t)FCODE8(i+1) : (int16_t)FCODE16(i+1) );

            length = 1 + offset_size;

            if (offset > 0) {
                /* end 'if' block and start 'else' block */
                length += 1;    /* also skip >resolve */

                ast_insert(&Tp, AST_BM_END|AST_BM_BEGIN, AST_ELSE);

            } else if ( FCODE8(i+1+offset_size) == 0xb2 ) {
                /* end 'while' block with 'repeat' */
                length += 1;    /* also skip >resolve */

                ast_insert(&Tp, AST_BM_END, AST_REPEAT);

            } else if ( FCODE8(i+offset) == 0xb1 ) {
                /* target is <mark: end 'begin' block with 'again' */

                ast_insert(&Tp, AST_BM_END, AST_AGAIN);

            } else {
                fprintf(stderr, "detokenize(): Block error (bbranch)\n");
                fprintf(stderr, "-> i = %#.4x, offset = %#.2x, "
                        "FCODE8(i+offset) = %#.2x\n",
                        i, offset, FCODE8(i+offset));
                exit(EXIT_FAILURE);
            };

        };  break;

        case 0x14: /* b?branch offset */
        {   int16_t offset = ( offset_size == 1
                    ? (int8_t)FCODE8(i+1) : (int16_t)FCODE16(i+1) );

            length = 1 + offset_size;

#ifdef DEBUG
            fprintf(stderr, "offset=%04x ", offset & 0xffff);
#endif

            if (offset < 0) {
                /* end 'begin' block with 'until' */
                ast_insert(&Tp, AST_BM_END, AST_UNTIL);

            } else if (FCODE8(i+offset) == 0xb2) {
                int16_t offset2 = ( offset_size == 1
                        ? (int8_t)FCODE8(i+offset-1)
                        : (int16_t)FCODE16(i+offset-2) );

#ifdef DEBUG
                fprintf(stderr, "offset2=%04x ", offset2 & 0xffff);
#endif

                /*
                 * This is a heuristic / BUG!
                 *
                 * To decide if the current 'b?branch' token is part of a
                 * 'while' statement or an 'if' clause, we check if it is
                 * preceded by a 'bbranch' with negative offset to a '<mark'
                 * before the current token.
                 *
                 * The following is an example of FCode that triggers the bug
                 * with its correctly detokenized source next to it.
                 *
                 * ( 10 00 00 00 b1 )   h# b1
                 * ( 14 00 08       )   if
                 * ( 10 00 13 ff fa )       h# 13fffa
                 * ( b2             )   then
                 *
                 * When the detokenizer gets to the 'b?branch' instruction, it
                 * will look ahead and (incorrectly) interpret the last 3 bytes
                 * of the numeric literal 13fffa as a 'bbranch' instruction
                 * with offset -6.  At offset -6 it will see the last byte of
                 * the literal b1 which it will mistake for a '<mark' token.
                 * It will therefore interpret the current 'b?branch' as a
                 * 'while' statement instead of an 'if' clause.
                 *
                 * The way to avoid this bug would be to use a two step
                 * approach and detokenize and decompile seperately.
                 *
                 * Fun fact: Sun's own FCode detokenizer (part of their DDK -
                 * Driver Development Kit) uses the same heuristic and thus has
                 * the same bug.
                 */
                if (FCODE8(i+offset-offset_size-1) == 0x13 &&
                        offset + offset2 <= offset_size &&
                        /* The following lines reduce the chances of triggering
                         * the bug and were required to handle the XVR-1000
                         * firmware. */
                        i + offset + offset2 >= 0 &&
                        i + offset + offset2 <= total_size &&
                        FCODE8(i+offset+offset2-offset_size-1) == 0xb1)
                {   /* end 'begin' block and start 'while' block */
                    ast_insert(&Tp, AST_BM_END|AST_BM_BEGIN, AST_WHILE);
                } else {
                    /* start 'if' block */
                    ast_insert(&Tp, AST_BM_BEGIN, AST_IF);
                };
            } else {
                fprintf(stderr, "detokenize(): Block error (b?branch)\n");
                fprintf(stderr, "-> i = %#.4x, offset = %#.2x, "
                        "FCODE8(i+offset) = %#.2x\n",
                        i, offset, FCODE8(i+offset));
                exit(EXIT_FAILURE);
            };

        };  break;

        case 0x17: /* do +offset */
            ast_insert(&Tp, AST_BM_BEGIN, AST_DO);

            length = 1 + offset_size;
            break;

        case 0x18: /* ?do +offset */
            ast_insert(&Tp, AST_BM_BEGIN, AST_QDO);

            length = 1 + offset_size;
            break;

        case 0x15: /* loop -offset */
            ast_insert(&Tp, AST_BM_END, AST_LOOP);

            length = 1 + offset_size;
            break;

        case 0x16: /* +loop -offset */
            ast_insert(&Tp, AST_BM_END, AST_PLOOP);

            length = 1 + offset_size;
            break;

        case 0xc4: /* case */
            ast_insert(&Tp, AST_BM_BEGIN, AST_CASE);

            length = 1;
            break;

        case 0xc5: /* endcase */
            ast_insert(&Tp, AST_BM_END, AST_ENDCASE);

            length = 1;
            break;

        case 0x1c: /* of +offset */
            ast_insert(&Tp, AST_BM_BEGIN, AST_CASE_OF);

            length = 1 + offset_size;
            break;

        case 0xc6: /* endof +offset */
            ast_insert(&Tp, AST_BM_END, AST_CASE_ENDOF);

            length = 1 + offset_size;
            break;

        case 0xcc: /* offset16 */
            ast_insert(&Tp, AST_BM_DEFAULT, AST_OFFSET16);

            offset_size = 2;

            length = 1;
            break;

        default:
        {   uint16_t opcode = ( FCODE8(i) > 0x0f ? FCODE8(i) : FCODE16(i) );

            ast_insert(&Tp, AST_BM_DEFAULT, AST_OP, opcode);

            length = ( opcode < 0x0100 ? 1 : 2 );
        };  break;
        };
    };

    if ( !fcode_end ) {
        fprintf(stderr, "detokenize(): Unexpected EOF, missing end0/end1\n");
        exit(EXIT_FAILURE);
    };

    return T0;
}
