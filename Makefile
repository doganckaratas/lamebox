
GITCLONE	:= git clone
MAKE		:= make
INSTALLDIR	:= _install
ARPSCAN_REPO	:= -b master "git://git.kali.org/packages/arp-scan.git"
BURP_REPO	:= -b master "git://git.kali.org/packages/burpsuite.git"
MDK3_REPO	:= -b master "git://github.com/wi-fi-analyzer/mdk3-master.git"
PIXIEWPS_REPO	:= -b master "git://git.kali.org/packages/pixiewps.git"
REAVER_REPO 	:= -b kali/master "git://git.kali.org/packages/reaver.git"

# All Tools 

.PHONY: all checkout build install clean distclean

all: checkout build install

checkout: arpscan_checkout \
	burp_checkout \
	mdk3_checkout \
	pixiewps_checkout \
	reaver_checkout

build: checkout \
	arpscan_build \
	burp_build \
	mdk3_build \
	pixiewps_build \
	reaver_build

install: build \
	arpscan_install \
	burp_install \
	mdk3_install \
	pixiewps_install \
	reaver_install

clean: 	arpscan_clean \
	burp_clean \
	mdk3_clean \
	pixiewps_clean \
	reaver_clean

distclean:
	rm -rf _install arp-scan burpsuite mdk3 pixiewps reaver

# arp-scan

arpscan_checkout:
	${GITCLONE} $(ARPSCAN_REPO)

arpscan_build:
	cd ./arp-scan && ./configure --prefix=$(shell pwd -P)/$(INSTALLDIR)
	${MAKE} -C arp-scan

arpscan_install:
	${MAKE} -C arp-scan install

arpscan_clean:
	${MAKE} -C arp-scan clean

# Burp Suite

burp_checkout:
	@true
#	${GITCLONE} $(BURP_REPO)

burp_build:
	@true

burp_install:
	@true
#	cp burpsuite/burpsuite.jar _install/bin

burp_clean:
	rm -rf burpsuite

# MDK3

mdk3_checkout:
	${GITCLONE} $(MDK3_REPO) mdk3

mdk3_build:
	${MAKE} -C mdk3

mdk3_install:
	${MAKE} -C mdk3 install PREFIX=$(shell pwd -P)/$(INSTALLDIR)

mdk3_clean:
	${MAKE} -C mdk3 clean

# PixieWPS

pixiewps_checkout:
	${GITCLONE} $(PIXIEWPS_REPO)

pixiewps_build:
	${MAKE} -C pixiewps

pixiewps_install:
	${MAKE} -C pixiewps install PREFIX=$(shell pwd -P)/$(INSTALLDIR)

pixiewps_clean:
	${MAKE} -C pixiewps clean

# Reaver 

reaver_checkout:	
	${GITCLONE} $(REAVER_REPO)

reaver_build: 
	cd ./reaver/src && ./configure --prefix=$(shell pwd -P)/$(INSTALLDIR)
	${MAKE} -C reaver/src

reaver_install:
	${MAKE} -C reaver/src install 

reaver_clean:
	${MAKE} -C reaver/src clean

