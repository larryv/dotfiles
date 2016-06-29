lynx := $(prefix)/.lynx
macros += lynx

LYNX_SAVE := $(or $(wildcard ~/Downloads),$(wildcard ~))
macros += LYNX_SAVE
