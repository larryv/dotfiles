lynx := $(prefix)/.lynx
macros += lynx

LYNX_SAVE := $(or $(XDG_DOWNLOAD_DIR),$(wildcard ~/Downloads))
ifneq ($(LYNX_SAVE),)
    macros += LYNX_SAVE
endif
