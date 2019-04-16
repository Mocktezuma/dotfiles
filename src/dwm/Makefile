# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = dwm.c
OBJ = ${SRC:.c=.o}

all: options dwm

options:
	@echo dwm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

dwm: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f dwm ${OBJ} dwm-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p dwm-${VERSION}
	@cp -R LICENSE Makefile README config.def.h config.mk \
	dwm.png dwm.1 ${SRC} dwmm other/ layouts/ dwm-${VERSION}
	@tar -cf dwm-${VERSION}.tar dwm-${VERSION}
	@gzip dwm-${VERSION}.tar
	@rm -rf dwm-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f dwm ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	@sed "s#DWMSRC#${DESTDIR}${PREFIX}/share/dwm/src/#g" < dwmm > ${DESTDIR}${PREFIX}/bin/dwmm
	@chmod 755 ${DESTDIR}${PREFIX}/bin/dwmm
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1
	@echo installing src files to ${DESTDIR}${PREFIX}/share/dwm
	@mkdir -p ${DESTDIR}${PREFIX}/share/dwm/src
	@cp -Rf dwm.c config.def.h config.mk Makefile layouts other  ${DESTDIR}${PREFIX}/share/dwm/src

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/dwm
	@rm -f ${DESTDIR}${PREFIX}/bin/dwmm
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/dwm.1
	@echo removing src files rom ${DESTDIR}${MANPREFIX}/share
	@rm -Rf ${DESTDIR}${PREFIX}/share/dwm

.PHONY: all options clean dist install uninstall
