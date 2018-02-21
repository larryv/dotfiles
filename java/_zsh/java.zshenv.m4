__header__

[[ -o LOGIN ]] || return 0

# The zsh documentation discourages setting environment variables from
# .zprofile or .zlogin (http://zsh.sourceforge.net/Intro/intro_3.html),
# so do it here.

# Set JAVA_HOME if a JVM is enabled. Verified on OS X / macOS only;
# I don't know how to do this on other systems, or whether it's even
# necessary.
export JAVA_HOME
JAVA_HOME=$(/usr/libexec/java_home -F 2>/dev/null) || unset JAVA_HOME

# vim: set filetype=zsh:
