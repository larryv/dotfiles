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
MODULES := git gnupg java lynx macports mercurial tmux zsh

# Transform repository pathnames into installation pathnames by replacing
# leading underscores with dots and removing the prefixed module name.
installpath = $(foreach f,$(subst /_,/.,$(1)),$(patsubst $(firstword $(subst /, ,$(f)))/%,%,$(f)))

# The _*-install targets repeat this command once for each file. Store
# it in a variable to preserve the trailing newline, or else the
# repetition erroneously produces one very long command.
define installcmd
umask $(UMASK) && cp $(1) '$(prefix)/$(call installpath,$(1))'

endef

# Generate per-module targets and prerequisites. For example:
#   - "make git": create Git-related dotfiles
#   - "make git-install": install Git-related dotfiles
#   - "make git-uninstall": uninstall Git-related dotfiles
#   - "make" / "make all": create all dotfiles
#   - "make install": install all dotfiles
#   - "make uninstall": uninstall all dotfiles

define load_module
# Find M4 templates automatically. Modules can add other files explicitly.
$(1)_files := $$(basename $$(shell find $(1) -type f -name '*.m4'))
$(1)_dirs = $$(filter-out ./,$$(sort $$(dir $$(call installpath,$$($(1)_files)))))

# Modules can "overload" these targets because they lack recipes.
.PHONY: $(1) $$(addprefix $(1)-,clean installdirs install uninstall)
$(1): $$$$($(1)_files)
$(1)-clean: _$(1)-clean
$(1)-installdirs: _$(1)-installdirs
$(1)-install: _$(1)-install
$(1)-uninstall: _$(1)-uninstall

# Helper targets that do the real work.
.PHONY: $$(addprefix _$(1)-,clean installdirs install uninstall)
_$(1)-clean:
	$$(RM) $$($(1)_files)
# TODO: Remove unnecessary directories from installdirs.
_$(1)-installdirs:
	$$(if $$($(1)_dirs),cd -- '$$(prefix)' && umask $(UMASK) && mkdir -p $$($(1)_dirs))
_$(1)-install: $(1) $(1)-installdirs
	$$(foreach f,$$($(1)_files),$$(call installcmd,$$(f)))
_$(1)-uninstall:
	cd -- '$$(prefix)' && $$(RM) $$(call installpath,$$($(1)_files))
endef

$(foreach module,$(MODULES),$(eval $(call load_module,$(module))))

# Let modules alter the install process.
sinclude $(addsuffix /module.mk,$(MODULES))

.PHONY: all clean installdirs install uninstall
.DEFAULT_GOAL := all
all: $(MODULES)
clean: $(addsuffix -clean,$(MODULES))
installdirs: $(addsuffix -installdirs,$(MODULES))
install: $(addsuffix -install,$(MODULES))
uninstall: $(addsuffix -uninstall,$(MODULES))

# Generate the command-line macro definitions.
defines := $(foreach macro,$(macros),-D __$(macro)__='$($(macro))')

% :: common.m4 $$@.m4
	$(M4) -P $(defines) $^ >$@
