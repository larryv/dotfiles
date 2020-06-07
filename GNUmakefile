# Front matter.
.DELETE_ON_ERROR:
.NOTPARALLEL:           # mkdir -p may cause race conditions.
.SUFFIXES:
SHELL := /bin/sh
M4 := m4

# The repository's child directories are "modules", containing "slices"
# of the final directory tree. These are "layered" during installation.
MODULES := git gnupg java lynx macports mercurial sh tmux zsh

# Given a prefix and two lists, expands to a string consisting of each pair of
# corresponding words on its own line, preceded by the prefix. Designed for
# generating series of commands for rules.
gencmds = $(call _gencmds,$(1),$(2),$(3),$(words $(2)))
define _gencmds
$(if $(and $(2),$(3)),$(1) $(firstword $(2)) $(firstword $(3))
$(call $(0),$(1),$(wordlist 2,$(4),$(2)),$(wordlist 2,$(4),$(3)),$(4)))
endef

# Given a list of paths, return the ones that are not prefixes of any
# other path. The output is intended for use with "mkdir -p", which
# implicitly creates the parent directories of its arguments.
collapsedirs = $(strip $(call _collapsedirs,$(sort $(1)),$(words $(1))))
define _collapsedirs
$(if $(1),\
    $(if $(filter $(firstword $(1))%,$(wordlist 2,$(2),$(1))),,$(firstword $(1)))\
    $(call $(0),$(wordlist 2,$(2),$(1)),$(2)))
endef

# Read module configurations and create per-module rules. For example:
#   - "make git": create Git-related dotfiles
#   - "make git-install": install Git-related dotfiles
#   - "make git-uninstall": uninstall Git-related dotfiles

include $(addsuffix /module.mk,$(MODULES))

define create_module_rules
# Modules can declare three lists of files to install:
#   - *_files: should never be deleted
#   - *_clean_files: should be deleted by "make clean" and "make maintainer-clean"
#   - *_maintclean_files: should be deleted by "make maintainer-clean"
$(1)_src_files := $$(sort $$($(1)_files) \
                          $$($(1)_clean_files) \
                          $$($(1)_maintclean_files))

# Transform repository pathnames into installation pathnames by replacing
# leading underscores with dots and removing the prefixed module name.
$(1)_dst_files := $$(patsubst $(1)/%,~/%,$$(subst /_,/.,$$($(1)_src_files)))

# Determine which directories to try creating.
$(1)_dirs := $$(filter-out ~/,$$(call collapsedirs,$$(dir $$($(1)_dst_files))))

# Modules can augment these dummy targets.
.PHONY: $(1) $$(addprefix $(1)-,clean installdirs install uninstall)
$(1): $$($(1)_src_files)
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
_$(1)-installdirs:
	$$(if $$($(1)_dirs),mkdir -p $$($(1)_dirs))
_$(1)-install: $(1) $(1)-installdirs
	$$(call gencmds,cp,$$($(1)_src_files),$$($(1)_dst_files))
_$(1)-uninstall:
	$$(RM) $$($(1)_dst_files)
endef

$(foreach module,$(MODULES),$(eval $(call create_module_rules,$(module))))

# Create rules that apply to all modules. For example:
#   - "make" / "make all": create all dotfiles
#   - "make install": install all dotfiles
#   - "make uninstall": uninstall all dotfiles
.PHONY: all clean installdirs install uninstall
.DEFAULT_GOAL := all
all: $(MODULES)
clean: $(addsuffix -clean,$(MODULES))
maintainer-clean: $(addsuffix -maintainer-clean,$(MODULES))
installdirs: $(addsuffix -installdirs,$(MODULES))
install: $(addsuffix -install,$(MODULES))
uninstall: $(addsuffix -uninstall,$(MODULES))

# Process M4 templates.
% : common.m4 %.m4
	$(M4) $^ >$@
