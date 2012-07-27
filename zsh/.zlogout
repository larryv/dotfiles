# On FreeBSD, terminate ssh-agent in a sensible manner, since
# subsequent shells won't be able to access it anyway
# if [[ "${OSTYPE}" =~ '^freebsd' ]]; then
#     if ! (ssh-add -l &> /dev/null); then
#         eval $(ssh-agent -ks)
#     fi
# fi
