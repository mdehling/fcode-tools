\ f3 03 c771 0000455c
fcode-version2 ( start4 )
hex

offset16

" SUNW,ffb" xdrstring " name" attribute " display" device-type

headers

: copyright ( 0800 )
    " Copyright (c) 1994-1997 Sun Microsystems, Inc."
;

: sccsid ( 0801 )
    " @(#)ffb2p.fth 2.9 98/07/14 "
;

: prt_sccsid ( 0802 )
    sccsid type copyright type
;

external

: .version_ffb ( 0803 )
    prt_sccsid
;

-1

headers

constant enable_hires? ( 0804 )
-1 value ffb_prom ( 0805 )
-1 value ffb_ramdac ( 0806 )
-1 value fbc_regs ( 0807 )
-1 value d_buff ( 0808 )
-1 value sun_pc ( 0809 )
-1 value ffb_fb ( 080a )
-1 value inter_reg ( 080b )
-1 value vres ( 080c )
-1 value hres ( 080d )
-1 value rt_id ( 080e )
0 value #size_cells_2? ( 080f )
0 value stereo_flag ( 0810 )
0 value hires_mode ( 0811 )
0 value lowres_mode ( 0812 )
0 value stereo_mode ( 0813 )
0 instance value sync_type ( 0814 )
-1 constant separate ( 0815 )
0 constant composite ( 0816 )
0 instance value polarity ( 0817 )
0 constant positive ( 0818 )
-1 constant negative ( 0819 )
-1 value portid ( 081a )
-1 value rd_strap_reg ( 081b )
0 value console_mode? ( 081c )
0 value timeout_checkpt ( 081d )
a value timer_delta ( 081e )
ff ff ff ff bljoin constant 32bit_mask ( 081f )

: ffb_map ( 0820 )
    my-address dup my-space 40000 " map-in" $call-parent is ffb_prom dup
    200000 + my-space 40000 " map-in" $call-parent is d_buff dup 400000 +
    my-space 1000 " map-in" $call-parent is ffb_ramdac dup 600000 +
    my-space 12000 " map-in" $call-parent is fbc_regs dup 1000000 +
    my-space 400000 " map-in" $call-parent is sun_pc dup 3000000 + my-space
    a00000 " map-in" $call-parent is ffb_fb drop
;

: map_interrupt_reg ( 0821 )
    my-address 610900 + my-space 4 " map-in" $call-parent is inter_reg
;

: ffb_unmap ( 0822 )
    ffb_fb a00000 " map-out" $call-parent -1 is ffb_fb sun_pc 400000
    " map-out" $call-parent -1 is sun_pc fbc_regs 12000 " map-out"
    $call-parent -1 is fbc_regs ffb_ramdac 1000 " map-out" $call-parent -1
    is ffb_ramdac d_buff 40000 " map-out" $call-parent -1 is d_buff
    ffb_prom 40000 " map-out" $call-parent -1 is ffb_prom
;

: check_clock_tick ( 0823 )
    dup get-msecs <>
;

: clock_tick ( 0824 )
    get-msecs
    begin
        check_clock_tick
    until
    drop
;

: set_timer_delta ( 0825 )
    clock_tick get-msecs clock_tick get-msecs swap - is timer_delta
;

: start_timeout ( 0826 )
    get-msecs + timer_delta + is timeout_checkpt
;

: check_timeout ( 0827 )
    get-msecs timeout_checkpt - 40000000 and 0=
;

: n->l ( 0828 )
    32bit_mask and
;

: wr_fbc ( 0829 )
    fbc_regs + rl!
;

: rd_fbc ( 082a )
    fbc_regs + rl@
;

: wait_rp_busy ( 082b )
    1388 start_timeout
    begin
        900 rd_fbc 3000000 and 0= check_timeout or
    until
;

: get_portid ( 082c )
    my-address my-space " upa-get-portid" $call-parent
;

: pub_portid ( 082d )
    ['] get_portid catch
    if
        my-space 1 >> 1f and
    then
    is portid portid xdrint " upa-portid" attribute
;

: sc_queue ( 082e )
    7 7 0 -1 -1 4 portid " upa-set-queue-sizes" $call-parent
;

: set_sc_queue ( 082f )
    ['] sc_queue catch
    if
        " Error in upa-set-queue-sizes for setting SC FIFO Depth" type cr
    then
;

: pub_console_props ( 0830 )
    my-self xdrint " ihandle" attribute sun_pc xdrint " address" attribute
;

: no_size_cells? ( 0831 )
    " #size-cells" get-inherited-attribute
    if
        0 is #size_cells_2?
    else
        xdrtoint 2 =
        if
            -1 is #size_cells_2?
        then
        2drop
    then
;

: encode_offset ( 0832 )
    my-address + my-space xdrphys xdr+
;

: encode_size ( 0833 )
    #size_cells_2?
    if
        >r 0 xdrint xdr+ r>
    then
    xdrint xdr+
;

: check_rp_stat ( 0834 )
    wait_rp_busy 900 rd_fbc dup 80000000 n->l and
    if
        " **** RP Queue Overflow!" type cr over
        if
            dup 3fffffff and 80000000 n->l or 900 wr_fbc
        then
    then
    dup 40000000 and
    if
        " **** Register Read Error!!!" type cr over
        if
            dup 3fffffff and 40000000 or 900 wr_fbc
        then
    then
    2drop
;

: get_rpq_free ( 0835 )
    900 rd_fbc fff and 9 - 0 max
;

: wait_rpq_free ( 0836 )
    1388 start_timeout
    begin
        get_rpq_free over >= check_timeout or
    until
    drop
;

: rd_monitor_id ( 0837 )
    d_buff 10 + dup rl@ drop rl@ 18 >> 7 and d_buff dup rl@ drop rl@ drop
;

: set_strap_reg ( 0838 )
    d_buff dup rb@ drop rb@ ff and is rd_strap_reg
;

: double_buffer? ( 0839 )
    rd_strap_reg 3 and 3 =
;

: using_double_buffering? ( 083a )
    double_buffer? hires_mode 0= and
;

: pub_ffb2_props ( 083b )
    rd_strap_reg xdrint " board_type" attribute rd_strap_reg e0 and 20 =
    if
        double_buffer?
        if
            " SUNW,501-4788" model
        else
            " SUNW,501-4789" model
        then
    else
        double_buffer?
        if
            " SUNW,501-4790" model
        else
            " SUNW,501-4795" model
        then
    then
    sccsid xdrstring " fcode_version" attribute
;

: halt_fbc ( 083c )
    0 10800 wr_fbc a ms
;

6000 constant RAMDAC_TIM_CRTL ( 083d )

: wr_dac_cf_ptr ( 083e )
    ffb_ramdac rl!
;

: rd_dac_cf_ptr ( 083f )
    ffb_ramdac rl@
;

: rd_dac_cf_data ( 0840 )
    ffb_ramdac 4 + rl@
;

: wr_dac_cf_data ( 0841 )
    ffb_ramdac 4 + rl!
;

: wr_dac ( 0842 )
    wr_dac_cf_ptr wr_dac_cf_data
;

: rd_dac ( 0843 )
    wr_dac_cf_ptr rd_dac_cf_data
;

: wid_combined_mode? ( 0844 )
    1001 rd_dac 30 and 0=
;

: set_x_plane ( 0845 )
    drop 1001 rd_dac 30 and
    case
        0 of ff endof
        10 of 0 endof
        20 of 0 endof
        0 swap
    endcase
;

: check_backfill? ( 0846 )
    1001 rd_dac 30 and 20 =
;

0 value chksum ( 0847 )
-1 value edid_error ( 0848 )
-1 value edid_match ( 0849 )
-1 value no_edid_blks ( 084a )
40 value delay_ct ( 084b )
create edid_hdr ( 084c )
h# 0 c, ff c, ff c, ff c, ff c, ff c, ff c, h# 0 c, 80
buffer: edid1 ( 084d )

: calibrate_delay_1 ( 084e )
    clock_tick 0 get-msecs
    begin
        8000 rd_dac drop swap 1 + swap check_clock_tick
    until
    drop 1 max
;

: calibrate_delay_2 ( 084f )
    clock_tick 0 get-msecs
    begin
        8000 rd_dac drop 8000 rd_dac drop swap 1 + swap check_clock_tick
    until
    drop 1 max
;

: calibrate_delay ( 0850 )
    f4240 timer_delta * dup calibrate_delay_2 / swap calibrate_delay_1 / -
    1 max 9c40 swap / 1 + 2 max is delay_ct
;

: do_delay ( 0851 )
    delay_ct 0
    do
        8000 rd_dac drop
    loop
;

: check_calibrated_delay ( 0852 )
    set_timer_delta calibrate_delay "    Nominal: " type dup base @ swap a
    base ! . base ! 19 * clock_tick get-msecs swap 0
    do
        do_delay
    loop
    get-msecs swap - "    Actual: " type base @ swap a base ! . base !
    "    [counter = " type delay_ct base @ swap a base ! . base ! " ]" type
;

: wr_ddc ( 0853 )
    8001 wr_dac
;

: rd_ddc ( 0854 )
    8002 rd_dac
;

: ddc_clock_stretch ( 0855 )
    0 >r fa
    begin
        do_delay 1 - dup 0= rd_ddc 1 and 0<> r> drop dup >r or
    until
    drop r> 0=
    if
        rd_ddc 2 and wr_ddc 1 throw
    then
;

: ddc_start ( 0856 )
    do_delay 2 wr_ddc do_delay 3 wr_ddc ddc_clock_stretch do_delay 1 wr_ddc
    do_delay 0 wr_ddc
;

: ddc_stop ( 0857 )
    do_delay 0 wr_ddc do_delay 1 wr_ddc ddc_clock_stretch do_delay 3 wr_ddc
    do_delay 2 wr_ddc 19 0
    do
        do_delay
    loop
;

: ddc_write_bit ( 0858 )
    if
        2
    else
        0
    then
    do_delay dup wr_ddc do_delay dup 1 or wr_ddc ddc_clock_stretch do_delay
    wr_ddc
;

: ddc_read_bit ( 0859 )
    do_delay 2 wr_ddc do_delay 3 wr_ddc ddc_clock_stretch do_delay rd_ddc 2
    and 2/ 2 wr_ddc
;

: ddc_write_byte ( 085a )
    8 0
    do
        dup 80 and ddc_write_bit 2*
    loop
    drop ddc_read_bit
    if
        2 throw
    then
;

: ddc_read_byte ( 085b )
    0 8 0
    do
        2* ddc_read_bit or
    loop
    0 ddc_write_bit
;

: init_ddc ( 085c )
    do_delay 1 wr_ddc do_delay 0 wr_ddc ddc_stop
;

: init_ddc_lines ( 085d )
    calibrate_delay
    ['] init_ddc catch drop
;

: send_edid_header ( 085e )
    9 0
    do
        ddc_stop
    loop
    ddc_start a0 ddc_write_byte h# 0 ddc_write_byte ddc_stop
;

: get_chksum ( 085f )
    chksum ff and
;

: verify_edid ( 0860 )
    edid1 edid_hdr 8 comp 0= get_chksum 0= and
;

: rd_edid ( 0861 )
    send_edid_header 0 is chksum ddc_start a1 ddc_write_byte 80 0
    do
        ddc_read_byte dup edid1 i + c! chksum + is chksum
    loop
    ddc_stop verify_edid 0=
    if
        3 throw
    then
;

: rd_blk ( 0862 )
    3
    begin
        ['] rd_edid catch dup is edid_error 0= swap 1 - tuck 0= or
    until
    drop
;

: chk_blk_rd ( 0863 )
    edid1 80 0
    do
        dup i + c@ .
    loop
    drop
;

: get_est_id ( 0864 )
    edid1 23 + dup c@ 8 << swap 1 + c@ or
;

: get_std_id ( 0865 )
    2* edid1 + 26 + dup c@ 8 << swap 1 + c@ or
;

: parse_established_timings ( 0866 )
    get_est_id 204f and dup
    if
        0 is edid_match dup 43 and
        if
            dup 1 and
            if
                18 is rt_id
            else
                dup 2 and
                if
                    10 is rt_id
                else
                    17 is rt_id
                then
            then
        else
            dup 4 and
            if
                7 is rt_id
            else
                dup 8 and
                if
                    6 is rt_id
                else
                    f is rt_id
                then
            then
        then
    then
    drop
;

: deter_dbz_rt_id ( 0867 )
    0
    begin
        dup is edid_match dup 1 + swap get_std_id
        case
            3140 of f is rt_id -1 endof
            454f of 17 is rt_id -1 endof
            5974 of 9 is rt_id -1 endof
            6140 of 6 is rt_id -1 endof
            614a of 7 is rt_id -1 endof
            614f of 10 is rt_id -1 endof
            7186 of 2 is rt_id -1 endof
            7190 of 3 is rt_id -1 endof
            8180 of 12 is rt_id -1 endof
            8187 of 4 is rt_id -1 endof
            818f of 18 is rt_id -1 endof
            8190 of 5 is rt_id -1 endof
            8199 of 19 is rt_id -1 endof
            81d0 of 11 is rt_id -1 endof
            95d0 of 13 is rt_id -1 endof
            a950 of d is rt_id -1 endof
            a9c6 of 14 is rt_id -1 endof
            a9d0 of 15 is rt_id -1 endof
            a94f of 1a is rt_id -1 endof
            d1ca of 16 is rt_id -1 endof
            d1cc of e is rt_id -1 endof
            0 swap -1 is edid_match
        endcase
        over 8 = or
    until
    drop -1 edid_match =
    if
        parse_established_timings
    then
;

: deter_sb_rt_id ( 0868 )
    0
    begin
        dup is edid_match dup 1 + swap get_std_id
        case
            3140 of f is rt_id -1 endof
            454f of 17 is rt_id -1 endof
            5974 of 9 is rt_id -1 endof
            6140 of 6 is rt_id -1 endof
            614a of 7 is rt_id -1 endof
            614f of 10 is rt_id -1 endof
            7186 of 2 is rt_id -1 endof
            7190 of 3 is rt_id -1 endof
            8180 of 12 is rt_id -1 endof
            8187 of 4 is rt_id -1 endof
            818f of 18 is rt_id -1 endof
            8190 of 5 is rt_id -1 endof
            8199 of 19 is rt_id -1 endof
            81d0 of 11 is rt_id -1 endof
            0 swap -1 is edid_match
        endcase
        over 8 = or
    until
    drop -1 edid_match =
    if
        parse_established_timings
    then
;

: determine_no_blks ( 0869 )
    edid1 7e + c@ 1 + is no_edid_blks edid_error
    if
        0 is no_edid_blks
    then
;

: pub_edid_#blks ( 086a )
    no_edid_blks ff and xdrint " no_edid_blks" attribute
;

: pub_edid_data ( 086b )
    edid1 80 xdrbytes " edid_data" attribute
;

: set_edid_mon ( 086c )
    edid_error 0=
    if
        double_buffer? enable_hires? and
        if
            deter_dbz_rt_id
        else
            deter_sb_rt_id
        then
    then
;

: rd_edid ( 086d )
    init_ddc_lines rd_blk determine_no_blks
;

external

: ffb_do_edid ( 086e )
    rd_edid pub_edid_#blks pub_edid_data
;

headers

: id_conv_rt ( 086f )
    case
        0 of 1 is rt_id endof
        1 of 2 is rt_id endof
        2 of 5 is rt_id endof
        3 of 2 is rt_id endof
        4 of 4 is rt_id endof
        5 of 6 is rt_id endof
        6 of 3 is rt_id endof
        7 of 2 is rt_id endof
        3 is rt_id
    endcase
;

: set_rt_id ( 0870 )
    rd_monitor_id id_conv_rt
;

: read_eeprom_opt ( 0871 )
    my-args 0<>
    if
        dup " r1024x768x77" comp 0=
        if
            1 is rt_id
        then
        dup " r1152x900x66" comp 0=
        if
            2 is rt_id
        then
        dup " r1152x900x76" comp 0=
        if
            3 is rt_id
        then
        dup " r1280x1024x67" comp 0=
        if
            4 is rt_id
        then
        dup " r1280x1024x76" comp 0=
        if
            5 is rt_id
        then
        dup " r1024x768x60" comp 0=
        if
            6 is rt_id
        then
        dup " r1024x768x70" comp 0=
        if
            7 is rt_id
        then
        dup " r1024x800x84" comp 0=
        if
            8 is rt_id
        then
        dup " r640x480x60" comp 0=
        if
            f is rt_id
        then
        dup " r1024x768x75" comp 0=
        if
            10 is rt_id
        then
        dup " r1280x800x76" comp 0=
        if
            11 is rt_id
        then
        dup " r1280x1024x60" comp 0=
        if
            12 is rt_id
        then
        dup " r800x600x75" comp 0=
        if
            17 is rt_id
        then
        dup " r1280x1024x75" comp 0=
        if
            18 is rt_id
        then
        dup " r1280x1024x85" comp 0=
        if
            19 is rt_id
        then
        enable_hires? double_buffer? and
        if
            dup " r1600x1280x76" comp 0=
            if
                d is rt_id
            then
            dup " r1920x1080x72" comp 0=
            if
                e is rt_id
            then
            dup " r1440x900x76" comp 0=
            if
                13 is rt_id
            then
            dup " r1600x1000x66" comp 0=
            if
                14 is rt_id
            then
            dup " r1600x1000x76" comp 0=
            if
                15 is rt_id
            then
            dup " r1920x1200x70" comp 0=
            if
                16 is rt_id
            then
            dup " r1600x1200x75" comp 0=
            if
                1a is rt_id
            then
        then
        dup " r960x680x112s" comp 0=
        if
            9 is rt_id
        then
        dup " r960x680x108s" comp 0=
        if
            a is rt_id
        then
        dup " r640x480x60i" comp 0=
        if
            b is rt_id
        then
        dup " r768x575x50i" comp 0=
        if
            c is rt_id
        then
    then
    drop
;

: set_mon_params ( 0872 )
    0 is hires_mode 0 is lowres_mode 0 is stereo_mode composite is
    sync_type positive is polarity rt_id
    case
        1 of 400 is hres 300 is vres endof
        2 of 480 is hres 384 is vres endof
        3 of 480 is hres 384 is vres endof
        4 of 500 is hres 400 is vres endof
        5 of 500 is hres 400 is vres endof
        6 of 400 is hres 300 is vres separate is sync_type negative is
            polarity endof
        7 of 400 is hres 300 is vres separate is sync_type negative is
            polarity endof
        8 of 400 is hres 320 is vres endof
        9 of 3c0 is hres 2a8 is vres 1 is stereo_mode endof
        a of 3c0 is hres 2a8 is vres 1 is stereo_mode endof
        b of 280 is hres 1e0 is vres 1 is lowres_mode endof
        c of 300 is hres 23f is vres 1 is lowres_mode endof
        d of 640 is hres 500 is vres 1 is hires_mode endof
        e of 780 is hres 438 is vres 1 is hires_mode endof
        f of 280 is hres 1e0 is vres separate is sync_type negative is
            polarity endof
        10 of 400 is hres 300 is vres separate is sync_type endof
        11 of 500 is hres 320 is vres endof
        12 of 500 is hres 400 is vres separate is sync_type endof
        13 of 5a0 is hres 384 is vres 1 is hires_mode endof
        14 of 640 is hres 3e8 is vres 1 is hires_mode endof
        15 of 640 is hres 3e8 is vres 1 is hires_mode endof
        16 of 780 is hres 4b0 is vres 1 is hires_mode endof
        17 of 320 is hres 258 is vres separate is sync_type endof
        18 of 500 is hres 400 is vres separate is sync_type endof
        19 of 500 is hres 400 is vres separate is sync_type endof
        1a of 640 is hres 4b0 is vres 1 is hires_mode separate is sync_type
        endof
        480 is hres 384 is vres
    endcase
;

: pub_mon_freq ( 0873 )
    rt_id
    case
        1 of 4d endof
        2 of 42 endof
        3 of 4c endof
        4 of 43 endof
        5 of 4c endof
        6 of 3c endof
        7 of 46 endof
        8 of 54 endof
        9 of 70 endof
        a of 6c endof
        b of 3c endof
        c of 32 endof
        d of 4c endof
        e of 48 endof
        f of 3c endof
        10 of 4b endof
        11 of 4c endof
        12 of 3c endof
        13 of 4c endof
        14 of 42 endof
        15 of 4c endof
        16 of 46 endof
        17 of 4b endof
        18 of 4b endof
        19 of 55 endof
        1a of 4b endof
        4c swap
    endcase
    xdrint " v_freq" attribute
;

: pub_mon_res ( 0874 )
    hres xdrint " width" attribute vres xdrint " height" attribute
;

: pub_mon_mode ( 0875 )
    0 hires_mode
    if
        drop 2
    then
    stereo_mode
    if
        drop 1
    then
    xdrint " monitor_mode" attribute
;

: pub_mon_attribs ( 0876 )
    pub_mon_res pub_mon_freq pub_mon_mode
;

: r640x480x60i ( 0877 )
    206 b d 37 b4 c2 1c b8 3b a5 20c 5 205 25
;

: r768x575x50i ( 0878 )
    26b 9 10 48 de e9 22 e2 4c c8 270 4 26a 2b
;

: r960x680x112s ( 0879 )
    0 0 0 7f 25f 26f 17 263 83 257 2d1 7 2cf 27
;

: r960x680x108s ( 087a )
    0 0 0 7b 25b 27f 1f 25f 7f 25f 2d0 3 2cd 25
;

: r1024x768x77 ( 087b )
    0 0 0 93 293 2a7 1f 297 97 267 324 3 322 22
;

: r1024x768x60 ( 087c )
    0 0 0 8f 28f 29f 43 293 93 25b 325 5 322 22
;

: r1024x768x70 ( 087d )
    0 0 0 87 287 297 43 28b 8b 253 325 5 322 22
;

: r1024x800x84 ( 087e )
    0 0 0 87 287 293 3f 28b 8b 27d 344 3 342 22
;

: r1152x900x66 ( 087f )
    0 0 0 a3 2e3 2fb 3f 2e7 a7 2bb 3a8 3 3a6 22
;

: r1152x900x76 ( 0880 )
    0 0 0 9b 2db 2ef 3f 2df 9f 2af 3ae 7 3ac 28
;

: r1280x1024x67 ( 0881 )
    0 0 0 a3 323 32f 37 327 a7 2ff 42a 7 428 28
;

: r1280x1024x76 ( 0882 )
    0 0 0 ab 32b 33f 1f 32f af 31f 429 7 427 27
;

: r1600x1280x76 ( 0883 )
    0 0 0 77 207 211 35 20b 7b 1db 53b 7 539 39
;

: r1920x1080x72 ( 0884 )
    0 0 0 8f 26f 27f 35 273 93 249 493 2 490 58
;

: r640x480x60 ( 0885 )
    0 0 0 43 183 18f 2f 187 47 15f 20c 1 202 22
;

: r1024x768x75 ( 0886 )
    0 0 0 83 283 28f 2f 287 87 25f 31f 2 31e 1e
;

: r1280x800x76 ( 0887 )
    0 0 0 82 302 310 38 306 86 2d7 34d 6 34a 2a
;

: r1280x1024x60 ( 0888 )
    0 0 0 af 32f 34b 37 333 b3 313 429 2 428 28
;

: r1440x900x76 ( 0889 )
    0 0 0 5f 1c7 1d5 27 1cb 63 1ad 3af 2 3ad 29
;

: r1600x1000x66 ( 088a )
    0 0 0 4d 1dd 1eb 21 1e1 51 1c9 40e 4 40c 24
;

: r1600x1000x76 ( 088b )
    0 0 0 77 207 213 35 20b 7b 1dd 41a 2 418 30
;

: r1920x1200x70 ( 088c )
    0 0 0 8a 26a 274 38 26e 8e 23b 4d7 2 4d6 26
;

: r800x600x75 ( 088d )
    0 0 0 73 203 20f 27 207 77 1e7 270 2 26f 17
;

: r1280x1024x75 ( 088e )
    0 0 0 bf 33f 34b 47 343 c3 303 429 2 428 28
;

: r1280x1024x85 ( 088f )
    0 0 0 bb 33b 35f 4f 33f bf 30f 42f 2 42e 2e
;

: r1600x1200x75 ( 0890 )
    0 0 0 77 207 21b 2f 20b 7b 1eb 4e1 2 4e0 30
;

: init_video_timing_regs ( 0891 )
    rt_id
    case
        1 of r1024x768x77 endof
        2 of r1152x900x66 endof
        3 of r1152x900x76 endof
        4 of r1280x1024x67 endof
        5 of r1280x1024x76 endof
        6 of r1024x768x60 endof
        7 of r1024x768x70 endof
        8 of r1024x800x84 endof
        9 of r960x680x112s endof
        a of r960x680x108s endof
        b of r640x480x60i endof
        c of r768x575x50i endof
        d of r1600x1280x76 endof
        e of r1920x1080x72 endof
        f of r640x480x60 endof
        10 of r1024x768x75 endof
        11 of r1280x800x76 endof
        12 of r1280x1024x60 endof
        13 of r1440x900x76 endof
        14 of r1600x1000x66 endof
        15 of r1600x1000x76 endof
        16 of r1920x1200x70 endof
        17 of r800x600x75 endof
        18 of r1280x1024x75 endof
        19 of r1280x1024x85 endof
        1a of r1600x1200x75 endof
        drop r1152x900x76 0
    endcase
    6001 wr_dac_cf_ptr e 0
    do
        wr_dac_cf_data
    loop
;

: wait_vertical_blank ( 0892 )
    20000000
    begin
        1 - dup 0= 600f rd_dac 0= or
    until
    drop
;

: halt_sync_gen ( 0893 )
    RAMDAC_TIM_CRTL rd_dac 2 and
    if
        wait_vertical_blank 31 RAMDAC_TIM_CRTL wr_dac 1 ms halt_fbc
    then
;

: start_sync_gen ( 0894 )
    22 sync_type
    case
        separate of 8 or endof
        swap lowres_mode
        if
            40 or
        else
            10 or
        then
        swap
    endcase
    RAMDAC_TIM_CRTL wr_dac 64 ms
;

: pclk219 ( 0895 )
    41 4 0
;

: pclk216 ( 0896 )
    50 5 0
;

: pclk203 ( 0897 )
    3c 4 0
;

: pclk170 ( 0898 )
    3f 5 0
;

: pclk157 ( 0899 )
    46 6 0
;

: pclk135 ( 089a )
    32 5 0
;

: pclk117 ( 089b )
    34 6 0
;

: pclk108 ( 089c )
    28 5 0
;

: pclk101 ( 089d )
    2d 6 0
;

: pclk99 ( 089e )
    25 5 0
;

: pclk94 ( 089f )
    46 5 1
;

: pclk78 ( 08a0 )
    46 6 1
;

: pclk84 ( 08a1 )
    4b 6 1
;

: pclk75 ( 08a2 )
    4e 7 1
;

: pclk64 ( 08a3 )
    30 5 1
;

: pclk49 ( 08a4 )
    42 9 1
;

: pclk25 ( 08a5 )
    43 9 2
;

: pclk14 ( 08a6 )
    34 6 3
;

: pclk12 ( 08a7 )
    50 b 3
;

: pll_val ( 08a8 )
    b << swap 7 << or or 4000 or
;

: program_ramdac_pll ( 08a9 )
    rt_id
    case
        1 of pclk84 endof
        2 of pclk94 endof
        3 of pclk108 endof
        4 of pclk117 endof
        5 of pclk135 endof
        6 of pclk64 endof
        7 of pclk75 endof
        8 of pclk94 endof
        9 of pclk101 endof
        a of pclk99 endof
        b of pclk12 endof
        c of pclk14 endof
        d of pclk216 endof
        e of pclk216 endof
        f of pclk25 endof
        10 of pclk78 endof
        11 of pclk101 endof
        12 of pclk108 endof
        13 of pclk135 endof
        14 of pclk135 endof
        15 of pclk170 endof
        16 of pclk219 endof
        17 of pclk49 endof
        18 of pclk135 endof
        19 of pclk157 endof
        1a of pclk203 endof
        drop pclk108 0
    endcase
    pll_val 0 wr_dac
;

: ffb_video_on ( 08aa )
    wait_vertical_blank RAMDAC_TIM_CRTL rd_dac 1 or RAMDAC_TIM_CRTL wr_dac
;

: ffb_video_off ( 08ab )
    wait_vertical_blank RAMDAC_TIM_CRTL rd_dac fffffffe n->l and
    RAMDAC_TIM_CRTL wr_dac
;

: ffb-blink-screen ( 08ac )
    ffb_video_off 100 ms ffb_video_on
;

: do_video_wait ( 08ad )
    12c ms c
    begin
        ['] send_edid_header catch 0<> swap 1 - tuck 0<> and
    while
        64 ms
    repeat
    drop
;

: do_short_wait ( 08ae )
    64 ms
;

: rd_dac_rev_reg ( 08af )
    1001 rd_dac
;

: ld_dac_internal_regs ( 08b0 )
    hires_mode
    if
        h# 3
    else
        h# 2
    then
    1000 wr_dac sync_type
    case
        composite of 80 endof
        separate of polarity
            if
                0
            else
                100
            then
        endof
    endcase
    5001 wr_dac using_double_buffering?
    if
        2c
    else
        8
    then
    1001 wr_dac wid_combined_mode?
    if
        e0 3151 wr_dac ff 3152 wr_dac 1f 3153 wr_dac
    else
        33f 3153 wr_dac
    then
    100 8 ffb_ramdac + rl! 3 c ffb_ramdac + rl! 104 8 ffb_ramdac + rl!
    8fc08fc0 n->l c ffb_ramdac + rl!
;

: load_clut ( 08b1 )
    2000 wr_dac_cf_ptr 100 0
    do
        i dup 8 << swap dup 10 << swap or or dup ffffff =
        if
            drop 0
        then
        i 0=
        if
            drop ffffff
        then
        wr_dac_cf_data
    loop
;

: load_wlut ( 08b2 )
    wid_combined_mode?
    if
        500
    else
        100
    then
    3100 wr_dac 4000 3200 wr_dac wid_combined_mode?
    if
        3201 wr_dac_cf_ptr 3f 0
        do
            4000 wr_dac_cf_data
        loop
    then
    2 3150 wr_dac
;

: init_ramdac ( 08b3 )
    set_mon_params halt_sync_gen program_ramdac_pll init_video_timing_regs
    ld_dac_internal_regs load_wlut load_clut
;

: init_gpclk ( 08b4 )
    3e 5 1 pll_val 1 wr_dac
;

: init_raw_stencil_patch ( 08b5 )
    using_double_buffering?
    if
        wait_rp_busy 254 rd_fbc dup 1fffffff and 80000000 n->l or 254
        wr_fbc swap 80000 or 2cc wr_fbc n->l 254 wr_fbc
    else
        drop
    then
;

: init_3dram_raw ( 08b6 )
    5 wait_rpq_free e00875aa n->l 254 wr_fbc 0 2c0 wr_fbc 0 2c4 wr_fbc 0
    2c8 wr_fbc 33300000 2cc wr_fbc 33300000 init_raw_stencil_patch 2
    wait_rpq_free using_double_buffering?
    if
        101
    else
        0
    then
    2d8 wr_fbc 0 2dc wr_fbc
;

: init_fbc_conf0 ( 08b7 )
    rt_id
    case
        1 of c7b4002b endof
        2 of c83c002b endof
        3 of c93c002b endof
        4 of c9c0002b endof
        5 of adc0002b endof
        6 of c634062f endof
        7 of c0b4002b endof
        8 of ad34002b endof
        9 of adb00013 endof
        a of b0300013 endof
        b of ce2003e7 endof
        c of ca2804a7 endof
        d of c728003b endof
        e of ca30003b endof
        f of f32003ef endof
        10 of d234002b endof
        11 of f740002b endof
        12 of fd4003ef endof
        13 of ef24003b endof
        14 of eaa8003b endof
        15 of f528003b endof
        16 of de30003b endof
        17 of fca8002b endof
        18 of fd40002b endof
        19 of f8c0002b endof
        1a of fc28003b endof
        c93c002b swap
    endcase
    10270 wr_fbc
;

: init_fbc_regs ( 08b8 )
    4 wait_rpq_free init_fbc_conf0 133600 10274 wr_fbc lowres_mode
    if
        2403520 10278 wr_fbc
    else
        2402520 10278 wr_fbc
    then
    double_buffer?
    if
        800
    else
        0
    then
    1027c wr_fbc a ms init_3dram_raw a ms 5 wait_rpq_free
    using_double_buffering?
    if
        202c75aa
    else
        200875aa
    then
    254 wr_fbc 83838383 n->l 258 wr_fbc 80808080 n->l 25c wr_fbc 0 10280
    wr_fbc 0 218 wr_fbc
;

: init_pp_regs ( 08b9 )
    b wait_rpq_free 869baa 200 wr_fbc 0 204 wr_fbc 0 220 wr_fbc 3ff07ff 224
    wr_fbc ffffff 290 wr_fbc ff 294 wr_fbc ff 35c wr_fbc 0 330 wr_fbc 0 334
    wr_fbc f0000000 n->l 338 wr_fbc 33300000 33c wr_fbc 33300000
    init_raw_stencil_patch
;

ff000000 n->l value crtl_byte ( 08ba )
4fe0 /l* constant logo_offset ( 08bb )
30 /l* buffer: su_regs ( 08bc )

: set_pixel_x ( 08bd )
    0 set_x_plane 18 <<
;

: check_current_mode ( 08be )
    10270 rd_fbc 30 and 10 =
    if
        1
    else
        0
    then
;

: set_fb_ctrl ( 08bf )
    double_buffer?
    if
        600875aa
    else
        200875aa
    then
    254 wr_fbc
;

: set_vert_regs ( 08c0 )
    6 wait_rpq_free 60 wr_fbc 64 wr_fbc 68 wr_fbc 6c wr_fbc 70 wr_fbc 74
    wr_fbc
;

: init_assoc_regs ( 08c1 )
    6 wait_rpq_free 869baf 200 wr_fbc 858585 258 wr_fbc set_fb_ctrl
    80808080 25c wr_fbc b 300 wr_fbc 0 218 wr_fbc
;

: set_rect_regs ( 08c2 )
    4 wait_rpq_free 60 wr_fbc 64 wr_fbc 70 wr_fbc 74 wr_fbc
;

: init_assoc_rect_fill_regs ( 08c3 )
    7 wait_rpq_free 869baf 200 wr_fbc crtl_byte or 208 wr_fbc set_fb_ctrl 8
    300 wr_fbc 80808080 25c wr_fbc 838383 258 wr_fbc 0 218 wr_fbc
;

: init_assoc_rect_inv_regs ( 08c4 )
    6 wait_rpq_free 869baf 200 wr_fbc 85858a 258 wr_fbc set_fb_ctrl
    80808080 25c wr_fbc 8 300 wr_fbc 0 218 wr_fbc
;

: init_assoc_rect_backfill_regs ( 08c5 )
    7 wait_rpq_free 869baf 200 wr_fbc crtl_byte 208 wr_fbc 4008b595 254
    wr_fbc 8 300 wr_fbc 80808080 25c wr_fbc 838383 258 wr_fbc 0 218 wr_fbc
;

: save_ffb ( 08c6 )
    wait_rp_busy su_regs 100 fbc_regs + 20 0
    do
        dup rl@ 2 pick rl! la1+ swap la1+ swap
    loop
    drop 258 rd_fbc over rl! la1+ 200 rd_fbc over rl! la1+ 254 rd_fbc over
    rl! la1+ 25c rd_fbc over rl! la1+ 300 rd_fbc over rl! la1+ 208 rd_fbc
    over rl! la1+ 218 rd_fbc over rl! la1+ drop
;

: restore_ffb ( 08c7 )
    wait_rp_busy su_regs 20 wait_rpq_free 100 fbc_regs + 20 0
    do
        over rl@ over rl! la1+ swap la1+ swap
    loop
    drop 7 wait_rpq_free dup rl@ 258 wr_fbc la1+ dup rl@ 200 wr_fbc la1+
    dup rl@ 254 wr_fbc la1+ dup rl@ 25c wr_fbc la1+ dup rl@ 300 wr_fbc la1+
    dup rl@ 208 wr_fbc la1+ dup rl@ 218 wr_fbc la1+ drop
;

0 value stereo_flag ( 08c8 )
-1 value prom_adr ( 08c9 )
-1 value logo_wid ( 08ca )
-1 value logo_ht ( 08cb )
0 value adr ( 08cc )

: init_fb32_term ( 08cd )
    stereo_mode is stereo_flag
;

: ffb_scrn_params ( 08ce )
    800 vres hres char-width / vres char-height /
;

external

: ffb_change_scrn_params ( 08cf )
    is vres is hres is screen-height is window-top is window-left is
    #columns is #lines
    case
        1 of 1 is stereo_mode 0 is hires_mode 0 is lowres_mode endof
        2 of enable_hires?
            if
                1 is hires_mode
            else
                0 is hires_mode
            then
            0 is stereo_mode 0 is lowres_mode endof
        3 of 1 is lowres_mode 0 is hires_mode 0 is stereo_mode endof
        0 is lowres_mode 0 is stereo_mode 0 is hires_mode
    endcase
    -1 is stereo_flag
;

headers

: change_to_stereo ( 08d0 )
    45 is #columns 1c is #lines 3c0 is hres 2a8 is vres 20 is window-top 42
    is window-left vres is screen-height -1 is stereo_flag
;

: chk_stereo? ( 08d1 )
    check_current_mode 1 =
;

: set_stereo ( 08d2 )
    stereo_flag 0=
    if
        change_to_stereo
    then
;

: rd_crtl_byte ( 08d3 )
    set_pixel_x is crtl_byte
;

: bytes/line ( 08d4 )
    screen-width /l*
;

: cal_x_pixel ( 08d5 )
    char-width * window-left +
;

: cal_y_pixel ( 08d6 )
    char-height * window-top +
;

: screen-adr ( 08d7 )
    cal_y_pixel bytes/line * swap cal_x_pixel /l* + frame-buffer-adr +
;

: cursor-adr ( 08d8 )
    column# line# screen-adr
;

: column-adr ( 08d9 )
    line# screen-adr
;

: line-adr ( 08da )
    0 swap screen-adr
;

: conv_to_adr ( 08db )
    bytes/line * swap /l* + frame-buffer-adr +
;

: wr_font_pat ( 08dc )
    char-width 0
    ?do
        dup 8000 and
        if
            0
        else
            ffffff
        then
        crtl_byte or 2 pick i /l* + rl! 1 <<
    loop
    drop
;

: wr_inv_font_pat ( 08dd )
    char-width 0
    ?do
        dup 8000 and
        if
            ffffff
        else
            0
        then
        crtl_byte or 2 pick i /l* + rl! 1 <<
    loop
    drop
;

: get_font_pat ( 08de )
    dup c@ 8 << swap ca1+ dup c@ rot or swap ca1+
;

: backfill_character ( 08df )
    check_backfill?
    if
        wait_rp_busy save_ffb init_assoc_rect_backfill_regs char-width
        char-height column# cal_x_pixel line# cal_y_pixel set_rect_regs
        wait_rp_busy restore_ffb
    then
;

: fb32-draw-character ( 08e0 )
    rd_crtl_byte backfill_character cursor-adr swap >font char-height 0
    ?do
        get_font_pat -rot inverse?
        if
            wr_inv_font_pat
        else
            wr_font_pat
        then
        bytes/line + swap
    loop
    2drop
;

: background-color ( 08e1 )
    inverse-screen?
    if
        0
    else
        ffffff
    then
    crtl_byte or
;

: fb-fill ( 08e2 )
    swap rot 0
    ?do
        2dup rl! la1+
    loop
    2drop
;

: prep_col_nos ( 08e3 )
    #columns column# - min dup column# + column#
;

: move-chars ( 08e4 )
    2dup max #columns swap - char-width * /l* -rot swap column-adr swap
    column-adr char-height 0
    ?do
        2 pick 2 pick 2 pick rot move swap bytes/line + swap bytes/line +
    loop
    2drop drop
;

: erase-chars ( 08e5 )
    swap char-width * swap column-adr char-height 0
    ?do
        2dup background-color fb-fill bytes/line +
    loop
    2drop
;

: backfill_line ( 08e6 )
    check_backfill?
    if
        wait_rp_busy save_ffb init_assoc_rect_backfill_regs char-width
        #columns * char-height window-left line# cal_y_pixel set_rect_regs
        wait_rp_busy restore_ffb
    then
;

: fb32-insert-characters ( 08e7 )
    rd_crtl_byte backfill_line #columns column# - min dup column# + column#
    swap move-chars column# erase-chars
;

: fb32-delete-characters ( 08e8 )
    rd_crtl_byte backfill_line #columns column# - min dup column# + column#
    move-chars #columns over - erase-chars
;

: fb32-cursor ( 08e9 )
    0
    ?do
        2dup 0
        ?do
            dup rl@ ffffff xor over rl! la1+
        loop
        drop swap bytes/line + swap
    loop
    2drop
;

: fb32-toggle-cursor ( 08ea )
    rd_crtl_byte cursor-adr char-width char-height fb32-cursor
;

: init_assoc_rect_regs ( 08eb )
    inverse-screen?
    if
        h# 0
    else
        ffffff
    then
    init_assoc_rect_fill_regs
;

: delete_start_line ( 08ec )
    line# + #lines min
;

: insert_start_line ( 08ed )
    line# + #lines min
;

: cal_wid_ht ( 08ee )
    #columns char-width * #lines rot - char-height *
;

: cal_src ( 08ef )
    line# + #lines min cal_y_pixel 0 cal_x_pixel swap
;

: cur_line ( 08f0 )
    0 cal_x_pixel line# cal_y_pixel
;

: cal_insert_dst ( 08f1 )
    0 cal_x_pixel swap line# + #lines min cal_y_pixel
;

: delete_scroll_vals ( 08f2 )
    dup delete_start_line cal_wid_ht rot cur_line rot cal_src
;

: insert_scroll_vals ( 08f3 )
    dup insert_start_line cal_wid_ht rot cal_src cur_line
;

: cal_blk_dst ( 08f4 )
    0 cal_x_pixel #lines rot - 0 max cal_y_pixel
;

: cal_blk_insert_dst ( 08f5 )
    0 cal_x_pixel line# cal_y_pixel
;

: cal_blk_wid_ht ( 08f6 )
    #columns char-width * swap #lines swap - 0 max #lines swap -
    char-height *
;

: cal_insert_blk_wid_ht ( 08f7 )
    #columns char-width * swap char-height *
;

: del_erase_blk ( 08f8 )
    dup cal_blk_wid_ht rot cal_blk_dst
;

: clear_lines ( 08f9 )
    conv_to_adr -rot 0
    ?do
        2dup 0
        ?do
            inverse?
            if
                h# 0
            else
                ffffff
            then
            crtl_byte or over rl! la1+
        loop
        drop swap bytes/line + swap
    loop
    2drop
;

: insert_erase_blk ( 08fa )
    cal_insert_blk_wid_ht cal_blk_insert_dst
;

: del_pixel_scroll ( 08fb )
    conv_to_adr -rot conv_to_adr swap 2swap 0
    ?do
        2 pick 2 pick 2 pick 0
        ?do
            dup rl@ 2 pick rl! la1+ swap la1+ swap
        loop
        2drop -rot bytes/line + swap bytes/line + swap rot
    loop
    drop 2drop
;

: pixel_adr ( 08fc )
    4 pick + conv_to_adr -rot 3 pick + conv_to_adr swap
;

: mv_lines_down ( 08fd )
    0
    ?do
        2 pick 2 pick 2 pick 0
        ?do
            dup rl@ 2 pick rl! la1+ swap la1+ swap
        loop
        2drop -rot bytes/line - swap bytes/line - swap rot
    loop
    drop 2drop
;

: insert_pixel_scroll ( 08fe )
    pixel_adr 2swap
;

: fb32-delete-lines ( 0900 )
    wait_rp_busy chk_stereo?
    if
        set_stereo
    then
    rd_crtl_byte save_ffb init_assoc_regs dup delete_scroll_vals
    set_vert_regs wait_rp_busy init_assoc_rect_regs del_erase_blk
    set_rect_regs wait_rp_busy restore_ffb
;

: fb32-insert-lines ( 0901 )
    wait_rp_busy rd_crtl_byte save_ffb init_assoc_regs dup
    insert_scroll_vals set_vert_regs wait_rp_busy init_assoc_rect_regs
    insert_erase_blk set_rect_regs wait_rp_busy restore_ffb
;

: cal_pix_src ( 0902 )
    #columns swap - 0 max cal_x_pixel line# cal_y_pixel
;

: cal_move_src_dst ( 0903 )
    column# + #columns min line# screen-adr cursor-adr swap
;

: cp_char ( 0904 )
    dup rl@ 2 pick rl!
;

: move_chars ( 0905 )
    char-height 0
    ?do
        2dup 4 pick char-width * 0
        ?do
            cp_char la1+ swap la1+ swap
        loop
        2drop bytes/line + swap bytes/line + swap
    loop
    2drop
;

: ffb-erase-screen ( 0906 )
    wait_rp_busy rd_crtl_byte save_ffb init_assoc_rect_regs hres vres 0 0
    set_rect_regs wait_rp_busy restore_ffb
;

: ffb-black-screen ( 0907 )
    wait_rp_busy rd_crtl_byte save_ffb h# 0 init_assoc_rect_fill_regs hres
    vres 0 0 set_rect_regs wait_rp_busy restore_ffb
;

: ffb-white-screen ( 0908 )
    wait_rp_busy rd_crtl_byte save_ffb ffffff init_assoc_rect_fill_regs
    hres vres 0 0 set_rect_regs wait_rp_busy restore_ffb
;

: fb32-invert-screen ( 0909 )
    wait_rp_busy rd_crtl_byte save_ffb init_assoc_rect_inv_regs hres vres 0
    0 set_rect_regs wait_rp_busy restore_ffb
;

: get_16bits_logo ( 090a )
    dup c@ 8 << swap ca1+ c@ or
;

: cal_logo_val ( 090b )
    8000 and inverse? xor
    if
        h# 0
    else
        ffffff
    then
    crtl_byte or
;

: fb32-draw-bits ( 090c )
    swap get_16bits_logo swap 10 0
    do
        over cal_logo_val over rl! la1+ swap 1 << swap
    loop
    nip
;

: draw-logo-line ( 090d )
    2 pick 4 >> 0
    do
        1 pick swap fb32-draw-bits swap 2 + swap
    loop
    bytes/line + 2 pick /l* -
;

: fb32-draw-logo ( 090e )
    rd_crtl_byte >r swap rot line-adr r> 0
    ?do
        draw-logo-line
    loop
    2drop drop
;

: ck_custom ( 090f )
    2 pick 92 + 0 swap 4 0
    do
        dup c@ rot 8 << + swap ca1+
    loop
    drop bfdfdfe7 n->l <>
;

: ck_ffblogo_exists ( 0910 )
    ffb_prom logo_offset + c@ 59 =
;

: clut_len ( 0911 )
    ffb_prom logo_offset + dup 1c /l* + c@ 18 << over 1d /l* + c@ 10 << or
    over 1e /l* + c@ 8 << or swap 1f /l* + c@ or
;

: logo_wid_ht ( 0912 )
    ffb_prom logo_offset + 7 /l* + c@ is logo_wid ffb_prom logo_offset + b
    /l* + c@ is logo_ht
;

: rd_logo_data ( 0913 )
    3 0
    do
        prom_adr c@ 10 8 i * - << prom_adr la1+ is prom_adr
    loop
    or or
;

: render_line ( 0914 )
    logo_wid 0
    ?do
        rd_logo_data crtl_byte or over rl! la1+
    loop
    drop
;

: wr_logo ( 0915 )
    logo_ht 0
    ?do
        adr render_line adr bytes/line + is adr
    loop
;

: drw_ffb_logo ( 0916 )
    rd_crtl_byte line-adr is adr ffb_prom logo_offset + 20 clut_len + /l* +
    is prom_adr logo_wid_ht wr_logo
;

: ffb-draw-logo ( 0917 )
    ck_custom
    if
        fb32-draw-logo
    else
        ck_ffblogo_exists
        if
            drop 2drop drw_ffb_logo
        else
            fb32-draw-logo
        then
    then
;

: clear_fbram ( 0918 )
    ffb_fb is adr vres 0
    do
        adr hres 0
        do
            ffffffff over rl! la1+
        loop
        drop adr 2000 + is adr
    loop
;

: black_fbram ( 0919 )
    ffb_fb is adr vres 0
    do
        adr hres 0
        do
            ff000000 over rl! la1+
        loop
        drop adr 2000 + is adr
    loop
;

: send_ffb_int ( 091a )
    inter_reg rl@ ffea and 1 inter_reg rl! inter_reg rl!
;

: interrupt_method ( 091b )
    ['] send_ffb_int portid " upa-slave-interrupt" $call-parent
;

: pub_interrupt_props ( 091c )
    5 xdrint " interrupts" attribute 0 0 " upa-interrupt-slave" attribute
    ['] interrupt_method catch
    if
        " Error in upa-slave-interrupt method. " type cr
    else
        drop
    then
;

: gen_done_int ( 091d )
    21 inter_reg rl!
;

: gen_vert_int ( 091e )
    b inter_reg rl!
;

: remove_int ( 091f )
    15 inter_reg rl!
;

: pub_dac_rev ( 0920 )
    rd_dac_rev_reg 8 >> f and xdrint " RamDAC_rev" attribute
;

: pub_fbc_rev ( 0921 )
    800 rd_fbc n->l xdrint " FBC_reg_ID" attribute
;

: pub_reg_prop ( 0922 )
    no_size_cells? my-address my-space xdrphys 400 encode_size 400000
    encode_offset 200000 encode_size 600000 encode_offset 200000
    encode_size 1000000 encode_offset 400000 encode_size 1400000
    encode_offset 400000 encode_size 1800000 encode_offset 400000
    encode_size 1c00000 encode_offset 400000 encode_size 2000000
    encode_offset 1000000 encode_size 3000000 encode_offset 1000000
    encode_size 4000000 encode_offset 400000 encode_size 4400000
    encode_offset 400000 encode_size 4800000 encode_offset 400000
    encode_size 4c00000 encode_offset 400000 encode_size 5000000
    encode_offset 1000000 encode_size 6000000 encode_offset 2000000
    encode_size 9000000 encode_offset 800000 encode_size 9800000
    encode_offset 800000 encode_size a000000 encode_offset 1000000
    encode_size b000000 encode_offset 800000 encode_size b800000
    encode_offset 800000 encode_size c000000 encode_offset 400000
    encode_size c800000 encode_offset 800000 encode_size d000000
    encode_offset 800000 encode_size d800000 encode_offset 800000
    encode_size " reg" attribute
;

: drvr_attributes ( 0923 )
    sun_pc xdrint " address" attribute
;

: mk_ffb_console ( 0924 )
    ffb_fb is frame-buffer-adr default-font set-font ffb_scrn_params
    fb8-install hres #columns char-width * - 2/ is window-left
;

: init_hw ( 0925 )
    init_ramdac init_gpclk init_fbc_regs init_pp_regs start_sync_gen
;

: init_ffb ( 0926 )
    init_hw ffb-black-screen
;

: start_ffb ( 0927 )
    init_hw ffb-white-screen ffb_video_on
;

: restart ( 0928 )
    is rt_id set_mon_params start_ffb
;

: ffb-install ( 0929 )
    ffb_map set_strap_reg -1 is console_mode? set_rt_id init_hw
    do_short_wait ffb_do_edid set_edid_mon read_eeprom_opt set_mon_params
    pub_mon_attribs pub_console_props start_ffb mk_ffb_console
    init_fb32_term
    ['] ffb_video_on is reset-screen
    ['] fb32-toggle-cursor is toggle-cursor
    ['] ffb-erase-screen is erase-screen
    ['] ffb-blink-screen is blink-screen
    ['] fb32-invert-screen is invert-screen
    ['] fb32-draw-character is draw-character
    ['] fb32-insert-characters is insert-characters
    ['] fb32-delete-characters is delete-characters
    ['] fb32-insert-lines is insert-lines
    ['] fb32-delete-lines is delete-lines
    ['] ffb-draw-logo is draw-logo
;

: ffb-remove ( 092a )
    ffb_video_off ffb_unmap 0 is console_mode?
;

: ffb-selftest ( 092b )
    0
;

: ffb-probe ( 092c )
    ffb_map set_strap_reg map_interrupt_reg set_timer_delta set_rt_id
    init_ffb do_video_wait ffb_do_edid set_edid_mon init_ffb
    pub_mon_attribs pub_portid pub_interrupt_props set_sc_queue
    pub_ffb2_props pub_dac_rev pub_fbc_rev pub_reg_prop
    ['] ffb-install is-install
    ['] ffb-remove is-remove
    ['] ffb-selftest is-selftest ffb_unmap
;

ffb-probe

end0
