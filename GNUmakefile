.DELETE_ON_ERROR:

# Minimize differences between make implementations [1].
.SUFFIXES:
SHELL := /bin/sh

# Allow overriding of utilities [2].
INSTALL := ./install-sh
INSTALL_DATA := $(INSTALL) -m 644
M4 := m4

# Child directories listed here are considered "modules", containing "slices"
# of the final directory tree; these are "layered" during installation. Beyond
# rules for updating files, modules define their own convenience rules (e.g.,
# "make sh-install") and make them prerequisites of the analogous global rules
# (e.g., "make install").
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
	$$(if $$($(1)_dirs),$$(INSTALL) -d $$($(1)_dirs))
_$(1)-install: $(1) $(1)-installdirs
	$$(call gencmds,$$(INSTALL_DATA),$$($(1)_src_files),$$($(1)_dst_files))
_$(1)-uninstall:
	$$(RM) $$($(1)_dst_files)
endef

$(foreach module,$(MODULES),$(eval $(call create_module_rules,$(module))))

.PHONY: all clean installdirs install uninstall
.DEFAULT_GOAL := all
all: $(MODULES)
clean: $(addsuffix -clean,$(MODULES))
maintainer-clean: $(addsuffix -maintainer-clean,$(MODULES))
installdirs: $(addsuffix -installdirs,$(MODULES))
install: $(addsuffix -install,$(MODULES))
uninstall: $(addsuffix -uninstall,$(MODULES))

# Process M4 templates.
% : %.m4
	$(M4) $^ >$@


# References:
#
# 1. https://www.gnu.org/software/make/manual/html_node/Makefile-Basics
# 2. https://www.gnu.org/software/make/manual/html_node/Command-Variables
