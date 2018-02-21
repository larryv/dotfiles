__header__

[[ -o LOGIN ]] || return 0

# The zsh documentation discourages setting environment variables from
# .zprofile or .zlogin (http://zsh.sourceforge.net/Intro/intro_3.html),
# so do it here.

# Set JAVA_HOME if a JVM is enabled. Verified on OS X / macOS only;
# I don't know how to do this on other systems, or whether it's even
# necessary.
#
# The unorthodox command substitution preserves the path that java_home
# outputs (http://www.etalabs.net/sh_tricks.html, § "Getting
# non-clobbered output from command substitution") without losing the
# exit status.
JAVA_HOME_temp=$(/usr/libexec/java_home -F 2>/dev/null; echo x$?)
if [[ ${JAVA_HOME_temp##*x} -eq 0 ]]
then
    # The character preceding "x" is a newline added by java_home.
    export JAVA_HOME=${JAVA_HOME_temp%?x*}
fi
unset JAVA_HOME_temp

# vim: set filetype=zsh:
