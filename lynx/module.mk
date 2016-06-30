lynx_dir := $(prefix)/.lynx
macros += lynx_dir

LYNX_SAVE := $(or $(XDG_DOWNLOAD_DIR),$(wildcard ~/Downloads))
ifneq ($(LYNX_SAVE),)
    macros += LYNX_SAVE
endif
