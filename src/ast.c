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

#include <assert.h>
#include <inttypes.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "ast.h"
#include "fstring.h"


#define AST_NEXT        do { Tp = &(*Tp)->next; } while(0)
#define AST_BLOCK_BEGIN do { Tp = &(*Tp)->child; } while(0)
#define AST_BLOCK_END   do { Tp = &(*Tp)->parent->next; } while(0)


#ifdef DEBUG

static int debug_indent_level = 0;

#endif /* DEBUG */


static ast_t *ast_node_new(ast_type_t type, ...);
static ast_t *ast_node_vnew(ast_type_t type, va_list ap);
static void ast_node_delete(ast_t *T);


/**
 * Create a new AST.
 *
 * @return      A minimal valid AST consisting of a single #AST_SENTINEL node
 *              with NULL `parent` member, or NULL in case of failure.
 */
ast_t *ast_new() {
    return ast_node_new(AST_SENTINEL);
}


/**
 * Delete an AST.  Currently calls `ast_delete()` recursively on children
 * since that's the trivial way to implement this.
 *
 * @param T     The AST to delete.
 */
void ast_delete(ast_t *T) {
    ast_t *T_;

    if (!T) return;

    while (T->type != AST_SENTINEL) {
        ast_delete(T->child);
        T_ = T->next;
        ast_node_delete(T);
        T = T_;
    };
    ast_node_delete(T);
}


/**
 * Insert an AST node of the same generation before the current one and make
 * it the (new) current one.  The new node is of type @p type.
 *
 * @param Tpp       Pointer to the current node pointer.  On success, the current
 *                  node pointer will be updated.
 * @param mode      Block mode ofthe new AST node.
 * @param type      Type of the new AST node.
 * @param ...       Parameters to pass on to `ast_node_new(type, ...)`.
 *
 * @retval 1        On success.
 * @retval 0        On failure.  The AST is unchanged in this case.
 */
int ast_insert(ast_t ***Tpp, ast_blockmode_t mode, ast_type_t type, ...) {
    ast_t *T, *S;
    ast_t **Tp;
    va_list ap;

    assert(Tpp && *Tpp && **Tpp);

    va_start(ap, type);
    T = ast_node_vnew(type, ap);
    va_end(ap);

    if (!T) return 0;

    S = ast_node_new(AST_SENTINEL);
    if (!S) {
        ast_node_delete(T);
        return 0;
    };
    S->parent = T;

    Tp = *Tpp;

    if (mode & AST_BM_END) {
        AST_BLOCK_END;
#ifdef DEBUG
        debug_indent_level--;
#endif
    };

    T->parent = (*Tp)->parent;
    T->child = S;
    T->next = *Tp;

    *Tp = T;

    if (mode & AST_BM_BEGIN) {
        AST_BLOCK_BEGIN;
#ifdef DEBUG
        debug_indent_level++;
#endif
    } else {
        AST_NEXT;
    };

    *Tpp = Tp;

    return 1;
}


/**
 * Advance to the next AST node in depth-first order.
 *
 * @param Tp        Pointer to the current node.  On success, @p Tp will point
 *                  to the next node in depth-first order.
 *
 * @retval 1        On success.
 * @retval 0        If AST traversal has finished.
 */
int ast_advance(ast_t **Tp) {

    assert(Tp && *Tp);

    if ((*Tp)->type == AST_SENTINEL) {
        *Tp = (*Tp)->parent;
        if ( ! *Tp )
            return 0;
        *Tp = (*Tp)->next;
    } else {
        *Tp = (*Tp)->child;
    };

    return 1;
}


/**
 * Create a new AST node.
 *
 * @param type      Type of the new AST node.
 * @param ...       Type-dependent parameters for AST node creation.
 *
 * @return          The new AST node.
 */
static ast_t *ast_node_new(ast_type_t type, ...) {
    ast_t *T;
    va_list ap;

    va_start(ap, type);
    T = ast_node_vnew(type, ap);
    va_end(ap);

    return T;
}


/**
 * Create a new AST node.
 *
 * @param type      Type of the new AST node.
 * @param ap        Type-dependent parameters for AST node creation.
 *
 * @return          The new AST node.
 */
