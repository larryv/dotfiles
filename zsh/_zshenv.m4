__header__

ZDOTDIR='__zsh_dir__'

# I can't think of a good reason to allow duplicates in these arrays.
typeset -aU fpath path

fpath=($ZDOTDIR/functions(N) $fpath)

# Refresh compiled functions and startup scripts.
zwcs=({~/.zshenv,$ZDOTDIR{,/functions}/*}.zwc(DN))
if (( ${#zwcs} ))
then
    autoload -Uz zrecompile
    zrecompile -q $zwcs 2>/dev/null
fi
unset zwcs

# Source application-specific "topic" scripts.
for script in $ZDOTDIR/*.zshenv(N)
do
    . $script
done

m4_divert(«-1»)
vim: set filetype=zsh:
