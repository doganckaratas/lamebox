
GITCLONE	:= git clone
MAKE		:= make
INSTALLDIR	:= _install
REAVER_REPO 	:= -b kali/master "git://git.kali.org/packages/reaver.git"
PIXIEWPS_REPO	:= -b master "git://git.kali.org/packages/pixiewps.git"


# All Tools 

.PHONY: all checkout build install clean distclean

all: checkout build install

checkout: pixiewps_checkout \
	reaver_checkout

build: checkout \
	pixiewps_build \
	reaver_build

install: build \
	pixiewps_install \
	reaver_install

clean: 	pixiewps_clean \
	reaver_clean

distclean:
	rm -rf _install pixiewps reaver

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

