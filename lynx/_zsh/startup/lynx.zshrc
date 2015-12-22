# Tell Lynx where to find its configuration.
if [[ -o LOGIN ]]
then
    export LYNX_CFG=__PREFIX__/.lynx/lynx.cfg
fi

# vim: filetype=zsh
