# lynx/_lynx.cfg.m4
# -----------------
#
# Written in 2013-2014, 2016, 2018, 2020-2022 by Lawrence Velazquez
# <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.
#
# SPDX-License-Identifier: CC0-1.0


syscmd(`test -d ~/Downloads')dnl
ifelse(sysval, `0', `SAVE_SPACE:~/Downloads

')dnl
# Local settings.
INCLUDE:.lynx.cfg.local

# vim: set filetype=lynx:
