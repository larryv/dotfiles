# On Mac OS X / OS X / macOS, set JAVA_HOME if a JVM is enabled. I don't know
# how to do this on other systems, or whether it's even necessary.

# https://www.etalabs.net/sh_tricks.html, § "Getting non-clobbered output from
# command substitution"
JAVA_HOME=$(/usr/libexec/java_home --failfast 2>/dev/null && echo x) \
    && export JAVA_HOME="${JAVA_HOME%??}" \
    || unset JAVA_HOME
