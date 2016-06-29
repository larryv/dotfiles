lynx := $(prefix)/.lynx
macros += lynx

ifneq ($(wildcard ~/Downloads),)
    LYNX_DOWNLOADS := $(wildcard ~/Downloads)
else
    LYNX_DOWNLOADS := $(wildcard ~)
endif
macros += LYNX_DOWNLOADS
