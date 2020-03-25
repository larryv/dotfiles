# If changing the paths, adjust macports/_zsh/macports.zshenv also. Iteration
# order is reversed from the desired order in PATH.
for dir in /opt/local/sbin /opt/local/bin; do
    if [ -d "$dir" ]; then
        PATH=$dir:$PATH
    fi
done
unset dir
