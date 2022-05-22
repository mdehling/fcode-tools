include ../Makefile.inc

PKGMK = /usr/bin/pkgmk
PKGTRANS = /usr/bin/pkgtrans

PKG = MDXfcode
ARCH = sparc

PKGFILE = $(PKG)-v$(FCODE_TOOLS_VERSION)-$(ARCH).pkg


.PHONY: all

all: pkginfo prototype
	$(PKGMK) -o -d . VERSION="Version $(FCODE_TOOLS_VERSION)"
	$(PKGTRANS) -s . $(PKGFILE) $(PKG)


.PHONY: clean

clean:
	rm -rf $(PKG) $(PKGFILE)
