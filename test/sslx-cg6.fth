\ fd 03 3dea 000026bc
fcode-version1
hex

offset16

" cgsix" xdrstring " name" attribute " SUNW,501-1672" model " display"
device-type

headers

: copyright ( 0800 )
    " Copyright (c) 1990 by Sun Microsystems, Inc. "
;

: sccsid ( 0801 )
    " @(#)obduplo.fth 1.33 92/10/23"
;

variable legosc-address ( 0802 )

: map-slot ( 0803 )
    swap legosc-address @ + swap map-sbus
;

4 constant lengthloc ( 0804 )
10 constant /dac ( 0805 )
8000 constant /prom ( 0806 )
58a28d4 constant mainosc ( 0807 )
-1 value dac-adr ( 0808 )
-1 value prom-adr ( 0809 )
-1 value ptr ( 080a )
-1 value logo ( 080b )
-1 value fhc ( 080c )
-1 value thc ( 080d )
-1 value fbc-adr ( 080e )
-1 value fb-addr ( 080f )
-1 value alt-adr ( 0810 )
-1 value tec ( 0811 )
-1 value tmp-len ( 0812 )
-1 value tmp-addr ( 0813 )
-1 value tmp-flag ( 0814 )
-1 value selftest-map ( 0815 )
0 value mapped? ( 0816 )
0 value alt-mapped? ( 0817 )
0 value my-reset ( 0818 )
1 value /vmsize ( 0819 )
8 value ppc ( 081a )
91 value bdrev ( 081b )
1238 value strap-value ( 081c )
200000 value /frame ( 081d )
100 alloc-mem constant data-space ( 081e )
0

external

value display-width ( 081f )
0 value display-height ( 0820 )
0 value dblbuf? ( 0821 )
-1 value acceleration ( 0822 )
0

headers

