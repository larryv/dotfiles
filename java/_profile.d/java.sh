# On Mac OS X / OS X / macOS, set JAVA_HOME if a JVM is enabled. I don't know
# how to do this on other systems, or whether it's even necessary.

if [ -z "$JAVA_HOME" ]; then
    # https://www.etalabs.net/sh_tricks.html, § "Getting non-clobbered output
    # from command substitution"
    if jh=$(/usr/libexec/java_home --failfast 2>/dev/null && echo x); then
        save_vars LC_CTYPE
        LC_CTYPE=C
        export JAVA_HOME="${jh%??}"
        restore_vars LC_CTYPE
    fi
    unset jh
fi
