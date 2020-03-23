[[ -o LOGIN ]] || return 0

# The zsh documentation discourages setting environment variables from
# .zprofile or .zlogin (http://zsh.sourceforge.net/Intro/intro_3.html),
# so do it here.

# Set JAVA_HOME if a JVM is enabled. Verified on OS X / macOS only;
# I don't know how to do this on other systems, or whether it's even
# necessary.

# https://www.etalabs.net/sh_tricks.html, § "Getting non-clobbered output from
# command substitution"
JAVA_HOME=$(/usr/libexec/java_home --failfast 2>/dev/null && echo x) \
    && export JAVA_HOME=${JAVA_HOME%??} \
    || unset JAVA_HOME

# vim: set filetype=zsh:
