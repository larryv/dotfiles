export gnupg_dir := $(raw_prefix)/.gnupg
quoted_gnupg_dir := $(quoted_prefix)/.gnupg

gnupg_clean_files := gnupg/_gnupg/gpg.conf \
                     gnupg/_gnupg/gpg.conf-1.4 \
                     gnupg/_gnupg/gpg.conf-2.0 \
                     gnupg/_zsh/gnupg.zshenv

# GnuPG 1.4 and 2.0 don't bundle the sks-keyservers.net CA certificate.
gnupg_files := gnupg/_gnupg/sks-keyservers.netCA.pem

# GnuPG requires restrictive permissions for its configuration.
gnupg-installdirs:
	chmod 700 '$(quoted_gnupg_dir)'
gnupg-install:
	cd -- '$(quoted_prefix)' && chmod 600 $(call installpath,$(filter gnupg/_gnupg/%,$(gnupg_src_files)))
