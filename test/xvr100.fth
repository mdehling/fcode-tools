tokenizer[
h# 1002 h# 5159 h# 030000 pci-header
h# c000 pci-vpd-offset
h# 0004 pci-code-revision
]tokenizer

\ f1 08 63a5 0000be20
fcode-version3 ( start1 )
hex

" "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c7 bf 00 20 02 10 08 09 00 00 00 00 00 00 00 00)"
2drop " SUNW,XVR-100" encode-string " name" property " SUNW,375-3126" model
" display" device-type

headers

: copyright ( 0800 )
    " Copyright (c) 2002 Sun Microsystems, Inc."
;

: sccsid ( 0801 )
    " @(#)xvr100.fth 1.61 03/12/18 SMI "
;

: prt-sccsid ( 0802 )
    sccsid type copyright type
;

ff ff ff ff bljoin constant num-32 ( 0803 )

: x-num ( 0804 )
    num-32 and
;

: and ( 0805 )
    x-num swap x-num and
;

: or ( 0806 )
    x-num swap x-num or
;

: lshift ( 0807 )
    lshift x-num
;

: rshift ( 0808 )
    rshift x-num
;

: conf-l@ ( 0809 )
    my-space + " config-l@" $call-parent
;

: conf-l! ( 080a )
    my-space + " config-l!" $call-parent
;

: conf-w@ ( 080b )
    my-space + " config-w@" $call-parent
;

: conf-w! ( 080c )
    my-space + " config-w!" $call-parent
;

: conf-b@ ( 080d )
    my-space + " config-b@" $call-parent
;

: conf-b! ( 080e )
    my-space + " config-b!" $call-parent
;

0 value uSec-wait-scale ( 080f )

: uSec-wait ( 0810 )
    f4240 * uSec-wait-scale / 0
    ?do
    loop
;

: uSec-wait-calibrate ( 0811 )
    get-msecs f4240 0
    do
    loop
    get-msecs swap - 3e8 * to uSec-wait-scale
;

0 value msec-timeout ( 0812 )

: msec-timer-start ( 0813 )
    get-msecs + to msec-timeout
;

: msec-timer-check ( 0814 )
    get-msecs msec-timeout >
;

headerless

: token-0815 ( 0815 )
    " r1152x900x66"
;

: token-0816 ( 0816 )
    " r640x480x60"
;

: token-0817 ( 0817 )
;

: token-0818 ( 0818 )
;

: token-0819 ( 0819 )
;

defer token-081a ( 081a )
defer token-081b ( 081b )
200 constant token-081c ( 081c )
600 constant token-081d ( 081d )
token-081c

headers

value pfb-current-depth ( 081e )
token-081c value pfb-default-depth ( 081f )
42 value pfb-current-vfreq ( 0820 )

: >bitdepth ( 0821 )
    dup token-081d =
    if
        drop 20 exit
    then
    token-081c =
    if
        8 exit
    then
;

: bitdepth> ( 0822 )
    dup 20 =
    if
        token-081d exit
    then
    8 =
    if
        token-081c exit
    then
;

0

headerless

value token-0823 ( 0823 )
0 value token-0824 ( 0824 )
0 value token-0825 ( 0825 )
1 constant token-0826 ( 0826 )
2 constant token-0827 ( 0827 )
14

headers

value pfb-blink-speed ( 0828 )
h# 0 constant truecolor-black ( 0829 )
ffffff constant truecolor-white ( 082a )
666699 constant truecolor-sunblue ( 082b )
0 value psuedocolor-black ( 082c )
ff value psuedocolor-white ( 082d )
1 value psuedocolor-sunblue ( 082e )

: n->l ( 082f )
    ff ff ff ff bljoin and
;

: n->w ( 0830 )
    ff ff bwjoin and
;

: compile-bytes ( 0831 )
    -rot >r >r tuck + swap r@ over + swap r> r> swap rot move
;

