<!--
    .github/README.md
    -----------------

    SPDX-License-Identifier: CC0-1.0

    Written by Lawrence Velazquez <vq@larryv.me> in:
      - 2018, 2021-2023 (as README.markdown)
      - 2023 (as README.md)

    To the extent possible under law, the author has dedicated all
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
Mac&nbsp;OS.


## Installation ##

Intended reader: A future me who has suffered tragic memory loss.

Installation should work on any system that conforms to
[POSIX.1-2017][POSIX] and includes [`make(1)`][MAKE].  It is known to
work with [GNU Make][GMAKE] 3.81, [GNU Bash][BASH] 3.2.57, and
[GNU M4][GM4] 1.4.6.

  [POSIX]: https://pubs.opengroup.org/onlinepubs/9699919799/
  [MAKE]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html "POSIX.1-2017 - XCU Chapter 4 (Utilities - make)"
  [GMAKE]: https://www.gnu.org/software/make/
  [BASH]: https://www.gnu.org/software/bash/
  [GM4]: https://www.gnu.org/software/m4/

Invoke `make(1)` from the project root or use the nonstandard `-C`
option to achieve the moral equivalent.

-   Install/uninstall all files:

    ```sh
    make install
    ```

    ```sh
    make uninstall
    ```

-   Install/uninstall files from specific modules:

    ```sh
    make git-install gnupg-install zsh-install
    ```

    ```sh
    make git-uninstall gnupg-uninstall zsh-uninstall
    ```

Files are always installed to `$HOME`.  To use a directory other than
the user's home directory (e.g., for testing), override `HOME`.

```sh
HOME=/tmp/dotfiles_test make install
```

The build system uses `m4` by default.  If that is unusable, override
`M4` as necessary.

```sh
make M4=gm4 install
```


## Testing ##

Intended reader: A future me who is trying to be responsible for once.

Some (but not all) modules provide best-effort sanity checks.  These are
not particularly rigorous, so don't take passing results too seriously.

Invoke `make(1)` from the project root or use the nonstandard `-C`
option to achieve the moral equivalent.

-   Run all tests:

    ```sh
    make check
    ```

-   Run tests from specific modules:

    ```sh
    make git-check gnupg-check zsh-check
    ```

The tests use nonstandard tools, which are listed in
[the makefile][MAKEFILE].  If any of the defaults are unsuitable,
override them as necessary.

  [MAKEFILE]: ../Makefile

```sh
make GPG=gpg2 SHELLCHECK=/opt/local/bin/shellcheck gnupg-check
```


## Legal ##

To the extent possible under law, the author has [dedicated][CC0] all
copyright and related and neighboring rights to this software to the
public domain worldwide.  This software is published from the United
States of America and distributed without any warranty.

Refer to [`install-sh`][INSTALL-SH] for its separate licensing terms.

  [CC0]: ../COPYING.txt "CC0 1.0 Universal Public Domain Dedication"
  [INSTALL-SH]: ../install-sh
