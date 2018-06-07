# Flotsam and jetsam.
.DELETE_ON_ERROR:
.NOTPARALLEL:           # mkdir -p may cause race conditions.
.SECONDEXPANSION:
.SUFFIXES:

# External programs.
SHELL := /bin/sh
M4 := m4

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
cp $(1) ~/$(call installpath,$(1))

endef

# Generate per-module targets and prerequisites. For example:
#   - "make git": create Git-related dotfiles
#   - "make git-install": install Git-related dotfiles
#   - "make git-uninstall": uninstall Git-related dotfiles
#   - "make" / "make all": create all dotfiles
#   - "make install": install all dotfiles
#   - "make uninstall": uninstall all dotfiles

define load_module
include $(1)/module.mk

# Modules can declare three lists of files to install:
#   - *_files: should never be deleted
#   - *_clean_files: should be deleted by "make clean" and "make maintainer-clean"
#   - *_maintclean_files: should be deleted by "make maintainer-clean"
$(1)_src_files := $$(sort $$($(1)_files) \
                          $$($(1)_clean_files) \
                          $$($(1)_maintclean_files))

# Determine which directories to try creating.
$(1)_dirs := $$(filter-out ./,$$(sort $$(dir $$(call installpath,$$($(1)_src_files)))))

# Modules can augment these dummy targets.
.PHONY: $(1) $$(addprefix $(1)-,clean installdirs install uninstall)
$(1): $$$$($(1)_src_files)
$(1)-clean: _$(1)-clean
$(1)-maintainer-clean: _$(1)-maintainer-clean
$(1)-installdirs: _$(1)-installdirs
$(1)-install: _$(1)-install
$(1)-uninstall: _$(1)-uninstall

# Helper targets that do the real work.
.PHONY: $$(addprefix _$(1)-,clean installdirs install uninstall)
_$(1)-clean:
	$$(if $$($(1)_clean_files),$$(RM) $$($(1)_clean_files))
_$(1)-maintainer-clean: $(1)-clean
	$$(if $$($(1)_maintclean_files),$$(RM) $$($(1)_maintclean_files))
# TODO: Remove unnecessary directories from installdirs.
_$(1)-installdirs:
	$$(if $$($(1)_dirs),cd && mkdir -p $$($(1)_dirs))
_$(1)-install: $(1) $(1)-installdirs
	$$(foreach f,$$($(1)_src_files),$$(call installcmd,$$(f)))
_$(1)-uninstall:
	cd && $$(RM) $$(call installpath,$$($(1)_src_files))
endef

$(foreach module,$(MODULES),$(eval $(call load_module,$(module))))

.PHONY: all clean installdirs install uninstall
.DEFAULT_GOAL := all
all: $(MODULES)
clean: $(addsuffix -clean,$(MODULES))
maintainer-clean: $(addsuffix -maintainer-clean,$(MODULES))
installdirs: $(addsuffix -installdirs,$(MODULES))
install: $(addsuffix -install,$(MODULES))
uninstall: $(addsuffix -uninstall,$(MODULES))

% :: common.m4 $$@.m4
	$(M4) $^ >$@