300 buffer: pfb-logo-cmap-buffer ( 0832 )
0 pfb-logo-cmap-buffer " "(ff ff ff)" compile-bytes
" "(00 00 00 59 4f bf 01 01 01 02 02 02 ff ff ff)" compile-bytes
" "(ec 00 0f 33 30 93 f7 74 1b 35 30 8e 57 4d bd)" compile-bytes
" "(56 4e b6 5b 52 c2 ef 26 0e 37 30 8e 40 2d 85)" compile-bytes
" "(f5 f7 fb 5d 51 bd ed 23 0e f5 2c 10 ec 00 08)" compile-bytes
" "(f1 2d 0f 56 2a 75 3f 2d 8b 37 2e 8a f2 37 12)" compile-bytes
" "(33 31 93 3b 2e 88 ec 15 0d 55 4b b8 e9 03 09)" compile-bytes
" "(f4 33 10 ee 00 09 3f 2e 87 58 4b ba e8 00 06)" compile-bytes
" "(f3 5f 19 ec 05 0b ef 41 13 1c 0d 28 5b 4d c1)" compile-bytes
" "(c7 11 25 6e 22 60 fa f2 38 e4 04 0c ee 17 0e)" compile-bytes
" "(63 24 69 76 76 77 3e 3b 5f ef 1c 0f 6a 62 ac)" compile-bytes
" "(e8 19 0d fc e7 2b a5 01 01 fd b5 22 fd da 39)" compile-bytes
" "(94 19 43 0f 0e 26 4a 2c 85 dc 03 0a 03 03 03)" compile-bytes
" "(8b 85 bf f5 f8 f6 56 4e c2 8a 1e 4c 54 2c 7a)" compile-bytes
" "(6a 25 65 46 2f 84 99 01 04 36 32 94 61 28 71)" compile-bytes
" "(c5 02 06 f2 0a 0c fc c9 25 d3 02 0b 7d 01 04)" compile-bytes
" "(fd eb 3e fc ed 36 e9 09 0c fd e7 3d fe de 29)" compile-bytes
" "(7c 1f 54 51 02 06 d9 11 13 44 30 87 51 28 7b)" compile-bytes
" "(27 23 73 38 30 8c fc d5 25 aa a6 d7 03 04 04)" compile-bytes
" "(31 0c 23 64 27 69 59 4e c1 ac 14 38 d3 01 01)" compile-bytes
" "(d9 d9 eb ef 04 0b 5b 4e bb be 01 03 a9 17 37)" compile-bytes
" "(8e 1a 45 47 2c 7e fc ce 2b e2 09 10 d7 09 0c)" compile-bytes
" "(af 0c 25 37 34 96 e8 11 0c cb 01 04 4d 2b 7e)" compile-bytes
" "(ae 10 33 7f 1a 48 3b 30 8f 57 11 2b 7b 21 57)" compile-bytes
" "(fd ed 3d 7e 0d 23 ee 09 0c 31 26 77 02 05 12)" compile-bytes
" "(71 25 60 5c 28 71 9b 12 38 d7 09 1e b8 01 04)" compile-bytes
" "(cf cc ed ee 0f 0e 1e 1a 4f c1 0b 1c e8 23 0c)" compile-bytes
" "(1d 02 09 fb ef 39 fc fe fb e3 00 09 ef 2f 10)" compile-bytes
" "(4f 1f 55 ec 03 0c fd e7 38 dc 00 07 5b 43 af)" compile-bytes
" "(bc 11 2c 82 1e 50 45 2d 89 3d 32 83 cc 0b 1d)" compile-bytes
" "(2e 1d 4f f3 0f 0d f1 00 0e 40 2f 88 fd bd 20)" compile-bytes
" "(f6 00 0a 55 4b c1 f4 1d 0e 5c 4e c2 f2 16 0e)" compile-bytes
" "(59 4e c7 fa 88 23 b0 01 04 f3 00 0d f2 04 0c)" compile-bytes
" "(9b 18 3f 73 21 5b 31 02 08 a3 9d d8 59 4b c2)" compile-bytes
" "(3c 2f 8a 53 2a 7d e9 00 0e 59 4e b6 f1 00 08)" compile-bytes
" "(f8 7f 06 e8 04 0e 58 4d c1 3a 2e 8c 0f 0a 25)" compile-bytes
" "(57 4f c0 5e 51 c4 37 30 95 be bd d2 07 0a 1f)" compile-bytes
" "(0c 00 0c 33 2f 91 33 2d 93 f4 53 1a 10 05 16)" compile-bytes
" "(f2 40 14 f4 3d 11 ed 0f 0e ed 1e 0e 07 05 12)" compile-bytes
" "(ff a7 2c ec 0a 0c ee 01 0e f5 6c 1e f3 49 16)" compile-bytes
" "(57 51 bc 59 4e bc f6 95 24 10 13 34 f9 90 04)" compile-bytes
" "(fa fc fe 3e 2e 8c ec 11 0d 59 50 b8 5a 4f c0)" compile-bytes
" "(f1 f2 ff 57 4f bd 39 2f 8f 35 2f 8f 58 50 c1)" compile-bytes
" "(fb ff fe fd a0 0e ec 17 0d 59 51 b6 59 52 b9)" compile-bytes
" "(ee 28 0c ed 1b 0d ec 08 0c 37 2e 93 5b 4f bc)" compile-bytes
" "(f4 28 0f f5 4c 15 5a 52 bd ec 0b 0d f3 23 0f)" compile-bytes
" "(59 50 c1 ec 1f 0d 58 51 c3 39 30 8c 32 2d 89)" compile-bytes
" "(fd ac 0c f4 45 13 5a 4f c8 f9 61 15 3b 2e 90)" compile-bytes
" "(ec 0d 0d 00 02 0c f6 56 11 fd fe fe fa 96 0d)" compile-bytes
" "(f9 76 07 3d 2e 8b ec 14 10 39 30 94 01 01 0e)" compile-bytes
" "(f3 41 0f 33 2f 8d)" compile-bytes drop
constant pfb-logo-cmap-buf-len ( 0833 )
64 constant pfb-logo-width ( 0834 )
64 constant pfb-logo-height ( 0835 )
pfb-logo-width pfb-logo-height * buffer: pfb-logo-buffer ( 0836 )
0 pfb-logo-buffer " "(c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0)"
compile-bytes " "(c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0)"
compile-bytes " "(c0 da e0 76 1e 23 20 69 7c a3 7b 64 5e a3 5b 40)"
compile-bytes " "(51 8e 8e 51 5b af 5c 46 46 46 7a 16 41 41 16 92)"
compile-bytes " "(b4 92 90 ca ca e5 d0 db b6 b7 6b b6 07 b4 56 56)"
compile-bytes " "(b4 b2 07 b2 56 af a6 71 71 18 09 b7 1a 07 af 56)"
compile-bytes " "(71 1b 71 f4 bc bc bc bc bc bc bc bc bc bc bc bc)"
compile-bytes " "(bc bc bc bc bc bc bc bc bc bc bc bc bc bc bc bc)"
compile-bytes " "(bc bc bc bc 7f 7f bc 48 1e 23 9f 68 91 52 8d 6f)"
compile-bytes " "(7b b5 38 40 8e 8e 70 5b b9 a2 5c 42 5c 46 7a 7a)"
compile-bytes " "(16 16 92 be 92 66 54 ca f2 a6 71 71 d1 57 07 b2)"
compile-bytes " "(6b 80 b4 07 be 09 1a 1a 56 af e5 f4 d0 d0 0e b2)"
compile-bytes " "(1a b6 c7 80 71 1b e5 f4 1c 1c 1c 1c 1c 1c 1c 1c)"
compile-bytes " "(1c 1c 1c 1c 1c 1c 1c 1c 1c 1c 1c 1c 1c 1c 1c 1c)"
compile-bytes " "(1c 1c 1c 1c 1c 1c 1c 1c 2d f3 f3 7f 25 aa aa 2c)"
compile-bytes " "(47 81 29 8d a3 72 38 38 38 40 72 b9 88 42 2a 2e)"
compile-bytes " "(2e 5c 7a 7a 7a 27 b5 88 66 54 17 17 f2 a6 ae d0)"
compile-bytes " "(b7 09 e6 6b b7 b7 b4 80 78 77 09 09 56 af 71 f4)"
compile-bytes " "(0e d0 09 1a b2 09 80 39 71 ae 1b 71 bd bd bd bd)"
compile-bytes " "(bd bd bd bd bd bd bd bd bd bd bd bd bd bd bd bd)"
compile-bytes " "(bd bd bd bd bd bd bd bd bd bd bd bd 31 31 31 31)"
compile-bytes " "(48 aa aa 23 4b 81 8d 81 a3 38 38 a1 38 70 ed 88)"
compile-bytes " "(79 79 2a 42 42 2e 46 7a af b9 66 66 43 8f 8f 8f)"
compile-bytes " "(95 95 a6 d0 0e db 57 b2 f4 09 c7 be 39 56 45 45)"
compile-bytes " "(56 af 71 f4 0e 71 d1 f7 b2 1a 77 be 71 71 1b 71)"
compile-bytes " "r"r"r"r"r"r"r"r"r"r"r"r"r"r"r"r" compile-bytes
" "r"r"r"r"r"r"r"r"r"r"r"r"r"r"r"r" compile-bytes
" "(0d 0d 0d dd 93 97 aa 14 81 29 91 a3 75 5e a1 a1)" compile-bytes
" "(75 b5 72 73 73 2a 79 2a 5c 42 88 b9 27 6e 6e 3a)" compile-bytes
" "(3a 3a 43 54 54 21 a6 eb 71 18 71 b2 09 80 b4 78)" compile-bytes
" "(80 80 b2 6b 56 af a6 d0 09 0e 0e f7 07 b6 0e 78)" compile-bytes
" "(77 71 21 d0 15 15 15 15 15 15 15 15 15 15 15 15)" compile-bytes
" "(15 15 15 15 15 15 15 15 15 15 15 15 15 15 15 15)" compile-bytes
" "(15 15 15 15 87 87 87 87 93 97 aa 14 91 7c 81 a3)" compile-bytes
" "(5e 5e 5e a1 a3 5b 8e 8e 51 73 2a 73 2a 88 83 27)" compile-bytes
" "(41 55 6e a7 6e 66 66 43 0f 21 f2 ca e5 f4 09 80)" compile-bytes
" "(78 c7 b7 b4 80 c7 b2 6b 56 af ca 18 09 0e db 09)" compile-bytes
" "(07 b6 45 c7 92 71 a6 ae 19 19 19 19 19 19 19 19)" compile-bytes
" "(19 19 19 19 19 19 19 19 19 19 19 19 19 19 19 19)" compile-bytes
" "(19 19 19 19 19 19 19 19 19 19 bb 19 1c 97 14 23)" compile-bytes
" "(7c 69 52 64 6f 6f 5e a3 a3 40 8e 8e 73 73 a2 a2)" compile-bytes
" "(72 b5 92 46 16 41 a7 a7 6e 6e 3a 43 8f 54 95 21)" compile-bytes
" "(ae 77 b4 b4 56 45 b2 80 c7 78 07 1a 77 39 95 a6)" compile-bytes
" "(0e db f4 57 b6 1a 09 80 c7 ca ca ae ba ba ba ba)" compile-bytes
" "(ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba ba)" compile-bytes
" "(ba ba ba ba ba ba ba ba ba ba ba ba ba f6 e8 ba)" compile-bytes
" "(9b 97 23 23 68 86 44 5e 6f 8d 52 83 65 65 40 8e)" compile-bytes
" "(8e 73 73 5b ed 88 46 7a 16 16 41 a7 3a 3a 3a 43)" compile-bytes
" "(8f 95 21 90 39 ed 56 0e e6 b2 57 e6 be 5a 0e 09)" compile-bytes
" "(77 39 a6 a6 0e d1 f4 09 f7 1a 09 56 b4 f2 ca 71)" compile-bytes
" "(c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3)" compile-bytes
" "(c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3 c3)" compile-bytes
" "(c3 26 de de 31 aa aa 14 3b 4b 6a 8d 8d 75 83 38)" compile-bytes
" "(38 38 65 40 40 70 5b be 2e 46 7a 7a 7a 7a 41 41)" compile-bytes
" "(a7 a7 6e 6e 3a 0f c7 3c 56 90 e5 d1 6b 6b b6 6b)" compile-bytes
" "(af 78 56 6b 56 39 ca a6 71 d0 0e d1 b6 b6 1a 1a)" compile-bytes
" "(04 ca ca e5 b8 b8 b8 b8 b8 b8 b8 b8 b8 b8 b8 b8)" compile-bytes
" "(b8 b8 b8 b8 b8 b8 b8 b8 b8 b8 b8 b8 b8 b8 b8 b8)" compile-bytes
" "(b8 b8 b8 b8 b8 b8 b8 ee 31 aa 14 20 06 81 29 8d)" compile-bytes
" "(6a 83 7b a1 38 38 65 40 70 83 27 2a 42 2e 2e 46)" compile-bytes
" "(7a 16 16 41 a7 55 6e 3a 92 be 39 90 90 a6 71 d1)" compile-bytes
" "(07 07 07 1a 80 ed 80 b2 56 39 f2 eb d0 d0 0e d1)" compile-bytes
" "(b6 b6 1a 1a b4 77 17 71 24 24 24 24 24 24 24 24)" compile-bytes
" $$$$$$$$$$$$$$$$" compile-bytes
" "(24 24 24 24 24 24 24 24 24 24 24 24 2d aa 23 aa)" compile-bytes
" "(4a 7c 91 81 a3 75 5e 7b 7b 38 38 72 5a 5b a2 42)" compile-bytes
" "(2a 42 5c 46 7a 7a 16 16 16 3a 92 b9 b9 56 ca 1b)" compile-bytes
" "(95 a6 ae d0 b6 07 1a 1a e6 f5 c7 1a 56 39 ca eb)" compile-bytes
" "(d0 d0 0e d1 d1 b6 1a 1a c7 80 8f 71 c2 c2 c2 c2)" compile-bytes
" "(c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2)" compile-bytes
" "(c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 c2 08)" compile-bytes
" "(93 aa 1e 20 81 91 7c 4b 75 7b 5e 64 a1 a1 72 b5)" compile-bytes
" "(72 73 79 79 42 5c 2e 2e 46 46 16 a7 66 27 b5 92)" compile-bytes
" "(8f 8f 0f 95 ca ae d0 f4 db b6 b6 b6 b2 c7 af 6b)" compile-bytes
" "(56 af ca eb e5 d0 d0 0e d1 b6 1a 1a 56 39 8f ca)" compile-bytes
" "(08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08)" compile-bytes
" "(08 08 08 08 08 08 08 08 08 08 08 08 08 08 08 08)" compile-bytes
" "(08 08 08 08 48 23 23 23 53 68 9e 4b 64 5e 6f 5e)" compile-bytes
" "(a1 52 83 70 51 73 a2 79 42 42 5c 46 46 46 88 27)" compile-bytes
" "(b5 92 66 43 66 54 17 95 ca 71 eb 71 0e b6 b6 09)" compile-bytes
" "(b2 56 78 b2 56 af ca 1b ae e5 d0 0e d1 b6 b6 1a)" compile-bytes
" "(e6 be 21 95 9d 9d 9d 9d 9d 9d 9d 9d 9d 9d 9d 9d)" compile-bytes
" "(9d 9d 9d 9d 9d 9d 9d 9d 9d 9d 9d 9d 9d 9d 9d 9d)" compile-bytes
" "(9d 9d 9d 9d 9d 9d 9d 08 97 23 1e 86 ac 7c 52 29)" compile-bytes
" "(6f 8d 5e 7b 52 83 70 8e 51 73 a2 79 a2 79 42 5c)" compile-bytes
" "(5c 92 b9 b9 66 66 6e 66 66 43 0f 0f f2 ca ae 18)" compile-bytes
" "(d0 0e d1 45 1a e6 78 e6 77 af ca 90 ae ae d0 0e)" compile-bytes
" "(d1 d1 b6 1a 6b f5 77 95 c6 c6 c6 c6 c6 c6 c6 c6)" compile-bytes
" "(c6 c6 c6 c6 c6 c6 c6 c6 c6 c6 c6 c6 c6 c6 c6 c6)" compile-bytes
" "(c6 c6 c6 c6 c6 c6 c6 c6 c6 c6 c6 ea aa 23 14 86)" compile-bytes
" "(a8 4b 81 8d 8d 8d 6f a3 83 65 40 8e 51 51 73 a2)" compile-bytes
" "(42 42 42 88 83 b9 92 41 a7 a7 3a 3a 3a 66 66 54)" compile-bytes
" "(95 f2 a6 18 71 0e b6 b6 1a b2 39 80 77 39 17 a6)" compile-bytes
" "(ae ae d0 0e 0e d1 b6 1a 6b 39 92 8f bf bf bf bf)" compile-bytes
" "(bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf)" compile-bytes
" "(bf bf bf bf bf bf bf bf bf bf bf bf bf bf bf ee)" compile-bytes
" "(48 97 20 1e 63 81 29 29 8d 8d 83 5b 65 40 65 40)" compile-bytes
" "(8e 51 73 8e 79 88 5b b5 92 16 41 a7 a7 a7 41 6e)" compile-bytes
" "(3a 8f 0f 43 21 1b a6 a6 71 09 db db 1a b2 80 b4)" compile-bytes
" "(56 39 ca f4 ae ae e5 0e 0e d1 b6 1a 1a 80 c7 17)" compile-bytes
" "(bf 36 36 36 36 36 36 36 bf 36 36 36 36 36 36 36)" compile-bytes
" "(36 36 36 36 36 36 36 36 bf bf 36 36 36 36 36 36)" compile-bytes
" "(36 96 bf f6 48 23 06 23 81 7c 7c 29 6a a3 72 a1)" compile-bytes
" "(38 38 65 40 40 8e 51 51 5b b9 5b 2e 46 7a 7a 16)" compile-bytes
" "(a7 a7 a7 3a 3a 3a 3a 43 17 17 ca ca eb d0 f4 b2)" compile-bytes
" "(09 0e 56 78 80 39 95 ca a6 71 71 d0 0e d1 b6 1a)" compile-bytes
" "(1a 77 be 8f 37 67 67 67 67 67 67 67 67 67 67 67)" compile-bytes
" gggggggggggggggg" compile-bytes
" "(67 67 67 67 67 37 49 ee 9b 68 8b 5f 53 7c 91 81)" compile-bytes
" "(a3 7b a1 a1 38 65 65 40 40 8e 72 b9 5b 88 5c 46)" compile-bytes
" "(46 7a 7a 16 16 41 a7 6e 6e 66 0f 21 0f 54 ca 1b)" compile-bytes
" "(a6 71 71 18 56 c7 b4 ed 80 af 90 eb a6 e5 71 d0)" compile-bytes
" "(0e d1 b6 1a 09 b6 5a 8f 8a 8a 4f 37 8a 8a 8a 8a)" compile-bytes
" "(37 37 4f 4f 4f 4f 4f 8a 8a 8a 8a 8a 8a 8a 8a 8a)" compile-bytes
" "(8a 8a 8a 8a 37 8a 4f 4f 4f 8a 96 58 bb 8b 4a ac)" compile-bytes
" "(53 53 4a 52 7b 6f 64 a1 a1 38 38 65 70 5b b9 72)" compile-bytes
" "(42 42 42 2e 46 7a 7a 16 16 41 41 6e 6e 66 43 43)" compile-bytes
" "(ca 17 17 eb 71 56 c7 78 b4 80 e6 b4 77 af 95 90)" compile-bytes
" "(a6 ca 71 d0 0e d1 b6 1a b2 1a b4 77 74 8a 4f 4c)" compile-bytes
" "(74 8a 4d 84 2b 2b 4d 84 4d 4d 4d 4d 74 74 74 74)" compile-bytes
" "(74 84 4d 4d 74 74 74 74 74 74 74 74 84 2b 58 50)" compile-bytes
" "(de 23 a8 14 68 3b 52 6f 5e 64 7b a1 a1 a1 65 5b)" compile-bytes
" "(be 5b 51 73 42 42 42 5c 46 46 7a 7a 41 41 a7 55)" compile-bytes
" "(6e 3a 3a 8f 54 54 77 c7 b4 b4 80 e6 07 6b 71 78)" compile-bytes
" "(80 c7 ca 1b ca ca ae e5 0e d1 b6 b6 b2 07 c7 80)" compile-bytes
" "(4d 74 74 74 84 2b 4d 74 74 4c 4c 4c 4c 74 74 74)" compile-bytes
" "(74 74 74 74 74 74 74 74 4c 4c 4c 4c 84 84 84 2b)" compile-bytes
" "(4d 34 58 58 99 a8 06 23 3b 4b 6f 8d 6f 5e 6f 64)" compile-bytes
" "(a1 72 b5 a3 70 73 a2 73 2a 2a 42 5c 2e 2e 46 7a)" compile-bytes
" "(a7 16 16 41 3a 3a 66 66 80 af be c7 77 f4 b7 f4)" compile-bytes
" "(45 b7 45 c7 c7 af 90 f4 ca ca ae e5 0e d1 d1 b6)" compile-bytes
" "(f7 6b 80 af f1 f1 f1 ab f1 ab ab f1 ab ab ab ab)" compile-bytes
" "(ab ab ab ab c8 c8 c8 c8 c8 c8 c8 c8 d4 d4 e7 e7)" compile-bytes
" "(e7 e7 e7 e7 e7 58 58 34 9b 4e 2c 8b 9e 8d 8d 6f)" compile-bytes
" "(6f 5e 64 75 83 a3 72 40 51 51 73 79 2a 2a 2a 5c)" compile-bytes
" "(5c 2e 7a 46 46 7a a7 3a 66 92 af ed 27 92 90 eb)" compile-bytes
" "(71 71 09 b2 f7 6b 6b 80 c7 39 ca 17 f2 ca ae e5)" compile-bytes
" "(0e d1 d1 b6 09 07 e6 ed d4 c8 ab d4 e7 96 50 4c)" compile-bytes
" "(4c 74 74 2b 2b 84 74 4c 4c 4c 4c 4c 4f 8a 8a 8a)" compile-bytes
" "(37 37 37 37 67 67 67 67 d4 15 aa 23 9f 8b 5f 81)" compile-bytes
" "(29 81 8d 29 64 6a 52 83 72 70 40 70 51 73 a2 73)" compile-bytes
" "(2a 79 42 42 5c 5c 46 46 41 16 88 27 b9 b9 80 90)" compile-bytes
" "(17 17 95 95 71 71 db b2 1a b2 b6 56 78 39 90 ca)" compile-bytes
" "(f2 ca a6 ae d0 0e d1 09 45 b6 b2 be 34 4d 8a 50)" compile-bytes
" "(e7 e7 d4 ab c8 d4 96 58 50 4d 84 74 4c 4c 4c 4c)" compile-bytes
" "(74 74 4c 4c 4d 4d 8a 8a 4f 4f 37 37 c8 ea 23 2c)" compile-bytes
" "(23 5f 4a 91 29 29 29 8d 75 83 52 38 a1 38 40 40)" compile-bytes
" "(8e 51 73 73 79 2a 2a 42 42 46 46 2e 27 b9 be 27)" compile-bytes
" "(77 54 8f 8f 95 17 f2 ae d0 d0 0e 09 1a f7 6b 77)" compile-bytes
" "(78 af 54 ca f2 a6 a6 ae d0 0e d1 d1 b6 6b b6 39)" compile-bytes
" "(c8 c8 96 34 84 4c 4d 74 50 58 96 d4 c8 ab c8 e7)" compile-bytes
" "(96 58 34 4d 4d 4d 84 2b 74 84 2b 4f 4c 4c 4d 58)" compile-bytes
" "(e7 58 6d 8b 5f 69 7c 69 91 7c 6a a3 a3 7b a1 38)" compile-bytes
" "(38 65 40 8e 8e 51 73 a2 73 a2 79 42 5c 92 b9 3c)" compile-bytes
" "(27 88 6e 3a 3a 3a 8f 8f 95 21 17 a6 ae d0 d1 d1)" compile-bytes
" "(b7 1a f7 b2 78 af 17 95 f2 f2 a6 ae d0 0e d1 d1)" compile-bytes
" "(f7 b2 09 80 4c 58 e7 ab c8 58 34 4c 2b 2b 74 4f)" compile-bytes
" "(4c 8a 49 96 d4 c8 ab ab d4 96 49 50 8a 4f 4d 2b)" compile-bytes
" "(2b 4d 84 e7 58 34 5f 4a 2c 7c 7c 7c 91 4b 52 75)" compile-bytes
" "(5e a1 a1 38 65 65 65 40 40 51 51 73 a2 2a 88 27)" compile-bytes
" "(b5 b9 92 41 16 41 6e 3a 3a 43 43 43 95 95 17 f2)" compile-bytes
" "(ae d0 0e d1 b7 b6 45 6b af 39 17 21 f2 f2 a6 ae)" compile-bytes
" "(e5 0e d1 d1 09 b7 1a 56 84 74 4f 34 58 d4 f1 e7)" compile-bytes
" "(67 4f 74 4c 4c 4f 4c 8a 37 37 67 67 36 f0 f0 c8)" compile-bytes
" "(c8 e7 e7 49 58 50 49 96 58 d8 8b 06 23 1e 69 6d)" compile-bytes
" "(52 75 64 5e 7b a1 a1 a1 38 38 40 70 70 40 8e 72)" compile-bytes
" "(27 b5 b5 5b 7a 46 7a 7a 41 a7 6e 6e 3a 66 43 66)" compile-bytes
" "(95 95 17 ca 71 d0 0e d1 07 f7 45 b2 c7 39 17 17)" compile-bytes
" "(f2 f2 a6 ae e5 0e 0e d1 09 b7 b2 09 67 4d 2b 4c)" compile-bytes
" "(74 4c 50 e7 c8 ab e7 50 84 84 34 2b 4c 8a 4f 37)" compile-bytes
" "(37 37 67 67 67 36 d4 f0 d4 f0 e7 e7 58 76 23 94)" compile-bytes
" "(06 4a 35 44 8d 6f 8d 6f 64 5e 7b a1 a1 38 65 40)" compile-bytes
" "(70 5b b9 be 5b 88 46 46 46 7a 16 a7 a7 a7 6e 6e)" compile-bytes
" "(66 66 43 54 95 95 95 f2 ae e5 0e 0e db f7 1a b7)" compile-bytes
" "(80 af 54 17 17 f2 f2 a6 ae d0 0e d1 d1 07 b2 b2)" compile-bytes
" "(f1 d4 58 4c 74 4d 4f 4f 37 49 e7 c8 c8 96 8a 4d)" compile-bytes
" "(74 74 74 74 4f 8a 37 37 67 67 49 49 bf 48 93 8b)" compile-bytes
" "(dd 6c 23 23 5f 35 81 8d 6f 6a 6f 64 5e 7b a1 64)" compile-bytes
" "(a1 65 72 83 b9 5b 88 79 42 42 5c 2e 46 46 16 41)" compile-bytes
" "(41 a7 55 6e 6e 66 8f 8f 95 95 95 f2 a6 e5 0e 0e)" compile-bytes
" "(d1 45 07 6b 56 b9 54 17 95 f2 a6 a6 ae d0 0e d1)" compile-bytes
" "(b6 45 b6 07 50 e7 f1 e7 84 4c 2b 4d 4c 37 37 67)" compile-bytes
" "(36 c8 ab c8 49 34 4d 2b 74 4c 4c 4f 37 37 37 67)" compile-bytes
" "(1f dd 8b 4a 1e 20 69 47 81 81 29 8d 8d 8d 6f 6a)" compile-bytes
" "(6f 5e 5e 72 5b 83 83 72 a2 a2 79 79 5c 5c 42 5c)" compile-bytes
" "(46 7a 7a 46 16 41 a7 6e 6e 3a 8f 8f 95 95 95 a6)" compile-bytes
" "(a6 e5 0e 0e d1 45 b7 45 77 be 66 17 95 17 a6 a6)" compile-bytes
" "(ae d0 0e 09 db d1 f7 1a 84 4f 58 c8 f1 49 2b 4c)" compile-bytes
" "(84 74 4c 4f 37 37 49 d4 c8 c8 e7 58 74 2b 4d 74)" compile-bytes
" "(74 74 4d c8 ee f0 5f 3b 5f 47 47 7c 81 29 29 29)" compile-bytes
" "(8d 8d 8d 8d 7b 52 83 83 72 70 8e 51 73 a2 2a 42)" compile-bytes
" "(2a 42 5c 5c 5c 7a 16 41 16 41 a7 6e 6e 66 43 8f)" compile-bytes
" "(95 95 95 f2 ca ae d0 0e d0 45 b7 b6 56 5a 77 8f)" compile-bytes
" "(95 95 a6 a6 ae e5 0e 09 09 d1 b6 1a 4c 4d 4f 37)" compile-bytes
" "(96 c8 c8 58 4d 4d 84 74 4f 37 37 67 67 36 d4 c8)" compile-bytes
" "(c8 e7 34 2b 2b 74 96 d4 96 e7 63 63 47 3b 69 7c)" compile-bytes
" "(91 7c 91 81 8d 6a 4b a3 83 52 70 65 40 8e 8e 51)" compile-bytes
" "(73 73 79 2a 42 42 5c 46 46 7a 16 16 16 55 55 6e)" compile-bytes
" "(6e 66 66 43 54 54 95 17 ca 71 71 0e d0 09 6b 1a)" compile-bytes
" "(77 5a 56 8f 95 95 a6 a6 ae e5 0e 09 18 b6 07 1a)" compile-bytes
" "(84 4d 4c 8a 37 67 e7 ab e7 50 74 74 74 84 8a 37)" compile-bytes
" "(37 67 67 96 bf ab d4 e7 96 e7 e7 e7 58 53 6d 86)" compile-bytes
" "(94 68 ac 53 81 91 81 81 52 a3 52 75 38 65 40 65)" compile-bytes
" "(8e 8e 8e 51 73 73 a2 a2 2a 42 5c 5c 5c 46 7a 7a)" compile-bytes
" "(41 41 41 6e 6e 3a 43 54 8f 8f 17 17 ca a6 18 e6)" compile-bytes
" "(56 80 c7 b4 78 3c 92 54 95 95 17 f2 ae e5 0e 0e)" compile-bytes
" "(d1 d1 1a b6 2b 74 8a 4c 84 8a 37 67 c8 ab 96 4d)" compile-bytes
" "(4c 74 4c 4d 8a 37 37 67 36 67 36 c6 ee f0 f0 e7)" compile-bytes
" "(e7 6d 23 68 2c ac 2c 7c 4a 44 52 52 75 7b a1 a1)" compile-bytes
" "(38 38 65 40 40 40 8e 51 73 a2 79 79 42 5c 5c 2e)" compile-bytes
" "(46 46 16 41 41 a7 a7 a7 3a 3a 66 66 43 66 56 80)" compile-bytes
" "(c7 b4 78 5a c7 80 56 56 56 27 0f 54 95 95 17 f2)" compile-bytes
" "(a6 e5 d0 0e 0e d1 b6 b6 96 4c 4d 84 4c 8a 8a 37)" compile-bytes
" "(37 96 c8 c8 49 2b 74 4d 4f 2b 4f 50 37 37 96 d8)" compile-bytes
" "(aa dd 8b ea 87 6d 9f 20 a8 69 7d 4b 52 75 6a 64)" compile-bytes
" "(7b 64 a1 a1 38 38 65 40 8e 8e 8e 8e 73 73 a2 2a)" compile-bytes
" "(79 42 2e 5c 46 46 46 7a 16 16 41 6e 77 92 27 27)" compile-bytes
" "(3c be af c7 80 56 18 f4 ae 71 6b 45 77 af 43 54)" compile-bytes
" "(95 95 17 a6 a6 ae d0 0e 0e d1 b6 1a ab e7 4c 4d)" compile-bytes
" "(4d 84 4f 4f 37 37 67 e7 c8 f0 58 4c 4f 4d 74 4d)" compile-bytes
" "(8a 67 f6 99 99 4a 86 94 9b ac a8 8b 7d 44 44 6a)" compile-bytes
" "(8d 6f 5e 5e 5e 64 a1 a1 a1 a1 38 70 40 8e 51 51)" compile-bytes
" "(a2 a2 a2 a2 42 42 42 5c 5c 2e 88 92 27 27 b9 b5)" compile-bytes
" "(b9 af 80 92 0f 90 95 a6 71 71 f4 b2 f4 d1 07 f7)" compile-bytes
" "(77 af 54 0f 95 95 95 a6 a6 ae 71 0e d0 d1 b6 1a)" compile-bytes
" "(37 c8 c8 4d 4d 84 2b 4c 4f 37 67 67 67 f0 ab e7)" compile-bytes
" "(4c 2b 84 4c 34 f1 f6 ee 1f 63 61 aa 6d 63 44 44)" compile-bytes
" "(9e 29 29 8d 8d 6f 6f 5e 7b 64 a1 a1 38 38 38 65)" compile-bytes
" "(70 8e 8e 8e 73 73 a2 79 a2 72 5b 5b 27 b5 b5 b9)" compile-bytes
" "(92 92 77 66 8f 54 90 90 17 ca ca 71 71 71 0e d1)" compile-bytes
" "(18 e6 6b 09 77 af 54 8f 95 95 95 f2 a6 ae 71 71)" compile-bytes
" "(0e d1 b6 45 37 67 d4 c8 50 4f 4c 4d 34 4f 37 37)" compile-bytes
" "(67 67 36 f0 ab 96 74 58 ab c8 e7 4c 8b 47 7d 44)" compile-bytes
" "(9e 81 91 7c 29 29 8d 8d 8d 8d 8d 64 5e 5e 7b a1)" compile-bytes
" "(a1 38 65 65 40 40 70 70 72 5b b9 5a b5 b9 27 92)" compile-bytes
" "(88 7a 41 41 a7 55 6e 6e 6e 66 43 43 95 95 21 1b)" compile-bytes
" "(ae 71 0e 0e b2 b7 6b f7 56 af 43 43 54 95 95 17)" compile-bytes
" "(ca e5 71 71 0e 0e db db 8a 37 67 d4 ab 58 4c 4d)" compile-bytes
" "(74 4d 4f 4f 37 67 67 67 d4 f0 c8 ab ab e7 50 ee)" compile-bytes
" "(44 35 6d 68 69 7c 53 7c 29 91 8d 8d 8d 6f 6f 6f)" compile-bytes
" "(6f 5e 64 a1 38 65 72 72 83 83 83 b5 27 5b 88 88)" compile-bytes
" "(5c 5c 46 7a 7a 16 16 16 16 16 a7 6e 3a 3a 43 43)" compile-bytes
" "(17 17 ca eb eb f4 f4 db 45 1a 1a b6 56 af 54 43)" compile-bytes
" "(54 95 95 17 a6 e5 71 71 0e d0 db b6 4c 4f 37 37)" compile-bytes
" "(e7 ab 49 2b 4c 4c 2b 4d 37 37 37 67 ea aa 1f c8)" compile-bytes
" "(ab c8 c8 63 8b 20 14 ac ac 69 7c 91 91 7c 8d 8d)" compile-bytes
" "(8d 8d 8d 6f 75 52 a3 a3 83 3c 83 5b 72 88 2a 79)" compile-bytes
" "(79 2a 42 5c 46 46 46 46 7a 7a 16 41 a7 a7 6e 6e)" compile-bytes
" "(66 43 54 95 43 54 21 21 a6 ae d0 0e f7 09 b6 09)" compile-bytes
" "(56 af 54 43 54 54 95 17 f2 e5 71 71 0e f4 45 b6)" compile-bytes
" "(4c 34 34 37 37 36 ab e7 4c 74 4c 8a 2b 8a 96 13)" compile-bytes
" "(48 97 93 47 d8 c8 33 4a 20 20 06 ac 68 53 7c 7c)" compile-bytes
" "(29 29 6a 44 4b a3 83 b5 a3 a3 72 72 70 8e 8e 8e)" compile-bytes
" "(73 73 a2 79 79 42 42 5c 5c 5c 46 7a 7a 16 41 41)" compile-bytes
" "(a7 a7 55 6e 3a 43 8f 8f 17 21 ca f2 ca 71 57 0e)" compile-bytes
" "(d0 e6 6b b2 56 39 8f 66 8f 90 43 54 95 f2 6b b2)" compile-bytes
" "(f4 eb 80 be 74 4c 8a 8a 37 37 36 c8 d4 4d 74 74)" compile-bytes
" "(34 e7 f6 dd 99 99 47 8b 14 13 5f 2c 94 06 a8 ac)" compile-bytes
" "(4a 81 44 4b a3 a3 a3 a3 52 75 7b a1 38 65 38 65)" compile-bytes
" "(40 8e 51 51 51 73 a2 a2 79 2a 42 5c 5c 5c 46 7a)" compile-bytes
" "(7a 16 41 41 a7 a7 55 6e 3a 43 43 43 54 95 95 a6)" compile-bytes
" "(a6 e5 18 57 b2 1a 1a 1a 77 b9 95 54 54 ca eb 71)" compile-bytes
" "(eb eb 90 92 c7 f5 b4 c7 4c 4c 4f 8a 37 37 67 67)" compile-bytes
" "(f0 c8 50 96 ab f1 f1 96 50 97 6d ac 94 14 06 5f)" compile-bytes
" "(6d 7d 44 4b 52 52 4b 4b 7b 7b 5e 5e 5e 64 a1 38)" compile-bytes
" "(38 38 65 65 40 40 8e 8e 51 73 a2 a2 79 2a 42 5c)" compile-bytes
" "(5c 5c 46 7a 7a 16 41 41 a7 a7 6e 6e 66 66 66 66)" compile-bytes
" "(17 17 95 21 1b e5 db b2 e6 71 b6 1a 77 27 3a 6e)" compile-bytes
" "(3a 3a 17 77 80 af f5 ed c7 e6 45 1a 4d 2b 4c 4d)" compile-bytes
" "(8a 37 50 37 36 f6 f1 c8 f1 ab 34 2b d9 9e 4a 6d)" compile-bytes
" "(9e 44 4b 44 44 44 9e 6a 8d 8d 8d 6f 6f 6f 5e 64)" compile-bytes
" "(7b a1 a1 a1 38 65 65 40 8e 8e 8e 51 51 73 a2 a2)" compile-bytes
" "(79 2a 42 5c 5c 2e 46 7a 7a 16 41 41 a7 a7 6e 6e)" compile-bytes
" "(3a 43 43 43 90 90 95 f2 71 71 f4 b2 ae b2 b2 6b)" compile-bytes
" "(56 39 43 43 80 c7 af be ed b4 80 eb 6b e6 56 39)" compile-bytes
" "(74 2b 4d 4d 74 8a d4 dd 97 6c f1 f1 ab e7 e7 f6)" compile-bytes
" "(44 35 9e 63 6d 69 69 7c 7c 91 91 29 29 8d 8d 6a)" compile-bytes
" "(6f 64 64 64 64 a1 a1 a1 a1 38 65 40 8e 8e 8e 51)" compile-bytes
" "(51 73 a2 a2 79 2a 42 5c 5c 5c 46 7a 7a 16 41 41)" compile-bytes
" "(41 a7 6e 3a 3a 8f 8f 0f 95 95 95 95 a6 e5 e5 0e)" compile-bytes
" "(09 6b 6b b2 56 b9 27 ed be 78 b5 ed b4 c7 c7 b4)" compile-bytes
" "(ed ed 04 5b 4f 4c 84 58 e7 f1 1f 99 93 99 1e 5f)" compile-bytes
" "(c8 c8 e7 35 89 14 06 a8 2c 68 68 68 91 91 91 29)" compile-bytes
" "(8d 8d 8d 8d 8d 6f 5e 5e 64 a1 a1 38 38 38 65 65)" compile-bytes
" "(40 8e 8e 8e 51 73 a2 a2 79 2a 42 5c 5c 5c 46 7a)" compile-bytes
" "(7a 16 41 41 41 a7 6e 3a 3a 8f 8f 54 ca 71 eb eb)" compile-bytes
" "(eb 71 71 71 e6 56 c7 b4 b9 5a 78 b9 be 78 b5 b9)" compile-bytes
" "(5b 72 75 81 52 6d aa a8 e7 e7 ab f1 f1 f1 f0 e7)" compile-bytes
" "(08 aa 47 14 26 ee 63 2c 2c c1 8b 06 68 4a 7c 68)" compile-bytes
" "(7c 91 29 29 29 29 8d 6a 6f 6f 6f 5e 5e a1 a1 38)" compile-bytes
" "(38 65 65 40 40 8e 51 51 73 73 a2 79 79 42 42 5c)" compile-bytes
" "(5c 5c 46 7a 7a 16 41 41 a7 a7 6e 3a 3a 43 66 66)" compile-bytes
" "(21 ca ca 1b 77 80 80 c7 be 78 78 b4 b4 5a 83 52)" compile-bytes
" "(81 68 7c 91 7c 91 6a 52 23 9f c1 94 f1 f0 d4 f1)" compile-bytes
" "(c8 34 2b 58 8b 6d 06 aa 7c f3 5f 94 9f aa 94 3b)" compile-bytes
" "(ac 68 69 7c 91 91 91 29 8d 8d 8d 8d 6f 6f 64 64)" compile-bytes
" "(64 a1 a1 a1 38 38 65 65 40 40 8e 8e 73 73 a2 79)" compile-bytes
" "(79 42 42 5c 5c 46 46 7a 7a 16 41 41 a7 a7 3a 6e)" compile-bytes
" "(66 77 92 80 c7 39 be 5a ed b4 c7 80 56 f7 77 c7)" compile-bytes
" "(b5 4b 91 7c 91 7c 29 29 81 44 4a 14 c1 aa aa c1)" compile-bytes
" "(ab ab f1 e7 50 34 58 7d 6d 4a 3b 3b 8b 86 86 8b)" compile-bytes
" "(86 8b 3b 4a 47 47 7d 7d 9e 9e 44 44 44 75 75 75)" compile-bytes
" uuuuuurrrrrrrrrr" compile-bytes
" "(72 72 88 88 88 88 88 88 88 88 88 88 88 88 88 92)" compile-bytes
" "(5b 27 be ed ed 78 78 78 ed ed 78 39 80 77 56 77)" compile-bytes
" "(56 c7 78 c7 27 06 53 53 91 7c 91 7d 35 3b c1 c1)" compile-bytes
" "(20 da 1e 9f 5f 69 ab c8 d4 f1 63 7d 35 35 35 9e)" compile-bytes
" 555555DDKKKKRRRR" compile-bytes
" "(52 a3 a3 a3 83 a3 a3 83 83 83 83 83 83 83 83 83)" compile-bytes
" "(83 83 b9 b9 b9 83 b9 b9 b9 b9 5a 5a ed b5 04 04)" compile-bytes
" "(03 be b9 b4 b4 af b9 78 ed 3c b5 b9 39 b9 b9 af)" compile-bytes
" "(af 78 ed 04 b4 af be b4 83 4a 7c 7c 7c 81 7d 3b)" compile-bytes
" "(86 c1 1e 97 c1 94 20 89 d9 dd ee c8 ee 63 6c 33)" compile-bytes
" "(93 93 93 93 76 48 61 61 c0 1e 25 61 aa 97 97 aa)" compile-bytes
" "(c1 20 9f 97 aa aa 61 25 06 06 06 ac 68 7c 7c 7c)" compile-bytes
" "(29 29 29 29 8d 8d 6a 6a 75 75 52 a3 83 83 a3 a3)" compile-bytes
" "(52 4b 6a 8d 29 8d 6f 6f 75 a3 83 52 81 68 7c 91)" compile-bytes
" "(29 29 7c 91 6a 52 47 23 aa a8 a8 06 7c 61 91 68)" compile-bytes
" "(47 47 4a 9f aa aa 14 97 20 c1 94 20 0d 82 19 82)" compile-bytes
" "(47 53 e3 93 1c 1c 6c cb bc 76 61 61 94 c1 94 94)" compile-bytes
" "(c1 89 89 a8 9f 9f 9f 94 c1 94 94 94 23 1e 2c 68)" compile-bytes
" "(68 7c 91 91 81 35 4b 52 a3 a3 a3 a3 52 4b 9e 81)" compile-bytes
" "(91 91 7c 29 29 7c 29 8d 6a 4b a3 52 9e 6d 68 68)" compile-bytes
" "(68 7c 7c 7c 91 91 9e 4b 4a 94 9f a8 23 94 94 a8)" compile-bytes
" "(68 ac 68 6d 5f a8 aa 9f 14 a0 aa 23 c1 20 20 20)" compile-bytes
" "(13 d8 99 e1 d9 bd 99 9b 9b f3 f3 bc bc e0 da 89)" compile-bytes
" "(4e 1e 89 61 61 20 c1 20 c1 c1 c1 94 20 94 9f 94)" compile-bytes
" "(a8 3b 47 35 4b 52 52 a3 4b 44 7d 4a 3b a8 06 06)" compile-bytes
" "(06 68 53 68 68 7c 7c 7c 81 6a 4b 52 4b 4a 86 1e)" compile-bytes
" "(06 06 ac 3b 68 7c 7c 81 63 44 86 97 aa 9f 97 97)" compile-bytes
" "(94 06 06 06 2c 6d 5f 3b 97 94 20 89 c1 94 1e 2c)" compile-bytes
" "(a8 9f 14 8b 15 13 82 12 87 e3 82 31 d5 1c 6c 6c)" compile-bytes
" "(ec c0 c0 c0 a0 aa 94 94 94 c1 c1 06 23 23 23 5f)" compile-bytes
" "(6d 7d 35 44 44 44 35 63 4a 86 9f 97 97 9f 94 20)" compile-bytes
" "(61 25 89 9f ac ac 06 7c 7c 81 44 4b 4b 7d 2c 14)" compile-bytes
" "(97 a0 a8 06 06 3b 2c 68 69 47 47 6d 8b 9f a8 89)" compile-bytes
" "(97 23 ac 06 aa aa 14 86 8b 6d a8 94 14 89 c1 06)" compile-bytes
" "(c1 a8 a8 ac 06 89 8b 5f 13 87 13 12 82 12 99 d5)" compile-bytes
" "(9b 9b 9b 48 48 76 e0 da 48 61 86 8b 6d 63 9e 35)" compile-bytes
" "(4b 44 35 63 5f 8b 86 86 25 61 61 aa 97 9f 94 9f)" compile-bytes
" "(c1 61 61 1e 14 20 c1 c1 68 3b 63 9e 44 35 47 23)" compile-bytes
" "(25 a0 20 14 97 aa 14 1e 06 06 68 4a 47 4a 2c ac)" compile-bytes
" "(94 06 94 61 97 97 14 89 25 3b 5f 5f 23 1e aa 25)" compile-bytes
" "(2c 89 9f a8 c1 ac 9f c1 ac 5f 5f 4e 87 15 13 e1)" compile-bytes
" "(0d 31 9b 31 2d f3 f3 2c 69 6d 63 7d 4b 4b 44 35)" compile-bytes
" "(7d 6d 3b 3b bc e0 e0 76 25 25 61 89 06 c1 89 20)" compile-bytes
" "(25 14 1e 1e 9f 9f c1 9f 97 06 8b 6d 35 9e 47 3b)" compile-bytes
" "(a8 c1 9f 94 aa 97 94 94 94 c1 9f 14 23 8b 6d 5f)" compile-bytes
" "(86 14 aa 9f aa 14 06 06 94 23 97 c1 86 4a 8b 06)" compile-bytes
" "(aa c1 1e ac 9f 1e 1e 2c 20 1e 20 14 6d 6d 68 e0)" compile-bytes
" "(13 13 13 12 6c 69 6d 63 44 44 44 44 9e 47 5f 69)" compile-bytes
" "(33 e3 bd d9 d9 1c 1c 7f cb 48 48 6c 4e 61 a0 c0)" compile-bytes
" "(20 89 ac ac 89 20 20 aa 9f 94 a8 4a 63 7d 7d 47)" compile-bytes
" "(86 25 61 aa aa 20 06 06 06 c1 c1 c1 94 61 23 8b)" compile-bytes
" "(6d 5f 86 94 94 20 06 89 20 9f 20 20 89 89 2c 8b)" compile-bytes
" "(5f 86 25 61 20 89 89 ac 20 20 c1 06 89 aa 14 63)" compile-bytes
" "(8b ec ec e0 6d 7d 35 44 35 7d 69 3b d5 0d 1f 19)" compile-bytes
" "(15 d8 d8 d8 e1 99 31 2d 9b 9b 9b f3 7f 76 e0 e0)" compile-bytes
" "(e0 48 61 23 1e 25 aa 97 94 06 a8 ac 47 7d 9e 63)" compile-bytes
" "(3b c1 94 89 20 1e 20 61 25 14 9f 1e 94 94 94 20)" compile-bytes
" "(86 5f 5f 5f 2c 2c 1e 1e 89 89 c1 14 89 89 c1 9f)" compile-bytes
" "(20 86 5f 5f 2c 4e da 61 89 89 89 1e 25 c1 89 20)" compile-bytes
" "(94 2c 7d 8b 6c f3 ec 7f 6c 82 19 ba e8 ba ba bb)" compile-bytes
" "(1f 19 19 87 15 13 dd 12 e1 99 99 2d 33 33 f3 48)" compile-bytes
" "(cb 7f 48 48 61 25 76 a0 c1 94 94 ac 4a 63 35 35)" compile-bytes
" "(6d 3b e0 e0 4e 1e 94 97 94 94 c1 89 14 14 25 aa)" compile-bytes
" "(23 06 86 6d 47 5f 1e 61 89 25 25 89 20 94 c1 ac)" compile-bytes
" "(06 06 c1 a8 5f 6d 8b 48 c0 da da 25 25 61 89 89)" compile-bytes
" "(ac ac 89 61 2c 7d 69 6c f3 cb c0 7f b8 c3 c3 c3)" compile-bytes
" "(ba ba bb 19 19 19 1f 1f 13 13 dd 12 82 e3 31 2d)" compile-bytes
" "(2d d9 2d cb 93 76 e0 ec 4e e0 76 14 3b 63 35 44)" compile-bytes
" "(9e 4a 4e 48 48 48 a0 a0 48 76 da 25 c1 c1 a8 ac)" compile-bytes
" "(89 ac 2c 20 5f 47 63 8b 76 a0 61 61 89 89 20 9f)" compile-bytes
" "(9f c1 89 1e c1 c1 3b 63 6d 25 48 4e 76 25 da da)" compile-bytes
" "(da 61 61 61 a8 25 25 86 7d 5f 6c 31 cb f3 7f 7f)" compile-bytes
" "(ee de de c3 c3 26 26 26 1f 1f 1f 13 13 d8 d8 15)" compile-bytes
" "(82 12 e1 31 33 33 2d 9b f3 7f 7f ec 1e 8b 7d 44)" compile-bytes
" "(35 63 6c 9b 2d 1c f3 f3 cb 6c 6c c0 61 20 25 6c)" compile-bytes
" "(1e 25 61 61 c1 c1 8b 7d 63 3b 48 a0 da c0 c0 2c)" compile-bytes
" "(da a0 94 89 2c 2c 89 9f 2c 6d 47 86 48 4e 4e 48)" compile-bytes
" "(76 76 da da da 25 25 61 a0 a0 3b 9e 69 1c 31 f3)" compile-bytes
" "(f3 9b f3 cb b8 de de e8 f6 f6 ba ba 26 19 19 19)" compile-bytes
" "(19 87 15 d8 d8 12 99 99 9b 9b 2d 1c 7f 2c 47 44)" compile-bytes
" "(44 9e 69 33 99 31 d9 33 f3 f3 7f bc 6c ec 76 48)" compile-bytes
" "(7f ec 4e 25 a0 1e 25 89 5f 9e 63 68 93 ec 6c ec)" compile-bytes
" "(48 c0 4e 76 25 da ac 2c 1e 25 2c 8b 7d 5f da 48)" compile-bytes
" "(ec bc 7f e0 76 76 76 da 25 25 76 76 a0 3b 9e 69)" compile-bytes
" "(d5 31 31 9b 2d 1c 1c 1c b8 b8 c3 c3 c3 c3 f6 f6)" compile-bytes
" "(19 19 1f 1f 87 87 15 13 0d 0d 82 31 9b bc 6d 9e)" compile-bytes
" "(44 9e 6d 33 0d dd e1 12 12 12 e3 d9 2d 9b f3 f3)" compile-bytes
" "(93 7f 48 76 76 76 a0 61 c1 1e 63 35 63 f3 f3 c0)" compile-bytes
" "(e0 7f 7f 4e 4e 76 48 da 76 4e 2c 25 a0 1e 5f 63)" compile-bytes
" "(69 6c f3 f3 cb 93 48 ec e0 e0 76 76 76 76 e0 4e)" compile-bytes
" "(8b 9e 69 2d bd 33 1c 2d 2d 1c 1c 2d b8 b8 de c3)" compile-bytes
" "(c3 26 ba ba ba 19 19 19 19 19 13 dd dd e1 6c 63)" compile-bytes
" "(35 44 63 69 dd 13 1f 13 13 e1 12 d8 12 31 31 9b)" compile-bytes
" "(9b 2d 1c 1c bc f3 cb 6c e0 e0 4e 86 35 35 47 ec)" compile-bytes
" "(9b 2d cb 1c 7f 7f 48 48 e0 e0 c0 76 da a0 a0 76)" compile-bytes
" "(8b 63 6d 53 9b f3 f3 cb cb cb 7f ec cb 7f 48 48)" compile-bytes
" "(48 76 1e 8b 44 53 31 31 31 d9 e3 d9 2d 2d d5 d5)" compile-bytes
" "(b8 b8 de de de e8 f6 e8 bb bb 19 19 1f 1f 12 3b)" compile-bytes
" "(81 35 35 6d 82 19 26 19 19 1f 1f 15 15 dd 0d 0d)" compile-bytes
" "(e1 e1 bd 31 31 31 33 1c 1c cb f3 7f 76 6d 35 44)" compile-bytes
" "(8b d5 31 31 d5 2d d5 1c 7f 93 7f bc bc e0 c0 76)" compile-bytes
" "(76 da ac 6d 9e 69 31 2d d5 2d 1c 1c 7f 7f 7f 7f)" compile-bytes
" "(93 76 4e 76 e0 76 8b 35 33 bd e1 e1 bd bd 31 31)" compile-bytes
" "(31 d9 d9 2d ee ee b8 b8 c3 c3 c3 26 26 ba 19 82)" compile-bytes
" "(5f 63 7d 63 69 87 b8 e8 bb f6 f6 1f 19 1f 1f 87)" compile-bytes
" "(15 15 dd 0d 12 bd e3 31 9b 9b d5 33 f3 93 4e 63)" compile-bytes
" "(35 9e 69 e1 31 e1 31 2d 2d 2d 2d 2d 33 33 7f 93)" compile-bytes
" "(c0 ec 7f 76 e0 4a 9e 47 9b 9b 9b 31 33 d5 d5 1c)" compile-bytes
" "(f3 f3 cb cb cb 7f 93 c0 48 4a 35 f3 e1 e1 e1 e1)" compile-bytes
" "(bd bd bd bd 31 31 d9 2d 24 b8 b8 b8 c3 c3 c3 f6)" compile-bytes
" "(6c 5f 7d 7d 5f 82 26 ee c3 de c3 f6 bb ba 19 19)" compile-bytes
" "(19 19 19 1f 13 13 dd 0d 82 e1 e1 bd e3 31 99 d5)" compile-bytes
" "(61 47 35 7d 33 dd d8 e3 0d 12 82 33 bd 33 1c d5)" compile-bytes
" "(f3 6c 33 1c 48 93 f3 4e 63 9e 69 e1 82 e1 12 d9)" compile-bytes
" "(d9 d9 2d d5 2d 2d f3 f3 33 6c cb 93 63 35 33 d8)" compile-bytes
" "(15 d8 82 82 12 12 82 82 e3 e3 e3 e3 24 ee b8 b8)" compile-bytes
" "(87 5f 7d 35 6d 6c ba b8 24 ee b8 de b8 c3 c3 c3)" compile-bytes
" "(c3 ba bb ba 19 19 19 1f 1f 15 15 d8 87 d8 d8 bd)" compile-bytes
" "(99 31 53 63 44 6d 99 13 1f 87 82 15 12 12 bd e1)" compile-bytes
" "(99 31 2d 9b f3 f3 93 7f cb 7f 4a 35 63 31 e1 e1)" compile-bytes
" "(0d 82 31 e1 31 31 31 2d 2d f3 f3 f3 bc 2d 93 63)" compile-bytes
" "(63 31 d8 13 dd 0d 0d 0d e1 e1 e1 e1 e1 31 31 31)" compile-bytes
" "(de 82 6d 7d 63 5f d8 b8 ea ea c2 24 b8 b8 b8 b8)" compile-bytes
" "(b8 c3 e8 26 26 e8 bb 19 19 19 19 19 1f 13 13 13)" compile-bytes
" "(13 82 0d e1 69 7d 7d 5f d8 19 19 1f 13 dd dd 15)" compile-bytes
" "(d8 d8 12 12 e3 e3 bd d9 1c 9b 93 93 bc 63 9e 53)" compile-bytes
" "(15 dd 87 82 82 0d 82 82 12 e3 e3 e3 d9 33 33 33)" compile-bytes
" "(9b cb 7d 63 12 1f 87 1f 15 d8 d8 d8 d8 d8 82 d8)" compile-bytes
" "(12 12 12 12 7d 5f 33 c3 c2 08 c2 c2 c2 ea ea 24)" compile-bytes
" "(ea 24 ee de c3 de de c3 26 26 c3 ba 19 19 19 19)" compile-bytes
" "(19 19 87 87 13 e1 69 35 35 69 15 19 1f 19 19 19)" compile-bytes
" "(87 87 87 15 0d 0d 12 12 e3 bd 31 d9 99 33 f3 53)" compile-bytes
" "(35 63 12 13 13 87 12 dd 87 e3 12 e1 31 31 31 31)" compile-bytes
" "(2d 2d 2d d5 9b 63 47 87 1f 15 13 15 13 13 13 13)" compile-bytes
" "(13 0d 0d dd 0d 12 12 e1 62 62 0a 3f 3f 9a 9a 28)" compile-bytes
" "(b0 9a 02 b0 02 b0 c4 dc c4 c4 1d 02 d2 3f d2 28)" compile-bytes
" "(02 02 dc cd 02 02 c5 c5 9a 9a 9c a5 b0 3f d2 11)" compile-bytes
" "(c4 11 62 cc 62 c5 02 62 11 dc 9a 9a 28 9a 9a 22)" compile-bytes
" "(22 9a d2 98 a5 b1 dc 22 0b 62 c4 0a 9a 9a 0a 11)" compile-bytes
" "(cd cd cd 02 02 02 02 02 5d 9c 9a 0b 0b dc 02 62)" compile-bytes
" "(62 62 c5 c5 c5 02 dc 28 cd cd 28 dc 9a b0 e4 e2)" compile-bytes
" "(c5 02 df c4 d2 02 b0 b0 9a 28 3f 9c 0a 9a 28 28)" compile-bytes
" "(0c c4 c4 62 c5 02 02 e2 e2 e2 d2 d2 b0 c4 c4 11)" compile-bytes
" "(11 62 02 d2 28 e4 3f e4 b0 cf 11 02 02 0a 02 d2)" compile-bytes
" "(b0 b0 02 b0 d2 c4 c4 dc 62 c4 c4 c4 e4 d2 28 28)" compile-bytes
" "(b0 02 0c b0 02 02 02 02 02 02 02 02 b0 d7 a9 0c)" compile-bytes
" "(e9 98 d2 5d cf cf cf 02 e2 e2 5d 5d b0 d2 d2 02)" compile-bytes
" "(02 02 02 02 02 02 02 02 d7 98 b1 a5 9a 62 cc 02)" compile-bytes
" "(62 9a ad d2 d2 ad 9a 62 c4 e9 28 b1 0b 3f 0c c5)" compile-bytes
" "(c5 11 98 d7 9a 28 62 0a cf 0a 11 c5 c5 cd cc e9)" compile-bytes
" "(a5 dc 02 a9 9a e9 e2 62 11 02 c5 62 e9 df 0b 9a)" compile-bytes
" "(a9 0c 98 0c 0b d6 e9 a9 0a 02 11 ad 02 df 98 e9)" compile-bytes
" "(d2 0a df 0b e9 9c 3f 0a 02 02 0c 0a 0a 02 cc 5d)" compile-bytes
" "(02 02 02 02 02 02 02 02 02 02 02 02 9c a4 10 d3)" compile-bytes
" "(10 a4 a9 e2 3d ce 0b d7 d7 0b ce 3d cf 28 ce 7e)" compile-bytes
" "(0c d2 df 7e 7e d6 a4 60 7e a4 60 cc cf 0c cc a4)" compile-bytes
" "(ce 3d 11 cc ce 7e 59 ce a9 0a 3f 11 3e b3 d7 3e)" compile-bytes
" "(10 3e 60 a4 e9 a5 98 e9 0b 0b e9 a9 e9 22 22 b1)" compile-bytes
" "(1d 0a cd a9 e2 0a 9c d6 ad cc 5d d7 02 e9 0a df)" compile-bytes
" "(e9 0a 1d b1 02 02 02 02 02 02 02 02 02 02 02 02)" compile-bytes
" "(9a d3 7e 11 3d 3d 0b 9c a4 85 0c 98 98 0c 85 a4)" compile-bytes
" "(cc 9c 85 c9 3d cc 22 7e 7e a5 d7 7e 59 ce ce 02)" compile-bytes
" "(0c c5 22 32 85 7e 0b a4 85 3d a4 05 a4 b1 9c 3d)" compile-bytes
" "(05 a4 5d 85 7e 59 60 85 3d c5 b1 ad df 02 9c dc)" compile-bytes
" "(9c 9c cd 0a e9 9a 3d a4 32 b1 a5 11 e9 cc 3d a4)" compile-bytes
" "(32 0b 0a 02 e9 c5 df 98 02 02 02 02 02 02 02 02)" compile-bytes
" "(02 02 02 02 a4 85 9a 9c b1 0b d7 0b 59 d3 22 df)" compile-bytes
" "(df 22 d3 59 5d 0a 05 ce ce 9a b1 7e 7e ad c5 7e)" compile-bytes
" "(60 ce 7e 9a 0b e9 5d d6 60 c9 a9 60 ce 9c df c9)" compile-bytes
" "(7e cc ad b3 85 cd b1 c9 59 1d d6 c9 7e 11 0b 0b)" compile-bytes
" "(ad e9 a4 ce c9 d6 cc cc 62 b3 c9 ce d3 59 62 b1)" compile-bytes
" "(dc b3 c9 10 d3 b3 0c 9c 02 0b df e9 02 02 02 02)" compile-bytes
" "(02 02 02 02 02 02 02 02 a4 d3 a4 62 11 9c cf e9)" compile-bytes
" "(a4 85 9c cc cc 9c 85 a4 9c d6 85 a4 3e 3d 22 7e)" compile-bytes
" "(7e 11 0c b1 8c b1 d6 e9 d6 9c 0b df 3d d3 7e 05)" compile-bytes
" "(a4 e2 02 ce 60 cc 02 7e 3e e9 0a 05 a4 0c 0a ce)" compile-bytes
" "(7e 22 0c e9 cc a4 ce 60 85 98 df 0b 32 ef a4 0b)" compile-bytes
" "(7e c9 9a 22 b1 d3 a4 dc 7e 10 c5 e9 0b df 02 d2)" compile-bytes
" "(02 02 02 02 02 02 02 02 02 02 02 02 a5 3e 85 59)" compile-bytes
" "(a9 0c 02 d7 a4 85 e9 9c 9c e9 85 a4 cf d6 05 9a)" compile-bytes
" "(ce 60 9c 7e 7e d6 98 df 9c 9a e9 0a 02 0a d6 e9)" compile-bytes
" "(b1 60 85 ce 11 e9 0a 7e 3e e9 98 ce 7e d2 d6 05)" compile-bytes
" "(a4 11 3d 05 a4 b1 9a 1d df 9a 11 a4 85 e9 0b e9)" compile-bytes
" "(a4 c9 22 e4 3d 85 b1 e9 a4 85 b1 a5 3d 85 b1 cd)" compile-bytes
" "(d7 e9 98 02 02 02 02 02 02 02 02 02 02 02 02 02)" compile-bytes
" "(9c 32 ce c9 60 32 02 11 a4 85 dc 0a 0a dc 85 a4)" compile-bytes
" "(3f 02 05 b1 a4 c9 32 7e 7e cc e9 0a 28 11 cc d6)" compile-bytes
" "(9c e9 e9 c5 a9 59 05 7e 62 df cc a4 85 cc 0c 85)" compile-bytes
" "(59 1d d7 ef 3e ce 85 7e e9 ad 62 c5 c5 b1 0a a4)" compile-bytes
" "(85 b1 0a b1 7e 3e 62 e4 e9 85 a4 dc 7e ce 9a dc)" compile-bytes
" "(a5 85 a4 d6 0a 9c e4 cf 02 02 02 02 02 02 02 02)" compile-bytes
" "(02 02 02 02 cf 9c a9 b3 d3 60 d6 02 59 85 cd 02)" compile-bytes
" "(02 cd 85 59 3f 02 d3 a9 b1 3e 7e 7e 7e 5d d2 d6)" compile-bytes
" "(c5 9a 3f 3f c5 d6 98 11 dc ce c9 ef 28 e2 c4 28)" compile-bytes
" "(ef a4 3d 05 b1 e2 e9 c9 7e c9 7e a9 62 7e 3e ce)" compile-bytes
" "(a4 22 9a a4 85 dc df 0b 7e 3e 62 d2 02 d3 a4 dc)" compile-bytes
" "(7e 3e 02 dc 11 3e 59 a9 e2 02 02 b0 02 02 02 02)" compile-bytes
" "(02 02 02 02 02 02 02 02 02 e2 9c cd 7e 85 0b 5d)" compile-bytes
" "(a4 3e 9a dc dc 9a 85 a4 0a b1 c9 c5 11 a4 85 60)" compile-bytes
" "(7e 9a 9a 02 e2 d6 e2 ad df e9 a9 dc 3d 85 a4 ef)" compile-bytes
" "(7e 9c e9 11 10 7e 7e c9 d6 9c ad 85 59 7e 85 b1)" compile-bytes
" "(9a 3d a4 a4 32 9c cd a4 d3 dc 11 22 7e ce 9c cd)" compile-bytes
" "(62 85 a4 c5 7e ce 9a 28 9a 85 a4 a9 e9 d6 d6 3f)" compile-bytes
" "(02 02 02 02 02 02 02 02 02 02 02 02 cc cd 11 0a)" compile-bytes
" "(a4 d3 0a 02 b1 d3 3d 9a 9a a4 d3 dc b1 1d d3 b1)" compile-bytes
" "(c5 d6 c9 ef 7e 62 cd 02 5d d6 02 0c 0b 9c 28 9a)" compile-bytes
" "(60 ce a5 60 85 d7 df 1d 7e 10 60 60 02 9c b1 c9)" compile-bytes
" "(a4 b1 ef 7e dc c5 11 e9 02 e9 0a 59 d3 28 62 11)" compile-bytes
" "(7e c9 11 0b 3d d3 b1 e9 b3 3e dc cc 3d c9 b1 b1)" compile-bytes
" "(98 02 0b e9 02 02 02 02 02 02 02 02 02 02 02 02)" compile-bytes
" "(32 7e a9 32 3e ce 28 ad cd ce 10 b1 b1 ce 60 0a)" compile-bytes
" "(0b d6 d3 22 11 62 7e c9 7e d6 dc 5d 9c d7 0a c5)" compile-bytes
" "(df 0a e9 3d d3 59 28 3d 3e 7e 98 11 a4 85 c9 59)" compile-bytes
" "(5d e9 9c d3 a4 a5 7e d3 3d 11 28 a5 cd 11 11 a4)" compile-bytes
" "(d3 9a 28 a5 3d 85 a4 11 7e 10 28 11 a4 d3 a4 a9)" compile-bytes
" "(7e 10 b1 22 0c 0c 02 9c 02 02 02 02 02 02 02 02)" compile-bytes
" "(02 02 02 02 a4 c9 c9 d3 c9 3d 9a 9a 11 b1 ce c9)" compile-bytes
" "(d3 60 a9 cd df ad 85 11 9c a9 8c d3 7e 11 1d 0c)" compile-bytes
" "(ad 0b 0c 02 c5 b1 0b 7e 3e a9 11 62 ef ce 98 9c)" compile-bytes
" "(c5 05 85 a9 d6 9c 0b d3 a4 b1 62 c9 ce d7 1d b1)" compile-bytes
" "(1d a4 d3 d3 85 d3 ce 11 a5 ce d3 ce c9 a4 dc 1d)" compile-bytes
" "(11 60 85 ce c9 3d 0c 0a cd 0b 9c 0a 02 02 02 02)" compile-bytes
" "(02 02 02 02 02 02 02 02 dc c5 a4 a4 28 d6 0a cd)" compile-bytes
" "(02 ad 0c b1 02 0a 9c 02 0c e2 0b ad 02 0c 11 a9)" compile-bytes
" "(d6 a5 b1 1d 0c d7 0a 5d e9 0a 02 98 df e9 9c 11)" compile-bytes
" "(22 cd d2 e9 a9 62 a5 e9 b1 0a 0a b1 22 02 a5 62)" compile-bytes
" "(0c 98 0c 1d df 11 9c 0c cc 62 62 28 9c a9 a4 a4)" compile-bytes
" "(32 cd 1d b1 dc a9 a4 a4 32 b1 98 98 e9 0b e9 df)" compile-bytes
" "(02 02 02 02 02 02 02 02 02 02 02 02 02 02 b1 1d)" compile-bytes
" "(dc cc 0c 02 02 0b 02 9c 9c cd df 0a 9c 0a e9 df)" compile-bytes
" "(e9 02 9c 5d 9a 9c 9a c5 df 0b 0c 5d 02 c5 cd 11)" compile-bytes
" "(22 d7 ad cc 28 ad df 0a 02 62 dc 9c 3f d6 0c 98)" compile-bytes
" "(9c 9c d7 d6 0b ad 0c 02 df d6 cd 0a e9 dc 98 62)" compile-bytes
" "(0c a5 11 a5 cd 1d b1 1d 22 df 11 0b 0a e9 e9 02)" compile-bytes
" "(e2 0c 0b 02 02 02 02 02 02 02 02 02 02 02 02 02)" compile-bytes
" "(cf 5d 0a 28 dc cc 02 d6 0a 0c 0b 0a 0c d6 0a 0c)" compile-bytes
" "(02 d7 98 d6 02 c5 0b e4 a5 9a cd 02 cd 0a cd 0a)" compile-bytes
" "(0a d7 5d 22 3f 02 cc d2 a5 d6 9c d7 0c 0a 5d d7)" compile-bytes
" "(5d 0b e9 b1 02 0b 0b e4 e9 9c 1d 9c 0c 0b 5d d7)" compile-bytes
" "(0a df 9c 0c cc 0c 0a b1 0a e9 98 0c b1 22 5d e9)" compile-bytes
" "(c5 c5 0b d6 02 0a 0c df 02 02 02 02 02 02 02 02)" compile-bytes
" "(02 02 02 02 d2 cf cc 0c 0a e9 9c c4 5d 02 c5 5d)" compile-bytes
" "(ad cc 02 5d 0b 0c 0a cd 9c e2 cf d2 dc cc 62 02)" compile-bytes
" "(e2 0a c5 cd df 5d 0a 11 df 98 e9 0b 11 0b b0 df)" compile-bytes
" "(3f e9 02 cc d6 9c 02 0a c5 d2 df 9c 0a 0c d7 ad)" compile-bytes
" "(cd cc 98 02 9c cf d7 3f 0a d7 98 d7 cc 02 e9 0a)" compile-bytes
" "(02 df 0b 5d e2 9c d7 0a 9c 5d 9c cc 02 02 02 02)" compile-bytes
" "(01 01 01 01 01 01 01 01 01 5a 01 01 01 01 01 03)" compile-bytes
" "(01 03 01 04 01 03 01 01 03 01 01 03 01 01 03 01)" compile-bytes
" "(01 5a 01 3c 01 04 01 03 04 01 03 01 01 01 5a 01)" compile-bytes
" "(01 01 01 01 01 01 3c 01 01 03 01 04 01 01 3c 01)" compile-bytes
" "(01 03 01 01 03 01 01 01 01 04 03 01 03 01 03 01)" compile-bytes
" "(01 3c 01 01 5a 01 5a 01 03 01 01 03 01 03 01 01)" compile-bytes
" "(01 01 01 01 01 01 01 01 01 01 01 01 04 01 30 27)" compile-bytes
" "(01 04 01 01 03 01 04 01 5a 01 01 04 03 01 03 01)" compile-bytes
" "(5a 01 01 03 03 01 5a 01 03 01 01 3c 01 5a 04 01)" compile-bytes
" "(5a 01 04 01 03 01 01 01 5a 01 03 01 03 01 04 01)" compile-bytes
" "(5a 01 01 01 01 03 01 3c 01 01 01 04 03 01 01 03)" compile-bytes
" "(01 30 27 03 03 01 03 3c 01 03 01 5a 30 27 3c 01)" compile-bytes
" "(03 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01)" compile-bytes
" "(b9 b3 05 85 30 01 01 03 04 01 03 2f 10 05 b3 30)" compile-bytes
" "(01 01 01 01 04 01 04 01 ef ef 92 01 01 03 5a 01)" compile-bytes
" "(01 04 01 ef 85 3e 2f 01 01 01 04 01 01 01 ef 2f)" compile-bytes
" "(01 2f 05 3c 01 03 01 04 03 01 b3 b3 5a 01 01 01)" compile-bytes
" "(01 01 04 01 b3 05 05 30 01 03 01 01 03 03 b9 60)" compile-bytes
" "(60 b3 2f 5a 01 04 01 5a 01 01 01 01 01 01 01 01)" compile-bytes
" "(01 01 01 01 2f 05 2f 2f 2f 01 3c 01 01 03 01 2f)" compile-bytes
" "(05 30 b3 60 01 03 03 01 5a 01 03 30 05 ef 2f 03)" compile-bytes
" "(3c 01 01 3c 3c 01 3c 05 3d 2f ef 30 03 01 01 5a)" compile-bytes
" "(01 01 05 2f 03 2f ef 01 01 03 01 01 03 01 b3 b3)" compile-bytes
" "(01 01 04 01 01 01 01 2f 05 30 2f 27 01 3c 01 01)" compile-bytes
" "(5a 01 2f 05 b9 03 3c 01 3c 04 01 01 01 01 01 01)" compile-bytes
" "(01 01 01 01 01 01 01 01 b3 60 5a 01 01 01 01 3c)" compile-bytes
" "(04 01 01 2f 05 01 2f ef 01 03 01 04 01 01 03 2f)" compile-bytes
" "(b3 b3 59 01 01 01 01 03 01 03 01 05 2f 3c ef 2f)" compile-bytes
" "(03 04 01 01 01 04 c9 2f 04 2f 85 5a 01 01 04 01)" compile-bytes
" "(01 03 b3 b3 01 03 01 04 01 03 03 3d 60 01 3c 01)" compile-bytes
" "(01 03 04 01 01 03 2f ef 30 01 01 5a 01 01 3c 01)" compile-bytes
" "(01 01 01 01 01 01 01 01 01 01 01 01 ef b3 30 2f)" compile-bytes
" "(2f 3c 01 01 03 01 03 2f 05 2f 3e 59 01 01 01 04)" compile-bytes
" "(01 3c 03 b3 3d 3d 3e 01 3c 03 03 01 01 01 03 05)" compile-bytes
" "(2f 30 05 30 01 01 3c 01 04 03 05 ef 05 05 05 01)" compile-bytes
" "(5a 03 01 03 01 01 b3 b3 01 01 04 01 03 01 01 b3)" compile-bytes
" "(b3 3c 01 04 01 01 03 01 01 5a 27 3e 05 2f 01 03)" compile-bytes
" "(01 01 03 03 01 01 01 01 01 01 01 01 01 01 01 01)" compile-bytes
" "(ef b3 30 60 b3 03 01 03 01 01 01 2f 05 3e ef b9)" compile-bytes
" "(3c 01 5a 01 04 01 01 05 2f 2f 05 92 01 01 01 01)" compile-bytes
" "(04 01 01 ef 05 60 2f 01 04 03 01 03 03 01 05 3d)" compile-bytes
" "(30 3d 05 3c 01 01 5a 01 04 01 b3 b3 01 01 03 03)" compile-bytes
" "(01 5a 01 b3 b3 01 3c 01 01 01 01 01 01 01 01 92)" compile-bytes
" "(b3 05 2f 01 01 5a 01 03 01 01 01 01 01 01 01 01)" compile-bytes
" "(01 01 01 01 60 60 01 b3 b3 01 3c 01 01 04 01 2f)" compile-bytes
" "(85 2f 05 92 01 04 01 3c 01 01 92 ef b3 b3 05 2f)" compile-bytes
" "(03 01 01 01 01 01 03 05 2f 03 01 03 01 01 01 03)" compile-bytes
" "(01 04 05 2f 01 2f 85 04 03 01 01 03 01 03 b3 b3)" compile-bytes
" "(3c 01 03 01 5a 01 01 59 60 04 01 01 01 01 04 01)" compile-bytes
" "(04 01 04 01 b9 60 05 03 03 01 03 01 01 01 01 01)" compile-bytes
" "(01 01 01 01 01 01 01 01 59 05 2f b3 b3 01 04 01)" compile-bytes
" "(01 01 03 2f ef 27 05 2f 01 03 01 01 03 01 2f 05)" compile-bytes
" "(30 30 05 3d 03 01 01 03 01 03 01 05 2f 03 01 01)" compile-bytes
" "(01 03 01 01 01 01 05 2f 03 2f 05 01 01 01 01 01)" compile-bytes
" "(01 01 b3 b3 03 01 03 01 04 03 01 2f 05 30 30 2f)" compile-bytes
" "(04 01 01 01 03 03 27 b9 b9 60 60 01 01 01 01 01)" compile-bytes
" "(01 01 01 01 01 01 01 01 01 01 01 01 92 3e 05 3e)" compile-bytes
" "(2f 01 03 01 03 03 01 2f 05 01 b3 3e 03 01 04 01)" compile-bytes
" "(01 01 3d b3 01 03 b3 60 01 01 3c 01 03 01 01 05)" compile-bytes
" "(2f 03 01 01 03 01 01 01 04 01 05 2f 01 2f ef 01)" compile-bytes
" "(01 03 01 03 01 3c b3 b3 01 01 01 03 01 03 01 b9)" compile-bytes
" "(b3 ef 3e 92 01 04 01 01 01 03 2f 05 ef 3e 30 01)" compile-bytes
" "(04 03 01 01 01 01 01 01 01 01 01 01 01 01 01 01)" compile-bytes
" "(03 b9 30 b9 01 04 01 01 01 01 5a 01 01 01 01 01)" compile-bytes
" "(01 01 01 5a 01 01 04 03 04 01 01 03 01 01 04 01)" compile-bytes
" "(01 04 01 01 03 01 01 01 01 03 01 3c 01 01 03 01)" compile-bytes
" "(03 01 03 04 01 01 04 01 03 01 04 01 03 03 03 01)" compile-bytes
" "(01 03 01 03 01 30 b9 01 01 01 01 01 3c 01 3c b9)" compile-bytes
" "(30 03 03 03 01 01 01 03 01 01 01 01 01 01 01 01)" compile-bytes
" "(01 01 01 01 01 01 03 01 03 01 04 01 01 04 01 3c)" compile-bytes
" "(01 01 03 01 01 01 03 01 01 3c 01 01 01 01 01 01)" compile-bytes
" "(01 01 01 03 01 01 01 01 01 01 03 01 01 01 01 01)" compile-bytes
" "(01 03 01 01 01 03 01 03 01 03 01 03 01 03 01 01)" compile-bytes
" "(01 01 01 03 01 01 04 01 3c 01 01 04 01 01 04 01)" compile-bytes
" "(01 04 01 03 01 01 01 01 03 01 03 01 01 01 01 01)" compile-bytes drop
constant pfb-logo-buf-len ( 0837 )
h# 0