value lego-status ( 0823 )
0 value sense-id-value ( 0824 )
0 value chip-rev ( 0825 )
defer (set-fbconfiguration ( 0826 )
defer (confused? ( 0827 )
defer fbprom ( 0828 )

: my-attribute ( 0829 )
    version 2000 <
    if
        2drop 2drop
    else
        my-reset 0 =
        if
            attribute
        else
            2drop 2drop
        then
    then
;

: my-xdrint ( 082a )
    my-reset 0=
    if
        xdrint
    else
        0
    then
;

: my-xdrstring ( 082b )
    my-reset 0=
    if
        xdrstring
    then
;

: hobbes-prom ( 082c )
    " fb-prom" $find drop is fbprom fbprom
;

: length@ ( 082d )
    hobbes-prom lengthloc + l@
;

: logo-data ( 082e )
    hobbes-prom length@ +
    begin
        dup 3 and
    while
        1 +
    repeat
;

: fbc! ( 082f )
    fbc-adr + l!
;

: fbc@ ( 0830 )
    fbc-adr + l@
;

: fhc! ( 0831 )
    fhc + l!
;

: fhc@ ( 0832 )
    fhc + l@
;

: tec! ( 0833 )
    tec + l!
;

: thc! ( 0834 )
    thc + l!
;

: thc@ ( 0835 )
    thc + l@
;

: dac! ( 0836 )
    dac-adr + l!
;

: alt! ( 0837 )
    alt-adr + l!
;

: fbc-busy-wait ( 0838 )
    begin
        10 fbc@ 10000000 and 0=
    until
;

: fbc-draw-wait ( 0839 )
    begin
        14 fbc@ 20000000 and 0=
    until
;

: fbc-blit-wait ( 083a )
    begin
        18 fbc@ 20000000 and 0=
    until
;

: background-color ( 083b )
    inverse-screen?
    if
        ff
    else
        0
    then
;

: rect-fill ( 083c )
    fbc-busy-wait 100 fbc! 2swap 904 fbc! 900 fbc! 904 fbc! 900 fbc!
    fbc-draw-wait fbc-busy-wait ff 100 fbc!
;

: >pixel ( 083d )
    swap char-width * window-left + swap char-height * window-top +
;

: char-fill ( 083e )
    2swap >pixel 2swap >pixel background-color rect-fill
;

: init-blit-reg ( 083f )
    fbc-busy-wait ffffffff 10 fbc! 0 4 tec! h# 0 8 fbc! h# 0 c0 fbc! h# 0
    c4 fbc! h# 0 d0 fbc! h# 0 d4 fbc! h# 0 e0 fbc! h# 0 e4 fbc! ff 100 fbc!
    h# 0 104 fbc! a9806c60 108 fbc! ff 10c fbc! ffffffff 110 fbc! h# 0 11c
    fbc! ffffffff 120 fbc! ffffffff 124 fbc! ffffffff 128 fbc! ffffffff 12c
    fbc! ffffffff 130 fbc! ffffffff 134 fbc! ffffffff 138 fbc! ffffffff 13c
    fbc! 229540 4 fbc! display-width 1 - f0 fbc! display-height 1 - f4 fbc!
    display-width
    case
        400 of ffffe3ff 0 fhc@ and 0 fhc! endof
        480 of ffffe3ff 0 fhc@ and 800 or 0 fhc! endof
        500 of ffffe3ff 0 fhc@ and 1000 or 0 fhc! endof
        640 of ffffe3ff 0 fhc@ and 1800 or 0 fhc! endof
        780 of ffffe3ff 0 fhc@ and 400 or 0 fhc! endof
    endcase
;

: cg6-save ( 0840 )
    fbc-busy-wait c0 fbc@ c4 fbc@ d0 fbc@ d4 fbc@ e0 fbc@ e4 fbc@ 8 fbc@
    100 fbc@ 104 fbc@ 108 fbc@ 10c fbc@ 110 fbc@ 4 fbc@ f0 fbc@ f4 fbc@ 80
    fbc@ 84 fbc@ 90 fbc@ 94 fbc@ a0 fbc@ a4 fbc@ b0 fbc@ b4 fbc@
    init-blit-reg
;

: cg6-restore ( 0841 )
    fbc-busy-wait b4 fbc! b0 fbc! a4 fbc! a0 fbc! 94 fbc! 90 fbc! 84 fbc!
    80 fbc! f4 fbc! f0 fbc! 40 or 4 fbc! 110 fbc! 10c fbc! 108 fbc! 104
    fbc! 100 fbc! 8 fbc! e4 fbc! e0 fbc! d4 fbc! d0 fbc! c4 fbc! c0 fbc!
;

variable tmp-blit ( 0842 )

: lego-blit ( 0843 )
    fbc-busy-wait >pixel 1 - b4 fbc! 1 - b0 fbc! >pixel a4 fbc! a0 fbc!
    >pixel 1 - 94 fbc! 1 - 90 fbc! >pixel 84 fbc! 80 fbc! fbc-blit-wait
    fbc-busy-wait
;

: lego-delete-lines ( 0844 )
    dup #lines <
    if
        tmp-blit ! cg6-save tmp-blit @ >r 0 line# r@ + #columns #lines 0
        line# #columns #lines r@ - line# r@ + #lines <
        if
            lego-blit
        else
            2drop 2drop 2drop 2drop
        then
        0 #lines r> - #columns #lines char-fill cg6-restore
    else
        tmp-blit ! cg6-save tmp-blit @ 0 swap #lines swap - #columns #lines
        char-fill cg6-restore
    then
;

: lego-insert-lines ( 0845 )
    dup #lines <
    if
        tmp-blit ! cg6-save tmp-blit @ >r 0 line# #columns #lines r@ - 0
        line# r@ + #columns #lines lego-blit 0 line# #columns line# r> +
        char-fill cg6-restore
    else
        tmp-blit ! cg6-save tmp-blit @ 0 swap line# swap #columns swap
        line# swap + char-fill cg6-restore
    then
;

: lego-erase-screen ( 0846 )
    cg6-save 0 0 screen-width screen-height background-color rect-fill
    cg6-restore
;

: lego-video-on ( 0847 )
    818 thc@ 400 or 818 thc!
;

: lego-video-off ( 0848 )
    818 thc@ fffffbff and 1000 or 818 thc!
;

: lego-sync-on ( 0849 )
    818 thc@ 80 or 818 thc!
;

: lego-sync-off ( 084a )
    818 thc@ ffffff7f and 818 thc!
;

: delay-100 ( 084b )
    1 ms
;

: lego-sync-reset ( 084c )
    818 thc@ 1000 or 818 thc! delay-100
;

: prom-map ( 084d )
    0 /prom map-slot is prom-adr
;

: prom-unmap ( 084e )
    prom-adr /prom free-virtual -1 is prom-adr
;

: dac-map ( 084f )
    240000 /dac map-slot is dac-adr
;

: dac-unmap ( 0850 )
    dac-adr /dac free-virtual -1 is dac-adr
;

: fhc-thc-map ( 0851 )
    300000 2000 map-slot is fhc fhc 1000 + is thc
;

: fhc-thc-unmap ( 0852 )
    fhc 2000 free-virtual -1 is fhc -1 is thc
;

: ?fhc-thc-map ( 0853 )
    fhc -1 =
    if
        -1 is mapped? fhc-thc-map
    else
        0 is mapped?
    then
;

: ?fhc-thc-unmap ( 0854 )
    mapped?
    if
        fhc-thc-unmap 0 is mapped?
    then
;

: fb-map ( 0855 )
    800000 /frame map-slot is fb-addr
;

: fb-unmap ( 0856 )
    fb-addr /frame free-virtual -1 is fb-addr
;

: fbc-map ( 0857 )
    700000 2000 map-slot is fbc-adr fbc-adr 1000 + is tec
;

: fbc-unmap ( 0858 )
    fbc-adr 2000 free-virtual -1 is fbc-adr
;

: alt-map ( 0859 )
    280000 2000 map-slot is alt-adr
;

: alt-unmap ( 085a )
    alt-adr 2000 free-virtual -1 is alt-adr
;

: ?alt-map ( 085b )
    alt-adr -1 =
    if
        -1 is alt-mapped? alt-map
    else
        0 is alt-mapped?
    then
;

: ?alt-unmap ( 085c )
    alt-mapped?
    if
        alt-unmap 0 is alt-mapped?
    then
;

: color ( 085d )
    dup rot + swap 0 dac-adr l!
    do
        i c@ dup 18 << + dac-adr 4 + l!
    loop
;

: 3color! ( 085e )
    dac-adr l! swap rot 3 0
    do
        dac-adr 4 + l!
    loop
;

: color! ( 085f )
    swap 0 dac! 2dup dac! 2dup dac! dac!
;

: lego-init-dac ( 0860 )
    dac-map 6000000 0 dac! 43000000 8 dac! 5000000 0 dac! h# 0 8 dac!
    4000000 0 dac! ff000000 8 dac! 7000000 0 dac! h# 0 8 dac! 9000000 0
    dac! 6000000 8 dac! ff000000 h# 0 4 color! h# 0 ff000000 4 color!
    ff000000 1000000 c color! h# 0 2000000 c color! h# 0 3000000 c color!
    64000000 41000000 b4000000 1000000 3color! dac-unmap
;

external

: r1024x768x60 ( 0861 )
    " 64125000,48286,60,16,128,160,1024,2,6,29,768,COLOR"
;

: r1024x768x70 ( 0862 )
    " 74250000,56593,70,16,136,136,1024,2,6,32,768,COLOR"
;

: r1024x768x76 ( 0863 )
    " 81000000,61990,76,40,128,136,1024,2,4,31,768,COLOR,0OFFSET"
;

: r1024x768x77 ( 0864 )
    " 84375000,62040,77,32,128,176,1024,2,4,31,768,COLOR,0OFFSET"
;

: r1024x800x72 ( 0865 )
    " 81000000,60994,73,40,128,136,1024,2,4,31,800,COLOR,0OFFSET"
;

: r1024x800x74 ( 0866 )
    " 84375000,62040,74,32,128,176,1024,2,4,31,800,COLOR,0OFFSET"
;

: r1024x800x85 ( 0867 )
    " 94500000,71590,85,16,128,152,1024,2,4,31,800,COLOR,0OFFSET"
;

: r1152x900x66 ( 0868 )
    " 94500000,61845,66,40,128,208,1152,2,4,31,900,COLOR"
;

: r1152x900x76 ( 0869 )
    " 108000000,71808,76,32,128,192,1152,2,4,31,900,COLOR,0OFFSET"
;

: r1280x1024x67 ( 086a )
    " 118125000,71678,67,24,128,216,1280,2,8,41,1024,COLOR,0OFFSET"
;

: r1280x1024x76 ( 086b )
    " 135000000,81128,76,32,64,288,1280,2,8,32,1024,COLOR,0OFFSET"
;

: r1600x1280x76 ( 086c )
    " 216000000,101890,76,24,216,280,1600,2,8,50,1280,COLOR,0OFFSET"
;

: svga60 ( 086d )
    r1024x768x60
;

: svga70 ( 086e )
    r1024x768x70
;

: svga77 ( 086f )
    r1024x768x77
;

headers

defer sense-code ( 0870 )

: legoSR-sense ( 0871 )
    sense-id-value
    case
        7 of r1152x900x66 endof
        6 of r1152x900x76 endof
        5 of r1024x768x60 endof
        4 of r1152x900x76 endof
        3 of r1152x900x66 endof
        2 of r1152x900x66 endof
        1 of r1152x900x66 endof
        0 of r1024x768x77 endof
        drop r1152x900x66 0
    endcase
;

: duploSR-sense ( 0872 )
    sense-id-value
    case
        7 of r1152x900x66 endof
        6 of r1152x900x76 endof
        5 of r1024x768x60 endof
        4 of r1152x900x76 endof
        3 of r1152x900x66 endof
        2 of r1280x1024x76 endof
        1 of r1600x1280x76 endof
        0 of r1024x768x77 endof
        drop r1152x900x66 0
    endcase
;

: ics-write ( 0873 )
    1c << 0 alt! 1c << 8000000 or 0 alt!
;

: ics47 ( 0874 )
    0 1 0 a 4 0 0 1 8 2 0 0 5
;

: ics54 ( 0875 )
    0 1 0 a 4 0 0 1 8 2 2 0 4
;

: ics64 ( 0876 )
    0 1 0 a 4 0 0 1 8 2 1 0 3
;

: ics74 ( 0877 )
    0 1 0 a 5 0 0 1 8 4 3 0 5
;

: ics81 ( 0878 )
    0 1 0 a 5 0 0 1 8 5 0 0 6
;

: ics84 ( 0879 )
    0 1 0 a 5 0 0 1 8 3 1 0 3
;

: ics94 ( 087a )
    0 1 0 a 5 0 0 1 8 2 0 0 2
;

: ics108 ( 087b )
    0 1 0 a 5 0 0 1 8 4 2 0 3
;

: ics118 ( 087c )
    0 1 0 a 5 0 0 1 8 3 2 0 2
;

: ics135 ( 087d )
    0 1 0 a 6 0 0 1 8 5 4 0 3
;

: ics189 ( 087e )
    0 0 0 a 5 0 0 1 8 2 0 0 2
;

: ics216 ( 087f )
    0 0 0 a 5 0 0 1 8 4 2 0 3
;

: oscillators ( 0880 )
    50775d8 4d3f640 46cf710 3d27848 cdfe600 b43e940 80befc0 70a71c8 66ff300
    5a1f4a0 337f980 2d0fa50 c
;

: setup-oscillator ( 0881 )
    ?alt-map
    case
        0 of ics47 endof
        1 of ics54 endof
        2 of ics94 endof
        3 of ics108 endof
        4 of ics118 endof
        5 of ics135 endof
        6 of ics189 endof
        7 of ics216 endof
        8 of ics64 endof
        9 of ics74 endof
        a of ics81 endof
        b of ics84 endof
        drop ics94 0
    endcase
    d 0
    do
        i ics-write
    loop
    0 f ics-write 94 thc@ 40 or dup 94 thc! is strap-value 1 ms ?alt-unmap
;

variable dpl ( 0882 )

: upper ( 0883 )
    bounds
    ?do
        i dup c@ upc swap c!
    loop
;

: compare-strings ( 0884 )
    rot tuck <
    if
        drop 2drop 0
    else
        comp 0=
    then
;

: long? ( 0885 )
    dpl @ 1 + 0<>
;

: convert ( 0886 )
    begin
        1 + dup >r c@ a digit
    while
        >r a * r> + long?
        if
            1 dpl +!
        then
        r>
    repeat
    drop r>
;

: number? ( 0887 )
    >r 0 r@ dup 1 + c@ 2d = dup >r - -1 dpl !
    begin
        convert dup c@ 2e =
    while
        0 dpl !
    repeat
    r>
    if
        swap negate swap
    then
    r> count + =
;

: number ( 0888 )
    number? drop
;

: /string ( 0889 )
    over min >r swap r@ + swap r> -
;

: +string ( 088a )
    1 +
;

: -string ( 088b )
    swap 1 + swap 1 -
;

: left-parse-string ( 088c )
    >r over 0 2swap
    begin
        dup
    while
        over c@ r@ =
        if
            r> drop -string 2swap exit
        then
        2swap +string 2swap -string
    repeat
    2swap r> drop
;

: left-parse-string' ( 088d )
    left-parse-string 2 pick 0=
    if
        2swap
    then
;

: cindex ( 088e )
    0 swap 2swap bounds
    ?do
        dup i c@ =
        if
            nip i -1 rot leave
        then
    loop
    drop
;

: right-parse-string ( 088f )
    >r 2dup + 0
    begin
        2 pick
    while
        over 1 - c@ r@ =
        if
            r> drop rot 1 - -rot exit
        then
        2swap 1 - 2swap swap 1 - swap 1 +
    repeat
    r> drop
;

variable cal-tmp ( 0890 )
variable osc-tmp ( 0891 )
variable confused? ( 0892 )
100 alloc-mem constant tmp-monitor-string ( 0893 )
100 alloc-mem constant tmp-pack-string ( 0894 )
variable tmp-monitor-len ( 0895 )

external

: monitor-string ( 0896 )
    tmp-monitor-string tmp-monitor-len @
;

headers

: flag-strings ( 0897 )
    " STEREO" " 0OFFSET" " OVERSCAN" " GRAY" 4
;

: mainosc? ( 0898 )
    -1 confused? ! 3e8 / osc-tmp ! oscillators 0
    do
        3e8 / osc-tmp @ =
        if
            i setup-oscillator 0 confused? !
        then
    loop
;

: parse-string ( 0899 )
    is tmp-len is tmp-addr is tmp-flag flag-strings 0
    do
        tmp-addr tmp-len 2swap compare-strings
        if
            1 i << tmp-flag + is tmp-flag
        then
    loop
    tmp-flag
;

: parse-flags ( 089a )
    0 >r
    begin
        2c left-parse-string r> -rot parse-string >r dup 0=
    until
    2drop r>
;

: parse-line ( 089b )
    b 0
    do
        2c left-parse-string tmp-pack-string pack dup number swap drop -rot
        dup 0=
        if
            leave
        then
    loop
    dup 0<>
    if
        parse-flags
    else
        2drop 0
    then
;

: cycles-per-tran ( 089c )
    1add30 ppc * /mod swap 0<>
    if
        1 +
    then
    4 - dup f >
    if
        drop f
    then
;

: vert ( 089d )
    is display-height rot dup my-xdrint " vfporch" my-attribute 1 - dup c0
    thc! rot dup my-xdrint " vsync" my-attribute + dup c4 thc! swap dup
    my-xdrint " vbporch" my-attribute + dup c8 thc! display-height + cc
    thc!
;

: horz ( 089e )
    is display-width rot dup my-xdrint " hfporch" my-attribute dup ppc / 1
    - dup a0 thc! 3 pick dup my-xdrint " hsync" my-attribute ppc / + dup a4
    thc! rot dup my-xdrint " hbporch" my-attribute ppc / + dup a8 thc!
    display-width ppc / + dup b0 thc! -rot - ppc / - ac thc!
;

: fbc-res ( 089f )
    display-width
    case
        400 of ffffe3ff 0 fhc@ and 0 fhc! endof
        480 of ffffe3ff 0 fhc@ and 800 or 0 fhc! endof
        500 of ffffe3ff 0 fhc@ and 1000 or 0 fhc! endof
        640 of ffffe3ff 0 fhc@ and 1800 or 0 fhc! endof
        780 of ffffe3ff 0 fhc@ and 400 or 0 fhc! endof
        0 is acceleration
    endcase
    cal-tmp @ 4 and 0<>
    if
        94 thc@ 80 or 94 thc!
    else
        94 thc@ 80 not and 94 thc!
    then
;

: cal-tim ( 08a0 )
    cal-tmp ! vert horz my-xdrint " vfreq" my-attribute my-xdrint " hfreq"
    my-attribute dup my-xdrint " pixfreq" my-attribute dup mainosc?
    cycles-per-tran 818 thc@ fffffff0 and or 818 thc! fbc-res bdrev
    my-xdrint " boardrev" my-attribute cal-tmp @ my-xdrint " montype"
    my-attribute acceleration
    if
        " cgsix"
    else
        " cgthree+"
    then
    my-xdrstring " emulation" my-attribute
;

external

: update-string ( 08a1 )
    2dup tmp-monitor-string swap move dup tmp-monitor-len !
;

headers

: set-fbconfiguration ( 08a2 )
    update-string parse-line cal-tim
;

' set-fbconfiguration is (set-fbconfiguration
' confused? is (confused?

: enable-disables ( 08a3 )
    94 thc@ 800 or 94 thc!
;

: disable-disables ( 08a4 )
    94 thc@ 800 not and 94 thc!
;

: lego-init-hc ( 08a5 )
    ?fhc-thc-map 8000 0 fhc! 1bb 0 fhc! chip-rev
    case
        5 of enable-disables 0 fhc@ 10000 or 0 fhc! disable-disables endof
        6 of enable-disables 0 fhc@ 10000 or 0 fhc! disable-disables endof
        7 of enable-disables 0 fhc@ 10000 or 0 fhc! disable-disables endof
        8 of enable-disables 0 fhc@ 10000 or 0 fhc! disable-disables endof
        enable-disables 0 fhc@ 10000 or 0 fhc! disable-disables
    endcase
    ffe0ffe0 8fc thc! lego-sync-reset lego-sync-on ?fhc-thc-unmap
;

: logo@ ( 08a6 )
    0 swap 4 0
    do
        dup c@ rot 8 << + swap 1 +
    loop
    drop
;

: cg6-move-line ( 08a7 )
    2 pick 2 pick 2 pick rot move
;

: move-image-to-fb ( 08a8 )
    rot 0
    do
        cg6-move-line display-width + swap 2 pick + swap
    loop
    drop 2drop
;

: lego-draw-logo ( 08a9 )
    2 pick 92 + logo@ bfdfdfe7 <>
    if
        fb8-draw-logo
    else
        dac-map 300 logo-data 2 + color dac-unmap drop 2drop logo-data c@
        logo-data 1 + c@ rot logo-data 302 + swap char-height * window-top
        + display-width * window-left + fb-addr + move-image-to-fb
    then
;

: diagnostic-type ( 08aa )
    diagnostic-mode?
    if
        type cr
    else
        2drop
    then
;

: ?lego-error ( 08ab )
    2swap <>
    if
        2 is lego-status diagnostic-type "  r/w failed"
    else
        2drop
    then
;

: lego-register-test ( 08ac )
    selftest-map
    if
        fb-map fbc-map
    then
    8 fbc@ 35 100 fbc! ca 104 fbc! 12345678 110 fbc! 96969696 84 fbc!
    69696969 80 fbc! 3c3c3c3c 90 fbc! a980cccc 108 fbc! ff 10c fbc! 0 e0
    fbc! h# 0 e4 fbc! display-width 1 - f0 fbc! display-height 1 - f4 fbc!
    14aac0 4 fbc! h# 0 8 fbc! h# 0 4 tec! "  FBC register test"
    diagnostic-type 100 fbc@ 35 " FBC_FCOLOR" ?lego-error 104 fbc@ ca
    " FBC_BCOLOR" ?lego-error 110 fbc@ 12345678 " FBC_PIXELMASK"
    ?lego-error 84 fbc@ 96969696 " FBC_Y0" ?lego-error 80 fbc@ 69696969
    " FBC_X0" ?lego-error 90 fbc@ 3c3c3c3c " FBC_RASTEROP" ?lego-error ff
    110 fbc! 0 84 fbc! 0 80 fbc! 1f 90 fbc! 55555555 1c fbc! 8 fbc!
    selftest-map
    if
        fb-unmap fbc-unmap
    then
;

: lego-fbc-test ( 08ad )
    selftest-map
    if
        fb-map
    then
    "  Font test" diagnostic-type 8 0
    do
        i 4 * fb-addr + @ ff00ff <>
        if
            1 is lego-status " Fonting to DFB error" diagnostic-type
        then
    loop
    selftest-map
    if
        fb-unmap
    then
;

: lego-fb-test ( 08ae )
    selftest-map
    if
        fb-map
    then
    ffffffff mask ! 0 group-code ! fb-addr /frame memory-test-suite
    if
        1 is lego-status
    then
    selftest-map
    if
        fb-unmap
    then
;

: lego-selftest ( 08af )
    fbc-adr -1 =
    if
        -1 is selftest-map
    else
        0 is selftest-map
    then
    " Testing cgsix" diagnostic-type lego-register-test lego-fbc-test
    lego-fb-test lego-status
;

: lego-blink-screen ( 08b0 )
    lego-video-off 20 ms lego-video-on
;

external

: set-resolution ( 08b1 )
    $find
    if
        execute
    then
    lego-init-hc (set-fbconfiguration (confused? @
    if
        sense-code (set-fbconfiguration
    then
    my-reset 0 =
    if
        display-width dup dup xdrint " width" attribute xdrint " linebytes"
        attribute xdrint " awidth" attribute display-height xdrint
        " height" attribute 8 xdrint " depth" attribute /vmsize xdrint
        " vmsize" attribute display-width display-height * 100000 <=
        if
            /vmsize 2 =
            if
                1 is dblbuf?
            else
                0 is dblbuf?
            then
        else
            0 is dblbuf?
        then
        dblbuf? xdrint " dblbuf" attribute
    then
;

: set-resolution-ext ( 08b2 )
    $find
    if
        execute
    then
    -1 is my-reset lego-init-hc (set-fbconfiguration (confused? @
    if
        sense-code (set-fbconfiguration
    then
    display-width display-height * 100000 <=
    if
        /vmsize 2 =
        if
            1 is dblbuf?
        else
            0 is dblbuf?
        then
    else
        0 is dblbuf?
    then
    0 is my-reset display-width data-space l! display-height data-space 4 +
    l! 8 data-space 8 + l! display-width data-space c + l! dblbuf?
    data-space 10 + l! acceleration data-space 14 + l!
;

: override ( 08b3 )
    sense-id-value =
    if
        set-resolution
    else
        2drop
    then
;

headers

: lego-reset-screen ( 08b4 )
    -1 is my-reset strap-value 94 thc! monitor-string set-resolution
    lego-video-on 0 is my-reset
;

: lego-draw-char ( 08b5 )
    fbc-busy-wait fb8-draw-character
;

: lego-toggle-cursor ( 08b6 )
    fbc-busy-wait fb8-toggle-cursor
;

: lego-invert-screen ( 08b7 )
    fbc-busy-wait fb8-invert-screen
;

: lego-insert-characters ( 08b8 )
    fbc-busy-wait fb8-insert-characters
;

: lego-delete-characters ( 08b9 )
    fbc-busy-wait fb8-delete-characters
;

: dfb-delete-lines ( 08ba )
    fbc-busy-wait fb8-delete-lines
;

: dfb-insert-lines ( 08bb )
    fbc-busy-wait fb8-insert-lines
;

: dfb-erase-screen ( 08bc )
    fbc-busy-wait fb8-erase-screen
;

external

: reinstall-console ( 08bd )
    display-width display-height over char-width / over char-height /
    fb8-install
    ['] lego-draw-logo is draw-logo
    ['] lego-blink-screen is blink-screen
    ['] lego-reset-screen is reset-screen
    ['] lego-draw-char is draw-character
    ['] lego-toggle-cursor is toggle-cursor
    ['] lego-invert-screen is invert-screen
    ['] lego-insert-characters is insert-characters
    ['] lego-delete-characters is delete-characters acceleration
    if
        ['] lego-delete-lines is delete-lines
        ['] lego-insert-lines is insert-lines
        ['] lego-erase-screen is erase-screen
    else
        ['] dfb-delete-lines is delete-lines
        ['] dfb-insert-lines is insert-lines
        ['] dfb-erase-screen is erase-screen
    then
;

headers

: get-size ( 08be )
    1234567 fb-addr l! 87654321 100000 fb-addr + l! fb-addr l@ 1234567 <>
    if
        1
    else
        fb-addr 100000 + l@ 87654321 <>
        if
            1
        else
            2
        then
    then
;

: init-duplo ( 08bf )
    200000 is /frame 1239 94 thc! fb-map get-size fb-unmap
    case
        1 of 1 is /vmsize 100000 is /frame 0 is dblbuf? 89 is bdrev
            ['] legoSR-sense is sense-code endof
        2 of 2 is /vmsize 1 is dblbuf? strap-value 1 or is strap-value 91
            is bdrev
            ['] duploSR-sense is sense-code endof
    endcase
;

: lego-install ( 08c0 )
    fb-map init-blit-reg default-font set-font fb-addr xdrint " address"
    attribute fb-addr is frame-buffer-adr my-args dup 0<>
    if
        set-resolution
    else
        2drop
    then
    reinstall-console lego-video-on
;

: lego-remove ( 08c1 )
    lego-video-off fb-unmap -1 is frame-buffer-adr
;

: legoh-probe ( 08c2 )
    my-address legosc-address ! fhc-thc-map init-duplo fbc-map alt-map
    strap-value 94 thc! fhc @ dup 18 >> f and 7 swap - is sense-id-value 14
    >> f and dup xdrint " chiprev" my-attribute is chip-rev 20 0
    do
        0 0 alt! 8000000 0 alt!
    loop
    " 74250000,64125000,216000000,135000000," xdrbytes
    " 118125000,108000000,94500000,54000000," xdrbytes xdr+
    " 47250000,81000000,84375000" xdrstring xdr+ xdrstring " oscillators"
    my-attribute data-space xdrint " global-data" attribute /frame xdrint
    " fbmapped" attribute strap-value 8 and dup is ppc 0=
    if
        4 is ppc
    then
    sense-code set-resolution lego-init-dac my-address my-space 1000000 reg
    5 0 intr
    ['] lego-install is-install
    ['] lego-remove is-remove
    ['] lego-selftest is-selftest
;

legoh-probe

end0
