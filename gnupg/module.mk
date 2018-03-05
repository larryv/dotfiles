export gnupg_dir := $(raw_prefix)/.gnupg
quoted_gnupg_dir := $(quoted_prefix)/.gnupg

# GnuPG 1.4 and 2.0 don't bundle the sks-keyservers.net CA certificate.
gnupg_files += gnupg/_gnupg/sks-keyservers.netCA.pem
gnupg-clean: gnupg_files := $(filter-out gnupg/_gnupg/sks-keyservers.netCA.pem,$(gnupg_files))

# GnuPG requires restrictive permissions for its configuration.
gnupg-installdirs:
	chmod 700 '$(quoted_gnupg_dir)'
gnupg-install:
	cd -- '$(quoted_prefix)' && chmod 600 $(call installpath,$(filter gnupg/_gnupg/%,$(gnupg_files)))
