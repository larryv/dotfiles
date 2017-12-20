__header__

# Use a TLS-enabled keyserver pool [1]. GnuPG 2.1.11 installs and
# automatically uses the necessary CA certificate [2]; install it
# manually for older versions [1].
keyserver hkps://hkps.pool.sks-keyservers.net
#hkp-cacert /path/to/sks-keyservers.netCA.pem


# References:
#
#   1. "OpenPGP Best Practices"
#      <https://help.riseup.net/en/security/message-security/openpgp/best-practices>
#   2. "[Announce] GnuPG 2.1.11 released"
#      <https://lists.gnupg.org/pipermail/gnupg-announce/2016q1/000383.html>
#
# vim: set filetype=gpg:
