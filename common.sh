# -----
# "Library" of common functionality.
# -----

# Usage: ResolveCanonicalPath PATH
ResolveCanonicalPath() {
    # Too many arguments.
    if [ $# -gt 1 ]; then
        # TODO: Print informative error.
        return 1
    fi

    # TODO: Handle symlinks.
    if [ -d "$1" ]; then
        (cd -P "$1" && printf '%s' "$PWD")
    elif [ -f "$1" ]; then
        rcp_DIR=$(ResolveCanonicalPath $(dirname -- "$1"))
        rcp_FILE=$(basename -- "$1")
        [ -z "$rcp_DIR" ] || [ -z "$rcp_FILE" ] && return 1;

        printf '%s/%s' "$rcp_DIR" "$rcp_FILE"
    fi
}

# Usage: ln_abs [-fs] source_file target_file
ln_abs() {
    # Make sure our getopts doesn't pick up where another getopts left off.
    OPTIND=1

    ln_FORCE=
    ln_SYMLINK=
    while getopts fs opt; do
        case $opt in
            f) ln_FORCE=-f ;;
            s) ln_SYMLINK=-s ;;
        esac
    done
    shift $(($OPTIND - 1))

    # Wrong number of non-option arguments.
    if [ $# -ne 2 ]; then
        # TODO: Print informative error.
        return 1
    fi

    ln_SOURCE=$(ResolveCanonicalPath -- "$1")
    ln_TARGET=$2

    if [ -n "$ln_SOURCE" ] &&
        ln $ln_FORCE $ln_SYMLINK -- "$ln_SOURCE" "$ln_TARGET"
    then
        printf 'OK: ' >&2
    else
        printf 'FAILED: ' >&2
    fi
    printf '%s -> %s\n' "$ln_TARGET" "$ln_SOURCE" >&2
}

# Make sure our getopts doesn't pick up where other getopts left off.
OPTIND=1
