__header__

# Use a TLS-enabled keyserver pool [2]. GnuPG 2.1.11 installs and
# automatically uses the necessary CA certificate [1]; install it
# manually for older versions [2].
keyserver hkps://hkps.pool.sks-keyservers.net
#hkp-cacert __gnupg_dir__/sks-keyservers.netCA.pem


# This configuration assumes GnuPG 2.1.11. Any and all rationales are
# naïve. I have no idea what I'm doing.
#
# References:
#
#   1. "[Announce] GnuPG 2.1.11 released"
#      <https://lists.gnupg.org/pipermail/gnupg-announce/2016q1/000383.html>
#   2. "OpenPGP Best Practices"
#      <https://help.riseup.net/en/security/message-security/openpgp/best-practices>
#
# vim: set filetype=gpg:
