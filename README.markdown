<!--
    README.markdown
    ---------------

    Written in 2018, 2021-2023 by Lawrence Velazquez <vq@larryv.me>.

    To the extent possible under law, the author(s) have dedicated all
    copyright and related and neighboring rights to this software to the
    public domain worldwide.  This software is distributed without any
    warranty.

    You should have received a copy of the CC0 Public Domain Dedication
    along with this software.  If not, see
    <http://creativecommons.org/publicdomain/zero/1.0/>.

    SPDX-License-Identifier: CC0-1.0
-->


# dotfiles #

These are my Unix dotfiles.  You almost certainly don't want to use them
-- that would be a bit like brushing with my toothbrush -- but you might
find a useful tidbit if you take a look.

In theory they're portable, but in practice they're only field-tested on
Mac OS.


## Installation ##

Intended reader: A future me who has suffered tragic memory loss.

Installation should work on systems that conform to [POSIX.1-2017][],
include [`make`][], and provide a POSIX shell at `/bin/sh`.  It is known
to work with [GNU Make][] 3.81, [GNU Bash][] 3.2.57, and [GNU M4][]
1.4.6.

  [POSIX.1-2017]: https://pubs.opengroup.org/onlinepubs/9699919799
  [`make`]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html
  [GNU Make]: https://www.gnu.org/software/make
  [GNU M4]: https://www.gnu.org/software/m4
  [GNU Bash]: https://www.gnu.org/software/bash

Invoke `make` from the project root or use the nonstandard `-C` option
to achieve the moral equivalent.

-   Install/uninstall all files:

        $ make install
        $ make uninstall

-   Install/uninstall files from specific top-level modules:

        $ make git-install
        $ make gnupg-install
        $ make zsh-install

        $ make git-uninstall
        $ make gnupg-uninstall
        $ make zsh-uninstall

The project assumes a destination of `$HOME`.  To use a different
directory (for testing, presumably), override `$HOME`.

    $ HOME=/tmp/test make install


## Legal ##

This work is published from the United States of America using the [CC0
1.0 Universal Public Domain Dedication][CC0].

  [CC0]: https://creativecommons.org/publicdomain/zero/1.0
