
GITCLONE	:= git clone
MAKE		:= make
INSTALLDIR	:= _install
MDK3_REPO	:= -b master "git://github.com/wi-fi-analyzer/mdk3-master.git"
PIXIEWPS_REPO	:= -b master "git://git.kali.org/packages/pixiewps.git"
REAVER_REPO 	:= -b kali/master "git://git.kali.org/packages/reaver.git"

# All Tools 

.PHONY: all checkout build install clean distclean

all: checkout build install

checkout: mdk3_checkout \
	pixiewps_checkout \
	reaver_checkout

build: checkout \
	mdk3_build \
	pixiewps_build \
	reaver_build

install: build \
	mdk3_install \
	pixiewps_install \
	reaver_install

clean: 	mdk3_clean \
	pixiewps_clean \
	reaver_clean

distclean:
	rm -rf _install mdk3 pixiewps reaver

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

