
GITCLONE	:= git clone
MAKE		:= make
INSTALLDIR	:= _install
REAVER_REPO 	:= -b kali/master "git://git.kali.org/packages/reaver.git"

# All Tools 

.PHONY: all checkout install clean distclean

all: checkout build install

checkout: \
	reaver_checkout	

build: checkout \
	reaver_build

install: build \
	reaver_install

clean: \
	reaver_clean

distclean:
	rm -rf _install reaver 

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

