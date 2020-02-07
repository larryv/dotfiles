gnupg_files := gnupg/_gnupg/dirmngr.conf \
               gnupg/_gnupg/gpg.conf \
               gnupg/_zsh/gnupg.zshenv

# GnuPG requires restrictive permissions for its configuration.
gnupg-installdirs:
	chmod 700 ~/.gnupg
gnupg-install:
	chmod 600 $(filter ~/.gnupg/%,$(gnupg_dst_files))