headerless

constant token-0838 ( 0838 )
4 constant token-0839 ( 0839 )
8 constant token-083a ( 083a )
c constant token-083b ( 083b )
30 constant token-083c ( 083c )
34 constant token-083d ( 083d )
40 constant token-083e ( 083e )
50 constant token-083f ( 083f )
53 constant token-0840 ( 0840 )
54 constant token-0841 ( 0841 )
58 constant token-0842 ( 0842 )
5b constant token-0843 ( 0843 )
d04 constant token-0844 ( 0844 )
60 constant token-0845 ( 0845 )
64 constant token-0846 ( 0846 )
68 constant token-0847 ( 0847 )
b0 constant token-0848 ( 0848 )
b2 constant token-0849 ( 0849 )
b0 constant token-084a ( 084a )
b4 constant token-084b ( 084b )
ec constant token-084c ( 084c )
f8 constant token-084d ( 084d )
108 constant token-084e ( 084e )
110 constant token-084f ( 084f )
140 constant token-0850 ( 0850 )
144 constant token-0851 ( 0851 )
148 constant token-0852 ( 0852 )
14c constant token-0853 ( 0853 )
154 constant token-0854 ( 0854 )
158 constant token-0855 ( 0855 )
168 constant token-0856 ( 0856 )
174 constant token-0857 ( 0857 )
178 constant token-0858 ( 0858 )
17c constant token-0859 ( 0859 )
180 constant token-085a ( 085a )
184 constant token-085b ( 085b )
188 constant token-085c ( 085c )
18c constant token-085d ( 085d )
200 constant token-085e ( 085e )
204 constant token-085f ( 085f )
208 constant token-0860 ( 0860 )
20c constant token-0861 ( 0861 )
224 constant token-0862 ( 0862 )
22c constant token-0863 ( 0863 )
230 constant token-0864 ( 0864 )
23c constant token-0865 ( 0865 )
2f0 constant token-0866 ( 0866 )
250 constant token-0867 ( 0867 )
254 constant token-0868 ( 0868 )
258 constant token-0869 ( 0869 )
25c constant token-086a ( 086a )
278 constant token-086b ( 086b )
27c constant token-086c ( 086c )
280 constant token-086d ( 086d )
284 constant token-086e ( 086e )
28c constant token-086f ( 086f )
290 constant token-0870 ( 0870 )
294 constant token-0871 ( 0871 )
2a4 constant token-0872 ( 0872 )
2a8 constant token-0873 ( 0873 )
2c4 constant token-0874 ( 0874 )
2c8 constant token-0875 ( 0875 )
dbc constant token-0876 ( 0876 )
b00 constant token-0877 ( 0877 )
d64 constant token-0878 ( 0878 )
4 constant token-0879 ( 0879 )
8 constant token-087a ( 087a )
c constant token-087b ( 087b )
10 constant token-087c ( 087c )
14 constant token-087d ( 087d )
18 constant token-087e ( 087e )
1c constant token-087f ( 087f )
20 constant token-0880 ( 0880 )
24 constant token-0881 ( 0881 )
28 constant token-0882 ( 0882 )
2c constant token-0883 ( 0883 )
30 constant token-0884 ( 0884 )
34 constant token-0885 ( 0885 )
38 constant token-0886 ( 0886 )
3c constant token-0887 ( 0887 )
40 constant token-0888 ( 0888 )
44 constant token-0889 ( 0889 )
48 constant token-088a ( 088a )
50 constant token-088b ( 088b )
54 constant token-088c ( 088c )
7c constant token-088d ( 088d )
7c constant token-088e ( 088e )
3f8 constant token-088f ( 088f )
3fb constant token-0890 ( 0890 )
300 constant token-0891 ( 0891 )
304 constant token-0892 ( 0892 )
308 constant token-0893 ( 0893 )
30c constant token-0894 ( 0894 )
324 constant token-0895 ( 0895 )
32c constant token-0896 ( 0896 )
330 constant token-0897 ( 0897 )
334 constant token-0898 ( 0898 )
338 constant token-0899 ( 0899 )
33c constant token-089a ( 089a )
3f0 constant token-089b ( 089b )
d14 constant token-089c ( 089c )
888 constant token-089d ( 089d )
88c constant token-089e ( 089e )
288 constant token-089f ( 089f )
3c4 constant token-08a0 ( 08a0 )
3c8 constant token-08a1 ( 08a1 )
2d0 constant token-08a2 ( 08a2 )
2d4 constant token-08a3 ( 08a3 )
2ec constant token-08a4 ( 08a4 )
194 constant token-08a5 ( 08a5 )
198 constant token-08a6 ( 08a6 )
19c constant token-08a7 ( 08a7 )
1a0 constant token-08a8 ( 08a8 )
1a4 constant token-08a9 ( 08a9 )
1a8 constant token-08aa ( 08aa )
1ac constant token-08ab ( 08ab )
1b0 constant token-08ac ( 08ac )
1b4 constant token-08ad ( 08ad )
a8 constant token-08ae ( 08ae )
ac constant token-08af ( 08af )
b0 constant token-08b0 ( 08b0 )
b4 constant token-08b1 ( 08b1 )
b8 constant token-08b2 ( 08b2 )
8000000 value token-08b3 ( 08b3 )
20000 value token-08b4 ( 08b4 )
80000 value token-08b5 ( 08b5 )
100 value token-08b6 ( 08b6 )
10 value token-08b7 ( 08b7 )
0 value token-08b8 ( 08b8 )
ffffffff value token-08b9 ( 08b9 )
400000 value token-08ba ( 08ba )
493e0 constant token-08bb ( 08bb )
28488 constant token-08bc ( 08bc )
6978 value token-08bd ( 08bd )
28870 value token-08be ( 08be )
28870 value token-08bf ( 08bf )
28870 value token-08c0 ( 08c0 )
606060 value token-08c1 ( 08c1 )
0 value token-08c2 ( 08c2 )
0 value token-08c3 ( 08c3 )
0 value token-08c4 ( 08c4 )
7d0 value token-08c5 ( 08c5 )
0 value token-08c6 ( 08c6 )
0 value token-08c7 ( 08c7 )
0 value token-08c8 ( 08c8 )
ff value token-08c9 ( 08c9 )
4 value token-08ca ( 08ca )
0 value token-08cb ( 08cb )
15 value token-08cc ( 08cc )
2f value token-08cd ( 08cd )
0 value token-08ce ( 08ce )
0 value token-08cf ( 08cf )
0 value token-08d0 ( 08d0 )
0 value token-08d1 ( 08d1 )

: token-08d2 ( 08d2 )
    token-08d1 and 0<>
;

: token-08d3 ( 08d3 )
    20 token-08d2
;

: token-08d4 ( 08d4 )
    400 token-08d2
;

: token-08d5 ( 08d5 )
    10 token-08d2
;

: token-08d6 ( 08d6 )
    40 token-08d2
;

: token-08d7 ( 08d7 )
    6000 token-08d2
;

0 value token-08d8 ( 08d8 )

: token-08d9 ( 08d9 )
    token-08d8 80 0 fill
;

defer token-08da ( 08da )
defer token-08db ( 08db )

: token-08dc ( 08dc )
    0
    ?do
        get-msecs dup <>
        if
        then
    loop
;

: token-08dd ( 08dd )
    token-08c3 0=
    if
        get-msecs
        begin
            dup get-msecs <>
        until
        drop get-msecs ffffffff 0
        do
            dup get-msecs <>
            if
                i 0<>
                if
                    i 1 +
                else
                    i
                then
                to token-08c3 leave
            then
        loop
        drop
    then
    token-08c3 to token-08c4 4 0
    do
        token-08c4 10 >
        if
            token-08c4 2/ to token-08c4
        else
            leave
        then
    loop
;

: token-08de ( 08de )
    token-08c4
    if
        token-08c4 token-08dc
    else
        1 ms
    then
;

: token-08df ( 08df )
    2/ 2/ 2/
;

: token-08e0 ( 08e0 )
    0 swap ffff 0
    do
        dup 0=
        if
            drop i swap leave
        then
        2/
    loop
    drop
;

: token-08e1 ( 08e1 )
    1 swap lshift
;

: token-08e2 ( 08e2 )
    * token-08c9 + token-08c9 invert and
;

: token-08e3 ( 08e3 )
    dup c@ 8 lshift swap char+ c@ or
;

: token-08e4 ( 08e4 )
    1c * swap 97 * rot 4d * + + 8 rshift
;

: token-08e5 ( 08e5 )
    80 - 1 swap lshift dup 4 <=
    if
        -1
    else
        drop 0
    then
;

8000 value token-08e6 ( 08e6 )
0 value token-08e7 ( 08e7 )
0 value token-08e8 ( 08e8 )
0 value token-08e9 ( 08e9 )
1 value token-08ea ( 08ea )
token-08cc value token-08eb ( 08eb )
token-08cc value token-08ec ( 08ec )
token-08cc value token-08ed ( 08ed )
0 value token-08ee ( 08ee )
0 value token-08ef ( 08ef )
0 value token-08f0 ( 08f0 )
0 value token-08f1 ( 08f1 )
0 value token-08f2 ( 08f2 )
0 value token-08f3 ( 08f3 )
0 value token-08f4 ( 08f4 )
0 value token-08f5 ( 08f5 )
0 value token-08f6 ( 08f6 )
ffff value token-08f7 ( 08f7 )
token-08ca value token-08f8 ( 08f8 )
token-08ca value token-08f9 ( 08f9 )
0 value token-08fa ( 08fa )
0 value token-08fb ( 08fb )
0 value token-08fc ( 08fc )

: token-08fd ( 08fd )
    token-08c2 0<> dup
    if
    else
        cr " Display not installed" type cr
    then
;

: token-08fe ( 08fe )
    token-08e7 token-08e8 *
;

: token-0900 ( 0900 )
    dup 20 <
    if
        token-08e1 token-08ee or to token-08ee
    else
        20 - dup 20 <
        if
            token-08e1 token-08ef or to token-08ef
        else
            drop
        then
    then
;

: token-0901 ( 0901 )
    dup 20 <
    if
        token-08e1 invert token-08ee and to token-08ee
    else
        20 - dup 20 <
        if
            token-08e1 invert token-08ef and to token-08ef
        else
            20 - dup 20 <
            if
                token-08e1 invert token-08f0 and to token-08f0
            else
                20 - dup 20 <
                if
                    token-08e1 invert token-08f1 and to token-08f1
                else
                    drop
                then
            then
        then
    then
;

: token-0902 ( 0902 )
    dup 20 <
    if
        token-08e1 token-08ee and 0<>
    else
        20 - dup 20 <
        if
            token-08e1 token-08ef and 0<>
        else
            drop 0
        then
    then
;

: token-0903 ( 0903 )
    token-08e7 token-08ea token-08e2 to token-08e9
;

: token-0904 ( 0904 )
    token-08e7 swap token-08e2 token-08e8 * token-08b7 100000 * token-08e6
    - <=
;

: token-0905 ( 0905 )
    4 4 0
    do
        i 1 + token-0904 0=
        if
            drop i leave
        then
    loop
    1 max 4 min dup 3 =
    if
        1 -
    then
;

5d to token-08cd 2f value token-0906 ( 0906 )
660 buffer: token-0907 ( 0907 )
0 token-0907 " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 59 00 7c 00 07 02 f0 01 df 02 0c 00 08 01 ea)"
compile-bytes " "(00 59 00 74 00 09 02 f4 01 8f 01 bd 00 03 01 90)"
compile-bytes " "(00 4f 00 63 00 8c 02 90 01 df 02 0c 00 82 01 e9)"
compile-bytes " "(00 4f 00 67 00 05 02 98 01 df 02 07 00 03 01 e8)"
compile-bytes " "(00 4f 00 67 00 85 02 98 01 df 02 07 00 83 01 e8)"
compile-bytes " "(00 4f 00 68 00 88 02 90 01 df 01 f3 00 83 01 e0)"
compile-bytes " "(00 63 00 7f 00 09 03 38 02 57 02 70 00 02 02 58)"
compile-bytes " "(00 63 00 83 00 10 03 48 02 57 02 73 00 04 02 58)"
compile-bytes " "(00 63 00 81 00 0f 03 58 02 57 02 99 00 06 02 7c)"
compile-bytes " "(00 63 00 83 00 0a 03 30 02 57 02 70 00 03 02 58)"
compile-bytes " "(00 ef 01 3f 00 9c 07 c0 04 af 04 e1 00 83 04 b2)"
compile-bytes " "(00 7f 00 ab 00 0c 04 30 02 ff 03 27 00 03 03 00)"
compile-bytes " "(00 7f 00 a7 00 91 04 18 02 ff 03 25 00 86 03 02)"
compile-bytes " "(00 7f 00 a5 00 91 04 18 02 ff 03 25 00 86 03 02)"
compile-bytes " "(00 7f 00 a3 00 0c 04 10 02 ff 03 1f 00 03 03 00)"
compile-bytes " "(00 9f 00 d2 00 12 05 10 03 ff 04 29 00 03 04 00)"
compile-bytes " "(00 7f 00 ab 00 0c 04 30 02 ff 03 27 00 03 03 00)"
compile-bytes " "(00 63 00 82 00 08 03 40 02 57 02 76 00 03 02 58)"
compile-bytes " "(00 4f 00 67 00 87 02 b8 01 df 01 fc 00 83 01 e0)"
compile-bytes " "(00 9f 00 d2 00 0e 05 30 03 ff 04 29 00 03 04 00)"
compile-bytes " "(00 8f 00 be 00 90 04 a8 03 83 03 a8 00 84 03 85)"
compile-bytes " "(00 8f 00 bb 00 90 04 a0 03 83 03 ae 00 88 03 85)"
compile-bytes " "(00 9f 00 cb 00 8e 05 10 03 ff 04 2a 00 88 04 01)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 c7 01 08 00 9b 06 58 04 ff 05 3b 00 88 05 01)"
compile-bytes " "(00 ef 01 3f 00 9b 07 b0 04 37 04 93 00 83 04 3a)"
compile-bytes " "(00 9f 00 c3 00 8e 05 14 03 1f 03 4d 00 87 03 22)"
compile-bytes " "(00 b3 00 ea 00 94 05 c8 03 83 03 af 00 83 03 85)"
compile-bytes " "(00 c7 00 f5 00 91 06 68 03 e7 04 0e 00 85 03 e9)"
compile-bytes " "(00 c7 01 09 00 9b 06 60 03 e7 04 1a 00 83 03 e9)"
compile-bytes " "(00 ef 01 39 00 9c 07 98 04 af 04 d7 00 83 04 b0)"
compile-bytes " "(00 9f 00 d7 00 14 05 40 03 ff 04 2f 00 03 04 00)"
compile-bytes " "(00 9f 00 cf 00 88 05 20 03 ff 04 29 00 88 04 01)"
compile-bytes " "(00 8f 00 c7 00 10 04 c0 03 5f 03 83 00 03 03 60)"
compile-bytes " "(00 7f 00 a9 00 88 04 20 02 ff 03 24 00 84 03 01)"
compile-bytes " "(00 7f 00 a4 00 90 04 10 03 1f 03 44 00 84 03 21)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 ef 01 00 00 07 07 88 04 af 04 d1 00 04 04 b1)"
compile-bytes " "(00 ef 01 00 00 08 07 84 04 37 04 57 00 04 04 39)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 59 00 7c 00 07 02 f0 01 df 02 0c 00 08 01 ea)"
compile-bytes " "(00 59 00 74 00 09 02 f4 01 8f 01 bd 00 03 01 90)"
compile-bytes " "(00 4f 00 63 00 8c 02 90 01 df 02 0c 00 82 01 e9)"
compile-bytes " "(00 4f 00 67 00 05 02 98 01 df 02 07 00 03 01 e8)"
compile-bytes " "(00 4f 00 67 00 85 02 98 01 df 02 07 00 83 01 e8)"
compile-bytes " "(00 4f 00 68 00 88 02 90 01 df 01 f3 00 83 01 e0)"
compile-bytes " "(00 63 00 7f 00 09 03 38 02 57 02 70 00 02 02 58)"
compile-bytes " "(00 63 00 83 00 10 03 48 02 57 02 73 00 04 02 58)"
compile-bytes " "(00 63 00 81 00 0f 03 58 02 57 02 99 00 06 02 7c)"
compile-bytes " "(00 63 00 83 00 0a 03 30 02 57 02 70 00 03 02 58)"
compile-bytes " "(00 ef 01 3f 00 9c 07 c0 04 af 04 e1 00 83 04 b2)"
compile-bytes " "(00 7f 00 ab 00 0c 04 30 02 ff 03 27 00 03 03 00)"
compile-bytes " "(00 7f 00 a7 00 91 04 18 02 ff 03 25 00 86 03 02)"
compile-bytes " "(00 7f 00 a5 00 91 04 18 02 ff 03 25 00 86 03 02)"
compile-bytes " "(00 7f 00 a3 00 0c 04 10 02 ff 03 1f 00 03 03 00)"
compile-bytes " "(00 9f 00 d2 00 12 05 10 03 ff 04 29 00 03 04 00)"
compile-bytes " "(00 7f 00 ab 00 0c 04 30 02 ff 03 27 00 03 03 00)"
compile-bytes " "(00 63 00 82 00 08 03 40 02 57 02 76 00 03 02 58)"
compile-bytes " "(00 4f 00 67 00 87 02 b8 01 df 01 fc 00 83 01 e0)"
compile-bytes " "(00 9f 00 d2 00 0e 05 30 03 ff 04 29 00 03 04 00)"
compile-bytes " "(00 8f 00 be 00 90 04 a8 03 83 03 a8 00 84 03 85)"
compile-bytes " "(00 8f 00 bb 00 90 04 a0 03 83 03 ae 00 88 03 85)"
compile-bytes " "(00 9f 00 cb 00 8e 05 10 03 ff 04 2a 00 88 04 01)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 c7 01 08 00 9b 06 58 04 ff 05 3b 00 88 05 01)"
compile-bytes " "(00 ef 01 3f 00 9b 07 b0 04 37 04 93 00 83 04 3a)"
compile-bytes " "(00 9f 00 c3 00 8e 05 14 03 1f 03 4d 00 87 03 22)"
compile-bytes " "(00 b3 00 ea 00 94 05 c8 03 83 03 af 00 83 03 85)"
compile-bytes " "(00 c7 00 f5 00 91 06 68 03 e7 04 0e 00 85 03 e9)"
compile-bytes " "(00 c7 01 09 00 9b 06 60 03 e7 04 1a 00 83 03 e9)"
compile-bytes " "(00 ef 01 39 00 9c 07 98 04 af 04 d7 00 83 04 b0)"
compile-bytes " "(00 9f 00 d7 00 14 05 40 03 ff 04 2f 00 03 04 00)"
compile-bytes " "(00 9f 00 cf 00 88 05 20 03 ff 04 29 00 88 04 01)"
compile-bytes " "(00 8f 00 c7 00 10 04 c0 03 5f 03 83 00 03 03 60)"
compile-bytes " "(00 7f 00 a9 00 88 04 20 02 ff 03 24 00 84 03 01)"
compile-bytes " "(00 7f 00 a4 00 90 04 10 03 1f 03 44 00 84 03 21)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 c7 01 0d 00 18 06 80 04 af 04 e1 00 03 04 b0)"
compile-bytes " "(00 ef 01 00 00 07 07 88 04 af 04 d1 00 04 04 b1)"
compile-bytes " "(00 ef 01 00 00 08 07 84 04 37 04 57 00 04 04 39)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes " "(00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)"
compile-bytes 2drop cc buffer: token-0908 ( 0908 )
0 token-0908 " "(00 00)" compile-bytes " "(0c 4e)" compile-bytes
" "(0d de)" compile-bytes " "(09 d6)" compile-bytes " "(0b 53)"
compile-bytes " "(0c 4e)" compile-bytes " "(0c 4e)" compile-bytes
" "(0e 10)" compile-bytes " "(0f a0)" compile-bytes " "(13 88)"
compile-bytes " "(13 56)" compile-bytes " "(5d 9b)" compile-bytes
" "(24 ea)" compile-bytes " "(19 64)" compile-bytes " "(1d 4c)"
compile-bytes " "(1e c3)" compile-bytes " "(34 bc)" compile-bytes
" "(24 ea)" compile-bytes " "(15 f9)" compile-bytes " "(0e 10)"
compile-bytes " *0" compile-bytes " "(24 ea)" compile-bytes " *0"
compile-bytes " "(2d b4)" compile-bytes " "(00 00)" compile-bytes
" "(00 00)" compile-bytes " "(00 00)" compile-bytes " "(00 00)"
compile-bytes " T`" compile-bytes " T`" compile-bytes " "(27 8d)"
compile-bytes " "(34 bc)" compile-bytes " "(34 bc)" compile-bytes " Br"
compile-bytes " "(55 b2)" compile-bytes " "(3d 86)" compile-bytes
" "(34 bc)" compile-bytes " *0" compile-bytes " "(20 f6)" compile-bytes
" "(24 ea)" compile-bytes " ?H" compile-bytes " "(44 8e)" compile-bytes
" "(49 d4)" compile-bytes " "(4f 1a)" compile-bytes " "(59 a6)"
compile-bytes " "(3b 10)" compile-bytes " "(35 ca)" compile-bytes
" "(00 00)" compile-bytes " "(0c 4e)" compile-bytes " "(0d de)"
compile-bytes " "(09 d6)" compile-bytes " "(0b 53)" compile-bytes
" "(0c 4e)" compile-bytes " "(0c 4e)" compile-bytes " "(0e 10)"
compile-bytes " "(0f a0)" compile-bytes " "(13 88)" compile-bytes
" "(13 56)" compile-bytes " "(5d 9b)" compile-bytes " "(24 ea)"
compile-bytes " "(19 64)" compile-bytes " "(1d 4c)" compile-bytes
" "(1e c3)" compile-bytes " "(34 bc)" compile-bytes " "(24 ea)"
compile-bytes " "(15 f9)" compile-bytes " "(0e 10)" compile-bytes " *0"
compile-bytes " "(24 ea)" compile-bytes " *0" compile-bytes " "(2d b4)"
compile-bytes " "(00 00)" compile-bytes " "(00 00)" compile-bytes
" "(00 00)" compile-bytes " "(00 00)" compile-bytes " T`" compile-bytes
" T`" compile-bytes " "(27 8d)" compile-bytes " "(34 bc)" compile-bytes
" "(34 bc)" compile-bytes " Br" compile-bytes " "(55 b2)" compile-bytes
" "(3d 86)" compile-bytes " "(34 bc)" compile-bytes " *0" compile-bytes
" "(20 f6)" compile-bytes " "(24 ea)" compile-bytes " ?H" compile-bytes
" "(44 8e)" compile-bytes " "(49 d4)" compile-bytes " "(4f 1a)"
compile-bytes " "(59 a6)" compile-bytes " "(3b 10)" compile-bytes
" "(35 ca)" compile-bytes " "(00 00)" compile-bytes " "(00 00)"
compile-bytes " "(00 00)" compile-bytes " "(00 00)" compile-bytes
" "(00 00)" compile-bytes " "(00 00)" compile-bytes " "(00 00)"
compile-bytes " "(00 00)" compile-bytes 2drop 198
buffer: token-0909 ( 0909 )
0 token-0909 " "(00 00 00 00)" compile-bytes " "(0c 00 38 04)"
compile-bytes " "(12 00 8e 06)" compile-bytes " "(18 00 b3 08)"
compile-bytes " "(16 00 bd 08)" compile-bytes " "(0c 00 38 04)"
compile-bytes " "(0c 00 38 04)" compile-bytes " "(0c 00 40 04)"
compile-bytes " "(12 00 a0 06)" compile-bytes " "(12 00 64 03)"
compile-bytes " "(0c 00 42 03)" compile-bytes " "(10 00 8e 01)"
compile-bytes " "(0c 00 54 02)" compile-bytes " "(12 00 82 03)"
compile-bytes " "(0c 00 64 03)" compile-bytes " "(0c 00 46 02)"
compile-bytes " "(0c 00 3c 01)" compile-bytes " "(0c 00 54 02)"
compile-bytes " "(0c 00 4b 03)" compile-bytes " "(0c 00 40 04)"
compile-bytes " "(0c 00 60 02)" compile-bytes " "(0c 00 54 02)"
compile-bytes " "(0c 00 60 02)" compile-bytes " "(0c 00 68 02)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(0c 00 60 01)" compile-bytes " "(0c 00 60 01)"
compile-bytes " "(0c 00 5a 02)" compile-bytes " "(0c 00 3c 01)"
compile-bytes " "(0c 00 3c 01)" compile-bytes " "(14 00 7e 01)"
compile-bytes " "(10 00 82 01)" compile-bytes " "(0c 00 46 01)"
compile-bytes " "(0c 00 3c 01)" compile-bytes " "(0c 00 60 02)"
compile-bytes " "(0c 00 4b 02)" compile-bytes " "(0c 00 54 02)"
compile-bytes " "(0c 00 48 01)" compile-bytes " "(0c 00 4e 01)"
compile-bytes " "(0c 00 54 01)" compile-bytes " "(0c 00 5a 01)"
compile-bytes " "(0c 00 66 01)" compile-bytes " "(0f 00 54 01)"
compile-bytes " "(0f 00 99 02)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(0c 00 38 04)" compile-bytes " "(12 00 8e 06)"
compile-bytes " "(18 00 b3 08)" compile-bytes " "(16 00 bd 08)"
compile-bytes " "(0c 00 38 04)" compile-bytes " "(0c 00 38 04)"
compile-bytes " "(0c 00 40 04)" compile-bytes " "(12 00 a0 06)"
compile-bytes " "(12 00 64 03)" compile-bytes " "(0c 00 42 03)"
compile-bytes " "(10 00 8e 01)" compile-bytes " "(0c 00 54 02)"
compile-bytes " "(12 00 82 03)" compile-bytes " "(0c 00 64 03)"
compile-bytes " "(0c 00 46 02)" compile-bytes " "(0c 00 3c 01)"
compile-bytes " "(0c 00 54 02)" compile-bytes " "(0c 00 4b 03)"
compile-bytes " "(0c 00 40 04)" compile-bytes " "(0c 00 60 02)"
compile-bytes " "(0c 00 54 02)" compile-bytes " "(0c 00 60 02)"
compile-bytes " "(0c 00 68 02)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(0c 00 60 01)"
compile-bytes " "(0c 00 60 01)" compile-bytes " "(0c 00 5a 02)"
compile-bytes " "(0c 00 3c 01)" compile-bytes " "(0c 00 3c 01)"
compile-bytes " "(14 00 7e 01)" compile-bytes " "(10 00 82 01)"
compile-bytes " "(0c 00 46 01)" compile-bytes " "(0c 00 3c 01)"
compile-bytes " "(0c 00 60 02)" compile-bytes " "(0c 00 4b 02)"
compile-bytes " "(0c 00 54 02)" compile-bytes " "(0c 00 48 01)"
compile-bytes " "(0c 00 4e 01)" compile-bytes " "(0c 00 54 01)"
compile-bytes " "(0c 00 5a 01)" compile-bytes " "(0c 00 66 01)"
compile-bytes " "(0f 00 54 01)" compile-bytes " "(0f 00 99 02)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes 2drop 198 buffer: token-090a ( 090a )
0 token-090a " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 0c)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 0c)"
compile-bytes " "(00 00 00 0c)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 0c)"
compile-bytes " "(00 00 00 0c)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 0c)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 0c)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 0c)" compile-bytes " "(00 00 00 0c)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 0c)" compile-bytes " "(00 00 00 0c)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 0c)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 1c)"
compile-bytes " "(00 00 00 1c)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes " "(00 00 00 00)" compile-bytes " "(00 00 00 00)"
compile-bytes 2drop

: token-090b ( 090b )
    token-090a swap la+
;

: token-090c ( 090c )
    token-090b l@
;

0 value token-090d ( 090d )
0 value token-090e ( 090e )
0 value token-090f ( 090f )
0 value token-0910 ( 0910 )

: token-0911 ( 0911 )
    my-args 0<>
    if
        dup " r720x480x60" comp 0=
        if
            1 to token-08eb
        then
        dup " r720x400x85" comp 0=
        if
            2 to token-08eb
        then
        dup " r640x480x60" comp 0=
        if
            3 to token-08eb
        then
        dup " r640x480x67" comp 0=
        if
            4 to token-08eb
        then
        dup " r640x480x72" comp 0=
        if
            5 to token-08eb
        then
        dup " r640x480x75" comp 0=
        if
            6 to token-08eb
        then
        dup " r800x600x56" comp 0=
        if
            7 to token-08eb
        then
        dup " r800x600x60" comp 0=
        if
            8 to token-08eb
        then
        dup " r800x600x72" comp 0=
        if
            9 to token-08eb
        then
        dup " r800x600x75" comp 0=
        if
            a to token-08eb
        then
        dup " r1920x1200x75" comp 0=
        if
            b to token-08eb
        then
        dup " r1024x768x87" comp 0=
        if
            c to token-08eb
        then
        dup " r1024x768x60" comp 0=
        if
            d to token-08eb
        then
        dup " r1024x768x70" comp 0=
        if
            e to token-08eb
        then
        dup " r1024x768x75" comp 0=
        if
            f to token-08eb
        then
        dup " r1280x1024x75" comp 0=
        if
            10 to token-08eb
        then
        dup " r1024x768x85" comp 0=
        if
            11 to token-08eb
        then
        dup " r800x600x85" comp 0=
        if
            12 to token-08eb
        then
        dup " r640x480x85" comp 0=
        if
            13 to token-08eb
        then
        dup " r1280x1024x60" comp 0=
        if
            14 to token-08eb
        then
        dup " r1152x900x66" comp 0=
        if
            15 to token-08eb
        then
        dup " r1152x900x76" comp 0=
        if
            16 to token-08eb
        then
        dup " r1280x1024x67" comp 0=
        if
            17 to token-08eb
        then
        dup " r1600x1280x76" comp 0=
        if
            1c to token-08eb
        then
        dup " r1920x1080x72" comp 0=
        if
            1d to token-08eb
        then
        dup " r1280x800x76" comp 0=
        if
            1e to token-08eb
        then
        dup " r1440x900x76" comp 0=
        if
            1f to token-08eb
        then
        dup " r1600x1000x66" comp 0=
        if
            20 to token-08eb
        then
        dup " r1600x1000x76" comp 0=
        if
            21 to token-08eb
        then
        dup " r1920x1200x70" comp 0=
        if
            22 to token-08eb
        then
        dup " r1280x1024x85" comp 0=
        if
            23 to token-08eb
        then
        dup " r1280x1024x76" comp 0=
        if
            24 to token-08eb
        then
        dup " r1152x864x75" comp 0=
        if
            25 to token-08eb
        then
        dup " r1024x768x77" comp 0=
        if
            26 to token-08eb
        then
        dup " r1024x800x84" comp 0=
        if
            27 to token-08eb
        then
        dup " r1600x1200x60" comp 0=
        if
            28 to token-08eb
        then
        dup " r1600x1200x65" comp 0=
        if
            29 to token-08eb
        then
        dup " r1600x1200x70" comp 0=
        if
            2a to token-08eb
        then
        dup " r1600x1200x75" comp 0=
        if
            2b to token-08eb
        then
        dup " r1600x1200x85" comp 0=
        if
            2c to token-08eb
        then
        dup " r1920x1200x60" comp 0=
        if
            2d to token-08eb
        then
        dup " r1920x1080x60" comp 0=
        if
            2e to token-08eb
        then
        dup " r720x480x60x8" comp 0=
        if
            1 to token-08eb
        then
        dup " r720x400x85x8" comp 0=
        if
            2 to token-08eb
        then
        dup " r640x480x60x8" comp 0=
        if
            3 to token-08eb
        then
        dup " r640x480x67x8" comp 0=
        if
            4 to token-08eb
        then
        dup " r640x480x72x8" comp 0=
        if
            5 to token-08eb
        then
        dup " r640x480x75x8" comp 0=
        if
            6 to token-08eb
        then
        dup " r800x600x56x8" comp 0=
        if
            7 to token-08eb
        then
        dup " r800x600x60x8" comp 0=
        if
            8 to token-08eb
        then
        dup " r800x600x72x8" comp 0=
        if
            9 to token-08eb
        then
        dup " r800x600x75x8" comp 0=
        if
            a to token-08eb
        then
        dup " r1920x1200x75x8" comp 0=
        if
            b to token-08eb
        then
        dup " r1024x768x87x8" comp 0=
        if
            c to token-08eb
        then
        dup " r1024x768x60x8" comp 0=
        if
            d to token-08eb
        then
        dup " r1024x768x70x8" comp 0=
        if
            e to token-08eb
        then
        dup " r1024x768x75x8" comp 0=
        if
            f to token-08eb
        then
        dup " r1280x1024x75x8" comp 0=
        if
            10 to token-08eb
        then
        dup " r1024x768x85x8" comp 0=
        if
            11 to token-08eb
        then
        dup " r800x600x85x8" comp 0=
        if
            12 to token-08eb
        then
        dup " r640x480x85x8" comp 0=
        if
            13 to token-08eb
        then
        dup " r1280x1024x60x8" comp 0=
        if
            14 to token-08eb
        then
        dup " r1152x900x66x8" comp 0=
        if
            15 to token-08eb
        then
        dup " r1152x900x76x8" comp 0=
        if
            16 to token-08eb
        then
        dup " r1280x1024x67x8" comp 0=
        if
            17 to token-08eb
        then
        dup " r1600x1280x76x8" comp 0=
        if
            1c to token-08eb
        then
        dup " r1920x1080x72x8" comp 0=
        if
            1d to token-08eb
        then
        dup " r1280x800x76x8" comp 0=
        if
            1e to token-08eb
        then
        dup " r1440x900x76x8" comp 0=
        if
            1f to token-08eb
        then
        dup " r1600x1000x66x8" comp 0=
        if
            20 to token-08eb
        then
        dup " r1600x1000x76x8" comp 0=
        if
            21 to token-08eb
        then
        dup " r1920x1200x70x8" comp 0=
        if
            22 to token-08eb
        then
        dup " r1280x1024x85x8" comp 0=
        if
            23 to token-08eb
        then
        dup " r1280x1024x76x8" comp 0=
        if
            24 to token-08eb
        then
        dup " r1152x864x75x8" comp 0=
        if
            25 to token-08eb
        then
        dup " r1024x768x77x8" comp 0=
        if
            26 to token-08eb
        then
        dup " r1024x800x84x8" comp 0=
        if
            27 to token-08eb
        then
        dup " r1600x1200x60x8" comp 0=
        if
            28 to token-08eb
        then
        dup " r1600x1200x65x8" comp 0=
        if
            29 to token-08eb
        then
        dup " r1600x1200x70x8" comp 0=
        if
            2a to token-08eb
        then
        dup " r1600x1200x75x8" comp 0=
        if
            2b to token-08eb
        then
        dup " r1600x1200x85x8" comp 0=
        if
            2c to token-08eb
        then
        dup " r1920x1200x60x8" comp 0=
        if
            2d to token-08eb
        then
        dup " r1920x1080x60x8" comp 0=
        if
            2e to token-08eb
        then
        dup " r720x480x60x24" comp 0=
        if
            1 to token-08eb 4 to token-08ea
        then
        dup " r720x400x85x24" comp 0=
        if
            2 to token-08eb 4 to token-08ea
        then
        dup " r640x480x60x24" comp 0=
        if
            3 to token-08eb 4 to token-08ea
        then
        dup " r640x480x67x24" comp 0=
        if
            4 to token-08eb 4 to token-08ea
        then
        dup " r640x480x72x24" comp 0=
        if
            5 to token-08eb 4 to token-08ea
        then
        dup " r640x480x75x24" comp 0=
        if
            6 to token-08eb 4 to token-08ea
        then
        dup " r800x600x56x24" comp 0=
        if
            7 to token-08eb 4 to token-08ea
        then
        dup " r800x600x60x24" comp 0=
        if
            8 to token-08eb 4 to token-08ea
        then
        dup " r800x600x72x24" comp 0=
        if
            9 to token-08eb 4 to token-08ea
        then
        dup " r800x600x75x24" comp 0=
        if
            a to token-08eb 4 to token-08ea
        then
        dup " r1920x1200x75x24" comp 0=
        if
            b to token-08eb 4 to token-08ea
        then
        dup " r1024x768x87x24" comp 0=
        if
            c to token-08eb 4 to token-08ea
        then
        dup " r1024x768x60x24" comp 0=
        if
            d to token-08eb 4 to token-08ea
        then
        dup " r1024x768x70x24" comp 0=
        if
            e to token-08eb 4 to token-08ea
        then
        dup " r1024x768x75x24" comp 0=
        if
            f to token-08eb 4 to token-08ea
        then
        dup " r1280x1024x75x24" comp 0=
        if
            10 to token-08eb 4 to token-08ea
        then
        dup " r1024x768x85x24" comp 0=
        if
            11 to token-08eb 4 to token-08ea
        then
        dup " r800x600x85x24" comp 0=
        if
            12 to token-08eb 4 to token-08ea
        then
        dup " r640x480x85x24" comp 0=
        if
            13 to token-08eb 4 to token-08ea
        then
        dup " r1280x1024x60x24" comp 0=
        if
            14 to token-08eb 4 to token-08ea
        then
        dup " r1152x900x66x24" comp 0=
        if
            15 to token-08eb 4 to token-08ea
        then
        dup " r1152x900x76x24" comp 0=
        if
            16 to token-08eb 4 to token-08ea
        then
        dup " r1280x1024x67x24" comp 0=
        if
            17 to token-08eb 4 to token-08ea
        then
        dup " r1600x1280x76x24" comp 0=
        if
            1c to token-08eb 4 to token-08ea
        then
        dup " r1920x1080x72x24" comp 0=
        if
            1d to token-08eb 4 to token-08ea
        then
        dup " r1280x800x76x24" comp 0=
        if
            1e to token-08eb 4 to token-08ea
        then
        dup " r1440x900x76x24" comp 0=
        if
            1f to token-08eb 4 to token-08ea
        then
        dup " r1600x1000x66x24" comp 0=
        if
            20 to token-08eb 4 to token-08ea
        then
        dup " r1600x1000x76x24" comp 0=
        if
            21 to token-08eb 4 to token-08ea
        then
        dup " r1920x1200x70x24" comp 0=
        if
            22 to token-08eb 4 to token-08ea
        then
        dup " r1280x1024x85x24" comp 0=
        if
            23 to token-08eb 4 to token-08ea
        then
        dup " r1280x1024x76x24" comp 0=
        if
            24 to token-08eb 4 to token-08ea
        then
        dup " r1152x864x75x24" comp 0=
        if
            25 to token-08eb 4 to token-08ea
        then
        dup " r1024x768x77x24" comp 0=
        if
            26 to token-08eb 4 to token-08ea
        then
        dup " r1024x800x84x24" comp 0=
        if
            27 to token-08eb 4 to token-08ea
        then
        dup " r1600x1200x60x24" comp 0=
        if
            28 to token-08eb 4 to token-08ea
        then
        dup " r1600x1200x65x24" comp 0=
        if
            29 to token-08eb 4 to token-08ea
        then
        dup " r1600x1200x70x24" comp 0=
        if
            2a to token-08eb 4 to token-08ea
        then
        dup " r1600x1200x75x24" comp 0=
        if
            2b to token-08eb 4 to token-08ea
        then
        dup " r1600x1200x85x24" comp 0=
        if
            2c to token-08eb 4 to token-08ea
        then
        dup " r1920x1200x60x24" comp 0=
        if
            2d to token-08eb 4 to token-08ea
        then
        dup " r1920x1080x60x24" comp 0=
        if
            2e to token-08eb 4 to token-08ea
        then
    then
    drop
;

: token-0912 ( 0912 )
    token-0907 swap 2* 2* la+
;

: token-0913 ( 0913 )
    token-0908 swap wa+
;

: token-0914 ( 0914 )
    dup >r token-0912 200 swap 4 /l* bounds
    do
        i l@ /l
    +loop
    r>
;

: token-0915 ( 0915 )
    token-0912 tuck l! la1+ tuck l! la1+ tuck l! la1+ l!
;

: token-0916 ( 0916 )
    token-0912 dup l@ 10 rshift ff and 1 + 8 * swap la1+ la1+ l@ 10 rshift
    1 +
;

: token-0917 ( 0917 )
    token-0913 w@
;

: token-0918 ( 0918 )
    token-0913 w!
;

: token-0919 ( 0919 )
    token-0912 dup l@ ffff and 1 + 8 * swap 2 la+ l@ ffff and 1 +
;

-1 value token-091a ( 091a )
-1 value token-091b ( 091b )
80 value token-091c ( 091c )
1 value token-091d ( 091d )
0 value token-091e ( 091e )
0 value token-091f ( 091f )
0 value token-0920 ( 0920 )
40 alloc-mem value token-0921 ( 0921 )
0 value token-0922 ( 0922 )
0 value token-0923 ( 0923 )
0 value token-0924 ( 0924 )

: token-0925 ( 0925 )
    token-0922 token-0916 drop
;

: token-0926 ( 0926 )
    token-0922 token-0916 swap drop
;

: token-0927 ( 0927 )
    token-0906 - dup 20 <
    if
        token-08e1 token-090d and 0<>
    else
        20 - dup 20 <
        if
            token-08e1 token-090e and 0<>
        else
            drop 0
        then
    then
;

: token-0928 ( 0928 )
    dup token-0927
    if
        token-0916 token-0926 >= swap token-0925 >= and 0<>
    else
        drop 0
    then
;

: token-0929 ( 0929 )
    dup token-0906 <=
    if
        token-0906 +
    then
;

: token-092a ( 092a )
    token-0929 to token-0922 token-0920 0<>
    if
        token-091f token-0916 token-0926 < swap token-0925 < and
        if
            token-0922 to token-091f
        then
    else
        token-0922 to token-091f
    then
    -1 token-0920 0
    ?do
        token-0921 i ca+ c@ token-0922 =
        if
            drop 0 leave
        then
    loop
    if
        token-0922 token-0921 token-0920 ca+ c! token-0920 1 + to
        token-0920
    then
;

: token-092b ( 092b )
    token-0929 dup to token-0922 dup to token-08eb token-0906 - dup 20 <
    if
        token-08e1 token-090d or to token-090d
    else
        20 - dup 20 <
        if
            token-08e1 token-090e or to token-090e
        else
            drop
        then
    then
;

: token-092c ( 092c )
    dup token-0916 2dup token-0922 token-0916 1000 * rot / swap 1000 * rot
    / min tuck * 800 / 1 + 2/ to token-0924 * 800 / 1 + 2/ 7 + 7 invert and
    to token-0923
;

: token-092d ( 092d )
    token-092c drop
;

: token-092e ( 092e )
    dup to token-0922 token-092d
;

88020 constant token-092f ( 092f )
11294 constant token-0930 ( 0930 )
7880108 constant token-0931 ( 0931 )
280203 constant token-0932 ( 0932 )
30148 constant token-0933 ( 0933 )
a1b constant token-0934 ( 0934 )
a3f constant token-0935 ( 0935 )
1000000 constant token-0936 ( 0936 )
5133a330 constant token-0937 ( 0937 )
f constant token-0938 ( 0938 )
ff60410a constant token-0939 ( 0939 )
h# 0 constant token-093a ( 093a )
5000200 constant token-093b ( 093b )
4000200 constant token-093c ( 093c )
100000 constant token-093d ( 093d )
ffffe000 constant token-093e ( 093e )
20007c7c constant token-093f ( 093f )
h# 0 constant token-0940 ( 0940 )
4443 constant token-0941 ( 0941 )
h# 0 constant token-0942 ( 0942 )
3 to token-08b8 5 value token-0943 ( 0943 )
78007200 value token-0944 ( 0944 )
a733 value token-0945 ( 0945 )
40000 value token-0946 ( 0946 )
400ec03 value token-0947 ( 0947 )
400bc33 value token-0948 ( 0948 )
a350000 value token-0949 ( 0949 )
fffffff8 value token-094a ( 094a )
53f value token-094b ( 094b )
8830883 value token-094c ( 094c )
1100 value token-094d ( 094d )
1000007 value token-094e ( 094e )
ff1f9fff value token-094f ( 094f )
ffcfffff value token-0950 ( 0950 )
7c00 value token-0951 ( 0951 )
66 value token-0952 ( 0952 )
2000 value token-0953 ( 0953 )
e05356b value token-0954 ( 0954 )
77777777 value token-0955 ( 0955 )
40320032 value token-0956 ( 0956 )
806 value token-0957 ( 0957 )
0 value token-0958 ( 0958 )
28870 to token-08be 28870 to token-08bf

: token-0959 ( 0959 )
    dup 3 invert and token-08c8 token-0838 + rl! 3 and token-08c8
    token-0839 + +
;

: token-095a ( 095a )
    token-08c8 +
;

: token-095b ( 095b )
    dup token-08b6 < token-08c6 0<> or
    if
        token-095a
    else
        token-0959
    then
;

: token-095c ( 095c )
    token-095b rl@
;

: token-095d ( 095d )
    token-095b rw@
;

: token-095e ( 095e )
    token-095b rb@
;

: token-095f ( 095f )
    token-095b rl!
;

: token-0960 ( 0960 )
    token-095b rw!
;

: token-0961 ( 0961 )
    token-095b rb!
;

: token-0962 ( 0962 )
    token-08c6 + rl!
;

: token-0963 ( 0963 )
    token-08c6 + rl@
;

: token-0964 ( 0964 )
    dup 2/ 2/ 7f and token-083a token-0961 3 and token-083b + token-095e
;

: token-0965 ( 0965 )
    dup 2/ 2/ 80 or token-083a token-0961 3 and token-083b + token-0961
;

: token-0966 ( 0966 )
    2/ 2/ 7f and token-083a token-0961 token-083b token-095c
;

: token-0967 ( 0967 )
    2/ 2/ 80 or token-083a token-0961 token-083b token-095f
;

: token-0968 ( 0968 )
    token-084b token-095f
;

: token-0969 ( 0969 )
    token-084b token-095c
;

: token-096a ( 096a )
    token-0849 token-0961
;

: token-096b ( 096b )
    token-0848 token-0961
;

: token-096c ( 096c )
    token-0842 token-095e dup 8 or token-0842 token-0961 token-08c1
    token-0864 token-095f 20 ms token-0842 token-095e f0 and 0<> 0
    token-0864 token-095f swap token-0842 token-0961
;

: token-096d ( 096d )
    token-088e dup token-095e 20 or swap token-0961
;

: token-096e ( 096e )
    token-088e dup token-095e 20 invert and swap token-0961
;

: token-096f ( 096f )
    1 - token-088e token-095e 1 invert and or token-088e token-0961
;

: token-0970 ( 0970 )
    token-089c token-095e 20 rot 1 =
    if
        or
    else
        invert and
    then
    token-089c token-0961 token-088e token-095e 2 or token-088e token-0961
    token-0932 token-089e token-095f token-088f token-095c 80 or token-088f
    token-095f
;

: token-0971 ( 0971 )
    token-088f token-095c 80 invert and token-088f token-095f
;

: token-0972 ( 0972 )
    1f56667 token-089d token-095f 880213 token-089e token-095f token-088e
    token-095e dup 2 invert and token-088e token-0961 20 ms token-089e
    token-095c swap token-088e token-0961 20 and 0<>
;

: token-0973 ( 0973 )
    token-0842 token-095e dup 8 or token-0842 token-0961 token-08c1
    token-0864 token-095f token-08c1 token-0897 token-095f 20 ms token-0842
    token-095e f0 and 0<> 0 token-0864 token-095f 0 token-0897 token-095f
    swap token-0842 token-0961
;

: token-0974 ( 0974 )
    4 my-space + dup " config-b@" $call-parent 2 or swap " config-b!"
    $call-parent 100 token-095c drop 0 token-0865 token-095f 0 token-089a
    token-095f 0 10 rshift 0 token-08b3 + 1 - ffff0000 and or token-0852
    token-095f
;

: token-0975 ( 0975 )
    0 to token-08c7 token-08c6 0=
    if
        token-08c7 0 my-space 2000010 + token-08b3 " map-in" $call-parent
        to token-08c6
    then
    0 to token-08c7 token-08c8 0=
    if
        token-08c7 0 my-space 2000018 + token-08b5 " map-in" $call-parent
        to token-08c8
    then
    token-0974
;

: token-0976 ( 0976 )
    my-address my-space 2000010 + token-08b3 " map-in" $call-parent to
    token-08c6 my-address my-space 2000018 + token-08b5 " map-in"
    $call-parent to token-08c8 token-0974
;

: token-0977 ( 0977 )
    token-08c6 token-08b3 " map-out" $call-parent token-08c8 token-08b5
    " map-out" $call-parent 0 to token-08c8 0 to token-08c6
;

: token-0978 ( 0978 )
    my-address 1000014 my-space + token-08b6 " map-in" $call-parent to
    token-08c8 4 my-space + dup " config-b@" $call-parent 1 or swap
    " config-b!" $call-parent
;

: token-0979 ( 0979 )
    token-08c8 token-08b6 " map-out" $call-parent 0 to token-08c8 4
    my-space + dup " config-b@" $call-parent fe and swap " config-b!"
    $call-parent
;

: token-097a ( 097a )
    token-092f token-08a2 token-095f token-0930 token-08a3 token-095f
    token-0932 token-089e token-095f token-0933 token-086e token-095f
    token-0936 token-0871 token-095f token-0872 token-095c 2 or 1 invert
    and token-0872 token-095f
;

token-0978 token-084e token-095c to token-08b3 token-084f token-095c to
token-08b5 token-0979

: token-097b ( 097b )
    token-0937 token-083c token-095f token-0938 token-083d token-095f
    token-0941 token-084c token-095f token-0939 token-0842 token-095f
    token-0957 token-0844 token-095f token-093b token-083f token-095f
    token-093c token-088f token-095f token-0942 token-0877 token-095f
    token-093f token-0866 token-095f token-0940 token-0878 token-095f
    token-093e token-0853 token-095f token-093d token-0857 token-095f
    token-0951 token-085c token-095f token-094f token-0858 token-095f
    token-0950 token-0859 token-095f 1 ms token-0856 dup token-095c 10000
    invert and swap token-095f 20 ms token-097a
;

0 value token-097c ( 097c )
0 value token-097d ( 097d )
0 value token-097e ( 097e )
0 value token-097f ( 097f )
0 value token-0980 ( 0980 )
0 value token-0981 ( 0981 )
0 value token-0982 ( 0982 )
0 value token-0983 ( 0983 )

: token-0984 ( 0984 )
    token-08bd * * -rot * /
;

: token-0985 ( 0985 )
    / min dup 0=
    if
        drop 1
    then
;

: token-0986 ( 0986 )
    / 1 + max
;

: token-0987 ( 0987 )
    token-08bd swap /
;

: token-0988 ( 0988 )
    token-08bd swap / 1 + 2 max
;

: token-0989 ( 0989 )
    * rot * 2* swap / token-08bd / 1 + 2/
;

0 value token-098a ( 098a )

: token-098b ( 098b )
    token-08d0 a * dup to token-098a 10 token-08bb token-098a token-0985 1
    + 1 1d4c0 token-098a token-0986
    do
        i 5 <> i 7 <> and i 9 <> and i a <> and i b <> and i d <> and i e
        <> and i f <> and
        if
            8ca token-0987 to token-097c token-098a 1 token-097c i
            token-0989 token-097c over i swap 1 token-0984 token-098a - abs
            rot 2dup <
            if
                drop swap to token-097d i to token-097e
            else
                -rot 2drop
            then
        then
        dup 0=
        if
            leave
        then
    loop
    drop
;

: token-098c ( 098c )
    token-08be dup to token-08c0 8 61a80 token-08c0 token-0985 1 + 2
    token-08b8 0=
    if
        1 -
    then
    30d40 token-08c0 token-0986 2dup <=
    if
        swap drop dup 1 + swap
    then
    do
        i 3 <> i 5 <> and i 6 <> and i 7 <> and
        if
            token-08c0 2 token-097f i token-0989 ff min token-097f over i
            swap 2 token-0984 token-08c0 - abs rot 2dup <
            if
                drop swap to token-0980 i to token-0981
            else
                -rot 2drop
            then
        then
        dup 0=
        if
            leave
        then
    loop
    drop
;

: token-098d ( 098d )
    token-08bf 8 61a80 token-08bf token-0985 1 + 1 30d40 token-08bf
    token-0986 2dup <=
    if
        swap drop dup 1 + swap
    then
    do
        i 3 <> i 5 <> and i 6 <> and i 7 <> and
        if
            token-08bf 2 token-097f i token-0989 ff min token-097f over i
            swap 2 token-0984 token-08bf - abs rot 2dup <
            if
                drop swap to token-0982 i to token-0983
            else
                -rot 2drop
            then
        then
        dup 0=
        if
            leave
        then
    loop
    drop
;

: token-098e ( 098e )
    token-0983 0= token-097f 0= or token-0980 0= or token-0982 0= or
    token-0981 0= or
    if
        7d0 token-0987 to token-097f token-098c token-098d
    then
;

: token-098f ( 098f )
    10 ms
;

: token-0990 ( 0990 )
    token-097e 8 =
    if
        6
    else
        token-097e 3 =
        if
            8
        else
            token-097e 6 =
            if
                c
            else
                token-097e c =
                if
                    e
                else
                    token-097e 10 =
                    if
                        a
                    else
                        token-097e
                    then
                then
            then
        then
    then
    2/
;

: token-0991 ( 0991 )
    token-098b token-097c token-087b token-0967 token-0990 10 lshift
    token-097d or token-087c token-0967 token-08d0 445c >
    if
        1
    else
        0
    then
    token-0880 1 + token-0965 token-098a token-097e * 3d090 >
    if
        7
    else
        4
    then
    b lshift token-087a token-0966 3800 invert and or token-087a token-0967
    token-087a token-0964 2 invert and token-087a token-0965 1 ms
    token-087a token-0964 3 invert and token-087a token-0965 1 ms
    token-097c 8000 or token-087b token-0967 10 0
    do
        token-087b token-0966 8000 and 0=
        if
            leave
        then
        token-098f
    loop
    token-098f 3 token-0880 token-0965
;

: token-0992 ( 0992 )
    token-0909 swap la+ l@ dup 0<>
    if
        dup 8 rshift ffff and to token-097d dup 18 rshift ff and to
        token-097c ff and to token-097e token-08d0 a * to token-098a
    else
        drop token-098b
    then
    token-097c token-087b token-0967 token-0990 10 lshift token-097d or
    token-087c token-0967 token-08d0 445c >
    if
        1
    else
        0
    then
    token-0880 1 + token-0965 token-098a token-097e * 3d090 >
    if
        7
    else
        4
    then
    b lshift token-087a token-0966 3800 invert and or token-087a token-0967
    token-087a token-0964 2 invert and token-087a token-0965 1 ms
    token-087a token-0964 3 invert and token-087a token-0965 1 ms
    token-097c 8000 or token-087b token-0967 10 0
    do
        token-087b token-0966 8000 and 0=
        if
            leave
        then
        token-098f
    loop
    token-098f 3 token-0880 token-0965
;

: token-0993 ( 0993 )
    token-0991
;

: token-0994 ( 0994 )
    token-098b token-097c token-08af token-0967 token-0990 10 lshift
    token-097d or token-08b0 token-0967 token-098a token-097e * 3d090 >
    if
        7
    else
        4
    then
    b lshift token-08ae token-0966 3800 invert and or token-08ae token-0967
    token-08ae token-0964 2 invert and token-08ae token-0965 1 ms
    token-08ae token-0964 3 invert and token-08ae token-0965 1 ms
    token-097c 8000 or token-08af token-0967 10 0
    do
        token-08af token-0966 8000 and 0=
        if
            leave
        then
        token-098f
    loop
    token-098f 3 token-08b1 token-0965
;

: token-0995 ( 0995 )
    token-094b c invert and token-08c0 dup 1d4c0 <
    if
        drop 1
    else
        249f0 >
        if
            3
        else
            2
        then
    then
    2 lshift or to token-094b token-094b token-0887 token-0967 token-094c
    token-0888 token-0967 1 ms token-094b 10001 invert and token-0887
    token-0967 1 ms token-094b 30003 invert and token-0887 token-0967 1 ms
    token-094c 10001 invert and token-0888 token-0967 1 ms token-094c 30003
    invert and token-0888 token-0967 1 ms
;

: token-0996 ( 0996 )
    token-098e token-0949 token-088a token-0967 1 ms token-094a token-0885
    token-0967 1 ms token-0947 token-0886 token-0967 1 ms token-0948
    token-0884 token-0967 1 ms token-094b token-0887 token-0967 1 ms
    token-094c token-0888 token-0967 1 ms token-097f token-0980 8 lshift or
    token-0982 10 lshift or 1000000 or token-0882 token-0967 1 ms
    token-08c0 token-0981 * 493e0 >=
    if
        7
    else
        4
    then
    b lshift token-0947 3800 invert and or token-0886 token-0967 1 ms
    token-0886 token-0964 2 invert and dup token-0886 token-0965 1 ms 3
    invert and token-0886 token-0965 token-098f token-0981 8 =
    if
        4
    else
        token-0981 4 =
        if
            3
        else
            token-0981
        then
    then
    dup token-08b8
    if
        1 -
    then
    4 lshift or dup 8 lshift or token-0949 ffff invert and or token-088a
    token-0967 1 ms token-08bf token-0983 * 493e0 >=
    if
        7
    else
        4
    then
    b lshift token-0948 3800 invert and or token-0884 token-0967 1 ms
    token-08bf token-08c0 = token-0981 3 < and
    if
        token-0981 2* 1 - 8 or token-088d token-0965 1 ms 7
    else
        token-0884 token-0964 1 invert and dup token-0884 token-0965 1 ms 3
        invert and token-0884 token-0965 1 ms token-0983 8 =
        if
            4
        else
            token-0983 4 =
            if
                3
            else
                token-0983
            then
        then
    then
    token-098f token-094a 7 invert and or token-0885 token-0967 1 ms
    token-0995
;

: token-0997 ( 0997 )
    0 token-083a 1 + token-0961 token-0943 token-0879 token-0965 1 ms
    token-0944 token-0883 token-0967 1 ms token-094d token-088b token-0967
    1 ms token-098f token-0945 token-087a token-0967 1 ms token-0945
    token-08ae token-0967 1 ms token-0946 token-0880 token-0967 1 ms 0
    token-08b1 token-0967 1 ms token-0996 token-094e token-088c token-0967
    1 ms 0 token-0881 token-0967 token-098f
;

9 value token-0998 ( 0998 )
h# 3 value token-0999 ( 0999 )
create token-099a ( 099a )
2e c, 40 c, ad c, 40 c, 2d c, 20 c, a9 c, 20 c, 29 c, 10 c, 8d c, 20 c, d
c, 10 c, 89 c, 10 c, 9 c, 8 c, 2e c, 20 c, 2d c, 10 c, 29 c, 8 c,

: token-099b ( 099b )
    token-0851 token-095c 100000 and 0=
;

: token-099c ( 099c )
    token-0851 token-095c tuck 100000 rot
    if
        invert and
    else
        or
    then
    tuck <>
    if
        token-0851 token-095f 1 ms
    else
        drop
    then
;

: token-099d ( 099d )
    token-099b 0 token-099c token-0956 dup token-0855 token-095f 80000000
    or token-0855 token-095f 1 ms token-0956 10000000 or token-0855
    token-095f 1 ms token-099c
;

: token-099e ( 099e )
    token-0956 7fff invert and or dup token-0855 token-095f 80000000 or
    token-0855 token-095f 1 ms
;

: token-099f ( 099f )
    token-08b8 2 and
    if
        token-099b 0 token-099c 2000 dup token-099e dup 1 or token-099e
        token-08b8 2 =
        if
            1 or
        then
        token-099e token-0956 100 or token-099e token-0956 token-099e
        token-0956 10000000 or token-0855 token-095f token-099c
    else
        token-099d
    then
;

: token-09a0 ( 09a0 )
    token-099f
;

: token-09a1 ( 09a1 )
    dup token-099a swap 2* ca+ dup c@ 8 lshift rot token-0998 >=
    if
        8 or
    then
    token-0850 token-095c f7 and or token-0850 token-095f char+ c@
    token-09a0
;

: token-09a2 ( 09a2 )
    token-0950 e0000000 rot token-094c 8000800 rot
    if
        or -rot or
    else
        invert and -rot invert and
    then
    dup to token-0950 token-0859 token-095f dup to token-094c 30003 invert
    and token-0888 token-0967
;

: token-09a3 ( 09a3 )
    aaaaaaaa 2dup swap token-0962 over token-0963 = swap 55555555 2dup swap
    token-0962 swap token-0963 = and
;

: token-09a4 ( 09a4 )
    ffffffff 0 token-099c 0 token-0963 drop 0 0 2 0
    do
        i 0= token-09a2 0 token-09a3
        if
            4 token-09a3
            if
                2drop token-0998 0 leave
            else
                2drop token-0998 token-0999 + token-0998 leave
            then
        then
    loop
    2drop drop 2 -1 token-099c
;

: token-09a5 ( 09a5 )
    9c token-08be * 9c400 / token-08b8
    if
        2/
    then
    1 - 18 lshift token-0851 token-095c ffffff and or token-0851 token-095f
;

: token-09a6 ( 09a6 )
    0 token-099c token-08b9 ffffffff =
    if
        token-09a4 to token-08b9
    then
    token-08b9 ffffffff <>
    if
        token-08b9 token-09a1
    else
        8
    then
    to token-08b7 token-08b7 100000 * token-084d token-095f token-09a5
    token-0951 token-08b9 token-0998 <
    if
        token-08bf token-08c0 >=
        if
            8000000 or
        then
    else
        800 invert and token-0950 800000 invert and token-0859 token-095f
    then
    token-085c token-095f token-09a0 -1 token-099c
;

: token-09a7 ( 09a7 )
    token-0952 token-085d token-095f token-0953 8 invert and token-0850
    token-095f token-0954 100000 invert and token-0851 token-095f
    token-0955 token-0854 token-095f token-099f token-09a6 token-08d1 80 or
    to token-08d1 token-0958
    if
        token-0952 10000 or token-085d token-095f
    then
;

0 value token-09a8 ( 09a8 )

: token-09a9 ( 09a9 )
    token-0841 token-095c 403300 or 8000 invert and token-0841 token-095f
    token-0842 token-095c 8000 or token-0842 token-095f
;

: token-09aa ( 09aa )
    token-09a8
    if
        401300
    else
        403300
    then
    invert token-0841 token-095c and 8000 or token-0841 token-095f
    token-0842 token-095c 8000 invert and token-0842 token-095f
;

: token-09ab ( 09ab )
    token-09a9 5 token-0840 token-0961 20 ms
;

: token-09ac ( 09ac )
    3 token-0840 token-0961 token-09aa 20 ms
;

: token-09ad ( 09ad )
    token-086d token-095c 1ffff invert and token-086d token-095f
;

: token-09ae ( 09ae )
    token-086d token-095c 1ffff invert and 20 or token-086d token-095f
;

: token-09af ( 09af )
    token-08eb token-0917 dup 0=
    if
        " Cannot program pixel clock zero" type cr token-08cc to token-08eb
        drop 17124
    then
    to token-08d0 token-08eb token-0914 drop token-08eb token-0992
    token-0861 token-095f token-0860 token-095f token-085f token-095f
    token-085e token-095f 700 invert and token-08ea 4 =
    if
        6
    else
        token-08ea 2 =
        if
            3
        else
            2
        then
    then
    8 lshift or token-083f token-0960 token-08ea 2/ 16 lshift token-0942 or
    token-0877 token-095f token-08eb token-090c 10 and 0<>
    if
        token-083f dup token-095e 10 or swap token-0961 token-085f 2 + dup
        token-095e 7f and swap token-0961 token-0861 2 + dup token-095e 7f
        and swap token-0961 token-0841 1 + dup token-095e 20 or swap
        token-0961 -1 to token-09a8
    else
        0 to token-09a8
    then
    token-0903 token-08e9 token-08df token-08ea / token-0863 token-095f
    token-08e6 token-0862 token-095f
;

0 value token-09b0 ( 09b0 )

: token-09b1 ( 09b1 )
    dup 2 and 2/ swap 1 and 2* or
;

: token-09b2 ( 09b2 )
    dup 3 rshift token-09b0
    if
        2/ token-09b1 10 lshift swap 2/ token-09b1 or token-0846 token-095f
    else
        2dup 1 and 10 lshift swap 1 and or token-0847 token-095f 2/
        token-09b1 10 lshift swap 2/ token-09b1 or token-0845 token-095f
    then
;

: token-09b3 ( 09b3 )
    token-09b0
    if
        token-0846 1 + token-095e token-09b1 2*
    else
        token-0847 1 + token-095e 1 and token-0845 1 + token-095e
        token-09b1 2* or
    then
;

: token-09b4 ( 09b4 )
    token-09b3 token-09b0
    if
        token-0846 2 + token-095e token-09b1 2*
    else
        token-0847 2 + token-095e 1 and token-0845 2 + token-095e
        token-09b1 2* or
    then
    3 lshift or
;

: token-09b5 ( 09b5 )
    drop
;

: token-09b6 ( 09b6 )
;

: token-09b7 ( 09b7 )
    token-08d0 3a98 <
    if
        token-0934
    else
        token-0935
    then
    token-0873 token-095f token-0872 token-095c 1 or dup token-0872
    token-095f 2 invert and 3 ms token-0872 token-095f 5 ms token-086e
    token-095c 1 or 2 invert and dup token-086e token-095f 5 ms 4 or
    token-086e token-095f
;

: token-09b8 ( 09b8 )
    token-0872 token-095c 2 or dup token-0872 token-095f 1 invert and
    token-0872 token-095f token-086e token-095c 4 invert and dup token-086e
    token-095f 1 invert and token-086e token-095f 5 ms
;

: token-09b9 ( 09b9 )
    token-086e token-095c 2000 rot
    if
        or
    else
        invert and
    then
    token-086e token-095f
;

: token-09ba ( 09ba )
    dup token-0922 =
    if
        drop
    else
        token-0916 token-0926 1 - c lshift swap token-0924 <
        if
            over token-0925 * token-0923 / 500 >
            if
                a000000
            else
                e000000
            then
            or
        then
        token-0870 token-095f token-0925 token-08df 1 - 10 lshift swap
        token-0923 <
        if
            e000000 or
        then
        token-086f token-095f 1 ms token-086c token-095c 1c or token-086c
        token-095f 1 ms
    then
;

: token-09bb ( 09bb )
    token-086c token-095c 3f invert and token-086c token-095f 0 token-086f
    token-095f 0 token-0870 token-095f 0 token-0876 token-095f
;

: token-09bc ( 09bc )
    dup token-08fc =
    if
        token-09b5
    else
        token-09b7 2 = token-09b9
    then
;

: token-09bd ( 09bd )
    token-08fc =
    if
        token-09b6
    else
        token-09b8
    then
;

: token-09be ( 09be )
    token-09bb 1 token-08ed token-0927
    if
        token-09bd
    else
        token-09a9
    then
    0 to token-08d0 5 token-0840 token-0961 20 ms
;

: token-09bf ( 09bf )
    token-09b8 token-0971 0 to token-08d0 4 token-0890 token-0961 20 ms
;

: token-09c0 ( 09c0 )
    3 token-0840 token-0961 20 ms 1 token-08ed token-0927
    if
        token-08ed token-09ba token-09bc
    else
        token-09aa
    then
;

: token-09c1 ( 09c1 )
    token-088f 3 + dup token-095e 2 or 4 invert and swap token-0961 20 ms 2
    dup token-09b7 2 = token-09b9 token-0970
;

: token-09c2 ( 09c2 )
    token-0841 1 + dup token-095e 4 invert and swap token-0961
;

: token-09c3 ( 09c3 )
    token-088f 2 + dup token-095e 80 invert and swap token-0961
;

: token-09c4 ( 09c4 )
    token-0841 1 + dup token-095e 4 or swap token-0961
;

: token-09c5 ( 09c5 )
    token-088f 2 + dup token-095e 80 or swap token-0961
;

: token-09c6 ( 09c6 )
    token-08ed token-0927
    if
        token-0922 token-0914 drop over 10 rshift tuck - token-0875
        token-095f - token-0868 token-095f over 10 rshift tuck 1 + 8 * -
        token-0874 token-095f - token-0867 token-095f drop token-0926
        token-08e8 * token-0924 / 1 - token-0925 token-08e7 * token-0923 /
        token-08df 1 - 10 lshift or token-086b token-095f
    then
;

: token-09c7 ( 09c7 )
    token-0892 token-095c token-08a0 token-095f token-0894 token-095c
    token-08a1 token-095f token-0892 token-095c token-0874 token-095f
    token-0894 token-095c token-0875 token-095f token-08ec token-090c 10
    and 0<>
    if
        token-08a0 2 + dup token-095e 7f and swap token-0961 token-08a1 2 +
        dup token-095e 7f and swap token-0961 token-0874 2 + dup token-095e
        7f and swap token-0961 token-0875 2 + dup token-095e 7f and swap
        token-0961
    then
    token-08ec token-0927
    if
        token-0926 token-08e8 - dup 2/ tuck - wljoin token-0925 token-08e7
        - token-08df dup 2/ tuck - wljoin
    else
        0 0
    then
    token-0898 token-095f token-0899 token-095f
;

: token-09c8 ( 09c8 )
    token-08ed token-0927
    if
        token-08ed token-092e
    then
    token-08ed token-0914 dup base @ swap 10 base ! . base ! cr token-0917
    dup 0=
    if
        drop c4e
    then
    to token-08d0 token-0993 token-0861 token-095f token-0860 token-095f
    token-085f token-095f token-085e token-095f 700 invert and token-08ea 4
    =
    if
        6
    else
        token-08ea 2 =
        if
            3
        else
            2
        then
    then
    8 lshift or token-083f token-0960 token-0877 token-095c 3 14 lshift
    invert and token-08ea 2/ 14 lshift or token-0877 token-095f token-08ed
    token-0927 0= token-08d1 8 and 0= token-08d1 10 rshift 62b = token-08d1
    10 rshift 221 = or and and
    if
        token-083f dup token-095e 10 or swap token-0961 token-085f 2 + dup
        token-095e 7f and swap token-0961 token-0861 2 + dup token-095e 7f
        and swap token-0961
    then
    token-0903 token-08e9 token-08df token-08ea / token-0863 token-095f
    token-08e6 token-0862 token-095f
;

: token-09c9 ( 09c9 )
    token-08ec token-0927
    if
        token-08ec token-092e token-0922
    else
        token-08ec
    then
    token-0914 token-0917 dup 0=
    if
        "   VCLK is zero" type cr drop c4e
    then
    to token-08d0 token-0994 token-08ec token-0927
    if
        token-0926 token-08e8 - tuck 2/ - -rot 10 lshift - swap
    then
    token-0894 token-095f token-0893 token-095f token-08ec token-0927
    if
        token-0925 token-08e7 - tuck 2/ - -rot token-08df 10 lshift - swap
    then
    token-0892 token-095f token-0891 token-095f 700 invert and token-08ea 4
    =
    if
        6
    else
        token-08ea 2 =
        if
            3
        else
            2
        then
    then
    8 lshift or token-088f token-095d 880 and or token-088f token-0960
    token-0877 token-095c 3 16 lshift invert and token-08ea 2/ 16 lshift or
    token-0877 token-095f token-08ec token-090c 10 and 0<>
    if
        token-088f 3 + dup token-095e 8 or swap token-0961 token-0892 2 +
        dup token-095e 7f and swap token-0961 token-0894 2 + dup token-095e
        7f and swap token-0961 token-088f 3 + dup token-095e 20 or swap
        token-0961 token-088f dup token-095e 40 or swap token-0961 -1 to
        token-09a8
    else
        0 to token-09a8
    then
    token-0903 token-08e9 token-08df token-08ea / token-0896 token-095f
    token-08e6 token-0895 token-095f
;

: token-09ca ( 09ca )
    token-08da 2 and 0<>
;

: token-09cb ( 09cb )
    token-08da 4 and 0<>
;

: token-09cc ( 09cc )
    token-08da ef and 2 or token-08db
;

: token-09cd ( 09cd )
    token-08da 10 or fd and token-08db
;

: token-09ce ( 09ce )
    token-08da df and 4 or token-08db
;

: token-09cf ( 09cf )
    token-08da 20 or fb and token-08db
;

: token-09d0 ( 09d0 )
    100 0
    do
        token-09cc token-09ca
        if
            leave
        else
            token-08de
        then
    loop
;

: token-09d1 ( 09d1 )
    token-09ce
;

: token-09d2 ( 09d2 )
    token-09d0 token-08de
;

: token-09d3 ( 09d3 )
    token-09cd token-08de
;

: token-09d4 ( 09d4 )
    ['] token-09b4 to token-08da
    ['] token-09b2 to token-08db
;

: token-09d5 ( 09d5 )
    token-08d8 c@ token-08d8 7 + c@ + 0=
    if
        -1 token-08d8 1 + 6 bounds
        do
            i c@ ff <>
            if
                drop 0 leave
            then
        loop
    else
        0
    then
;

: token-09d6 ( 09d6 )
    0 token-08d8 7f bounds
    do
        i c@ +
    loop
    negate ff and token-08d8 7f + c@ =
;

: token-09d7 ( 09d7 )
    token-09d5 token-09d6 and
;

: token-09d8 ( 09d8 )
    80 and
    if
        token-09d1
    else
        token-09cf
    then
    token-09d2 token-09d3
;

: token-09d9 ( 09d9 )
    token-09ce token-08de token-09d2 token-09cb token-09d3
;

: token-09da ( 09da )
    token-09ce token-09cc token-08de 100 0
    do
        token-09ca token-09cb and
        if
            leave
        then
        token-09d3 token-09d2
    loop
;

: token-09db ( 09db )
    token-09da token-09d2 token-09cf 10 ms token-09d3 token-09ce token-08de
;

: token-09dc ( 09dc )
    100 0
    do
        token-09d3 token-08de token-09cf token-08de token-09d2 token-08de
        token-09d1 10 ms token-09ca token-09cb and
        if
            leave
        then
    loop
;

: token-09dd ( 09dd )
    8 0
    do
        dup token-09d8 2*
    loop
    drop token-09ce token-09d2 0 4 0
    do
        100 0
        do
            token-09cb 0=
            if
                drop -1 leave
            then
        loop
        token-08de dup
        if
            leave
        then
    loop
    token-09d3
;

: token-09de ( 09de )
    token-09ce 0 8 0
    do
        2* token-09d2 token-09cb
        if
            1 +
        then
        token-09d3
    loop
    0 token-09d8
;

: token-09df ( 09df )
    token-09db -1 -rot bounds
    ?do
        i c@ token-09dd 0=
        if
            drop 0 leave
        then
    loop
    token-09dc
;

: token-09e0 ( 09e0 )
    token-09ce 0 8 0
    do
        2* token-09d2 token-09cb
        if
            1 +
        then
        token-09d3
    loop
;

: token-09e1 ( 09e1 )
    0 token-09db a0 token-09dd
    if
        h# 0 token-09dd
        if
            drop -1
        then
    then
    token-09dc
;

: token-09e2 ( 09e2 )
    token-08d8 + l!
;

: token-09e3 ( 09e3 )
    ffffff h# 0 token-09e2 ffffff00 4 token-09e2 38a3d465 8 token-09e2
    1010101 c token-09e2 80d0103 10 token-09e2 80241d78 14 token-09e2
    ea6eaf9c 18 token-09e2 594c9926 1c token-09e2 194c50bf 20 token-09e2
    ef803159 24 token-09e2 45596159 28 token-09e2 714f814f 2c token-09e2
    1010101 30 token-09e2 101302a 34 token-09e2 985100 38 token-09e2
    2a403070 3c token-09e2 1300671f 40 token-09e2 1100001e 44 token-09e2 fd
    48 token-09e2 32551f 4c token-09e2 520e000a 50 token-09e2 20202020 54
    token-09e2 20200000 58 token-09e2 fc004c 5c token-09e2 43443138 60
    token-09e2 38305358 64 token-09e2 a202020 68 token-09e2 ff 6c
    token-09e2 333230 70 token-09e2 31373434 74 token-09e2 43420a20 78
    token-09e2 20200050 7c token-09e2
;

: token-09e4 ( 09e4 )
    token-09db a1 token-09dd
    if
        3 token-08d1 or to token-08d1 token-08d8 7f bounds
        do
            token-09de i c!
        loop
        token-09e0 token-08d8 7f ca+ c!
    then
    token-09d7 dup
    if
        b token-08d1 or to token-08d1
    then
    token-09dc
;

: token-09e5 ( 09e5 )
    0 4 0
    do
        token-09e4
        if
            drop -1 leave
        then
    loop
;

: token-09e6 ( 09e6 )
    token-09d4 token-09dc token-09cd 100 ms token-09dc 0 token-09ca
    token-09cb and
    if
        token-09cd 100 ms token-09cb
        if
            token-09cf token-09cc token-08de token-09ca token-09cb 0= and
            if
                token-09dc 10 0
                do
                    token-09e1
                    if
                        3 ms 2 token-08d1 or to token-08d1 drop -1 leave
                    then
                loop
            then
        then
    then
;

: token-09e7 ( 09e7 )
    12 * 36 + token-08d8 +
;

: token-09e8 ( 09e8 )
    token-09e7 dup
;

: token-09e9 ( 09e9 )
    swap token-09e7 + dup c@ swap
;

: token-09ea ( 09ea )
    token-09e8 c@ swap 1 + c@ bwjoin
;

: token-09eb ( 09eb )
    token-09e9 2 + c@ f0 and 4 rshift bwjoin
;

: token-09ec ( 09ec )
    2 token-09eb
;

: token-09ed ( 09ed )
    token-09e9 1 + c@ f and bwjoin
;

: token-09ee ( 09ee )
    3 token-09ed
;

: token-09ef ( 09ef )
    5 token-09eb
;

: token-09f0 ( 09f0 )
    6 token-09ed
;

: token-09f1 ( 09f1 )
    token-09e8 b + c@ c0 and 2 lshift swap 8 + c@ or
;

: token-09f2 ( 09f2 )
    token-09e8 b + c@ 30 and 4 lshift swap 9 + c@ or
;

: token-09f3 ( 09f3 )
    token-09e7 a + dup c@
;

: token-09f4 ( 09f4 )
    token-09f3 4 rshift swap 1 + c@ c and 2 lshift or
;

: token-09f5 ( 09f5 )
    token-09f3 f and swap 1 + c@ h# 3 and 4 lshift or
;

: token-09f6 ( 09f6 )
    token-09e7 11 + c@
;

: token-09f7 ( 09f7 )
    token-09f6 h# 2 and 0<>
;

: token-09f8 ( 09f8 )
    token-09f6 4 and 0<>
;

: token-09f9 ( 09f9 )
    token-09f6 80 and 0<>
;

: token-09fa ( 09fa )
    token-08d8 7f + c@
;

: token-09fb ( 09fb )
    token-08d8 18 + c@ 18 and 0=
;

: token-09fc ( 09fc )
    token-08d8 14 ca+ c@ 80 and 0<>
;

: token-09fd ( 09fd )
    token-08d8 18 ca+ c@ 2 and 0<>
;

0 value token-09fe ( 09fe )
0 value token-0a00 ( 0a00 )
0 value token-0a01 ( 0a01 )
0 value token-0a02 ( 0a02 )
ffffffff value token-0a03 ( 0a03 )

: token-0a04 ( 0a04 )
    token-09fc
    if
        token-0929
    then
    dup 20 <
    if
        token-08e1 token-09fe or to token-09fe
    else
        20 - dup 20 <
        if
            token-08e1 token-0a00 or to token-0a00
        else
            20 - dup 20 <
            if
                token-08e1 token-0a01 or to token-0a01
            else
                20 - dup 20 <
                if
                    token-08e1 token-0a02 or to token-0a02
                else
                    drop
                then
            then
        then
    then
;

: token-0a05 ( 0a05 )
    dup 20 <
    if
        token-08e1 token-09fe and 0<>
    else
        20 - dup 20 <
        if
            token-08e1 token-0a00 and 0<>
        else
            20 - dup 20 <
            if
                token-08e1 token-0a01 and 0<>
            else
                20 - dup 20 <
                if
                    token-08e1 token-0a02 and 0<>
                else
                    drop 0
                then
            then
        then
    then
;

: token-0a06 ( 0a06 )
    ffffffff token-0a03 =
    if
        token-09fc
        if
            token-091f
        else
            0 token-08cd 0
            ?do
                i token-0a05
                if
                    drop i leave
                then
            loop
        then
        to token-0a03
    then
;

: token-0a07 ( 0a07 )
    0 to token-09fe 0 to token-0a00 0 to token-0a01 0 to token-0a02
    ffffffff to token-0a03 token-08d8 23 + c@ 3f and token-08d8 24 + c@ ef
    and 8 lshift or 10 0
    do
        dup 1 i lshift and
        if
            i token-0a04
        then
    loop
    drop token-08d8 25 + c@ 80 and
    if
        10 token-0a04
    then
    4 0
    do
        i token-09f4 i token-09ef + i token-09f5 i token-09f8 0=
        if
            80 or
        then
        wljoin i token-09ef i token-09f0 + 1 - i token-09ef 1 - wljoin i
        token-09f1 i token-09ec + i token-09f2 token-08df i token-09f7 0=
        if
            80 or
        then
        wljoin i token-09ec i token-09ee + token-08df 1 - i token-09ec
        token-08df 1 - wljoin token-08cd token-0915 i token-09ea dup
        token-08cd token-0918 dup 0<> swap token-09fc
        if
            token-08bc
        else
            token-08bb
        then
        <= and i token-09f9 0= and
        if
            token-08cd token-0a04 token-09fd ffffffff token-0a03 = and
            token-09fc and
            if
                token-08cd to token-0a03
            then
            token-08cd 1 + to token-08cd
        then
    loop
    token-09fc
    if
        token-08cd 0
        ?do
            i token-0a05
            if
                i dup token-092b token-092a
            then
        loop
        ffffffff token-0a03 <>
        if
            token-0a03 token-0929 dup to token-0a03 to token-091f
        then
    then
    token-0a06
;

: token-0a08 ( 0a08 )
    token-08d8 + c@
;

: token-0a09 ( 0a09 )
    token-08d8 + w@
;

: token-0a0a ( 0a0a )
    token-08d8 + l@
;

: token-0a0b ( 0a0b )
    13 token-0a08 12 token-0a08 1 > swap 3 >= or
;

: token-0a0c ( 0a0c )
    dup <# u# u# u# u# u#> type "  (" type dup 8 rshift ff and 1f + 8 * dup
    base @ swap a base ! . base ! " x " type over 6 rshift 3 and
    case
        0 of token-0a0b 0<>
            if
                a * 10 /
            else
            then
        endof
        1 of h# 3 * 4 / endof
        2 of 4 * 5 / endof
        3 of 9 * 10 / endof
    endcase
    base @ swap a base ! . base ! " @ " type 3f and 3c + base @ swap a base
    ! . base ! " )" type cr
;

: token-0a0d ( 0a0d )
    token-09e7 12 0
    do
        dup c@ <# u# u# u#> type "  " type 1 +
    loop
    drop
;

: token-0a0e ( 0a0e )
    dup token-09ea "   Pixel Clock:     " type base @ swap a base ! . base
    ! " KHz" type cr dup token-09ec "   Hz. Active:      " type base @ swap
    a base ! . base ! " Pixels" type cr dup token-09ee
    "   Hz. Blank:       " type base @ swap a base ! . base ! " Pixels"
    type cr dup token-09ef "   Vt. Active:      " type base @ swap a base !
    . base ! " Lines" type cr dup token-09f0 "   Vt. Blank:       " type
    base @ swap a base ! . base ! " Lines" type cr dup token-09f1
    "   Hz. Sync Offset: " type base @ swap a base ! . base ! " Pixels"
    type cr dup token-09f2 "   Hz. Sync Width:  " type base @ swap a base !
    . base ! " Pixels" type cr dup token-09f4 "   Vt. Sync Offset: " type
    base @ swap a base ! . base ! " Lines" type cr dup token-09f5
    "   Vt. Sync Width:  " type base @ swap a base ! . base ! " Lines" type
    cr dup token-09e7 e + c@ f0 and 4 lshift over token-09e7 c + c@ or
    "   Hz. Image Size:  " type base @ swap a base ! . base ! " mm" type cr
    dup token-09e7 e + c@ f and 8 lshift over token-09e7 d + c@ or
    "   Vt. Image Size:  " type base @ swap a base ! . base ! " mm" type cr
    dup token-09e7 f + c@ "   Hz. Border:      " type base @ swap a base !
    . base ! " Pixels" type cr dup token-09e7 10 + c@
    "   Vt. Border:      " type base @ swap a base ! . base ! " Lines" type
    cr token-09e7 11 + c@ dup "   Flags:           0x" type base @ swap 10
    base ! . base ! cr dup 80 and 0=
    if
        "     Non-interlaced" type
    else
        "     Interlaced" type
    then
    cr dup 61 and
    case
        20 of "     Field Sequential Stereo, right on sync" type endof
        40 of "     Field Sequential Stereo, left on sync" type endof
        21 of "     2-Way Interleaved Stereo, right on even" type endof
        41 of "     2-Way Interleaved Stereo, left on even" type endof
        60 of "     2-Way Interleaved Stereo" type endof
        61 of "     Size-by-Side Interleaved Stereo" type endof
        "     No Stereo" type
    endcase
    cr dup 18 and
    case
        h# 0 of "     Analog Composite" type cr "       Serrate " type dup
            4 and 0<>
            if
                " On" type
            else
                " Off" type
            then
            cr "       Sync On " type 1 and 0<>
            if
                " RGB" type
            else
                " Green" type
            then
            cr endof
        8 of "     Bipolar Analog Composite" type cr "       Serrate " type
            dup 4 and 0<>
            if
                " On" type
            else
                " Off" type
            then
            cr "       Sync On " type 1 and 0<>
            if
                " RGB" type
            else
                " Green" type
            then
            cr endof
        10 of "     Digital Composite" type cr "       Serrate " type dup 4
            and 0<>
            if
                " On" type
            else
                " Off" type
            then
            cr "       Composite Polarity " type 1 and 0<>
            if
                " +" type
            else
                " -" type
            then
            cr endof
        18 of "     Digital Separate" type cr "       Vt. Polarity " type
            dup 4 and 0<>
            if
                " +" type
            else
                " -" type
            then
            cr "       Hz. Polarity " type 1 and 0<>
            if
                " +" type
            else
                " -" type
            then
            cr endof
    endcase
;

: token-0a0f ( 0a0f )
    token-09e7 5 +
    begin
        dup c@ dup a <>
    while
        emit 1 +
    repeat
    2drop
;

: token-0a10 ( 0a10 )
    dup token-09e7 h# 3 + c@
    case
        ff of "   Monitor S/N: " type token-0a0f cr endof
        fe of "   ASCII Data String: " type token-0a0f cr endof
        fd of "   Monitor Range Limits: " type cr token-09e7 5 + dup c@
            "     Min Vt. Rate: " type base @ swap a base ! . base ! " Hz"
            type cr 1 + dup c@ "     Max Vt. Rate: " type base @ swap a
            base ! . base ! " Hz" type cr 1 + dup c@ "     Min Hz. Rate: "
            type base @ swap a base ! . base ! " KHz" type cr 1 + dup c@
            "     Min Hz. Rate: " type base @ swap a base ! . base ! " KHz"
            type cr 1 + c@ "     Min Pixel Clock: " type a * base @ swap a
            base ! . base ! " MHz" type cr endof
        fc of "   Monitor Name: " type token-0a0f cr endof
        fb of "   Color Paint " type cr endof
        fa of "   Standard Timing Identifiers: " type cr
            "     Identification  9: 0x" type token-09e7 5 + dup c@ swap 1
            + dup c@ rot 8 lshift or token-0a0c
            "     Identification 10: 0x" type 1 + dup c@ swap 1 + dup c@
            rot 8 lshift or token-0a0c "     Identification 11: 0x" type 1
            + dup c@ swap 1 + dup c@ rot 8 lshift or token-0a0c
            "     Identification 12: 0x" type 1 + dup c@ swap 1 + dup c@
            rot 8 lshift or token-0a0c "     Identification 13: 0x" type 1
            + dup c@ swap 1 + dup c@ rot 8 lshift or token-0a0c
            "     Identification 14: 0x" type 1 + dup c@ swap 1 + c@ rot 8
            lshift or token-0a0c endof
        f9 of "   Flat Panel Displays" type cr endof
        0 of "   Manufacturer Defined Type " type cr endof
        1 of "   Manufacturer Defined Type " type cr endof
        " Undefined Data Type" type
    endcase
;

: token-0a11 ( 0a11 )
    dup token-09ea 0<>
    if
        " Detailed Timing #" type dup 1 + base @ swap a base ! . base !
        " : " type dup token-0a0d cr token-0a0e
    else
        " Monitor Descriptor #" type dup 1 + base @ swap a base ! . base !
        " : " type dup token-0a0d cr token-0a10
    then
;

: token-0a12 ( 0a12 )
    token-09ab token-09af
    if
        token-09ad
    else
        token-09ae
    then
    token-09ac
;

: token-0a13 ( 0a13 )
    -1 token-0a12
;

: token-0a14 ( 0a14 )
    0 token-0a12
;

: token-0a15 ( 0a15 )
    token-09be token-09c8 token-09c6
    if
        token-09c2
    else
        token-09c4
    then
    token-09c0
;

: token-0a16 ( 0a16 )
    token-09bf token-09c9 token-09c7
    if
        token-09c3
    else
        token-09c5
    then
    token-09c1
;

: token-0a17 ( 0a17 )
    -1 token-0a15
;

: token-0a18 ( 0a18 )
    -1 token-0a16
;

: token-0a19 ( 0a19 )
    0 token-0a15
;

: token-0a1a ( 0a1a )
    0 token-0a16
;

: token-0a1b ( 0a1b )
    token-08cc to token-08eb token-08eb dup token-0900 token-0916 to
    token-08e8 to token-08e7 token-0903
;

-1

headers

value edid_match ( 0a1c )
0 value edid1 ( 0a1d )

: get_est_id ( 0a1e )
    edid1 23 + dup c@ 8 lshift swap 1 + c@ or
;

: get_std_id ( 0a1f )
    2* edid1 + 26 + dup c@ 8 lshift swap 1 + c@ or
;

: parse_established_timings ( 0a20 )
    get_est_id 204f and dup
    if
        0 to edid_match dup 43 and
        if
            dup 1 and
            if
                10 to token-08eb
            else
                dup 2 and
                if
                    f to token-08eb
                else
                    a to token-08eb
                then
            then
        else
            dup 4 and
            if
                e to token-08eb
            else
                dup 8 and
                if
                    d to token-08eb
                else
                    3 to token-08eb
                then
            then
        then
    then
    drop
;

: get_edid_mode ( 0a21 )
    " edid" get-my-property 0=
    if
        drop to edid1 0
        begin
            dup to edid_match dup 1 + swap get_std_id
            case
                6140 of d to token-08eb -1 endof
                614a of e to token-08eb -1 endof
                7186 of 15 to token-08eb -1 endof
                7190 of 16 to token-08eb -1 endof
                8187 of 17 to token-08eb -1 endof
                8190 of 24 to token-08eb -1 endof
                a950 of 1c to token-08eb -1 endof
                d1cc of 1d to token-08eb -1 endof
                3140 of 3 to token-08eb -1 endof
                614f of f to token-08eb -1 endof
                81d0 of 1e to token-08eb -1 endof
                8180 of 14 to token-08eb -1 endof
                95d0 of 1f to token-08eb -1 endof
                a9c6 of 20 to token-08eb -1 endof
                a9d0 of 21 to token-08eb -1 endof
                d1ca of 22 to token-08eb -1 endof
                8199 of 23 to token-08eb -1 endof
                818f of 10 to token-08eb -1 endof
                a940 of 28 to token-08eb -1 endof
                a94f of 2b to token-08eb -1 endof
                a959 of 2c to token-08eb -1 endof
                454f of a to token-08eb -1 endof
                d100 of 2d to token-08eb -1 endof
                d1c0 of 2e to token-08eb -1 endof
                0 swap -1 to edid_match
            endcase
            over 8 = or
        until
        drop -1 edid_match =
        if
            parse_established_timings
        then
    then
;

: check-edid ( 0a22 )
    " edid" get-my-property 0=
    if
        drop dup to edid1 to token-08d8 -1
    else
        " No EDID Available" type 0
    then
;

: edid-print-raw ( 0a23 )
    " EDID : " type cr token-08d8 dup 80 + swap
    do
        i token-08d8 - 1f and 0=
        if
            i token-08d8 <>
            if
                cr
            then
        then
        i l@ <# u# u# u# u# u# u# u# u# u#> type "  " type 4
    +loop
;

external

: edid-print ( 0a24 )
    check-edid 0<>
    if
        edid-print-raw cr 8 token-0a09 " Manufacturer Name: " type dup a
        rshift 1f and 40 + emit dup 5 rshift 1f and 40 + emit 1f and 40 +
        emit cr a token-0a09 wbflip " Product Code: 0x" type base @ swap 10
        base ! . base ! cr c token-0a0a " Serial Number: 0x" type base @
        swap 10 base ! . base ! cr 10 token-0a08 " Week of Manufacture: "
        type base @ swap a base ! . base ! cr 11 token-0a08 7c6 +
        " Year of Manufacture: " type base @ swap a base ! . base ! cr 12
        token-0a08 " EDID version: " type . cr 13 token-0a08
        " EDID Revision: " type . cr 14 token-0a08
        " Video Input Definition: " type 7 rshift 1 and 0=
        if
            " analog" type
        else
            " digital" type
        then
        cr 15 token-0a08 " Max Hz. Image Size: " type base @ swap a base !
        . base ! " cm" type cr 16 token-0a08 " Max Vt. Image Size: " type
        base @ swap a base ! . base ! " cm" type cr 17 token-0a08 dup
        " Gamma: " type 64 + 64 /mod <# u# u#> type 2e emit base @ swap a
        base ! . base ! " ( 0x" type base @ swap 10 base ! . base ! " )"
        type cr 18 token-0a08 " Feature Support:" type cr "   Stand-by:   "
        type dup 80 and 0<>
        if
            " yes" type
        else
            " no" type
        then
        cr "   Suspend:    " type dup 40 and 0<>
        if
            " yes" type
        else
            " no" type
        then
        cr "   Active Off: " type dup 20 and 0<>
        if
            " yes" type
        else
            " no" type
        then
        cr "   Type:       " type h# 3 rshift 3 and
        case
            0 of " mono/gray" type endof
            1 of " R/G/B" type endof
            2 of " non rgb color" type endof
            3 of " undefined" type endof
        endcase
        cr " Color Characteristics: r = " type 19 token-0a08 1b token-0a08
        2 lshift over 6 rshift 3 and or a base ! <# u# u# u# u# u#> type 10
        base ! " ," type 1c token-0a08 2 lshift over 4 rshift 3 and or a
        base ! <# u# u# u# u# u#> type 10 base ! "  g = " type 1d
        token-0a08 2 lshift over 2 rshift 3 and or a base ! <# u# u# u# u#
        u#> type 10 base ! " ," type 1e token-0a08 2 lshift swap 3 and or a
        base ! <# u# u# u# u# u#> type 10 base ! "  b = " type 1a
        token-0a08 1f token-0a08 2 lshift over 6 rshift 3 and or a base !
        <# u# u# u# u# u#> type 10 base ! " ," type 20 token-0a08 2 lshift
        over 4 rshift 3 and or a base ! <# u# u# u# u# u#> type 10 base !
        "  w = " type 21 token-0a08 2 lshift over 2 rshift 3 and or a base
        ! <# u# u# u# u# u#> type 10 base ! " ," type 22 token-0a08 2
        lshift swap 3 and or a base ! <# u# u# u# u# u#> type 10 base ! cr
        23 token-0a08 dup " Established Timings 1: 0x" type base @ swap 10
        base ! . base ! cr dup 80 and 0<>
        if
            "   720x400@70" type cr
        then
        dup 40 and 0<>
        if
            "   720x400@88" type cr
        then
        dup 20 and 0<>
        if
            "   640x480@60" type cr
        then
        dup 10 and 0<>
        if
            "   640x480@67" type cr
        then
        dup 8 and 0<>
        if
            "   640x480@72" type cr
        then
        dup 4 and 0<>
        if
            "   640x480@75" type cr
        then
        dup h# 2 and 0<>
        if
            "   800x600@56" type cr
        then
        h# 1 and 0<>
        if
            "   800x600@60" type cr
        then
        24 token-0a08 dup " Established Timings 2: 0x" type base @ swap 10
        base ! . base ! cr dup 80 and 0<>
        if
            "   800x600@72" type cr
        then
        dup 40 and 0<>
        if
            "   800x600@75" type cr
        then
        dup 20 and 0<>
        if
            "   832x624@75" type cr
        then
        dup 10 and 0<>
        if
            "   1024x768@87" type cr
        then
        dup 8 and 0<>
        if
            "   1024x768@60" type cr
        then
        dup 4 and 0<>
        if
            "   1024x768@70" type cr
        then
        dup h# 2 and 0<>
        if
            "   1024x768@75" type cr
        then
        h# 1 and 0<>
        if
            "   1280x1024@75" type cr
        then
        25 token-0a08 dup " Manufacturers Reserved Timings: 0x" type base @
        swap 10 base ! . base ! cr 80 and 0<>
        if
            "   1152x870@75" type cr
        then
        8 0
        do
            " Standard Timing #" type i 1 + . " : 0x" type i get_std_id
            token-0a0c
        loop
        4 0
        do
            i token-0a11
        loop
        7e token-0a08 " Extention EDID Blocks that Follow: " type base @
        swap a base ! . base ! cr 7f token-0a08 " Checksum: 0x" type base @
        swap 10 base ! . base ! cr
    then
;

headerless

: token-0a25 ( 0a25 )
    1 to token-09b0 0 to token-08f4 token-08d9 token-08cc dup to token-08ec
    token-0916 to token-08e8 to token-08e7 token-0a1a token-0972
    if
        token-08d1 40 or to token-08d1 2 to token-08fc
    else
        token-09e6
        if
            token-08d1 4 or to token-08d1 1 to token-08fc
        then
    then
    44 token-08d2
    if
        token-09e6
        if
            token-09e5
            if
                token-08d8 80 encode-bytes " EDID" property 1 encode-int
                " primary-stream" property 1 to token-08fa token-08d1 200
                or to token-08d1
            then
        then
        token-08ce 1 + to token-08ce get_edid_mode token-08eb token-09fc
        if
            token-092b
        else
            token-0900
        then
        token-08eb to token-08ec token-08eb token-0916 to token-08e8 to
        token-08e7 token-0903 200 token-08d2
        if
            token-09fa to token-08f4
        then
        token-0a1a 0 to token-09b0
    then
;

: token-0a26 ( 0a26 )
    0 to token-08ce 0 to token-08f4 token-08d9 token-08cc dup to token-08eb
    token-0916 to token-08e8 to token-08e7 token-0a14 token-09ab token-09ad
    token-09aa token-096c
    if
        token-08d1 10 or to token-08d1
    else
        7 dup token-09b2 10 ms token-09b3 <>
        if
            token-08d1 4 or to token-08d1
        then
    then
    14 token-08d2
    if
        token-09e6
        if
            token-09e5
            if
                token-08d8 80 encode-bytes " EDID" property 0 encode-int
                " primary-stream" property 0 to token-08fa token-08d1 200
                or to token-08d1
            then
        then
        token-08ce 1 + to token-08ce 200 token-08d2
        if
            token-09fa to token-08f4
        then
        get_edid_mode token-08eb token-0900 token-08eb token-0916 to
        token-08e8 to token-08e7 token-0903 token-0a14 token-09ab
        token-09ad
    else
        token-0a25
    then
;

: token-0a27 ( 0a27 )
    token-0969 dup 10 rshift ff and swap dup 8 rshift ff and swap ff and
;

: token-0a28 ( 0a28 )
    swap 8 lshift or swap 10 lshift or token-0968
;

: token-0a29 ( 0a29 )
    " "(00 00 00 00 00 aa 00 aa 00 00 aa aa aa 00 00 aa 00 aa aa 55 00 aa aa aa 55 55 55 55 55 ff 55 ff 55 55 ff ff ff 55 55 ff 55 ff ff ff 55 ff ff ff)"
    token-08cb
    if
        2dup bounds
        do
            i c@ i 1 + c@ i 2 + c@ token-08e4 dup i c! dup i 1 + c! i 2 +
            c! 3
        +loop
    then
    0 swap 3 /
;

0 value token-0a2a ( 0a2a )

: token-0a2b ( 0a2b )
    token-08ea 1 =
    if
        swap rot fill
    else
        swap token-08ea * bounds
        do
            dup i token-08ea 2 =
            if
                w!
            else
                l!
            then
            token-08ea
        +loop
        drop
    then
;

: token-0a2c ( 0a2c )
    swap token-08ea * move rot token-0a2a token-08ea * + -rot
;

: token-0a2d ( 0a2d )
    -rot token-08ea * move rot token-0a2a token-08ea * + -rot
;

defer token-0a2e ( 0a2e )

: token-0a2f ( 0a2f )
    token-08c6 token-08e6 +
;

: token-0a30 ( 0a30 )
    >r dup to token-0a2a swap >r swap dup token-08e7 <
    if
        swap over + token-08e7 min over - r> r> swap dup token-08e8 <
        if
            swap over + token-08e8 min over - rot swap 2swap token-08e9 *
            token-0a2f + swap token-08ea * + swap 0
            ?do
                2 pick 2 pick 2 pick token-0a2e token-08e9 +
            loop
        else
            2drop
        then
    else
        r> r> 2drop
    then
    drop 2drop
;

: token-0a31 ( 0a31 )
    token-096a token-0a27
;

: token-0a32 ( 0a32 )
    token-096b token-0a28
;

external

: dimensions ( 0a33 )
    token-08e7 token-08e8
;

: color@ ( 0a34 )
    token-08fd
    if
        token-08fa 0<>
        if
            token-096d
        then
        token-0a31
    else
        drop 0 0 0
    then
;

: color! ( 0a35 )
    token-08fd
    if
        token-08fa 0<>
        if
            token-096d
        then
        token-0a32
    else
        2drop 2drop
    then
;

: set-colors ( 0a36 )
    token-08fd
    if
        swap token-096b 3 * bounds
        ?do
            i c@ 10 lshift i 1 + c@ 8 lshift i 2 + c@ + + token-0968 3
        +loop
    else
        drop 2drop
    then
;

: get-colors ( 0a37 )
    token-08fd
    if
        swap token-096a 3 * bounds
        ?do
            token-0969 dup 10 rshift ff and i c! dup 8 rshift ff and i 1 +
            c! ff and i 2 + c! 3
        +loop
    else
        drop 2drop
    then
;

: fill-rectangle ( 0a38 )
    token-08fd
    if
        ['] token-0a2b to token-0a2e token-0a30
    else
        drop 2drop 2drop
    then
;

: draw-rectangle ( 0a39 )
    token-08fd
    if
        ['] token-0a2c to token-0a2e token-0a30
    else
        drop 2drop 2drop
    then
;

: read-rectangle ( 0a3a )
    token-08fd
    if
        ['] token-0a2d to token-0a2e token-0a30
    else
        drop 2drop 2drop
    then
;

: ddc2-set-start ( 0a3b )
    token-09d4 token-09db
;

: ddc2-set-stop ( 0a3c )
    token-09d4 token-09dc
;

: ddc2-send-byte ( 0a3d )
    token-09d4 token-09dd
;

: ddc2-get-byte ( 0a3e )
    token-09d4 token-09de
;

headerless

defer token-0a3f ( 0a3f )
defer token-0a40 ( 0a40 )
defer token-0a41 ( 0a41 )
defer token-0a42 ( 0a42 )
defer token-0a43 ( 0a43 )
defer token-0a44 ( 0a44 )
0 value token-0a45 ( 0a45 )

: token-0a46 ( 0a46 )
    token-08fa 0=
    if
        token-0841 token-095c 400 or token-0841 token-095f
    else
        token-09c5
    then
;

: token-0a47 ( 0a47 )
    token-08fa 0=
    if
        token-0841 token-095c 400 invert and token-0841 token-095f
    else
        token-09c3
    then
;

headers

: pfb-blink-screen ( 0a48 )
    token-0a46 pfb-blink-speed ms token-0a47
;

headerless

: token-0a49 ( 0a49 )
    token-08fa 0=
    if
        token-0860
    else
        token-0893
    then
    token-095c 10 rshift 1 +
;

: token-0a4a ( 0a4a )
    token-08fa 0=
    if
        token-085e
    else
        token-0891
    then
    token-095c 10 rshift 1 + 2* 2* 2*
;

: token-0a4b ( 0a4b )
    token-08fa 0=
    if
        token-083f token-095c f00 and
    else
        token-088f token-095c f00 and
    then
;

: token-0a4c ( 0a4c )
    100 0
    do
        i dup dup i color!
    loop
;

: token-0a4d ( 0a4d )
    80 dup token-095e 1 or swap token-0961
;

: token-0a4e ( 0a4e )
    ff ff ff h# 0 color! 66 66 99 h# 1 color! ff h# 0 h# 0 h# 2 color! ff
    ff h# 0 h# 3 color! h# 0 ff h# 0 4 color! h# 0 ff ff 5 color! h# 0 h# 0
    ff 6 color! ff h# 0 ff 7 color! ff ff ff fe color! h# 0 h# 0 h# 0 ff
    color! token-0a4d
;

: token-0a4f ( 0a4f )
    ff ff ff h# 0 color! h# 0 h# 0 h# 0 ff color!
;

: token-0a50 ( 0a50 )
    ff ff ff h# 0 color! 66 66 66 66 color! 99 99 99 99 color! h# 0 h# 0
    h# 0 ff color!
;

: token-0a51 ( 0a51 )
    ff dup dup 0 color! ff 1
    do
        pfb-logo-cmap-buffer i 3 * + dup n->l c@ over 1 + n->l c@ rot 2 +
        n->l c@ i color!
    loop
    0 0 0 ff color! token-0a4d
;

: token-0a52 ( 0a52 )
    0 0 0 0 color! ff ff ff ff color! token-0a4d
;

: token-0a53 ( 0a53 )
    token-0a4b token-081d =
    if
        0 color@ + + 0<> ff color@ and and ff <> or
        if
            token-0a52
        then
    then
;

: token-0a54 ( 0a54 )
    token-0a4b dup token-081d =
    if
        0 color@ + + 0<> ff color@ and and ff <> or
        if
            0 0 0 0 color! ff dup 2dup color! token-0a4d
        then
    then
    token-08c2 0 <>
    if
        pfb-current-depth <>
        if
            -1 exit
        then
        token-0a4a token-08e7 <>
        if
            -1 exit
        then
        token-0a49 token-08e8 <>
        if
            -1 exit
        then
        0
    then
;

: token-0a55 ( 0a55 )
    0
;

: token-0a56 ( 0a56 )
    token-0a4b pfb-current-depth <>
    if
        -1 exit
    then
    token-0a4a token-08e7 <>
    if
        -1 exit
    then
    token-0a49 token-08e8 <>
    if
        -1 exit
    then
    0
;

' token-0a55 to token-081b

: token-0a57 ( 0a57 )
    token-0a4b pfb-current-depth <>
;

: token-0a58 ( 0a58 )
    token-0a54
    if
        token-081a
    then
    fb8-reset-screen
;

: token-0a59 ( 0a59 )
    token-0a54
    if
        token-081a
    then
    token-0a4b dup token-081d =
    if
        drop token-0a40 exit
    then
    token-081c =
    if
        fb8-toggle-cursor
    then
;

: token-0a5a ( 0a5a )
    token-0a57
    if
        token-081a
    then
    token-0a4b dup token-081d =
    if
        drop token-0a3f exit
    then
    token-081c =
    if
        column# 0=
        if
            token-0a4f
        then
        fb8-draw-character
    then
;

: token-0a5b ( 0a5b )
    token-0a54
    if
        token-081a
    then
    token-0a4b dup token-081d =
    if
        drop token-0a41 exit
    then
    token-081c =
    if
        fb8-delete-lines
    then
;

: token-0a5c ( 0a5c )
    token-0a54
    if
        token-081a
    then
    token-0a4b dup token-081d =
    if
        drop token-0a42 exit
    then
    token-081c =
    if
        token-0a50 fb8-draw-logo
    then
;

: token-0a5d ( 0a5d )
    " /options" find-package
    if
        " oem-logo?" rot get-package-property 0<>
        if
            0
        then
    else
        0
    then
    if
        token-0a4b
        case
            token-081d of token-0a42 exit endof
            token-081c of token-0a5c exit endof
            2drop 2drop exit
        endcase
    then
    token-0a4b
    case
        token-081c of token-0a51 token-0a43 endof
        token-081d of token-0a44 endof
        2drop 2drop
    endcase
;

: token-0a5e ( 0a5e )
    ['] token-0a5a to draw-character
    ['] token-0a58 to reset-screen
    ['] token-0a59 to toggle-cursor
    ['] pfb-blink-screen to blink-screen
    ['] fb8-invert-screen to invert-screen
    ['] fb8-erase-screen to erase-screen
    ['] fb8-insert-characters to insert-characters
    ['] fb8-delete-characters to delete-characters
    ['] fb8-insert-lines to insert-lines
    ['] fb8-delete-lines to delete-lines
    ['] token-0a5d to draw-logo
;

defer token-0a5f ( 0a5f )

: token-0a60 ( 0a60 )
    token-0a4a to token-08e7 token-0a49 to token-08e8 token-0a4b dup to
    pfb-current-depth >bitdepth token-08fa 0=
    if
        token-0863
    else
        token-0896
    then
    token-095c 7ff and * to token-08e9 token-0a2f to frame-buffer-adr
    default-font set-font token-08e9 token-08e8 token-08e7 char-width /
    over char-height / fb8-install window-left token-08e9 token-08e7 - 2/ -
    to window-left pfb-current-depth dup token-081c =
    if
        token-0a5e
    then
    token-081d =
    if
        token-0a5f
    then
;

' noop to token-081a

: token-0a61 ( 0a61 )
    token-0a4a dup to token-08e7 token-0a49 dup to token-08e8 token-08e7
    char-width / token-08e8 char-height /
;

: token-0a62 ( 0a62 )
    token-0a61 fb8-install token-08e7 #columns char-width * - 2/ to
    window-left 0 dup to line# to column# token-0a4b dup token-081d =
    if
        drop token-0a5f exit
    then
    token-081c =
    if
        token-0a5e
    then
;

: token-0a63 ( 0a63 )
    pfb-current-depth >bitdepth dup 20 =
    if
        drop 18
    then
;

: token-0a64 ( 0a64 )
;

: token-0a65 ( 0a65 )
    token-0a45 0=
    if
        1 to token-0a45
        ['] token-0a55 to token-081b
        ['] token-0a54 to token-081b pfb-current-depth token-081d =
        if
            token-0a4c
        then
        token-0a62 token-0a64
    else
        token-0a45 1 + to token-0a45 token-0a62
    then
;

: token-0a66 ( 0a66 )
    token-0a45 1 =
    if
        0 to token-0a45
    else
        token-0a45 1 - 0 max to token-0a45
    then
;

h# 0 constant token-0a67 ( 0a67 )
0 value token-0a68 ( 0a68 )
truecolor-black value token-0a69 ( 0a69 )

: token-0a6a ( 0a6a )
    ffffff00 token-0818 n->l
;

: token-0a6b ( 0a6b )
    ffffff n->l
;

headers

: crtl_byte ( 0a6c )
    token-0a67 18 lshift
;

: pfb24_scrn_params ( 0a6d )
    token-0a4a token-0a49 over char-width / over char-height /
;

: >depth-bytes ( 0a6e )
    dup 18 =
    if
        drop 20
    then
    2/ 2/ 2/
;

: pixels->bytes ( 0a6f )
    pfb-current-depth >bitdepth 8 <>
    if
        pfb-current-depth >bitdepth dup 18 = swap 20 = or
        if
            /l*
        then
    then
;

: bytes/line ( 0a70 )
    token-08e9
;

headerless

: token-0a71 ( 0a71 )
    char-width * window-left +
;

: token-0a72 ( 0a72 )
    char-height * window-top +
;

: token-0a73 ( 0a73 )
    token-0a72 bytes/line * swap token-0a71 pfb-current-depth >bitdepth
    >depth-bytes * + token-0a2f +
;

: token-0a74 ( 0a74 )
    column# line# token-0a73
;

: token-0a75 ( 0a75 )
    line# token-0a73
;

: token-0a76 ( 0a76 )
    0 swap token-0a73
;

: token-0a77 ( 0a77 )
    bytes/line * swap pfb-current-depth >bitdepth >depth-bytes * +
    frame-buffer-adr +
;

: token-0a78 ( 0a78 )
    char-width 0
    ?do
        dup 8000 and
        if
            truecolor-black
        else
            truecolor-white
        then
        crtl_byte or token-0818 2 pick i /l* + rl! 1 lshift
    loop
    drop
;

: token-0a79 ( 0a79 )
    char-width 0
    ?do
        dup 8000 and
        if
            truecolor-white
        else
            truecolor-black
        then
        crtl_byte or token-0818 2 pick i /l* + rl! 1 lshift
    loop
    drop
;

: token-0a7a ( 0a7a )
    dup c@ 8 lshift swap char+ dup c@ rot or swap char+
;

headers

: fb32-draw-character ( 0a7b )
    token-0a74 swap >font char-height 0
    ?do
        token-0a7a -rot inverse?
        if
            token-0a79
        else
            token-0a78
        then
        bytes/line + swap
    loop
    2drop
;

' fb32-draw-character to token-0a3f

: fb32-background-color ( 0a7c )
    inverse-screen?
    if
        truecolor-black
    else
        truecolor-white
    then
    crtl_byte or
;

headerless

: token-0a7d ( 0a7d )
    2 pick dup lxjoin -rot dup /x 1 - and >r /x / 0
    ?do
        2dup rx! xa1+
    loop
    r> rot drop
;

: token-0a7e ( 0a7e )
    /l / 0
    ?do
        2dup rl! la1+
    loop
    2drop
;

: token-0a7f ( 0a7f )
    dup 0<>
    if
        over /l and
        if
            -rot 2dup rl! la1+ rot /l -
        then
        token-0a7d dup 0<>
        if
            token-0a7e
        else
            drop 2drop
        then
    else
        drop 2drop
    then
;

headers

: fb32-fill ( 0a80 )
    token-0818 swap rot token-0a7e
;

: move-chars ( 0a81 )
    2dup max #columns swap - char-width * /l* -rot swap token-0a75 swap
    token-0a75 char-height 0
    ?do
        2 pick 2 pick 2 pick rot move swap bytes/line + swap bytes/line +
    loop
    drop 2drop
;

: erase-chars ( 0a82 )
    swap char-width * pixels->bytes swap token-0a75 char-height 0
    ?do
        2dup fb32-background-color fb32-fill bytes/line +
    loop
    2drop
;

: fb32-insert-characters ( 0a83 )
    #columns column# - min dup column# + column# swap move-chars column#
    erase-chars
;

: fb32-delete-characters ( 0a84 )
    #columns column# - min dup column# + column# move-chars #columns over -
    erase-chars
;

: fb32-cursor ( 0a85 )
    0
    ?do
        2dup 0
        ?do
            dup rl@ token-0818 token-0a6b xor token-0818 over rl! la1+
        loop
        drop swap bytes/line + swap
    loop
    2drop
;

: fb32-toggle-cursor ( 0a86 )
    token-0a74 char-width char-height fb32-cursor
;

' fb32-toggle-cursor to token-0a40

headerless

: token-0a87 ( 0a87 )
    line# + #lines min
;

: token-0a88 ( 0a88 )
    line# + #lines min
;

: token-0a89 ( 0a89 )
    #columns char-width * #lines rot - char-height *
;

: token-0a8a ( 0a8a )
    line# + #lines min token-0a72 0 token-0a71 swap
;

: token-0a8b ( 0a8b )
    0 token-0a71 line# token-0a72
;

: token-0a8c ( 0a8c )
    0 token-0a71 swap line# + #lines min token-0a72
;

: token-0a8d ( 0a8d )
    dup token-0a87 token-0a89 rot token-0a8b rot token-0a8a
;

: token-0a8e ( 0a8e )
    dup token-0a88 token-0a89 rot token-0a8a token-0a8b
;

: token-0a8f ( 0a8f )
    0 token-0a71 #lines rot - 0 max token-0a72
;

: token-0a90 ( 0a90 )
    0 token-0a71 line# token-0a72
;

: token-0a91 ( 0a91 )
    #columns char-width * swap #lines swap - 0 max #lines swap -
    char-height *
;

: token-0a92 ( 0a92 )
    #columns char-width * swap char-height *
;

: token-0a93 ( 0a93 )
    dup token-0a91 rot token-0a8f
;

: token-0a94 ( 0a94 )
    token-0a77 -rot 0
    ?do
        2dup 0
        ?do
            inverse?
            if
                truecolor-white
            else
                truecolor-black
            then
            crtl_byte or over rl! la1+
        loop
        drop swap bytes/line + swap
    loop
    2drop
;

: token-0a95 ( 0a95 )
    token-0a92 token-0a90
;

: token-0a96 ( 0a96 )
    5 pick 0<>
    if
        token-0a77 -rot token-0a77 2swap >r pixels->bytes -rot r> 0
        ?do
            2 pick 2 pick 2 pick rot move bytes/line + swap bytes/line +
            swap
        loop
    else
        drop 2drop
    then
    drop 2drop
;

: token-0a97 ( 0a97 )
    4 pick + token-0a77 -rot 3 pick + token-0a77 swap
;

: token-0a98 ( 0a98 )
    over 0<>
    if
        >r pixels->bytes -rot swap rot r> 0
        ?do
            2 pick 2 pick 2 pick move -rot bytes/line - -rot bytes/line -
            -rot
        loop
    else
        drop
    then
    drop 2drop
;

: token-0a99 ( 0a99 )
    token-0a97 2swap token-0a98
;

headers

: fb32-delete-lines ( 0a9a )
    dup token-0a8d token-0a96 token-0a93 token-0a77 rot pixels->bytes swap
    rot inverse-screen?
    if
        truecolor-black
    else
        truecolor-white
    then
    crtl_byte or swap 0
    ?do
        2 pick 2 pick 2 pick fb32-fill swap bytes/line + swap
    loop
    drop 2drop
;

' fb32-delete-lines to token-0a41

: fb32-insert-lines ( 0a9b )
    dup token-0a8e token-0a99 token-0a95 token-0a77 rot pixels->bytes swap
    rot inverse-screen?
    if
        truecolor-black
    else
        truecolor-white
    then
    crtl_byte or swap 0
    ?do
        2 pick 2 pick 2 pick fb32-fill swap bytes/line + swap
    loop
    drop 2drop
;

headerless

: token-0a9c ( 0a9c )
    -rot 2 pick /l / 0
    ?do
        dup rl@ token-0818 token-0a6b xor token-0818 2 pick rl! la1+ -rot
        la1+ -rot /l - -rot
    loop
    rot
;

: token-0a9d ( 0a9d )
    -rot 2 pick /x / 0
    ?do
        dup rx@ token-0819 token-0a6a dup lxjoin xor token-0819 2 pick rx!
        xa1+ -rot xa1+ -rot /x - -rot
    loop
    rot
;

headers

: move-xor24 ( 0a9e )
    dup 0<>
    if
        2 pick /x 1 - and 2 pick /x 1 - and or 0=
        if
            token-0a9d
        else
            2 pick /x 1 - and 2 pick /x 1 - and and /l and
            if
                -rot over rl@ token-0818 token-0a6b xor token-0818 2 pick
                rl! la1+ -rot la1+ -rot /l - token-0a9d
            then
        then
        dup 0<>
        if
            token-0a9c
        then
    then
    drop 2drop
;

: fb32-erase-screen ( 0a9f )
    token-0a2f to token-0a68 token-0a4a pixels->bytes token-0a49 0
    ?do
        dup token-0a68 inverse-screen?
        if
            truecolor-black
        else
            truecolor-white
        then
        crtl_byte or fb32-fill token-0a68 bytes/line + to token-0a68
    loop
    drop
;

: fb32-black-screen ( 0aa0 )
    token-0a2f to token-0a68 token-0a4a pixels->bytes token-0a49 0
    ?do
        dup token-0a68 truecolor-black crtl_byte or fb32-fill token-0a68
        bytes/line + to token-0a68
    loop
    drop
;

: fb32-white-screen ( 0aa1 )
    token-0a2f to token-0a68 token-0a4a pixels->bytes token-0a49 0
    ?do
        dup token-0a68 truecolor-white crtl_byte or fb32-fill token-0a68
        bytes/line + to token-0a68
    loop
    drop
;

: fb32-invert-screen ( 0aa2 )
    token-0a2f to token-0a68 token-0a4a pixels->bytes token-0a49 0
    ?do
        token-0a68 token-0a68 2 pick move-xor24 token-0a68 bytes/line + to
        token-0a68
    loop
    drop
;

headerless

: token-0aa3 ( 0aa3 )
    " /options" find-package
    if
        " oem-logo?" rot get-package-property 0<>
        if
            0
        then
    else
        0
    then
;

: token-0aa4 ( 0aa4 )
    dup c@ 8 lshift swap 1 + c@ or
;

: token-0aa5 ( 0aa5 )
    truecolor-white token-0a69 rot 8000 and
    if
        swap
    then
    drop inverse?
    if
        token-0a6b xor
    then
    crtl_byte or
;

: token-0aa6 ( 0aa6 )
    swap token-0aa4 swap 10 0
    do
        over token-0aa5 token-0818 over rl! la1+ swap 1 lshift swap
    loop
    nip
;

: token-0aa7 ( 0aa7 )
    2 pick 4 rshift 0
    do
        1 pick swap token-0aa6 swap 2 + swap
    loop
    bytes/line + 2 pick 4 * -
;

headers

: fb8-draw-papaya-logo ( 0aa8 )
    drop 2drop token-0a76 pfb-logo-buffer pfb-logo-width pfb-logo-height 0
    ?do
        2dup i * + over bounds
        ?do
            i c@ 3 pick bytes/line j * + i 4 pick - n->l 3 pick mod + n->l
            c!
        loop
    loop
    drop 2drop
;

' fb8-draw-papaya-logo to token-0a43

: fb32-draw-papaya-logo ( 0aa9 )
    drop 2drop token-0a76 pfb-logo-buffer pfb-logo-width pfb-logo-height 0
    ?do
        2dup i * + over bounds
        ?do
            i n->l c@ dup 0= over ff = or 0=
            if
                pfb-logo-cmap-buffer swap 3 * + dup n->l c@ 10 lshift swap
                1 + dup n->l c@ 8 lshift swap 1 + n->l c@ or or
            else
                0=
                if
                    ffffff
                else
                    0
                then
            then
            token-0818 3 pick bytes/line j * + i 4 pick - n->l 3 pick mod
            2* 2* + n->l rl!
        loop
    loop
    drop 2drop
;

' fb32-draw-papaya-logo to token-0a44

: fb32-install-prep ( 0aaa )
    ['] token-0a58 to reset-screen
    ['] token-0a59 to toggle-cursor
    ['] fb32-erase-screen to erase-screen
    ['] pfb-blink-screen to blink-screen
    ['] fb32-invert-screen to invert-screen
    ['] token-0a5a to draw-character
    ['] fb32-insert-characters to insert-characters
    ['] fb32-delete-characters to delete-characters
    ['] fb32-insert-lines to insert-lines
    ['] token-0a5b to delete-lines
    ['] token-0a5d to draw-logo
;

' fb32-install-prep to token-0a5f

headerless

: token-0aab ( 0aab )
    dup token-0906 <
    if
        token-0902
    else
        dup token-08cd <
        if
            token-0927
        else
            drop 0
        then
    then
;

: token-0aac ( 0aac )
    token-0916 swap token-08ea token-08e2 * token-08b7 100000 * token-08e6
    - <=
;

: token-0aad ( 0aad )
    dup token-0928 over token-0927 = over token-08cd < and over token-0aac
    and over token-0917 0<> and
;

external

: mode# ( 0aae )
    token-08eb
;

: set-mode ( 0aaf )
    dup token-0aab
    if
        token-0aad
        if
            token-0916 to token-08e8 to token-08e7 token-08e7 encode-int
            " width" property token-08e8 encode-int " height" property
            token-0903 token-08e9 encode-int " linebytes" property
            token-08ea 8 * encode-int " depth" property token-08fd
            if
                token-08e9 token-08e8 token-08e7 char-width / over
                char-height / fb8-install window-left token-08e9 token-08e7
                - 2/ - to window-left 0 dup to column# to line# token-08ea
                1 =
                if
                    token-081c to pfb-current-depth token-0a5e
                else
                    token-08ea 4 =
                    if
                        token-081d to pfb-current-depth token-0a5f
                        token-0a4c
                    then
                then
                token-08fa 0=
                if
                    token-0a13
                else
                    token-0a18
                then
                ['] token-0a54 to token-081b
                ['] token-0a60 to token-081a erase-screen
            then
        else
            . "  not supported" type cr
        then
    else
        . "  disabled" type cr
    then
;

: show-modes ( 0ab0 )
    cr token-08cd 0
    do
        i token-0916 i . " = " type swap base @ swap a base ! . base !
        " X " type base @ swap a base ! . base ! " @ " type i token-0917
        4e20 * i token-0919 * / 1 + 2/ base @ swap a base ! . base ! " Hz "
        type i token-0927
        if
            " LCD " type
        then
        i token-0aad 0=
        if
            drop " - not supported " type
        else
            token-0902 0=
            if
                " - Disabled" type
            then
        then
        i token-08eb =
        if
            "  * CURRENT" type
        then
        cr i
        begin
            dup #lines >
        while
            #lines -
        repeat
        #lines 2 - =
        if
            " Press any key" type
            begin
                key?
            while
                key drop
            repeat
            key drop cr
        then
    loop
;

: enable-videomode ( 0ab1 )
    token-0aad
    if
        token-0900
    else
        . "  not supported" type cr
    then
;

: disable-videomode ( 0ab2 )
    token-0aad
    if
        dup token-08eb <>
        if
            token-0901
        else
            drop " Cannot disable current mode" type cr
        then
    else
        drop
    then
;

headerless

: token-0ab3 ( 0ab3 )
    1 to token-08ea token-0a29 set-colors ff dup 2dup color! 168 get-token
    drop 169 get-token drop <>
    if
        0 0 " iso6429-1983-colors" property
    else
        ff dup dup 0 color! 0 dup dup ff color!
    then
    default-font set-font token-08eb set-mode
;

: token-0ab4 ( 0ab4 )
    token-08c2 0=
    if
        token-0975 token-0a2f encode-int " address" property token-08d1 80
        and 0=
        if
            token-09a6 token-08d1 80 or to token-08d1
        then
    then
    token-08d1 100 and 0=
    if
        token-08d1 100 or to token-08d1 token-08d1 encode-int " aty,flags"
        property
    then
    token-08c2 1 + to token-08c2 token-0911 token-08eb token-09fc
    token-08fa 0<> and
    if
        token-092b
    else
        token-0900
    then
    token-08eb to token-08ec token-08eb token-0916 to token-08e8 to
    token-08e7 token-0903 token-0a2f to frame-buffer-adr token-0ab3
;

: token-0ab5 ( 0ab5 )
    token-08c2 1 - 0 max to token-08c2 token-08c2 0=
    if
        token-08fa 0=
        if
            token-09ab
        else
            token-09bf
        then
        token-0977 " address" delete-property -1 to frame-buffer-adr
        token-08d1 100 invert and to token-08d1 token-08d1 encode-int
        " aty,flags" property
    then
;

: token-0ab6 ( 0ab6 )
    0
;

: token-0ab7 ( 0ab7 )
    sccsid encode-string " version" property
;

token-08dd token-0976 token-097b token-0997 token-09a7 80 alloc-mem to
token-08d8 token-0a26 token-08d8 80 free-mem token-0977 token-08d1
encode-int " aty,flags" property token-08bd encode-int " ATY,RefCLK"
property token-08be encode-int " ATY,MCLK" property token-08bf encode-int
" ATY,SCLK" property token-08e7 encode-int " width" property token-08e8
encode-int " height" property token-0903 token-08e9 encode-int " linebytes"
property token-08ea 8 * encode-int " depth" property token-08ce
if
    token-08fa 0=
    if
        token-08eb
    else
        token-08ec
    then
    token-0927
    if
        " LCD"
    else
        " CRT"
    then
else
    token-08d7
    if
        " TV"
    else
        " NONE"
    then
then
encode-string " display-type" property " display" device-type " ISO8859-1"
encode-string " character-set" property 168 get-token drop 169 get-token
drop <>
if
    0 0 " iso6429-1983-colors" property
then
my-address my-space encode-phys 0 encode-int encode+ 0 encode-int encode+
my-address my-space 2000010 + encode-phys encode+ 0 encode-int encode+
token-08b3 encode-int encode+ my-address my-space 2000014 + encode-phys
encode+ 0 encode-int encode+ 100 encode-int encode+ my-address my-space
2000018 + encode-phys encode+ 0 encode-int encode+ token-08b5 encode-int
encode+ my-address my-space 2000030 + encode-phys encode+ 0 encode-int
encode+ token-08b4 encode-int encode+ " reg" property
' token-0ab4 is-install
' token-0ab5 is-remove
' token-0ab6 is-selftest token-0ab7 " 113-85507-107" encode-string
" ATY,Rom#" property " 102-85515-00" encode-string " ATY,Card#" property
" 1.86" encode-string " ATY,Fcode" property

end0
