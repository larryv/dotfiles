MACPORTS := /opt/local
SUBSTITUTIONS += $(call encode,s|__MACPORTS__|$(MACPORTS)|g)
