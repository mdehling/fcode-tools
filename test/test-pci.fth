\ This is just an example, for a simple PCI fcode. 


\ to add PCI header 
tokenizer[

h# aaaa h# bbbb h# ccddee  pci-header  ( vendor-id device-id class-code -- )
h# ff11 pci-vpd-offset                 ( vendor-prod-data -- )
h# 2233 pci-code-revision              ( code-rev -- )

]tokenizer

fcode-version2
hex
headers

\ following is to make sure that bit[31] value doesn't get propagated
\ to all the way to bit[63] on 3.x openboot cpu proms. 
ff ff ff ff bljoin constant num-32
: x-num  ( n -- l )  num-32 and  ;
: and    ( a b -- a-and-b )  x-num swap x-num and  ;
: or     ( a b -- a-or-b )  x-num swap x-num or  ;
: lshift ( x n -- x' )  lshift x-num  ;
: rshift ( x n -- x' )  rshift x-num  ;

\ Each SunSwift PCI card will define one network device node:
\
\                       pci
\                        |
\                        |
\                        |
\                       network 
\
\
\ The general pathname (after pci) for a hme node is
\       network@0,1
\
\ name            network 
\                 Phys.hi    Phys.mid   Phys.lo    Size.hi    Size.lo
\                 -------    ---------  ---------  ---------  ---------
\ reg             0000.0S00  0000.0000  0000.0000  0000.0000  0000.0000  \ PCI Cfg
\                 0200.0S10  0000.0000  0000.0000  0000.0000  0000.7020  \ HME space
\
\                 where "S" = PCI Device | Function 1 (h# 100)
\
\                 FEPS Enet uses the following memory space:
\                 (offset from Base Address 10 setting)
\                   Offset     Size
\                   ------     ----
\                     0000      108     \ Global registers
\                     2000     2000     \ ETX registers
\                     4000     2000     \ ERX registers
\                     6000      360     \ BigMAC registers
\                     7000       20     \ MIF registers
\
\ device_type     network
\ interrupts      <CPU-level>  00000000           \ Platform dependent
\ model           SUNW,sunswift                    \ To be assigned.
\ address-bits    00000030
\ max-frame-size  00004000
\ transfer-speed  00000064                        \ Speed in Mbps.

my-address      constant my-bus-addr-mid  constant my-bus-addr-low
my-space        constant my-bus-space
2  constant pci-hme-intr       \ for PCI card

: my-bus-addr (  --  paddr.low paddr.mid )
   my-bus-addr-low  my-bus-addr-mid
;


\ for mac id on the fcode prom itself
h# 24 constant vpdp-loc
h# c000 value vpd-base
0 value cheer-rombase
0 value vpd-addr
headerless
h# 1.0000 value /cheer-rom

\ FEPS Enet Address Map
hex
   000.0000	constant	global-regs-offset
        108	constant	/global-regs
   000.2000	constant	etx-regs-offset
       2000	constant	/etx-regs
   000.4000	constant	erx-regs-offset
       2000	constant	/erx-regs
   000.6000	constant	bmac-regs-offset
       2000	constant	/bmac-regs
   000.7000	constant	mif-regs-offset
         20	constant	/mif-regs
       7020     constant        /total-reg-space

h# 4000	    constant max-frame-size		( d# 1536 for le )
d# 48	    constant address-bits
h# 30       constant cfg-rom-base
h# 200.0000 constant 32-bit-mem-ss


: encode-ints  ( nn .. n1 n -- adr len ) 
   0 0 encode-bytes   rot  0  ?do  rot encode-int encode+  loop
;

: xdrreg  ( addr space size -- adr len )
   >r encode-phys  r> 0 2 encode-ints  encode+
;

: offset>physical-addr  ( offset -- paddr.lo paddr.mid paddr.hi )
   my-bus-addr >r + r> my-bus-space h# 0200.0010 or  \ OR in "ss" = memory, base reg=10
;

headers
\ create needed properties for device/fcode driver. 
: create-hme-attributes  ( -- )

   \ see "generic name" recommended practice on IEEE 1275
   \ Open Firmware Working Group's homepage: http://playground.sun.com/1275
   " network"      name		
   " SUNW,sunswift" encode-string  " model" property

   my-bus-addr my-bus-space 0  xdrreg
   global-regs-offset offset>physical-addr  /total-reg-space xdrreg encode+
   " reg" property

   max-frame-size encode-int " max-frame-size" property
   address-bits encode-int " address-bits" property
   pci-hme-intr  encode-int  " interrupts"  property
   " network" device-type
   " 1.16" encode-string " version" property
   "  " encode-string " has-fcode" property

   \ look in Recommended Practice for "compatible" at Open Firmware WG's 
   \ homepage: http://playground.sun.com/1275
   " pci108e,1001" encode-string 
   " pciclass,060000" encode-string encode+ " compatible" property

;

: enable-cheer-cmd-reg ( -- )
   \ PCI Command Register Settings
   \ h# 100  = SERR# Enable
   \ h#  40  = Parity Error Enable
   \ h#   4  = Mastering Enable
   \ h#   2  = Memory Access Enable
   my-bus-space 4 +  " config-w@" $call-parent   ( cmd-reg )
   h# 146  or                                    ( cmd-reg' )
   my-bus-space 4 +  " config-w!" $call-parent   \ Set PCI Command reg's bits
;

: enable-cheer-rom ( -- )
   my-bus-space cfg-rom-base +  " config-l@" $call-parent   ( cmd-reg )
   h# 1  or                                                 ( cmd-reg' )
   my-bus-space cfg-rom-base +  " config-l!" $call-parent   \ enable rom accesses
;

: disable-cheer-rom  ( -- )
   my-bus-space cfg-rom-base +  " config-l@" $call-parent   ( cmd-reg )
   h# 1 invert and                                          ( cmd-reg' )
   my-bus-space cfg-rom-base +  " config-l!" $call-parent   \ disable rom accesses
;
: map-cheer-rom  ( -- )
   0 0 my-bus-space 32-bit-mem-ss or cfg-rom-base or /cheer-rom
   " map-in" $call-parent to cheer-rombase
;

: unmap-cheer-rom  ( -- )
   cheer-rombase /cheer-rom " map-out" $call-parent
   0 to cheer-rombase
;


\ the Vital Product Data for Fresh Choice ethernet looks like this:
\
\ (Offsets are in decimal.)
\ Offset		Item			Value
\   0	Large Resource Type VPD Tag (0x10)	0x90
\   1	Length					0x0009
\   3	VPD Keyword				"NA"
\   5	Length					6
\   6	Ethernet Address			0x080020.??????
\  12 	Small Resource Type End Tag (0xf)	0x79
\  13	Data (nominally checksum)		0
\
\

: uw@  ( adr -- w )  dup c@ swap 1+ c@ swap bwjoin  ;
: ul,  ( 32bit# -- ) lbsplit c, c, c, c,  ;

: set-vpdp-value  ( -- )	\ set pointer to vpd, rom access etc.
   map-cheer-rom
   enable-cheer-cmd-reg
   enable-cheer-rom		
   cheer-rombase vpdp-loc +  rw@ cheer-rombase + to vpd-addr
;

: unset-vpdp-value  ( -- )       \ disable rom access etc.
   disable-cheer-rom
   unmap-cheer-rom
   0 to vpd-addr
;
: get-macid-header  	(  -- tag len1 keyword len2  )
   vpd-addr  dup c@ 	( tag )
   swap 1+ dup uw@ 	( tag len1 )
   swap 2+ dup uw@ 	( tag len1 keyword )
   swap 2+ c@ 		( tag len1 keyword len2 )
;

: verify-macid-header-ok?  ( tag len1 keyword len2 -- ok? )
   h# 6 <>  if 2drop drop false exit then
   ( tag len1 keyword )
   ( "NA" ) h# 4e41  <>  if  2drop false exit then
   ( tag len1 )
   h# 9  <>  if  drop false exit then
   h# 90  <>  if  false else  true  then
;
6 buffer: my-loc-mac-addr

: loc-mac-prop  ( addr -- )
   6 encode-bytes " local-mac-address" property
;
: make-loc-mac  ( -- )    my-loc-mac-addr  loc-mac-prop  ;
: get-macid  ( -- valid? )
   get-macid-header
   verify-macid-header-ok?  if
     vpd-addr 6 + my-loc-mac-addr 6 cmove
     true
   else
     diagnostic-mode?  if
       ." Wrong Vital Prod. Data/Network Address header" cr
     then
     false
   then
;
: make-macid  ( -- )
   get-macid  if
     make-loc-mac
   then
;

: create-macid  ( -- )
   set-vpdp-value
   make-macid
   unset-vpdp-value
;
create-hme-attributes   \ Create ENET port device node.
create-macid		\ create local mac id 

end0		\ end of sample PCI fcode program.
