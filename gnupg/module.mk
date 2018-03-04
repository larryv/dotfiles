gnupg_dir := $(prefix)/.gnupg

# GnuPG requires restrictive permissions for its configuration.
gnupg-installdirs:
	chmod 700 '$(gnupg_dir)'
gnupg-install:
	cd -- '$(prefix)' && chmod 600 $(call installpath,$(filter gnupg/_gnupg/%,$(gnupg_files)))
