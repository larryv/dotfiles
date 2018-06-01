MACPORTS := /opt/local
export quoted_MACPORTS := $(call shellquote,$(value MACPORTS))

macports_clean_files := macports/_zsh/macports.zprofile \
                        macports/_zsh/macports.zshenv
