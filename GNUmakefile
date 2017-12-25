ifeq ($(or $(VERBOSE),0),0)
    quiet := @
endif

# The GnuPG dotfiles require restrictive permissions.
UMASK := 077

# Template parameters.
prefix := $(wildcard ~)
macros := prefix

# Flotsam and jetsam.
SHELL := /bin/sh
.NOTPARALLEL:           # mkdir -p may cause race conditions.
.SECONDEXPANSION:
.SUFFIXES:

# Treat each child directory listed in VPATH as a "module". Generate
# per-module targets and prerequisites based on directory contents.
# For example:
# - "make git" / "make git-install": install Git-related dotfiles
# - "make git-uninstall": delete Git-related dotfiles
# - "make install": install all dotfiles
# - "make uninstall": delete all dotfiles

VPATH := git gnupg java lynx macports mercurial tmux zsh

.PHONY: install uninstall
install: $(addsuffix -install,$(VPATH))
uninstall: $(addsuffix -uninstall,$(VPATH))

define load_module
$(1)_dotfiles := $$(shell find $(1) -type f -name '*.m4')
$(1)_dotfiles := $$(subst /_,/.,$$($(1)_dotfiles))
$(1)_dotfiles := $$(patsubst $(1)%.m4,$$(prefix)%,$$($(1)_dotfiles))

.PHONY: $(1) $(1)-install $(1)-uninstall
$(1) $(1)-install: $$$$($(1)_dotfiles)
$(1)-uninstall:
	rm -fR $$($(1)_dotfiles)
endef

$(foreach module,$(VPATH),$(eval $(call load_module,$(module))))

# Modules can use submakefiles to define their own macros or otherwise
# alter the install process.
sinclude $(addsuffix /module.mk,$(VPATH))

# Generate the command-line macro definitions.
defines := $(foreach macro,$(macros),-D __$(macro)__='$($(macro))')

src = $(patsubst .%,_%,$(subst /.,/_,$*)).m4
$(prefix)/% : $$(src) common.m4
	$(quiet)umask $(UMASK) && \
    mkdir -p -- "$$(dirname '$@')" && \
    '$(or $(M4),m4)' -P $(defines) common.m4 '$<' >'$@'
	@printf '$(if $(quiet),Wrote %s)\n' '$@' >&2
