all: mercurial
mercurial: FORCE mercurial/_hgrc

install: mercurial-install
mercurial-install: FORCE mercurial
	$(INSTALL_DATA) mercurial/_hgrc ~/.hgrc

uninstall: mercurial-uninstall
mercurial-uninstall: FORCE
	rm -f ~/.hgrc
