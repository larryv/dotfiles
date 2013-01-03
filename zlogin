# Most of these options are here because I don't want them to
# override preexisting environment variables from a calling shell.
# They are desirable for a login shell though.

export EDITOR='/usr/bin/env vim'
export GREP_OPTIONS='--color=auto'
export PAGER='/usr/bin/env less'

if [[ ${OSTYPE} == darwin* ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home -F 2> /dev/null)"
    if [[ -z ${JAVA_HOME} ]]; then unset JAVA_HOME; fi
fi

# Gnuplot
export GDFONTPATH=${HOME}/Library/Fonts:/Library/Fonts:/System/Library/Fonts
export GNUPLOT_DEFAULT_GDFONT=helvetica
export GNUTERM=x11      # AquaTerm is stupid and cuts shit off
