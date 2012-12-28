# Most of these options are here because I don't want them to
# override preexisting environment variables from a calling shell.
# They are desirable for a login shell though.

export EDITOR='/usr/bin/env vim'
export GREP_OPTIONS='--color=auto'
export PAGER='/usr/bin/env less'

if [[ ${OSTYPE} == darwin* ]]; then
    if [[ -x /opt/local/bin/mvim ]]; then
        # MacVim
        export VISUAL='/usr/bin/env mvim --nofork'
        export LESSEDIT='/usr/bin/env mvim +%lm -- %f'
    elif [[ -x /usr/local/bin/mate ]]; then
        # TextMate
        export VISUAL='/usr/bin/env mate --wait'
        export LESSEDIT='/usr/bin/env mate --line %lm %f'
    fi

    function {
        local JH=/usr/libexec/java_home
        if [[ -x ${JH} ]] && JAVA_HOME=$(${JH} -F 2> /dev/null); then
            export JAVA_HOME
        fi
    }
fi

# Gnuplot
export GDFONTPATH=${HOME}/Library/Fonts:/Library/Fonts:/System/Library/Fonts
export GNUPLOT_DEFAULT_GDFONT=helvetica
export GNUTERM=x11      # AquaTerm is stupid and cuts shit off

# Disable term output flow control
stty -ixon
