<!--
    .github/README.md
    -----------------

    SPDX-License-Identifier: CC0-1.0

    Written by Lawrence Velazquez <vq@larryv.me> in:
      - 2018, 2021-2023 (as README.markdown)
      - 2023 (as README.md)

    To the extent possible under law, the author(s) have dedicated all
    copyright and related and neighboring rights to this software to the
    public domain worldwide.  This software is distributed without any
    warranty.

    You should have received a copy of the CC0 Public Domain Dedication
    along with this software.  If not, see
    <https://creativecommons.org/publicdomain/zero/1.0/>.
-->


# dotfiles #

These are my hopelessly overengineered Unix dotfiles.  You definitely
don't want to use them -- that'd be like using my toothbrush -- but you
might find a useful tidbit somewhere in the bristles.  End analogy.

In theory they're portable, but in practice they're only field-tested on
Mac OS.


## Installation ##

Intended reader: A future me who has suffered tragic memory loss.

Installation should work on any system that conforms to
[POSIX.1-2017][] and includes [`make`][].  It is known to
work with [GNU Make][] 3.81, [GNU Bash][] 3.2.57, and
[GNU M4][] 1.4.6.

  [POSIX.1-2017]: https://pubs.opengroup.org/onlinepubs/9699919799
  [`make`]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html
  [GNU Make]: https://www.gnu.org/software/make
  [GNU Bash]: https://www.gnu.org/software/bash
  [GNU M4]: https://www.gnu.org/software/m4

Invoke `make` from the project root or use the nonstandard `-C`
option to achieve the moral equivalent.

-   Install/uninstall all files:

        $ make install
        $ make uninstall

-   Install/uninstall files from specific modules:

        $ make git-install
        $ make gnupg-install
        $ make zsh-install

        $ make git-uninstall
        $ make gnupg-uninstall
        $ make zsh-uninstall

Files are always installed to `$HOME`.  To use a directory other than
the user's home directory (e.g., for testing), override `$HOME`.

    $ HOME=/tmp/dotfiles_test make install

The build system uses `/bin/sh` and `m4` by default.  If those are
unusable, override `SHELL` or `M4` as necessary (but note that some
tools may be hard-coded to use `/bin/sh`).

    $ make SHELL=/usr/local/bin/sh M4=gm4 install


## Testing ##

Intended reader: A future me who is trying to be responsible for once.

Some (but not all) modules provide best-effort sanity checks.  These are
not particularly rigorous, so don't take passing results too seriously.

Invoke `make` from the project root or use the nonstandard `-C`
option to achieve the moral equivalent.

-   Run all tests:

        $ make check

-   Run tests from specific modules:

        $ make git-check
        $ make gnupg-check
        $ make zsh-check

The tests use nonstandard tools, which are listed in
[the makefile][].  If any of the defaults are unsuitable,
override them as necessary.

  [the makefile]: ../Makefile

    $ make GPG=gpg2 SHELLCHECK=/opt/local/bin/shellcheck gnupg-check


## Legal ##

Unless otherwise noted, this work is published from the United States of
America using the [CC0 1.0 Universal Public Domain Dedication][CC0].

  [CC0]: https://creativecommons.org/publicdomain/zero/1.0
