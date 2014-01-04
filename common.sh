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
        # The root directory is intentionally represented by the null string.
        (cd -P "$1" && printf '%s' "${PWD%/}")
    elif [ -f "$1" ]; then
        rcp_DIR=$(ResolveCanonicalPath $(dirname "$1"))
        rcp_FILE=$(basename "$1")
        [ -z "$rcp_DIR" ] || [ -z "$rcp_FILE" ] && return 1;

        printf '%s/%s' "$rcp_DIR" "$rcp_FILE"
    fi
}

# Usage: CreateAbsoluteSymlinks [-df] src [src2 ...] TARGET_DIR
CreateAbsoluteSymlinks() {
    # We currently ignore invalid options.
    cas_DOTTED=
    cas_FORCE=
    while getopts df opt; do
        case $opt in
            d) cas_DOTTED=. ;;
            f) cas_FORCE=-f ;;
        esac
    done
    shift $(($OPTIND - 1))

    # Too few non-option arguments.
    if [ $# -lt 2 ]; then
        # TODO: Print informative error.
        return 1
    fi

    # TODO: Allow final argument to be a non-directory, mirroring ln(s).

    # Extract final argument sans trailing slashes. The root directory
    # is intentionally represented by the null string.
    eval cas_TARGET_DIR='${'$#'%/}'

    # Create the symlinks using absolute source paths.
    until [ $# -eq 1 ]; do
        cas_SOURCE=$(ResolveCanonicalPath "$1")
        cas_TARGET=$cas_TARGET_DIR/${cas_DOTTED}$(basename "$1")

        cas_RESULT='Failed to symlink'
        if [ -n "$cas_SOURCE" ] && [ -n "$cas_TARGET" ]; then
            ln -s $cas_FORCE "$cas_SOURCE" "$cas_TARGET" && cas_RESULTS=Symlinked
        fi
        printf '%s %s as %s\n' "$cas_RESULT" "$cas_SOURCE" "$cas_TARGET"

        shift
    done
}
