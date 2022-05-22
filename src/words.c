/**
 * Forth dictionary functions.
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

#include "words.h"
#include "wordlist_v2.h"
#include "wordlist_v3.h"

#include "compat_asprintf.h"


char *user_word[MAX_USER_WORDS];

char **builtin_word;


/**
 * Load the wordlist for @p fcode_version.
 *
 * @param fcode_version     FCode version of the dictionary to load.
 *
 * @retval 1        On success.
 * @retval 0        On failure.  This happens when @p fcode_version is invalid.
 */
int init_wordlist(int fcode_version) {
    switch (fcode_version) {
    case 2:
        builtin_word = wordlist_v2;
        break;
    case 3:
        builtin_word = wordlist_v3;
        break;
    default:
        return 0;
    };

    return 1;
}


/**
 * Add a word to the user dictionary.  Note that his does _not_ make a copy of
 * @p word, so do not free() it!
 *
 * @param code      Code for the word to add.
 * @param word      The word to add.
 *
 * @retval 1        On success.
 * @retval 0        On failure.  This happens when @p code is outside of the
 *                  valid range.
 */
int set_user_word(uint16_t code, char *word) {

    if (USER_WORD_MIN_I <= code && code <= USER_WORD_MAX_I) {
        user_word[code-USER_WORD_MIN_I] = word;
    } else {
        return 0;
    };

    return 1;
}


/**
 * Look up the word corresponding to the given @p code in the dictionary.
 *
 * @param code      Code for the word to look up.
 *
 * @return          The word corresponding to @p code or NULL.
 */
char *get_word(uint16_t code) {
    char *word = NULL;

    if (BUILTIN_WORD_MIN_I <= code && code <= BUILTIN_WORD_MAX_I) {
        word = builtin_word[code-BUILTIN_WORD_MIN_I];
    } else if (USER_WORD_MIN_I <= code && code <= USER_WORD_MAX_I) {
        word = user_word[code-USER_WORD_MIN_I];
    };

    if (!word) {
        fprintf(stderr, "get_word(): Token %04x unknown\n", code);
        exit(EXIT_FAILURE);
    };

    return word;
}
