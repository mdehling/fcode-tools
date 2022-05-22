/**
 * FCode interface.
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

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "ast.h"
#include "detokenize.h"
#include "fcode.h"
#include "pprint.h"
#include "words.h"


ssize_t fcode_read(uint8_t **fcodep, int fd) {
    uint8_t *fcode;
    uint32_t fcode_size, total_size, i = 0;
    ssize_t n;

    /*
     * Read the FCode header first - it contains the FCode size.
     */

    fcode = malloc(FCODE_HEADER_SIZE);
    if (!fcode) {
        perror("fcode_read()");
        return -1;
    };

    n = read(fd, fcode, FCODE_HEADER_SIZE);
    if (-1 == n) {
        perror("fcode_read()");
        return -1;
    } else if (n < FCODE_HEADER_SIZE) {
        /* Should retry but the read is so short it is unlikely to help. */
        fprintf(stderr, "fcode_read(): Short read\n");
        return -1;
    };

    if (fcode[i+0x00] == 0x55 && fcode[i+0x01] == 0xaa) {
        fcode = realloc(fcode, PCI_HEADER_SIZE+FCODE_HEADER_SIZE);
        if (!fcode) {
            perror("fcode_read()");
            return -1;
        };

        n = read(fd, &fcode[FCODE_HEADER_SIZE], PCI_HEADER_SIZE);
        if (-1 == n) {
            perror("fcode_read()");
            return -1;
        } else if (n < PCI_HEADER_SIZE) {
            fprintf(stderr, "fcode_read(): Short read\n");
            return -1;
        };

        i = PCI_HEADER_SIZE;
    };

    /* There should now be an FCode header at fcode[i]. */
    switch (fcode[i+0x00]) {
    case 0xf0:
    case 0xf1:
    case 0xf2:
    case 0xf3:
    case 0xfd:
        fcode_size =
            fcode[i+0x04]<<24|fcode[i+0x05]<<16|fcode[i+0x06]<<8|fcode[i+0x07];
        break;
    default:
        fprintf(stderr, "fcode_read(): No FCode header found\n");
        return -1;
    };

    /* Use FCode length to read remaining FCode. */
    total_size = i + fcode_size;

    fcode = realloc(fcode, total_size);
    if (!fcode) {
        perror("fcode_read()");
        return -1;
    };

    for (i = i + FCODE_HEADER_SIZE; i < total_size; i += n) {
        n = read(fd, &fcode[i], total_size - i);
        if (n < 0) {
            perror("fcode_read()");
            return -1;
        } else if (n == 0) {
            fprintf(stderr, "fcode_read(): Unexpected EOF\n");
            return -1;
        };
    };

    /* success */
    *fcodep = fcode;

    return total_size;
}


int fcode_detokenize(char *infname, char *outfname) {
    int infd;
    FILE *outfp = stdout;
    uint8_t *fcode;
    ast_t *T;

    if ( (infd = open(infname, O_RDONLY)) == -1 ) {
        perror("fcode_detokenize()");
        return 0;
    };

    if (outfname) {
        if ( !(outfp = fopen(outfname, "w")) ) {
            perror("fcode_detokenize()");
            return 0;
        };
    };

    if (fcode_read(&fcode, infd) == -1) {
        fprintf(stderr, "Failed to read FCode!\n");
        return 0;
    } else if ( (T = detokenize(fcode)) == NULL ) {
        fprintf(stderr, "Failed to detokenize FCode!\n");
        return 0;
    } else {
        prettyprint(outfp, T);
    };

    if (outfname)
        fclose(outfp);

    close(infd);

    return 1;
}


int fcode_copy(char *infname, char *outfname) {
    int infd, outfd;
    uint8_t *fcode;
    ssize_t total_size, n, i;

    if ( (infd = open(infname, O_RDONLY)) == -1 ) {
        perror("fcode_copy()");
        return 0;
    };

    if ( (total_size = fcode_read(&fcode, infd)) == -1 ) {
        fprintf(stderr, "fcode_copy(): Error reading FCode\n");
        return 0;
    };

    if ( (outfd = open(outfname, O_CREAT|O_WRONLY, 0666)) == -1 ) {
        perror("fcode_copy()");
        close(infd);
        return 0;
    };

    for (i = 0; i < total_size; i += n) {
        n = write(outfd, &fcode[i], total_size - i);
        if (n < 0) {
            perror("fcode_copy()");
            return 0;
        } else if (n == 0) {
            fprintf(stderr, "fcode_copy(): Unexpected EOF\n");
            return 0;
        };
    };

    close(outfd);
    close(infd);

    return 1;
}
