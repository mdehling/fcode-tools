/**
 * Forth string handling functions.
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

#include <stdlib.h>

#include "fstring.h"


/**
 * Convenience function to copy a forth identifier to a C string.  A forth
 * identifier is a forth string containing only printable characters.
 *
 * @param fstr      The forth string (identifier) to copy.
 *
 * @return          The identifier as a C string or NULL.
 */
char *fidentifier(fstring_t *fstr) {
    char *cstr;
    size_t i;

    cstr = malloc(fstr->length+1);
    if (!cstr) return NULL;

    for (i = 0; i < fstr->length; i++) {
        if (fstr->string[i] < 32 || fstr->string[i] > 127) {
            free(cstr);
            return NULL;
        };
        cstr[i] = fstr->string[i];
    };

    cstr[i] = '\0';

    return cstr;
}


/**
 * Encode a forth string.  Newline, carriage return, and tab are encoded as
 * `"n`, `"r`, and `"t`, respectively, and `"` itself is encoded as `""`.
 * Should any other characters outside of the printable range (32..127) appear
 * in the forth string, we fall back to hex/binary encoding using
 * fstring_encode_binary().
 *
 * @param fstr      The forth string to encode.
 *
 * @return          The encoded C string or NULL.
 */
char *fstring_encode(fstring_t *fstr) {
    char *cstr, *ret;
    size_t i, j = 0;

    /* Allocates the amount of space needed if _every_ character is encoded
     * as a two byte sequence (+ null termination.) */
    cstr = malloc(2*fstr->length+1);
    if (!cstr) return NULL;

    for (i = 0; i < fstr->length; i++) {
        switch (fstr->string[i]) {
        case '\n':  cstr[j++] = '"'; cstr[j++] = 'n'; break;
        case '\r':  cstr[j++] = '"'; cstr[j++] = 'r'; break;
        case '\t':  cstr[j++] = '"'; cstr[j++] = 't'; break;
        case '"':   cstr[j++] = '"'; cstr[j++] = '"'; break;
        default:
            if (fstr->string[i] < 32 || fstr->string[i] > 127) {
                /* Non-printable char - use binary encoding instead. */
                free(cstr);
                return fstring_encode_binary(fstr);
            };
            cstr[j++] = fstr->string[i];
        };
    };

    cstr[j] = '\0';

    /* Free unused space. */
    ret = realloc(cstr, j+1);
    if (!ret) ret = cstr;

    return ret;
}


/**
 * Encode a forth string in hex/binary notation.  This encoding starts with
 * `"(` followed by the 2 byte hex representations of the forth string's
 * character (`00`..`ff`) seperated by spaces, and ends with `)`.  E.g., the
 * forth string `Hello World` of length 11 would be encoded as the C string
 * `"(48 65 6c 6c 6f 20 57 6f 72 6c 64)`.
 *
 * @param fstr      The forth string to encode.
 *
 * @return          The encoded C string or NULL.
 */
char *fstring_encode_binary(fstring_t *fstr) {
    const char *hex = "0123456789abcdef";
    char *cstr;
    size_t i, j = 0;

    /* Allocates the exact right amount of space: 2 bytes for `"(`, 3 bytes
     * per character including the following ` ` or `)`, and 1 byte for the
     * terminating null character. */
    cstr = malloc(2+3*fstr->length+1);
    if (!cstr) return NULL;

    cstr[j++] = '"'; cstr[j++] = '(';

    for (i = 0; i < fstr->length; i++) {
        cstr[j++] = hex[ fstr->string[i]>>4 & 0xf ];
        cstr[j++] = hex[ fstr->string[i] & 0xf ];
        cstr[j++] = ' ';
    };

    cstr[j-1] = ')'; cstr[j] = '\0';

    return cstr;
}