static ast_t *ast_node_vnew(ast_type_t type, va_list ap) {
    ast_t *T = NULL;

#ifdef DEBUG
    if (type != AST_SENTINEL) {
        fprintf(stderr, "[%02x] ", debug_indent_level);
    };
#endif

    switch(type) {

    case AST_PCI_HEADER:
    {   ast_pci_header_t *node = malloc(sizeof *node);

        if (node) {
            node->vendor_id = (uint16_t) va_arg(ap, unsigned);
            node->device_id = (uint16_t) va_arg(ap, unsigned);
            node->class_code = (uint32_t) va_arg(ap, unsigned);
            node->vendor_prod_data = (uint16_t) va_arg(ap, unsigned);
            node->code_rev = (uint16_t) va_arg(ap, unsigned);
            node->size = (uint16_t) va_arg(ap, unsigned);
#ifdef DEBUG
            fprintf(stderr, "AST_PCI_HEADER: %04x %04x %08x %04x %04x %04x\n",
                node->vendor_id, node->device_id, node->class_code,
		node->vendor_prod_data, node->code_rev, node->size);
#endif
        };

        T = (ast_t *)node;
    };  break;

    case AST_HEADER:
    {   ast_header_t *node = malloc(sizeof *node);

        if (node) {
            node->magic = (uint8_t) va_arg(ap, unsigned);
            node->reserved = (uint8_t) va_arg(ap, unsigned);
            node->checksum = (uint16_t) va_arg(ap, unsigned);
            node->size = (uint32_t) va_arg(ap, unsigned);
#ifdef DEBUG
            fprintf(stderr, "AST_HEADER: %02x %02x %04x %08x\n",
                node->magic, node->reserved, node->checksum, node->size);
#endif
        };

        T = (ast_t *)node;
    };  break;

    case AST_LITERAL:
    {   ast_literal_t *node = malloc(sizeof *node);

        if (node) {
            node->value = (uint32_t) va_arg(ap, unsigned);
#ifdef DEBUG
            fprintf(stderr, "AST_LITERAL: %08x\n", node->value);
#endif
        };

        T = (ast_t *)node;
    };  break;

    case AST_ACF:
    {   ast_op_t *node = malloc(sizeof *node);

        if (node) {
            node->code = (uint16_t) va_arg(ap, unsigned);
#ifdef DEBUG
            fprintf(stderr, "AST_ACF: %04x\n", node->code);
#endif
        };

        T = (ast_t *)node;
    };  break;

    case AST_STRING:
    {   ast_string_t *node = malloc(sizeof *node);

        if (node) {
            node->fstring = va_arg(ap, fstring_t *);
#ifdef DEBUG
            fprintf(stderr, "AST_STRING: ...\n");
#endif
        };

        T = (ast_t *)node;
    };  break;

    case AST_TOKEN:
    {   ast_token_t *node = malloc(sizeof *node);

        if (node) {
            node->tokhdr = va_arg(ap, int);
            node->name = va_arg(ap, char *);
            node->tokcode = (uint16_t) va_arg(ap, unsigned);
            node->toktype = (uint8_t) va_arg(ap, unsigned);
#ifdef DEBUG
            fprintf(stderr, "AST_TOKEN: %08x '%s' %04x %02x\n",
                node->tokhdr, node->name, node->tokcode, node->toktype);
#endif
        };

        T = (ast_t *)node;
    };  break;

    case AST_END:
    case AST_OP:
    {   ast_op_t *node = malloc(sizeof *node);

        if (node) {
            node->code = (uint16_t) va_arg(ap, unsigned);
#ifdef DEBUG
            fprintf(stderr, "AST_END/AST_OP: %04x\n", node->code);
#endif
        };

        T = (ast_t *)node;
    };  break;

    default:
#ifdef DEBUG
        if (type != AST_SENTINEL) {
            fprintf(stderr, "AST_XXX[%04x]\n", type);
        };
#endif
        T = malloc(sizeof *T);
    };

    if (T) {
        T->parent = NULL;
        T->child = NULL;
        T->next = NULL;
        T->type = type;
    };

    return T;
}


/**
 * Delete an AST node and free any associated memory.
 *
 * @param T         The node to delete.
 */
static void ast_node_delete(ast_t *T) {

    assert(T);

    switch (T->type) {

    case AST_STRING:
    {   ast_string_t *node = (ast_string_t *)T;
        free(node->fstring);
    };  break;

    case AST_TOKEN:
    {   ast_token_t *node = (ast_token_t *)T;
        free(node->name);
    };  break;

    default:
        break;
    };

    free(T);
}
