include Makefile.inc


.PHONY: all
all:
	cd src; $(MAKE) -f Makefile.`uname` $(MAKEFLAGS) all; cd ..
	cd test; $(MAKE) $(MAKEFLAGS) all; cd ..


.PHONY: package
package: all
	cd pkg; $(MAKE) $(MAKEFLAGS) all; cd ..


.PHONY: clean
clean:
	cd src; $(MAKE) -f Makefile.`uname` $(MAKEFLAGS) clean; cd ..
	cd pkg; $(MAKE) $(MAKEFLAGS) clean; cd ..
