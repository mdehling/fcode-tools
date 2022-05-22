/**
 * Forth / FCode AST.
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

#ifndef AST_H
#define AST_H

#include <inttypes.h>
#include <stdarg.h>

#include "fstring.h"


/**
 * AST node type enumeration type.  The special value AST_SENTINEL marks leaf
 * nodes.  Such nodes have no meaning in FCode and exist only to make building
 * and iterating over ASTs easier.  Sentinel nodes must have NULL `child` and
 * `next` members and a valid (possibly NULL) `parent` member.
 */
typedef enum ast_type {
    AST_SENTINEL = -1,
    AST_PCI_HEADER,
    AST_HEADER,                             AST_END,
    AST_LITERAL,
    AST_ACF,
    AST_STRING,
    AST_IF,             AST_ELSE,           AST_THEN,
    AST_BEGIN,                              AST_AGAIN,
                                            AST_UNTIL,
                        AST_WHILE,          AST_REPEAT,
    AST_DO,                                 AST_LOOP,
    AST_QDO,                                AST_PLOOP,
    AST_CASE,           AST_CASE_OF,
                        AST_CASE_ENDOF,     AST_ENDCASE,
    AST_TOKEN,                              AST_ENDDEF,
    AST_OFFSET16,
    AST_OP,
} ast_type_t;


/** Base AST node type. */
typedef struct ast {
    struct ast *parent, *child;
    struct ast *next;
    ast_type_t type;
} ast_t;


/** AST node type for PCI header. */
typedef struct ast_pci_header {
    ast_t base;
    uint16_t vendor_id, device_id;
    uint32_t class_code;
    uint16_t vendor_prod_data;
    uint16_t code_rev;
    uint16_t size;
} ast_pci_header_t;


/** AST node type for FCode header. */
typedef struct ast_header {
    ast_t base;
    uint8_t magic, reserved;
    uint16_t checksum;
    uint32_t size;
} ast_header_t;


/** AST node type for numeric literal. */
typedef struct ast_literal {
    ast_t base;
    uint32_t value;
} ast_literal_t;


/** AST node type for string literal. */
typedef struct ast_string {
    ast_t base;
    fstring_t *fstring;
} ast_string_t;


/** AST node token header visibility type. */
typedef enum token_header {
    TOKEN_HEADER,
    TOKEN_NOHEADER,
    TOKEN_EXTERNAL,
} token_header_t;


/** AST node type for token. */
typedef struct ast_token {
    ast_t base;
    token_header_t tokhdr;
    char *name;
    uint16_t tokcode;
    uint8_t toktype;
} ast_token_t;


/** AST node type for other operations. */
typedef struct ast_op {
    ast_t base;
    uint16_t code;
} ast_op_t;


ast_t *ast_new();
void ast_delete(ast_t *T);


typedef enum ast_blockmode {
    AST_BM_DEFAULT  = 0x0,
    AST_BM_BEGIN    = 0x1,
    AST_BM_END      = 0x2
} ast_blockmode_t;


int ast_insert(ast_t ***Tpp, ast_blockmode_t mode, ast_type_t type, ...);

int ast_advance(ast_t **Tp);


#endif
