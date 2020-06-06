# Move MacPorts directories to the beginning of PATH so its software takes
# precedence over the system's. I used to add the directories to PATH in this
# file, but any files sourced earlier could not find MacPorts-installed
# software. Using /etc/paths.d gets the directories into PATH as soon as the
# system startup files are sourced, but they are appended after the default
# entries. (See the path_helper(8) man page for more information.)

# MacPorts does not provide this file; I create it myself. It usually contains
# only "/opt/local/bin" and "/opt/local/sbin".
macports_paths_file=/etc/paths.d/macports

[ -f "$macports_paths_file" ] || { unset macports_paths_file; return; }

macports_paths=

# path_helper(8) operates linewise, ignoring blanks.
while IFS= read -r macports_dir || [ -n "$macports_dir" ]; do
    [ -n "$macports_dir" ] || continue

    # Remove the directory from PATH to keep things clean. Fortunately,
    # path_helper(8) ensures each entry is unique, so search only once.
    case $PATH in
        "$macports_dir")
            PATH=
            ;;
        "$macports_dir":*)
            PATH=${PATH#"$macports_dir":}
            ;;
        *:"$macports_dir":*)
            PATH=${PATH%%:"$macports_dir":*}:${PATH#*:"$macports_dir":}
            ;;
        *:"$macports_dir")
            PATH=${PATH%:"$macports_dir"}
            ;;
        *)
            # The absence of the directory from PATH suggests a deeper problem
            # that should be investigated. Do not work around it by adding the
            # directory, but inform the user.
            printf 'Directory in %s missing from PATH: %s\n' \
                "$macports_paths_file" "$macports_dir" >&2
            continue
            ;;
    esac

    macports_paths=$macports_paths$macports_dir:
done <"$macports_paths_file"

if [ -n "$PATH" ]; then
    PATH=$macports_paths$PATH
else
    PATH=${macports_paths%:}
fi

unset macports_paths_file macports_paths macports_dir
