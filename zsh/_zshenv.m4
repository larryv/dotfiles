__header__

# The zsh documentation discourages setting environment variables from
# .zprofile or .zlogin (http://zsh.sourceforge.net/Intro/intro_3.html),
# so do it here.

# Set JAVA_HOME if a JVM is enabled. This particular method only works
# on OS X; I don't know how to do it on other systems, or whether it's
# even necessary.
if [[ -o LOGIN ]]
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
