lynx_dir := $(prefix)/.lynx
macros += lynx_dir

LYNX_SAVE := $(or $(XDG_DOWNLOAD_DIR),$(wildcard ~/Downloads))
ifneq ($(LYNX_SAVE),)
    macros += LYNX_SAVE
endif

# Perform multiple pattern substitutions. The first argument should be
# a list of alternating patterns and replacements, suitable for use with
# patsubst. The substitutions are performed on the second argument.
patsubst_multi = $(call _patsubst_multi,$(1),$(words $(1)),$(2))
_patsubst_multi = \
    $(if $(1),$(call $(0),$(wordlist 3,$(2),$(1)),$(2),$(patsubst $(word 1,$(1)),$(word 2,$(1)),$(3))),$(3))

# Normalize idiosyncratic charset/charmap names:
# - Arch: ANSI_X3.4-1968, IBM{437,850,852,862,864,866,869}, NEXTSTEP
# - OS X: euc{CN,JP,KR}, ISO8559-*, SJIS
lynx_charset_tweaks := ansi-x3.4-1968 us-ascii euccn euc-cn eucjp euc-jp \
    euckr euc-kr ibm% cp% iso8859-% iso-8859-% nextstep next sjis shift_jis

# List of charsets/charmaps recognized by Lynx 2.8.8, retrieved from
# http://lynx.invisible-island.net/lynx2.8.8/lynx_help/body.html#CHARACTER_SET
# on 30 June 2016. Omit "iso-8859-1" to allow Lynx to default to it.
lynx_valid_charsets := big5 cp437 cp737 cp775 cp850 cp852 cp862 cp864 \
    cp866 cp866u cp869 dec-mcs euc-cn euc-jp euc-kr hp-roman8 iso-8859-2 \
    iso-8859-3 iso-8859-4 iso-8859-5 iso-8859-6 iso-8859-7 iso-8859-8 \
    iso-8859-9 iso-8859-10 iso-8859-13 iso-8859-14 iso-8859-15 koi8-r \
    koi8-u macintosh mnemonic mnemonic+ascii+0 next shift_jis us-ascii \
    utf-8 viscii windows-1250 windows-1251 windows-1252 windows-1253 \
    windows-1255 windows-1256 windows-1257 x-transparent

LYNX_CHARSET := $(shell locale charmap | tr '[:upper:]_' '[:lower:]-')
LYNX_CHARSET := $(call patsubst_multi,$(lynx_charset_tweaks),$(LYNX_CHARSET))
LYNX_CHARSET := $(filter $(lynx_valid_charsets),$(LYNX_CHARSET))
ifneq ($(LYNX_CHARSET),)
    macros += LYNX_CHARSET
endif
