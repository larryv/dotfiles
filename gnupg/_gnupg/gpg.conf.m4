__header__

# This configuration assumes GnuPG 2.1.16 (for the default keyserver).
# Keep roughly synced with gpg.conf-1.4 and gpg.conf-2.0.
#
# Any and all rationales are naïve. I have no idea what I'm doing.

# The 2.2.4 defaults with some modifications.
#   - Add Camellia and Twofish, GnuPG's other 128-bit block ciphers.
#   - Add RIPEMD-160 to discourage use of SHA-1, which is broken as far
#     as signatures are concerned [1].
#   - Disallow compression, which leaks information about message
#     contents [2][3][4].
personal-compress-preferences Uncompressed
default-preference-list AES256 CAMELLIA256 TWOFISH AES192 CAMELLIA192 AES CAMELLIA128 3DES SHA512 SHA384 SHA256 SHA224 RIPEMD160 SHA1 Uncompressed

# Not particularly useful for the public web of trust because everyone
# has their own definition of "trust", but I still want to provide
# a rough idea of how thoroughly I've vetted a key.
ask-cert-level

# Try to hinder traffic analysis by removing recipients' key IDs [5][6].
throw-keyids

# Show fingerprints because key IDs are garbage [7][8].
with-fingerprint

# Ensure new key is used. Remove after revoking old key.
default-key 0x3FD9032247DE2D201E7528C49AC940DFFD017443


# References:
#
#   1. "Research Results on SHA-1 Collisions"
#      <https://csrc.nist.gov/News/2017/Research-Results-on-SHA-1-Collisions>
#   2. "BREACH - a new attack against HTTP. What can be done?"
#      <https://security.stackexchange.com/a/39953/1596>
#   3. "Is it safe for GPG to compress all messages prior to encryption
#      by default?" <http://security.stackexchange.com/a/43425/1596>
#   4. "Whats the best custom compression method to use when I have SSL?"
#      <https://security.stackexchange.com/a/39914/1596>
#   5. "What information is leaked from an OpenPGP encrypted file?"
#      <https://security.stackexchange.com/q/25170/1596>
#   6. "15 reasons not to start using PGP"
#      <http://secushare.org/PGP#sec-2>
#   7. "OpenPGP Best Practices"
#      <https://help.riseup.net/en/security/message-security/openpgp/best-practices>
#   8. "OpenPGP Key IDs are not useful"
#      <https://debian-administration.org/users/dkg/weblog/105>

divert(«-1»)
vim: set filetype=gpg:
