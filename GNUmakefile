# Flotsam and jetsam.
.NOTPARALLEL:           # mkdir -p may cause race conditions.
.SECONDEXPANSION:
.SUFFIXES:

# External programs.
SHELL := /bin/sh
M4 := m4

# The GnuPG dotfiles require restrictive permissions.
UMASK := 077

# Template parameters.
prefix := $(wildcard ~)
macros := prefix

# The repository's child directories are "modules", containing "slices"
# of the final directory tree. These are "layered" during installation.
VPATH := git gnupg java lynx macports mercurial tmux zsh

# Generate per-module targets and prerequisites. For example:
#   - "make git" / "make git-install": install Git-related dotfiles
#   - "make git-uninstall": uninstall Git-related dotfiles
#   - "make install": install all dotfiles
#   - "make uninstall": uninstall all dotfiles

.PHONY: install uninstall
install: $(addsuffix -install,$(VPATH))
uninstall: $(addsuffix -uninstall,$(VPATH))

define load_module
# Find M4 templates automatically. Modules can add other files explicitly.
$(1)_files := $$(shell find $(1) -type f -name '*.m4')
$(1)_files := $$(subst /_,/.,$$($(1)_files))
$(1)_files := $$(patsubst $(1)%.m4,$$(prefix)%,$$($(1)_files))

.PHONY: $(1) $(1)-install $(1)-uninstall
$(1) $(1)-install: $$$$($(1)_files)
$(1)-uninstall:
	rm -fR $$($(1)_files)
endef

$(foreach module,$(VPATH),$(eval $(call load_module,$(module))))

# Let modules alter the install process.
sinclude $(addsuffix /module.mk,$(VPATH))

# Generate the command-line macro definitions.
defines := $(foreach macro,$(macros),-D __$(macro)__='$($(macro))')

src = $(patsubst .%,_%,$(subst /.,/_,$*)).m4
$(prefix)/% : $$(src) common.m4
	umask $(UMASK) && \
    mkdir -p -- "$$(dirname '$@')" && \
    $(M4) -P $(defines) common.m4 '$<' >'$@'
