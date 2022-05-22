/**
 * Auxiliary filename handling functions.
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
#include <string.h>


/**
 * Isolate the basename of a path, i.e., the part after the last '/'.  This
 * functions returns a pointer into its argument path and does _not_ make a
 * copy of the basename.
 *
 * @param path      The full path.
 *
 * @return          The basename.
 */
char *basename(char *path) {
    char *s;

    for (s = path; *s != '\0'; s++) {
        if (*s == '/')
            path = s+1;
    };

    return path;
}


/**
 * Change the extension of a file name.  Checks if path has oldext and, if so,
 * replaces it with newext or, if not, simply adds newext.  This function
 * allocates a string and it is the caller's responsibility to free() it.
 *
 * @param path      The full path or file name.
 * @param oldext    The old extension to remove if present.
 * @param newext    The new extension to add.
 *
 * @return          The path with its changed extension.
 */
char *change_extension(char *path, char *oldext, char *newext) {
    char *newpath;
    size_t path_len = strlen(path),
           oldext_len = strlen(oldext),
           newext_len = strlen(newext);

    if (!strcmp(path+path_len-oldext_len, oldext)) {
        newpath = malloc(path_len-oldext_len+newext_len+1);
        if (newpath) {
            strncpy(newpath, path, path_len-oldext_len);
            strcpy(newpath+path_len-oldext_len, newext);
        };
    } else {
        newpath = malloc(path_len+newext_len+1);
        if (newpath) {
            strcpy(newpath, path);
            strcpy(newpath+path_len, newext);
        };
    };

    return newpath;
}
