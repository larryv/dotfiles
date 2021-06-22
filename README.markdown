# dotfiles #

These are my Unix dotfiles. You almost certainly don't want to use them --
that would be a bit like brushing with my toothbrush -- but you might find
a useful setting or two if you take a look.

In theory they're portable, but in practice they're only field-tested on
macOS.

## Installation ##

Intended reader: A future me who has suffered tragic memory loss.

Installation is verified to work with GNU [Make][] 3.81 and GNU [M4][] 1.4.6.
It may or may not work with other versions.

  [Make]: https://www.gnu.org/software/make
  [M4]: https://www.gnu.org/software/m4

Commands must be run from the project root.

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

The project assumes a destination of `$HOME`. To use a different
directory (for testing, presumably), override `$HOME`.

    $ HOME=/tmp/test make install
