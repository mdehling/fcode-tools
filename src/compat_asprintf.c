/**
 * An implementation of `asprintf()` for older systems that don't have one.
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

#ifdef COMPAT_ASPRINTF

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

#include "compat_asprintf.h"
#include "compat_va_copy.h"


int compat_asprintf (char **s, const char *fmt, ...) {
    int n;
    va_list ap;

    va_start(ap, fmt);
    n = compat_vasprintf(s, fmt, ap);
    va_end(ap);

    return n;
}


int compat_vasprintf (char **s, const char *fmt, va_list ap) {
    int n;
    char dummy_buffer[1];
    va_list ap_;

    /* Older Solaris ships a broken vsnprintf() so we can't pass length 0. */
    va_copy(ap_, ap);
    n = vsnprintf(&dummy_buffer[0], 1, fmt, ap_);
    va_end(ap_);

    if (n < 0) {
        *s = NULL;
        return -1;
    };

    *s = malloc(n + 1);
    if (! *s) return -1;

    return vsprintf(*s, fmt, ap);
}

#endif /* COMPAT_ASPRINTF */
