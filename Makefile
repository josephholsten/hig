.POSIX:

VERSION=0.4.4

# Installation enviroment specific vars
INSTALL=install
INSTALL_PROGRAM=$(INSTALL)
INSTALL_DATA=$(INSTALL) -m 644

PREFIX        = /usr
bindir        = $(PREFIX)/bin
libdir        = $(PREFIX)/lib
libexecdir    = $(PREFIX)/lib
mandir        = $(PREFIX)/share/man/
completiondir = $(PREFIX)/share/bash-completion/completions/

# Build vars
PANDOC = pandoc
PANDOCFLAGS=

# Dist vars
BIN_FILES=\
	bin/hig \
	bin/chbr \
	bin/ci \
	bin/cia \
	bin/cim \
	bin/co \
	bin/cop \
	bin/get \
	bin/lsbr \
	bin/lstag \
	bin/mkbr \
	bin/mktag \
	bin/pick \
	bin/pull \
	bin/push \
	bin/rmbr \
	bin/st \

LIB_FILES=\
	lib/hig/common.sh \

LIBEXEC_FILES= \
	libexec/hig/hig \
	libexec/hig/hig-cop \
	libexec/hig/hig-pr \
	libexec/hig/hig-diff \
	libexec/hig/hig-mktag \
	libexec/hig/hig-rmbr \
	libexec/hig/hig-st \
	libexec/hig/hig-get \
	libexec/hig/hig-rm \
	libexec/hig/hig-view \
	libexec/hig/hig-rebase \
	libexec/hig/hig-push \
	libexec/hig/hig-ci \
	libexec/hig/hig-lsbr \
	libexec/hig/hig-pick \
	libexec/hig/hig-lstag \
	libexec/hig/hig-log \
	libexec/hig/hig-pull \
	libexec/hig/hig-co \
	libexec/hig/hig-add \
	libexec/hig/hig-format \
	libexec/hig/hig-cim \
	libexec/hig/hig-cia \
	libexec/hig/hig-mkbr \
	libexec/hig/hig-chbr \
	libexec/hig/hig-help \

MAN_FILES=\
	man/hig.1 \

COMPLETION_FILES=\
	completion/hig \

FPM = fpm
PACKAGE = hig_$(VERSION)_amd64.deb

TESTS=\
	t/git.bats \

# publish vars
PACKAGECLOUD = package_cloud
PACKAGECLOUD_REPO = josephholsten/hig

.SUFFIXES: .1.html .1.md .1

.1.md.1:
	$(PANDOC) $(PANDOCFLAGS) -f markdown $< -t man -s -o $@

all: man

man: $(MAN_FILES)

check:
	bats $(TESTS)

build-container:
	sudo docker build -t hig-pkg .
.PHONY: build-container
CONTAINER_EXEC = sudo docker run -v "$(PWD):/opt/src" --env DESTDIR=pkg --env-file .env hig-pkg
container_exec:
	$(CONTAINER_EXEC) $(CMD)
.PHONY: container_exec
pkg:
	$(CONTAINER_EXEC) pkg/$(PACKAGE)
.PHONY: pkg
clean:
	$(CONTAINER_EXEC) c-clean
.PHONY: clean
upload:
	$(CONTAINER_EXEC) c-upload-ubuntu-xenial
.PHONY: upload

install: all
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL) -d $(DESTDIR)$(libdir)/hig
	$(INSTALL) -d $(DESTDIR)$(mandir)
	$(INSTALL) -d $(DESTDIR)$(completiondir)

	$(INSTALL_PROGRAM) -t $(DESTDIR)$(libexecdir)/hig $(LIBEXEC_FILES)
	$(INSTALL_DATA) -t $(DESTDIR)$(libdir)/hig $(LIB_FILES)
	$(INSTALL_DATA) -t $(DESTDIR)$(mandir) $(MAN_FILES)
	$(INSTALL_DATA) -t $(DESTDIR)$(completiondir) $(COMPLETION_FILES)

	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/hig
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/chbr
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/ci
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/cia
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/cim
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/co
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/cop
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/get
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/lsbr
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/lstag
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/mkbr
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/mktag
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/pick
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/pull
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/push
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/rmbr
	ln -sf ../`basename $(libexecdir)`/hig/hig $(DESTDIR)$(bindir)/st

pkg/$(PACKAGE): install
	rm -f pkg/$(PACKAGE)
	cd pkg; $(FPM) -s dir -t deb -n hig -v $(VERSION) .

c-upload-ubuntu-xenial: pkg/$(PACKAGE)
	$(PACKAGECLOUD) push $(PACKAGECLOUD_REPO)/ubuntu/xenial pkg/$(PACKAGE)

c-clean:
	rm -f $(MAN_FILES)
	rm -rf pkg
	rm -f *.deb
	rm -f tags
