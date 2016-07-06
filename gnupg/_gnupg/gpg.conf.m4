__header__

# Preferences for negotiating with recipients. Ciphers and digests are
# ordered roughly by strength. List as many as possible to reduce the
# chance of settling on a weak fallback [8].
#   - Blowfish-128, CAST5, IDEA, and 3DES-168 are not suitable for
#     encrypting large files due to small block size [3].
#   - Blowfish has issues with weak keys, apparently [8].
#   - IDEA is last because I just don't like the sound of it [2].
#   - Try to avoid compression, which leaks information about data
#     contents [1][5][9].
personal-cipher-preferences AES256 CAMELLIA256 TWOFISH AES192 CAMELLIA192 AES CAMELLIA128 CAST5 BLOWFISH 3DES IDEA
personal-digest-preferences SHA512 SHA384 SHA256 SHA224 RIPEMD160 SHA1
personal-compress-preferences Uncompressed BZIP2 ZLIB ZIP

# Preferences for my own keys.
default-preference-list AES256 CAMELLIA256 TWOFISH AES192 CAMELLIA192 AES CAMELLIA128 CAST5 BLOWFISH 3DES IDEA SHA512 SHA384 SHA256 SHA224 RIPEMD160 SHA1 Uncompressed BZIP2 ZLIB ZIP

# Beef up passphrase mangling for symmetric encryption. Beyond
# unnecessary for me [4], but I'm paranoid and this makes me feel
# better. (In GnuPG 2.1.12, gpg-agent doesn't respect gpg's --s2k-*
# options, so the private keyring uses default settings [6].)
s2k-digest-algo SHA512
s2k-count 65011712

# Omit metadata in ASCII armored output.
no-comments
no-emit-version

# If we're going to compress, don't hold back.
bzip2-compress-level 9
compress-level 9

# Ignore recipients' keyserver preferences.[7]
keyserver-options no-honor-keyserver-url

# Minimize opportunities for visual spoofing.[7]
keyid-format 0xlong
with-fingerprint


# This configuration assumes GnuPG 2.1.11. Any and all rationales are
# naïve. I have no idea what I'm doing.
#
# References:
#
#   1. "BREACH - a new attack against HTTP. What can be done?"
#      <http://security.stackexchange.com/a/39953/1596>
#   2. "Crypto Guru Bruce Schneier Answers"
#      <https://slashdot.org/story/99/10/29/0832246>
#   3. "GnuPG Frequently Asked Questions"
#      <https://www.gnupg.org/faq/gnupg-faq.html>
#   4. "gpg --perfect-code"
#      <http://security.stackexchange.com/a/30457/1596>
#   5. "Is it safe for GPG to compress all messages prior to encryption
#      by default?" <http://security.stackexchange.com/a/43425/1596>
#   6. "Issue 1800: Allow s2k options for gpg --export-secret-key"
#      <https://bugs.gnupg.org/gnupg/issue1800>
#   7. "OpenPGP Best Practices"
#      <https://help.riseup.net/en/security/message-security/openpgp/best-practices>
#   8. "Ranked Order of Security for Encryption Algorithm Preferences:
#      For GPG" <http://superuser.com/q/968566/6528>
#   9. "Whats the best custom compression method to use when I have SSL?"
#      <http://security.stackexchange.com/a/39914/1596>

m4_divert(«-1»)
vim: set filetype=gpg:
