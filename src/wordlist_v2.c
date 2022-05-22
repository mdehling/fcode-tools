/**
 * FCode v2.x dictionary.
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

#include "words.h"


char *wordlist_v2[MAX_BUILTIN_WORDS] = {
/* 00 */    NULL,
/* 01 */    NULL,
/* 02 */    NULL,
/* 03 */    NULL,
/* 04 */    NULL,
/* 05 */    NULL,
/* 06 */    NULL,
/* 07 */    NULL,
/* 08 */    NULL,
/* 09 */    NULL,
/* 0a */    NULL,
/* 0b */    NULL,
/* 0c */    NULL,
/* 0d */    NULL,
/* 0e */    NULL,
/* 0f */    NULL,
/* 10 */    NULL,
/* 11 */    NULL,
/* 12 */    NULL,
/* 13 */    NULL,
/* 14 */    NULL,
/* 15 */    NULL,
/* 16 */    NULL,
/* 17 */    NULL,
/* 18 */    NULL,
/* 19 */    "i",                        /* ( -- n ) */
/* 1a */    "j",                        /* ( -- n ) */
/* 1b */    "leave",                    /* ( -- ) */
/* 1c */    NULL,
/* 1d */    "execute",                  /* ( acf -- ) */
/* 1e */    "+",                        /* ( n1 n2 -- n3 ) */
/* 1f */    "-",                        /* ( n1 n2 -- n3 ) */
/* 20 */    "*",                        /* ( n1 n2 -- n3 ) */
/* 21 */    "/",                        /* ( n1 n2 -- quot ) */
/* 22 */    "mod",                      /* ( n1 n2 -- rem ) */
/* 23 */    "and",                      /* ( n1 n2 -- n3 ) */
/* 24 */    "or",                       /* ( n1 n2 -- n3 ) */
/* 25 */    "xor",                      /* ( n1 n2 -- n3 ) */
/* 26 */    "not",                      /* ( n1 -- n2 ) */
/* 27 */    "<<",                       /* ( n1 +n -- n2 ) */
/* 28 */    ">>",                       /* ( n1 +n -- n2 ) */
/* 29 */    ">>a",                      /* ( n1 +n -- n2 ) */
/* 2a */    "/mod",                     /* ( n1 n2 -- rem quot ) */
/* 2b */    "u/mod",                    /* ( ul un -- un.rem un.quot ) */
/* 2c */    "negate",                   /* ( n1 -- n2 ) */
/* 2d */    "abs",                      /* ( n -- u ) */
/* 2e */    "min",                      /* ( n1 n2 -- n3 ) */
/* 2f */    "max",                      /* ( n1 n2 -- n3 ) */
/* 30 */    ">r",                       /* ( n -- ) */
/* 31 */    "r>",                       /* ( -- n ) */
/* 32 */    "r@",                       /* ( -- n ) */
/* 33 */    "exit",                     /* ( -- ) */
/* 34 */    "0=",                       /* ( n -- flag ) */
/* 35 */    "0<>",                      /* ( n -- flag ) */
/* 36 */    "0<",                       /* ( n -- flag ) */
/* 37 */    "0<=",                      /* ( n -- flag ) */
/* 38 */    "0>",                       /* ( n -- flag ) */
/* 39 */    "0>=",                      /* ( n -- flag ) */
/* 3a */    "<",                        /* ( n1 n2 -- flag ) */
/* 3b */    ">",                        /* ( n1 n2 -- flag ) */
/* 3c */    "=",                        /* ( n1 n2 -- flag ) */
/* 3d */    "<>",                       /* ( n1 n2 -- flag ) */
/* 3e */    "u>",                       /* ( u1 u2 -- flag ) */
/* 3f */    "u<=",                      /* ( u1 u2 -- flag ) */
/* 40 */    "u<",                       /* ( u1 u2 -- flag ) */
/* 41 */    "u>=",                      /* ( u1 u2 -- flag ) */
/* 42 */    ">=",                       /* ( n1 n2 -- flag ) */
/* 43 */    "<=",                       /* ( n1 n2 -- flag ) */
/* 44 */    "between",                  /* ( n min max -- flag ) */
/* 45 */    "within",                   /* ( n min max -- flag ) */
/* 46 */    "drop",                     /* ( n -- ) */
/* 47 */    "dup",                      /* ( n -- n n ) */
/* 48 */    "over",                     /* ( n1 n2 -- n1 n2 n1 ) */
/* 49 */    "swap",                     /* ( n1 n2 -- n2 n1 ) */
/* 4a */    "rot",                      /* ( n1 n2 n3 -- n2 n3 n1 ) */
/* 4b */    "-rot",                     /* ( n1 n2 n3 -- n3 n1 n2 ) */
/* 4c */    "tuck",                     /* ( n1 n2 -- n2 n1 n2 ) */
/* 4d */    "nip",                      /* ( n1 n2 -- n2 ) */
/* 4e */    "pick",                     /* ( +n -- n2 ) */
/* 4f */    "roll",                     /* ( +n -- ) */
/* 50 */    "?dup",                     /* ( n -- n n | 0 ) */
/* 51 */    "depth",                    /* ( -- +n ) */
/* 52 */    "2drop",                    /* ( n1 n2 -- ) */
/* 53 */    "2dup",                     /* ( n1 n2 -- n1 n2 n1 n2 ) */
/* 54 */    "2over",                    /* ( n1 n2 n3 n4 -- n1 n2 n3 n4 n1 n2 ) */
/* 55 */    "2swap",                    /* ( n1 n2 n3 n4 -- n3 n4 n1 n2 ) */
/* 56 */    "2rot",                     /* ( n1 n2 n3 n4 n5 n6 -- n3 n4 n5 n6 n1 n2 ) */
/* 57 */    "2/",                       /* ( n1 -- n2 ) */
/* 58 */    "u2/",                      /* ( u1 -- u2 ) */
/* 59 */    "2*",                       /* ( n1 -- n2 ) */
/* 5a */    "/c",                       /* ( -- n ) */
/* 5b */    "/w",                       /* ( -- n ) */
/* 5c */    "/l",                       /* ( -- n ) */
/* 5d */    "/n",                       /* ( -- n ) */
/* 5e */    "ca+",                      /* ( adr1 index -- adr2 ) */
/* 5f */    "wa+",                      /* ( adr1 index -- adr2 ) */
/* 60 */    "la+",                      /* ( adr1 index -- adr2 ) */
/* 61 */    "na+",                      /* ( adr1 index -- adr2 ) */
/* 62 */    "ca1+",                     /* ( adr1 -- adr2 ) */
/* 63 */    "wa1+",                     /* ( adr1 -- adr2 ) */
/* 64 */    "la1+",                     /* ( adr1 -- adr2 ) */
/* 65 */    "na1+",                     /* ( adr1 -- adr2 ) */
/* 66 */    "/c*",                      /* ( n1 -- n2 ) */
/* 67 */    "/w*",                      /* ( n1 -- n2 ) */
/* 68 */    "/l*",                      /* ( n1 -- n2 ) */
/* 69 */    "/n*",                      /* ( n1 -- n2 ) */
/* 6a */    "on",                       /* ( adr -- ) */
/* 6b */    "off",                      /* ( adr -- ) */
/* 6c */    "+!",                       /* ( n adr -- ) */
/* 6d */    "@",                        /* ( adr -- n ) */
/* 6e */    "l@",                       /* ( adr -- long ) */
/* 6f */    "w@",                       /* ( adr -- word ) */
/* 70 */    "<w@",                      /* ( adr -- n ) */
/* 71 */    "c@",                       /* ( adr -- byte ) */
/* 72 */    "!",                        /* ( n adr -- ) */
/* 73 */    "l!",                       /* ( long adr -- ) */
/* 74 */    "w!",                       /* ( word adr -- ) */
/* 75 */    "c!",                       /* ( byte adr -- ) */
/* 76 */    "2@",                       /* ( adr -- n1 n2 ) */
/* 77 */    "2!",                       /* ( n1 n2 adr -- ) */
/* 78 */    "move",                     /* ( adr1 adr2 u -- ) */
/* 79 */    "fill",                     /* ( adr u byte -- ) */
/* 7a */    "comp",                     /* ( adr1 adr2 len -- n ) */
/* 7b */    "noop",                     /* ( -- ) */
/* 7c */    "lwsplit",                  /* ( long -- w1 w2 ) */
/* 7d */    "wljoin",                   /* ( w1 w2 -- long ) */
/* 7e */    "lbsplit",                  /* ( long -- b1 b2 b3 b4 ) */
/* 7f */    "bljoin",                   /* ( b1 b2 b3 b4 -- long ) */
/* 80 */    "flip",                     /* ( w1 -- w2 ) */
/* 81 */    "upc",                      /* ( char -- upper-case-char ) */
/* 82 */    "lcc",                      /* ( char -- lower-case-char ) */
/* 83 */    "pack",                     /* ( adr len pstr -- pstr ) */
/* 84 */    "count",                    /* ( pstr -- adr +n ) */
/* 85 */    "body>",                    /* ( apf -- acf ) */
/* 86 */    ">body",                    /* ( acf -- apf ) */
/* 87 */    "version",                  /* ( -- n ) */
/* 88 */    "span",                     /* ( -- adr ) */
/* 89 */    NULL,
/* 8a */    "expect",                   /* ( adr +n -- ) */
/* 8b */    "alloc-mem",                /* ( nbytes -- adr ) */
/* 8c */    "free-mem",                 /* ( adr nbytes -- ) */
/* 8d */    "key?",                     /* ( -- flag ) */
/* 8e */    "key",                      /* ( -- char ) */
/* 8f */    "emit",                     /* ( char -- ) */
/* 90 */    "type",                     /* ( adr +n -- ) */
/* 91 */    "(cr",                      /* ( -- ) */
/* 92 */    "cr",                       /* ( -- ) */
/* 93 */    "#out",                     /* ( -- adr ) */
/* 94 */    "#line",                    /* ( -- adr ) */
/* 95 */    "hold",                     /* ( char -- ) */
/* 96 */    "<#",                       /* ( -- ) */
/* 97 */    "#>",                       /* ( l -- adr +n ) */
/* 98 */    "sign",                     /* ( n -- ) */
/* 99 */    "#",                        /* ( +l1 -- +l2 ) */
/* 9a */    "#s",                       /* ( +l -- 0 ) */
/* 9b */    "u.",                       /* ( u -- ) */
/* 9c */    "u.r",                      /* ( u +n -- ) */
/* 9d */    ".",                        /* ( n -- ) */
/* 9e */    ".r",                       /* ( n +n -- ) */
/* 9f */    ".s",                       /* ( -- ) */
/* a0 */    "base",                     /* ( -- adr ) */
/* a1 */    NULL,
/* a2 */    "$number",                  /* ( adr len -- true | n false ) */
/* a3 */    "digit",                    /* ( char base -- digit true | char false ) */
/* a4 */    "-1",                       /* ( -- -1 ) */
/* a5 */    "0",                        /* ( -- 0 ) */
/* a6 */    "1",                        /* ( -- 1 ) */
/* a7 */    "2",                        /* ( -- 2 ) */
/* a8 */    "3",                        /* ( -- 3 ) */
/* a9 */    "bl",                       /* ( -- n ) */
/* aa */    "bs",                       /* ( -- n ) */
/* ab */    "bell",                     /* ( -- n ) */
/* ac */    "bounds",                   /* ( startadr len -- endadr startadr ) */
/* ad */    "here",                     /* ( -- adr ) */
/* ae */    "aligned",                  /* ( adr1 -- adr2 ) */
/* af */    "wbsplit",                  /* ( word -- b1 b2 ) */
/* b0 */    "bwjoin",                   /* ( b1 b2 -- word ) */
/* b1 */    NULL,
/* b2 */    NULL,
/* b3 */    NULL,
/* b4 */    NULL,
/* b5 */    NULL,
/* b6 */    NULL,
/* b7 */    NULL,
/* b8 */    NULL,
/* b9 */    NULL,
/* ba */    NULL,
/* bb */    NULL,
/* bc */    NULL,
/* bd */    NULL,
/* be */    NULL,
/* bf */    NULL,
/* c0 */    "instance",                 /* ( -- ) */
/* c1 */    NULL,
/* c2 */    NULL,
/* c3 */    "is",                       /* ( n -- ) */
/* c4 */    NULL,
/* c5 */    NULL,
/* c6 */    NULL,
/* c7 */    NULL,
/* c8 */    NULL,
/* c9 */    NULL,
/* ca */    NULL,
/* cb */    "$find",                    /* ( adr len -- adr len false | acf +-1 ) */
/* cc */    NULL,
/* cd */    "eval",                     /* ( ??? adr len -- ? ) */
/* ce */    NULL,
/* cf */    NULL,
/* d0 */    "c,",                       /* ( byte -- ) */
/* d1 */    "w,",                       /* ( word -- ) */
/* d2 */    "l,",                       /* ( long -- ) */
/* d3 */    ",",                        /* ( n -- ) */
/* d4 */    "u*x",                      /* ( u1_32 u2_32 -- product_64 ) */
/* d5 */    "xu/mod",                   /* ( u1_64 u2_32 -- remainder_32 quot_32 ) */
/* d6 */    "x+",                       /* ( x1 x2 -- x3 ) */
/* d7 */    "x-",                       /* ( x1 x2 -- x3 ) */
/* d8 */    NULL,
/* d9 */    NULL,
/* da */    NULL,
/* db */    NULL,
/* dc */    NULL,
/* dd */    NULL,
/* de */    NULL,
/* df */    NULL,
/* e0 */    NULL,
/* e1 */    NULL,
/* e2 */    NULL,
/* e3 */    NULL,
/* e4 */    NULL,
/* e5 */    NULL,
/* e6 */    NULL,
/* e7 */    NULL,
/* e8 */    NULL,
/* e9 */    NULL,
/* ea */    NULL,
/* eb */    NULL,
/* ec */    NULL,
/* ed */    NULL,
/* ee */    NULL,
/* ef */    NULL,
/* f0 */    NULL,
/* f1 */    NULL,
/* f2 */    NULL,
/* f3 */    NULL,
/* f4 */    NULL,
/* f5 */    NULL,
/* f6 */    NULL,
/* f7 */    NULL,
/* f8 */    NULL,
/* f9 */    NULL,
/* fa */    NULL,
/* fb */    NULL,
/* fc */    "ferror",                   /* ( -- ) */
/* fd */    NULL,
/* fe */    NULL,
/* ff */    NULL,
/* 01 00 */ NULL,
/* 01 01 */ "dma-alloc",                /* ( nbytes -- virt ) */
/* 01 02 */ "my-address",               /* ( -- phys ) */
/* 01 03 */ "my-space",                 /* ( -- space ) */
/* 01 04 */ "memmap",                   /* ( physoffset space size -- virtual ) */
/* 01 05 */ "free-virtual",             /* ( virt nbytes -- ) */
/* 01 06 */ ">physical",                /* ( virt -- phys space ) */
/* 01 07 */ NULL,
/* 01 08 */ NULL,
/* 01 09 */ NULL,
/* 01 0a */ NULL,
/* 01 0b */ NULL,
/* 01 0c */ NULL,
/* 01 0d */ NULL,
/* 01 0e */ NULL,
/* 01 0f */ "my-params",                /* ( -- adr len ) */
/* 01 10 */ "attribute",                /* ( xdr-adr xdr-len name-adr name-len -- ) */
/* 01 11 */ "xdrint",                   /* ( n -- xdr-adr xdr-len ) */
/* 01 12 */ "xdr+",                     /* ( xdr-adr1 xdr-len1 xdr-adr2 xdr-len2 -- xdr-adr xdr-len ) */
/* 01 13 */ "xdrphys",                  /* ( phys space -- xdr-adr xdr-len ) */
/* 01 14 */ "xdrstring",                /* ( adr len -- xdr-adr xdr-len ) */
/* 01 15 */ "xdrbytes",                 /* ( adr len -- xdr-adr xdr-len ) */
/* 01 16 */ "reg",                      /* ( phys space size -- ) */
/* 01 17 */ "intr",                     /* ( intr-level vector -- ) */
/* 01 18 */ "driver",                   /* ( adr len -- ) */
/* 01 19 */ "model",                    /* ( adr len -- ) */
/* 01 1a */ "device-type",              /* ( adr len -- ) */
/* 01 1b */ "decode-2int",              /* ( xdr-adr xdr-len -- phys space ) */
/* 01 1c */ "is-install",               /* ( acf -- ) */
/* 01 1d */ "is-remove",                /* ( acf -- ) */
/* 01 1e */ "is-selftest",              /* ( acf -- ) */
/* 01 1f */ "new-device",               /* ( -- ) */
/* 01 20 */ "diagnostic-mode?",         /* ( -- flag ) */
/* 01 21 */ "display-status",           /* ( n -- ) */
/* 01 22 */ "memory-test-suite",        /* ( adr len -- status ) */
/* 01 23 */ "group-code",               /* ( -- adr ) */
/* 01 24 */ "mask",                     /* ( -- adr ) */
/* 01 25 */ "get-msecs",                /* ( -- ms ) */
/* 01 26 */ "ms",                       /* ( n -- ) */
/* 01 27 */ "finish-device",            /* ( -- ) */
/* 01 28 */ NULL,
/* 01 29 */ NULL,
/* 01 2a */ NULL,
/* 01 2b */ NULL,
/* 01 2c */ NULL,
/* 01 2d */ NULL,
/* 01 2e */ NULL,
/* 01 2f */ NULL,
/* 01 30 */ "map-sbus",                 /* ( phys size -- virt ) */
/* 01 31 */ "sbus-intr>cpu",            /* ( sbus-intr# -- cpu-intr# ) */
/* 01 32 */ NULL,
/* 01 33 */ NULL,
/* 01 34 */ NULL,
/* 01 35 */ NULL,
/* 01 36 */ NULL,
/* 01 37 */ NULL,
/* 01 38 */ NULL,
/* 01 39 */ NULL,
/* 01 3a */ NULL,
/* 01 3b */ NULL,
/* 01 3c */ NULL,
/* 01 3d */ NULL,
/* 01 3e */ NULL,
/* 01 3f */ NULL,
/* 01 40 */ NULL,
/* 01 41 */ NULL,
/* 01 42 */ NULL,
/* 01 43 */ NULL,
/* 01 44 */ NULL,
/* 01 45 */ NULL,
/* 01 46 */ NULL,
/* 01 47 */ NULL,
/* 01 48 */ NULL,
/* 01 49 */ NULL,
/* 01 4a */ NULL,
/* 01 4b */ NULL,
/* 01 4c */ NULL,
/* 01 4d */ NULL,
/* 01 4e */ NULL,
/* 01 4f */ NULL,
/* 01 50 */ "#lines",                   /* ( -- n ) */
/* 01 51 */ "#columns",                 /* ( -- n ) */
/* 01 52 */ "line#",                    /* ( -- n ) */
/* 01 53 */ "column#",                  /* ( -- n ) */
/* 01 54 */ "inverse?",                 /* ( -- flag ) */
/* 01 55 */ "inverse-screen?",          /* ( -- flag ) */
/* 01 56 */ NULL,
/* 01 57 */ "draw-character",           /* ( char -- ) */
/* 01 58 */ "reset-screen",             /* ( -- ) */
/* 01 59 */ "toggle-cursor",            /* ( -- ) */
/* 01 5a */ "erase-screen",             /* ( -- ) */
/* 01 5b */ "blink-screen",             /* ( -- ) */
/* 01 5c */ "invert-screen",            /* ( -- ) */
/* 01 5d */ "insert-characters",        /* ( n -- ) */
/* 01 5e */ "delete-characters",        /* ( n -- ) */
/* 01 5f */ "insert-lines",             /* ( n -- ) */
/* 01 60 */ "delete-lines",             /* ( n -- ) */
/* 01 61 */ "draw-logo",                /* ( line# logoaddr logowidth logoheight -- ) */
/* 01 62 */ "frame-buffer-adr",         /* ( -- adr ) */
/* 01 63 */ "screen-height",            /* ( -- n ) */
/* 01 64 */ "screen-width",             /* ( -- n ) */
/* 01 65 */ "window-top",               /* ( -- n ) */
/* 01 66 */ "window-left",              /* ( -- n ) */
/* 01 67 */ NULL,
/* 01 68 */ NULL,
/* 01 69 */ NULL,
/* 01 6a */ "default-font",             /* ( -- fontbase charwidth charheight fontbytes #firstchar #chars ) */
/* 01 6b */ "set-font",                 /* ( fontbase charwidth charheight fontbytes #firstchar #chars -- ) */
/* 01 6c */ "char-height",              /* ( -- n ) */
/* 01 6d */ "char-width",               /* ( -- n ) */
/* 01 6e */ ">font",                    /* ( char -- adr ) */
/* 01 6f */ "fontbytes",                /* ( -- n ) */
/* 01 70 */ "fb1-draw-character",       /* ( char -- ) */
/* 01 71 */ "fb1-reset-screen",         /* ( -- ) */
/* 01 72 */ "fb1-toggle-cursor",        /* ( -- ) */
/* 01 73 */ "fb1-erase-screen",         /* ( -- ) */
/* 01 74 */ "fb1-blink-screen",         /* ( -- ) */
/* 01 75 */ "fb1-invert-screen",        /* ( -- ) */
/* 01 76 */ "fb1-insert-characters",    /* ( n -- ) */
/* 01 77 */ "fb1-delete-characters",    /* ( n -- ) */
/* 01 78 */ "fb1-insert-lines",         /* ( n -- ) */
/* 01 79 */ "fb1-delete-lines",         /* ( n -- ) */
/* 01 7a */ "fb1-draw-logo",            /* ( line# logoaddr logow logoh -- ) */
/* 01 7b */ "fb1-install",              /* ( width height #columns #lines -- ) */
/* 01 7c */ "fb1-slide-up",             /* ( n -- ) */
/* 01 7d */ NULL,
/* 01 7e */ NULL,
/* 01 7f */ NULL,
/* 01 80 */ "fb8-draw-character",       /* ( char -- ) */
/* 01 81 */ "fb8-reset-screen",         /* ( -- ) */
/* 01 82 */ "fb8-toggle-cursor",        /* ( -- ) */
/* 01 83 */ "fb8-erase-screen",         /* ( -- ) */
/* 01 84 */ "fb8-blink-screen",         /* ( -- ) */
/* 01 85 */ "fb8-invert-screen",        /* ( -- ) */
/* 01 86 */ "fb8-insert-characters",    /* ( n -- ) */
/* 01 87 */ "fb8-delete-characters",    /* ( n -- ) */
/* 01 88 */ "fb8-insert-lines",         /* ( n -- ) */
/* 01 89 */ "fb8-delete-lines",         /* ( n -- ) */
/* 01 8a */ "fb8-draw-logo",            /* ( line# logoaddr logow logoh -- ) */
/* 01 8b */ "fb8-install",              /* ( width height #columns #lines -- ) */
/* 01 8c */ NULL,
/* 01 8d */ NULL,
/* 01 8e */ NULL,
/* 01 8f */ NULL,
/* 01 90 */ NULL,
/* 01 91 */ NULL,
/* 01 92 */ NULL,
/* 01 93 */ NULL,
/* 01 94 */ NULL,
/* 01 95 */ NULL,
/* 01 96 */ NULL,
/* 01 97 */ NULL,
/* 01 98 */ NULL,
/* 01 99 */ NULL,
/* 01 9a */ NULL,
/* 01 9b */ NULL,
/* 01 9c */ NULL,
/* 01 9d */ NULL,
/* 01 9e */ NULL,
/* 01 9f */ NULL,
/* 01 a0 */ NULL,
/* 01 a1 */ NULL,
/* 01 a2 */ NULL,
/* 01 a3 */ NULL,
/* 01 a4 */ "mac-address",              /* ( -- adr len ) */
/* 01 a5 */ NULL,
/* 01 a6 */ NULL,
/* 01 a7 */ NULL,
/* 01 a8 */ NULL,
/* 01 a9 */ NULL,
/* 01 aa */ NULL,
/* 01 ab */ NULL,
/* 01 ac */ NULL,
/* 01 ad */ NULL,
/* 01 ae */ NULL,
/* 01 af */ NULL,
/* 01 b0 */ NULL,
/* 01 b1 */ NULL,
/* 01 b2 */ NULL,
/* 01 b3 */ NULL,
/* 01 b4 */ NULL,
/* 01 b5 */ NULL,
/* 01 b6 */ NULL,
/* 01 b7 */ NULL,
/* 01 b8 */ NULL,
/* 01 b9 */ NULL,
/* 01 ba */ NULL,
/* 01 bb */ NULL,
/* 01 bc */ NULL,
/* 01 bd */ NULL,
/* 01 be */ NULL,
/* 01 bf */ NULL,
/* 01 c0 */ NULL,
/* 01 c1 */ NULL,
/* 01 c2 */ NULL,
/* 01 c3 */ NULL,
/* 01 c4 */ NULL,
/* 01 c5 */ NULL,
/* 01 c6 */ NULL,
/* 01 c7 */ NULL,
/* 01 c8 */ NULL,
/* 01 c9 */ NULL,
/* 01 ca */ NULL,
/* 01 cb */ NULL,
/* 01 cc */ NULL,
/* 01 cd */ NULL,
/* 01 ce */ NULL,
/* 01 cf */ NULL,
/* 01 d0 */ NULL,
/* 01 d1 */ NULL,
/* 01 d2 */ NULL,
/* 01 d3 */ NULL,
/* 01 d4 */ NULL,
/* 01 d5 */ NULL,
/* 01 d6 */ NULL,
/* 01 d7 */ NULL,
/* 01 d8 */ NULL,
/* 01 d9 */ NULL,
/* 01 da */ NULL,
/* 01 db */ NULL,
/* 01 dc */ NULL,
/* 01 dd */ NULL,
/* 01 de */ NULL,
/* 01 df */ NULL,
/* 01 e0 */ NULL,
/* 01 e1 */ NULL,
/* 01 e2 */ NULL,
/* 01 e3 */ NULL,
/* 01 e4 */ NULL,
/* 01 e5 */ NULL,
/* 01 e6 */ NULL,
/* 01 e7 */ NULL,
/* 01 e8 */ NULL,
/* 01 e9 */ NULL,
/* 01 ea */ NULL,
/* 01 eb */ NULL,
/* 01 ec */ NULL,
/* 01 ed */ NULL,
/* 01 ee */ NULL,
/* 01 ef */ NULL,
/* 01 f0 */ NULL,
/* 01 f1 */ NULL,
/* 01 f2 */ NULL,
/* 01 f3 */ NULL,
/* 01 f4 */ NULL,
/* 01 f5 */ NULL,
/* 01 f6 */ NULL,
/* 01 f7 */ NULL,
/* 01 f8 */ NULL,
/* 01 f9 */ NULL,
/* 01 fa */ NULL,
/* 01 fb */ NULL,
/* 01 fc */ NULL,
/* 01 fd */ NULL,
/* 01 fe */ NULL,
/* 01 ff */ NULL,
/* 02 00 */ NULL,
/* 02 01 */ "device-name",              /* ( adr len -- ) */
/* 02 02 */ "my-args",                  /* ( -- adr len ) */
/* 02 03 */ "my-self",                  /* ( -- ihandle ) */
/* 02 04 */ "find-package",             /* ( adr len -- false | phandle true ) */
/* 02 05 */ "open-package",             /* ( adr len phandle -- ihandle | 0 ) */
/* 02 06 */ "close-package",            /* ( ihandle -- ) */
/* 02 07 */ "find-method",              /* ( adr len phandle -- false | acf true ) */
/* 02 08 */ "call-package",             /* ( [...] acf ihandle -- [...] ) */
/* 02 09 */ "$call-parent",             /* ( [...] adr len -- [...] ) */
/* 02 0a */ "my-parent",                /* ( -- ihandle ) */
/* 02 0b */ "ihandle>phandle",          /* ( ihandle -- phandle ) */
/* 02 0c */ NULL,
/* 02 0d */ "my-unit",                  /* ( -- low high ) */
/* 02 0e */ "$call-method",             /* ( [...] adr len ihandle -- [...] ) */
/* 02 0f */ "$open-package",            /* ( arg-adr arg-len adr len -- ihandle | 0 ) */
/* 02 10 */ "processor-type",           /* ( -- processor-type ) */
/* 02 11 */ "firmware-version",         /* ( -- n ) */
/* 02 12 */ "fcode-version",            /* ( -- n ) */
/* 02 13 */ "alarm",                    /* ( acf n -- ) */
/* 02 14 */ "(is-user-word)",           /* ( adr len acf -- ) */
/* 02 15 */ "suspend-fcode",            /* ( -- ) */
/* 02 16 */ "abort",                    /* ( -- ) */
/* 02 17 */ "catch",                    /* ( [...] acf -- [...] error-code ) */
/* 02 18 */ "throw",                    /* ( error-code -- ) */
/* 02 19 */ "user-abort",               /* ( -- ) */
/* 02 1a */ "get-my-attribute",         /* ( nam-adr nam-len -- true | xdr-adr xdr-len false ) */
/* 02 1b */ "xdrtoint",                 /* ( xdr-adr xdr-len -- xdr2-adr xdr2-len n ) */
/* 02 1c */ "xdrtostring",              /* ( xdr-adr xdr-len -- xdr2-adr xdr2-len adr len ) */
/* 02 1d */ "get-inherited-attribute",  /* ( nam-adr nam-len -- true | xdr-adr xdr-len false ) */
/* 02 1e */ "delete-attribute",         /* ( nam-adr nam-len -- ) */
/* 02 1f */ "get-package-attribute",    /* ( adr len phandle -- true | xdr-adr xdr-len false ) */
/* 02 20 */ "cpeek",                    /* ( adr -- false | byte true ) */
/* 02 21 */ "wpeek",                    /* ( adr -- false | word true ) */
/* 02 22 */ "lpeek",                    /* ( adr -- false | long true ) */
/* 02 23 */ "cpoke",                    /* ( byte adr -- ok? ) */
/* 02 24 */ "wpoke",                    /* ( word adr -- ok? ) */
/* 02 25 */ "lpoke",                    /* ( long adr -- ok? ) */
/* 02 26 */ NULL,
/* 02 27 */ NULL,
/* 02 28 */ NULL,
/* 02 29 */ NULL,
/* 02 2a */ NULL,
/* 02 2b */ NULL,
/* 02 2c */ NULL,
/* 02 2d */ NULL,
/* 02 2e */ NULL,
/* 02 2f */ NULL,
/* 02 30 */ "rb@",                      /* ( adr -- byte ) */
/* 02 31 */ "rb!",                      /* ( byte adr -- ) */
/* 02 32 */ "rw@",                      /* ( adr -- word ) */
/* 02 33 */ "rw!",                      /* ( word adr -- ) */
/* 02 34 */ "rl@",                      /* ( adr -- long ) */
/* 02 35 */ "rl!",                      /* ( long adr -- ) */
/* 02 36 */ "wflips",                   /* ( adr len -- ) */
/* 02 37 */ "lflips",                   /* ( adr len -- ) */
/* 02 38 */ "probe",                    /* ( arg-adr arg-len reg-adr reg-len fcode-adr fcode-len -- ) */
/* 02 39 */ "probe-virtual",            /* ( arg-adr arg-len reg-adr reg-len fcode-adr -- ) */
/* 02 3a */ NULL,
/* 02 3b */ "child",                    /* ( phandle -- child-phandle ) */
/* 02 3c */ "peer",                     /* ( phandle -- peer-phandle ) */
/* 02 3d */ NULL,
/* 02 3e */ NULL,
/* 02 3f */ NULL,
/* 02 40 */ "left-parse-string",        /* ( adr len char -- adrR lenR adrL lenL ) */
/* 02 41 */ NULL,
/* 02 42 */ NULL,
/* 02 43 */ NULL,
/* 02 44 */ NULL,
/* 02 45 */ NULL,
/* 02 46 */ NULL,
/* 02 47 */ NULL,
/* 02 48 */ NULL,
/* 02 49 */ NULL,
/* 02 4a */ NULL,
/* 02 4b */ NULL,
/* 02 4c */ NULL,
/* 02 4d */ NULL,
/* 02 4e */ NULL,
/* 02 4f */ NULL,
/* 02 50 */ NULL,
/* 02 51 */ NULL,
/* 02 52 */ NULL,
/* 02 53 */ NULL,
/* 02 54 */ NULL,
/* 02 55 */ NULL,
/* 02 56 */ NULL,
/* 02 57 */ NULL,
/* 02 58 */ NULL,
/* 02 59 */ NULL,
/* 02 5a */ NULL,
/* 02 5b */ NULL,
/* 02 5c */ NULL,
/* 02 5d */ NULL,
/* 02 5e */ NULL,
/* 02 5f */ NULL,
/* 02 60 */ NULL,
/* 02 61 */ NULL,
/* 02 62 */ NULL,
/* 02 63 */ NULL,
/* 02 64 */ NULL,
/* 02 65 */ NULL,
/* 02 66 */ NULL,
/* 02 67 */ NULL,
/* 02 68 */ NULL,
/* 02 69 */ NULL,
/* 02 6a */ NULL,
/* 02 6b */ NULL,
/* 02 6c */ NULL,
/* 02 6d */ NULL,
/* 02 6e */ NULL,
/* 02 6f */ NULL,
/* 02 70 */ NULL,
/* 02 71 */ NULL,
/* 02 72 */ NULL,
/* 02 73 */ NULL,
/* 02 74 */ NULL,
/* 02 75 */ NULL,
/* 02 76 */ NULL,
/* 02 77 */ NULL,
/* 02 78 */ NULL,
/* 02 79 */ NULL,
/* 02 7a */ NULL,
/* 02 7b */ NULL,
/* 02 7c */ NULL,
/* 02 7d */ NULL,
/* 02 7e */ NULL,
/* 02 7f */ NULL,
/* 02 80 */ NULL,
/* 02 81 */ NULL,
/* 02 82 */ NULL,
/* 02 83 */ NULL,
/* 02 84 */ NULL,
/* 02 85 */ NULL,
/* 02 86 */ NULL,
/* 02 87 */ NULL,
/* 02 88 */ NULL,
/* 02 89 */ NULL,
/* 02 8a */ NULL,
/* 02 8b */ NULL,
/* 02 8c */ NULL,
/* 02 8d */ NULL,
/* 02 8e */ NULL,
/* 02 8f */ NULL,
/* 02 90 */ NULL,
/* 02 91 */ NULL,
/* 02 92 */ NULL,
/* 02 93 */ NULL,
/* 02 94 */ NULL,
/* 02 95 */ NULL,
/* 02 96 */ NULL,
/* 02 97 */ NULL,
/* 02 98 */ NULL,
/* 02 99 */ NULL,
/* 02 9a */ NULL,
/* 02 9b */ NULL,
/* 02 9c */ NULL,
/* 02 9d */ NULL,
/* 02 9e */ NULL,
/* 02 9f */ NULL,
/* 02 a0 */ NULL,
/* 02 a1 */ NULL,
/* 02 a2 */ NULL,
/* 02 a3 */ NULL,
/* 02 a4 */ NULL,
/* 02 a5 */ NULL,
/* 02 a6 */ NULL,
/* 02 a7 */ NULL,
/* 02 a8 */ NULL,
/* 02 a9 */ NULL,
/* 02 aa */ NULL,
/* 02 ab */ NULL,
/* 02 ac */ NULL,
/* 02 ad */ NULL,
/* 02 ae */ NULL,
/* 02 af */ NULL,
/* 02 b0 */ NULL,
/* 02 b1 */ NULL,
/* 02 b2 */ NULL,
/* 02 b3 */ NULL,
/* 02 b4 */ NULL,
/* 02 b5 */ NULL,
/* 02 b6 */ NULL,
/* 02 b7 */ NULL,
/* 02 b8 */ NULL,
/* 02 b9 */ NULL,
/* 02 ba */ NULL,
/* 02 bb */ NULL,
/* 02 bc */ NULL,
/* 02 bd */ NULL,
/* 02 be */ NULL,
/* 02 bf */ NULL,
/* 02 c0 */ NULL,
/* 02 c1 */ NULL,
/* 02 c2 */ NULL,
/* 02 c3 */ NULL,
/* 02 c4 */ NULL,
/* 02 c5 */ NULL,
/* 02 c6 */ NULL,
/* 02 c7 */ NULL,
/* 02 c8 */ NULL,
/* 02 c9 */ NULL,
/* 02 ca */ NULL,
/* 02 cb */ NULL,
/* 02 cc */ NULL,
/* 02 cd */ NULL,
/* 02 ce */ NULL,
/* 02 cf */ NULL,
/* 02 d0 */ NULL,
/* 02 d1 */ NULL,
/* 02 d2 */ NULL,
/* 02 d3 */ NULL,
/* 02 d4 */ NULL,
/* 02 d5 */ NULL,
/* 02 d6 */ NULL,
/* 02 d7 */ NULL,
/* 02 d8 */ NULL,
/* 02 d9 */ NULL,
/* 02 da */ NULL,
/* 02 db */ NULL,
/* 02 dc */ NULL,
/* 02 dd */ NULL,
/* 02 de */ NULL,
/* 02 df */ NULL,
/* 02 e0 */ NULL,
/* 02 e1 */ NULL,
/* 02 e2 */ NULL,
/* 02 e3 */ NULL,
/* 02 e4 */ NULL,
/* 02 e5 */ NULL,
/* 02 e6 */ NULL,
/* 02 e7 */ NULL,
/* 02 e8 */ NULL,
/* 02 e9 */ NULL,
/* 02 ea */ NULL,
/* 02 eb */ NULL,
/* 02 ec */ NULL,
/* 02 ed */ NULL,
/* 02 ee */ NULL,
/* 02 ef */ NULL,
/* 02 f0 */ NULL,
/* 02 f1 */ NULL,
/* 02 f2 */ NULL,
/* 02 f3 */ NULL,
/* 02 f4 */ NULL,
/* 02 f5 */ NULL,
/* 02 f6 */ NULL,
/* 02 f7 */ NULL,
/* 02 f8 */ NULL,
/* 02 f9 */ NULL,
/* 02 fa */ NULL,
/* 02 fb */ NULL,
/* 02 fc */ NULL,
/* 02 fd */ NULL,
/* 02 fe */ NULL,
/* 02 ff */ NULL
};
