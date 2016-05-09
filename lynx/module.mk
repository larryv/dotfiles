lynx := $(prefix)/.lynx
macros += lynx

ifeq ($(shell uname),Darwin)
    LYNX_DOWNLOADS := $(HOME)/Downloads
else
    LYNX_DOWNLOADS := $(HOME)
endif
macros += LYNX_DOWNLOADS
