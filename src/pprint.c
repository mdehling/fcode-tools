/**
 * Pretty printing forth code.
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

#include <assert.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "pprint.h"

#include "ast.h"
#include "fstring.h"
#include "words.h"
#include "compat_asprintf.h"


/**
 * Pretty printing modes.  Determine whether to place the output on a seperate
 * line or even seperate it by a blank line from the forth code before and
 * after it.
 */
typedef enum pp_mode {
    PP_MODE_DEFAULT         = 0x0,
    PP_MODE_SEP_BEFORE      = 0x1,
    PP_MODE_SEP_AFTER       = 0x2,
    PP_MODE_SEP_BOTH        = 0x3,
    PP_MODE_BLANK_BEFORE    = 0x4,
    PP_MODE_BLANK_AFTER     = 0x8,
    PP_MODE_BLANK_BOTH      = 0xC,
} pp_mode_t;


/**
 * Output forth code to stream.
 *
 * @param outfp      The output stream.
 * @param str       The code to output.
 * @param lvl       The currently active indentation level.
 * @param mode      Seperation mode.
 */
static void output(FILE *outfp, char *str, int lvl, pp_mode_t mode) {
    static int i = 0;
    static int prev_blank = 0;
    int j;
    int len;

    if (! str) {
        fprintf(stderr, "output(): Attempt to print NULL string\n");
        exit(EXIT_FAILURE);
    };

    len = strlen(str);

    if (mode & PP_MODE_BLANK_BEFORE && !prev_blank) {
        /* Make sure the following code is seperated by a blank line. */
        if (i != 0) {
            fputc('\n', outfp);
            i = 0;
        };
        fputc('\n', outfp);
    } else if ( i != 0 &&
            ( (i+len > MAX_LINE_LENGTH) || (mode & PP_MODE_SEP_BEFORE) ) )
    {
        /* Start a new line to avoid overfilling. */
        fputc('\n', outfp);
        i = 0;
    };

    if (i == 0) {
        /* Indent by 4 spaces per level if this is the start of a line, ... */
        for (j = 1; j < lvl; j++) fputs("    ", outfp);
        i = 4*lvl;
    } else {
        /* ... or seperate the following code by a single space if not. */
        fputc(' ', outfp);
        i++;
    };

    fputs(str, outfp);
    i += len;

    if (mode & PP_MODE_BLANK_AFTER) {
        /* Following code is seperated by a blank line. */
        fputs("\n\n", outfp);
        i = 0;
        prev_blank = 1;
    } else {
        /* Following code goes on a seperate line. */
        if (mode & PP_MODE_SEP_AFTER) {
            fputc('\n', outfp);
            i = 0;
        };
        prev_blank = 0;
    };
}


/**
 * Pretty print forth code for the given AST.
 *
 * @param outfp      The output stream.
 * @param T         The AST to print.
 */
void prettyprint(FILE *outfp, ast_t *T) {
    int lvl = 0;
    char *s;

    int in_definition = 0;
    token_header_t tokhdr_mode = -1;    /* Invalid to force setting. */

    assert(T);

    do {
        if (T->type == AST_SENTINEL) {
            lvl--;
            continue;
        };

        switch(T->type) {

        case AST_PCI_HEADER:
        {   ast_pci_header_t *node = (ast_pci_header_t *)T;

            output(outfp, "tokenizer[", lvl, PP_MODE_SEP_BOTH);

            asprintf(&s, "h# %04x h# %04x h# %06x pci-header",
                node->vendor_id, node->device_id, node->class_code);
            output(outfp, s, lvl, PP_MODE_SEP_BOTH);
            free(s);

            if (node->vendor_prod_data) {
                asprintf(&s, "h# %04x pci-vpd-offset", node->vendor_prod_data);
                output(outfp, s, lvl, PP_MODE_SEP_BOTH);
                free(s);
            };

            if (node->code_rev) {
                asprintf(&s, "h# %04x pci-code-revision", node->code_rev);
                output(outfp, s, lvl, PP_MODE_SEP_BOTH);
                free(s);
            };

            output(outfp, "]tokenizer", lvl, PP_MODE_BLANK_AFTER);
        };  break;

        case AST_HEADER:
        {   ast_header_t *node = (ast_header_t *)T;

            asprintf(&s, "\\ %02x %02x %04x %08x",
                    node->magic, node->reserved, node->checksum, node->size );
            output(outfp, s, lvl, PP_MODE_SEP_BOTH);
            free(s);

            if (node->magic == 0xfd) {
                output(outfp, "fcode-version1", lvl, PP_MODE_SEP_BOTH);
            } else {
                asprintf(&s, "fcode-version%d ( start%d )",
                    (node->reserved == 0x08 ? 3 : 2),
                    4 >> (3 - node->magic&0xf) );
                output(outfp, s, lvl, PP_MODE_SEP_BOTH);
                free(s);
            };

            /* Any numeric literals in the following are in hex notation. */
            output(outfp, "hex", lvl, PP_MODE_BLANK_AFTER);
        };  break;

        case AST_END:
        {   ast_op_t *node = (ast_op_t *)T;

            if (node->code == 0x00) {
                output(outfp, "end0", lvl,
                    PP_MODE_SEP_BOTH|PP_MODE_BLANK_BEFORE);
            } else {
                output(outfp, "end1", lvl,
                    PP_MODE_SEP_BOTH|PP_MODE_BLANK_BEFORE);
            };

        };  break;

        case AST_OFFSET16:
            output(outfp, "offset16", lvl, PP_MODE_BLANK_BOTH);
            break;

        case AST_LITERAL:
        {   ast_literal_t *node = (ast_literal_t *)T;

            if (node->value <= 3) {
                /* For i = 0..3, make sure to write `h# i` to distinguish the
                 * numeric literal from their special tokens `0xa5` for `0`,
                 * etc.  Since we print unsigned values, there is no need to
                 * worry about `0xa4` for `-1` - it will be printed as
                 * `ffffffff` instead. */
                asprintf(&s, "h# %x", node->value);
            } else {
                asprintf(&s, "%x", node->value);
            };
            output(outfp, s, lvl, PP_MODE_DEFAULT);
            free(s);

        };  break;

        case AST_STRING:
        {   ast_string_t *node = (ast_string_t *)T;
            char *cstr = fstring_encode(node->fstring);

            /* Note that the extra space after `"` is not a mistake! */
            asprintf(&s, "\" %s\"", cstr);
            output(outfp, s, lvl, PP_MODE_DEFAULT);
            free(s);

            free(cstr);
        };  break;

        case AST_IF:
            output(outfp, "if", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_ELSE:
            output(outfp, "else", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_THEN:
            output(outfp, "then", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_BEGIN:
            output(outfp, "begin", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_AGAIN:
            output(outfp, "again", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_UNTIL:
            output(outfp, "until", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_WHILE:
            output(outfp, "while", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_REPEAT:
            output(outfp, "repeat", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_DO:
            output(outfp, "do", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_LOOP:
            output(outfp, "loop", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_QDO:
            output(outfp, "?do", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_PLOOP:
            output(outfp, "+loop", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_CASE:
            output(outfp, "case", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_CASE_OF:
            output(outfp, "of", lvl, PP_MODE_DEFAULT);
            break;

        case AST_CASE_ENDOF:
            output(outfp, "endof", lvl, PP_MODE_SEP_AFTER);
            break;

        case AST_ENDCASE:
            output(outfp, "endcase", lvl, PP_MODE_SEP_BOTH);
            break;

        case AST_TOKEN:
        {   ast_token_t *node = (ast_token_t *)T;
            pp_mode_t mode = PP_MODE_SEP_AFTER;
            char *t;

            if (tokhdr_mode != node->tokhdr) {
                /* Change currently active token header visibility mode. */
                tokhdr_mode = node->tokhdr;

                switch (tokhdr_mode) {
                case TOKEN_NOHEADER:
                    output(outfp, "headerless", lvl, PP_MODE_BLANK_BOTH);
                    break;
                case TOKEN_HEADER:
                    output(outfp, "headers", lvl, PP_MODE_BLANK_BOTH);
                    break;
                case TOKEN_EXTERNAL:
                    output(outfp, "external", lvl, PP_MODE_BLANK_BOTH);
                    break;
                default:
                    assert(0);
                    break;
                };
            }

            switch(node->toktype) {
            case 0xb7:
                t = ":";
                mode |= PP_MODE_BLANK_BEFORE;
                in_definition = 1;
                break;
            case 0xb8: t = "value"; break;
            case 0xb9: t = "variable"; break;
            case 0xba: t = "constant"; break;
            case 0xbb: t = "create"; break;
            case 0xbc: t = "defer"; break;
            case 0xbd: t = "buffer:"; break;
            case 0xbe: t = "field"; break;
            default:
                assert(0);
                break;
            };

            asprintf(&s, "%s %s ( %04x )", t, node->name, node->tokcode);
            output(outfp, s, lvl, mode);
            free(s);

            set_user_word(node->tokcode, node->name);

        };  break;

        case AST_ENDDEF:
            in_definition = 0;
            output(outfp, ";", lvl, PP_MODE_SEP_BOTH|PP_MODE_BLANK_AFTER);
            break;

        case AST_OP:
        {   ast_op_t *node = (ast_op_t *)T;

            output(outfp, get_word(node->code), lvl, PP_MODE_DEFAULT);

        };  break;

        case AST_ACF:
        {   ast_op_t *node = (ast_op_t *)T;

            if (in_definition) {
                output(outfp, "[']", lvl, PP_MODE_SEP_BEFORE);
            } else {
                output(outfp, "'", lvl, PP_MODE_SEP_BEFORE);
            };
            output(outfp, get_word(node->code), lvl, PP_MODE_DEFAULT);

        };  break;

        default:
        {   ast_t *node = T;

            fprintf(stderr, "prettyprint_i(): "
                    "Unknown AST node type %d\n", node->type);
            exit(EXIT_FAILURE);
        };  break;
        };

        lvl++;
    } while (ast_advance(&T));
}
