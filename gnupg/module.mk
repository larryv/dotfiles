quoted_gnupg_dir := $(quoted_prefix)/.gnupg

# GnuPG requires restrictive permissions for its configuration.
gnupg-installdirs:
	chmod 700 '$(quoted_gnupg_dir)'
gnupg-install:
	cd -- '$(quoted_prefix)' && chmod 600 $(call installpath,$(filter gnupg/_gnupg/%,$(gnupg_files)))
