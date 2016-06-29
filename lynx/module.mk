lynx := $(prefix)/.lynx
macros += lynx

ifneq ($(wildcard $(HOME)/Downloads),)
    LYNX_DOWNLOADS := $(HOME)/Downloads
else
    LYNX_DOWNLOADS := $(HOME)
endif
macros += LYNX_DOWNLOADS
