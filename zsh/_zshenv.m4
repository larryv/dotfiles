__header__

# The zsh documentation discourages setting environment variables in
# .zprofile or .zlogin (http://zsh.sourceforge.net/Intro/intro_3.html),
# so do it here.

# Set JAVA_HOME dynamically, if a JVM is installed.
if [[ -o LOGIN && $OSTYPE == darwin* ]]
then
    export JAVA_HOME="$(/usr/libexec/java_home -F 2> /dev/null)"
    [[ -z $JAVA_HOME ]] && unset JAVA_HOME
fi

# Source application-specific "topic" scripts.
for script in __zsh_dir__/*.zshenv(N)
do
    . $script
done

m4_divert(«-1»)
vim: set filetype=zsh:
