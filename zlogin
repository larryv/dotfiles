# Most of these options are here because I don't want them to
# override preexisting environment variables from a calling shell.
# They are desirable for a login shell though.

export EDITOR='/usr/bin/env vim'
export GREP_OPTIONS='--color=auto'
export PAGER='/usr/bin/env less'

# Set JAVA_HOME dynamically, if a JVM is installed
if [[ ${OSTYPE} == darwin* ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home -F 2> /dev/null)"
    [[ -z ${JAVA_HOME} ]] && unset JAVA_HOME
fi

# Gnuplot
export GDFONTPATH=${HOME}/Library/Fonts:/Library/Fonts:/System/Library/Fonts
export GNUPLOT_DEFAULT_GDFONT=helvetica
export GNUTERM=x11      # AquaTerm is stupid and cuts shit off

# Custom lynx configuration
export LYNX_CFG=${HOME}/.lynx/lynx.cfg
