# On Mac, set JAVA_HOME to the active JVM, if there is one.

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
