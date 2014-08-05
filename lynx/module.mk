uname := $(shell uname)
ifeq ($(uname),Darwin)
    LYNX_DOWNLOADS := ~/Downloads
else
    LYNX_DOWNLOADS := ~
endif

SUBSTITUTIONS += s|__LYNX_DOWNLOADS__|$(wildcard $(LYNX_DOWNLOADS))|g
