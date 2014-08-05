colemakerel_DOTFILES := $(subst lesskey,.colemakerel/less,$(colemakerel_DOTFILES))

$(prefix)/.colemakerel/less: lesskey
	@mkdir -p -- "$(dir $@)"
	@lesskey --output="$@" "$<"
	@printf "Wrote $@\n" >&2
