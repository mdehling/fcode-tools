/**
 * FCode-Tools Command Line Interface.
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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "auxfile.h"
#include "fcode.h"
#include "words.h"


static char *cmd;


void usage() {
    fprintf(stderr, "usage:\n");
    fprintf(stderr, "\t%s [-h|-v]\n", cmd);
    fprintf(stderr, "\t%s detokenize [-2|-3] [-o <output.fth>] input.fcode\n",
        cmd);
    fprintf(stderr, "\t%s extract [-o <output.fcode>] input.bin\n",
        cmd);
}


int main(int argc, char **argv) {
    int c;
    extern char *optarg;
    extern int optind;
    int error = 0;

    cmd = basename(argv[0]);

    while ( (c = getopt(argc, argv, "hv")) != -1 ) {
        switch (c) {
        case 'v':
            fprintf(stderr,
                "FCode-Tools Version %s, Copyright (C) 2022 Malte Dehling.\n",
                FCODE_TOOLS_VERSION);
            exit(EXIT_SUCCESS);
        case 'h':
            usage();
            exit(EXIT_SUCCESS);
        default:
            /* unknown option */
            usage();
            exit(EXIT_FAILURE);
            break;
        };
    };


    if (argc - optind < 1) {
        /* missing command */
        usage();
        exit(EXIT_FAILURE);

    } else if (!strcmp(argv[optind], "detokenize")) {

        char *input = NULL, *output = NULL;
        int fcode_version = 2;

        optind++;

        while ( (c = getopt(argc, argv, "23o:")) != -1 ) {
            switch (c) {
            case '2':
                fcode_version = 2;
                break;
            case '3':
                fcode_version = 3;
                break;
            case 'o':
                output = optarg;
                break;
            default:
                usage();
                exit(EXIT_FAILURE);
                break;
            };
        };

        if (argc - optind == 1) {
            input = argv[optind];
        } else {
            /* missing required argument: output filename */
            usage();
            exit(EXIT_FAILURE);
        };

#ifdef DEBUG
        fprintf(stderr,
            "fcode_detokenize(input='%s', output='%s', fcode_version=%d)\n",
            input, (output ? output : "-"), fcode_version);
#endif

        if (!init_wordlist(fcode_version) || !fcode_detokenize(input, output)) {
            exit(EXIT_FAILURE);
        };

    } else if (!strcmp(argv[optind], "extract")) {
        char *input = NULL, *output = NULL;

        optind++;

        while ( (c = getopt(argc, argv, "o:")) != -1 ) {
            switch (c) {
            case 'o':
                output = optarg;
                break;
            default:
                usage();
                exit(EXIT_FAILURE);
            };
        };

        if (argc - optind == 1) {
            input = argv[optind];
        } else {
            /* missing required argument: output filename */
            usage();
            exit(EXIT_FAILURE);
        };

        if (!output) {
            output = change_extension(basename(input), ".bin", ".fcode");
        };

#ifdef DEBUG
        fprintf(stderr, "fcode_extract(input='%s', output='%s')\n",
            input, output);
#endif

        if (!fcode_copy(input, output)) {
            fprintf(stderr, "Failed to extract FCode!\n");
            exit(EXIT_FAILURE);
        };

    } else {
        /* unknown command */
        usage();
        exit(EXIT_FAILURE);
    };

    exit(EXIT_SUCCESS);
}
