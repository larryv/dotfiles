all: tmux
tmux: FORCE tmux/_tmux.conf

install: tmux-install
tmux-install: FORCE tmux
	$(INSTALL_DATA) tmux/_tmux.conf ~/.tmux.conf

uninstall: tmux-uninstall
tmux-uninstall: FORCE
	rm -f ~/.tmux.conf
