__header__

# This configuration assumes GnuPG 2.1.11. Any and all rationales are
# naïve. I have no idea what I'm doing.

# Preferences for negotiating with recipients. Ciphers and digests are
# ordered roughly by strength. List as many as possible to reduce the
# chance of settling on a weak fallback [1].
#   - Blowfish-128, CAST5, IDEA, and 3DES-168 are not suitable for
#     encrypting large files due to small block size [2].
#   - Blowfish has issues with weak keys, apparently [1].
#   - IDEA is last because I just don't like the sound of it [3].
#   - Try to avoid compression, which leaks information about data
#     contents [4][5][6].
personal-cipher-preferences AES256 CAMELLIA256 TWOFISH AES192 CAMELLIA192 AES CAMELLIA128 CAST5 BLOWFISH 3DES IDEA
personal-digest-preferences SHA512 SHA384 SHA256 SHA224 RIPEMD160 SHA1
personal-compress-preferences Uncompressed BZIP2 ZLIB ZIP

# Preferences for my own keys.
default-preference-list AES256 CAMELLIA256 TWOFISH AES192 CAMELLIA192 AES CAMELLIA128 CAST5 BLOWFISH 3DES IDEA SHA512 SHA384 SHA256 SHA224 RIPEMD160 SHA1 Uncompressed BZIP2 ZLIB ZIP

# Beef up passphrase mangling for symmetric encryption. Beyond
# unnecessary for me [7], but I'm paranoid and this makes me feel
# better. (In GnuPG 2.1.12, gpg-agent doesn't respect gpg's --s2k-*
# options, so the private keyring uses default settings [8].)
s2k-digest-algo SHA512
s2k-count 65011712

# Omit metadata in ASCII armored output.
no-comments
no-emit-version

# If we're going to compress, don't hold back.
bzip2-compress-level 9
compress-level 9

# Ignore recipients' keyserver preferences [9].
keyserver-options no-honor-keyserver-url

# Show fingerprints where possible because key IDs are garbage [10].
with-fingerprint


# References:
#
#   1. "Ranked Order of Security for Encryption Algorithm Preferences:
#      For GPG" <http://superuser.com/a/968649/6528>
#   2. "GnuPG Frequently Asked Questions"
#      <https://www.gnupg.org/faq/gnupg-faq.html>
#   3. "Crypto Guru Bruce Schneier Answers"
#      <https://slashdot.org/story/99/10/29/0832246>
#   4. "BREACH - a new attack against HTTP. What can be done?"
#      <http://security.stackexchange.com/a/39953/1596>
#   5. "Is it safe for GPG to compress all messages prior to encryption
#      by default?" <http://security.stackexchange.com/a/43425/1596>
#   6. "Whats the best custom compression method to use when I have SSL?"
#      <http://security.stackexchange.com/a/39914/1596>
#   7. "gpg --perfect-code"
#      <http://security.stackexchange.com/a/30457/1596>
#   8. "Issue 1800: Allow s2k options for gpg --export-secret-key"
#      <https://bugs.gnupg.org/gnupg/issue1800>
#   9. "OpenPGP Best Practices"
#      <https://help.riseup.net/en/security/message-security/openpgp/best-practices>
#  10. "OpenPGP Key IDs are not useful"
#      <https://debian-administration.org/users/dkg/weblog/105>

m4_divert(«-1»)
vim: set filetype=gpg:
