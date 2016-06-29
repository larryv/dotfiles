lynx := $(prefix)/.lynx
macros += lynx

LYNX_SAVE := $(or $(XDG_DOWNLOAD_DIR),$(wildcard ~/Downloads),$(wildcard ~))
macros += LYNX_SAVE
