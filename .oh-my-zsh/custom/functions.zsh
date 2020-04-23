###############################################################################
# Functions
#
# My personal functions to make life happier
###############################################################################

aws.sso() {
    export AWS_PROFILE="$1"
    aws sso login --profile "$1"
}

tmx() {
  # Get the current directory's name
	DIR_NAME=${PWD##*/}
  # Replace any '.' in the name since tmux hates that
	SESS_NAME=${DIR_NAME/./dot_}
	# Try to attach to an existing session, if not, create a new one
	tmux attach -t ${SESS_NAME} || tmux new -s ${SESS_NAME} 
}

# Use FZF to switch Tmux sessions:
# bind-key s run "tmux new-window 'bash -ci fs'"
fs() {
	local -r fmt='#{session_id}:|#S|(#{session_attached} attached)'
	{ tmux display-message -p -F "$fmt" && tmux list-sessions -F "$fmt"; } \
		| awk '!seen[$1]++' \
		| column -t -s'|' \
		| fzf -q '$' --reverse --prompt 'switch session: ' -1 \
		| cut -d':' -f1 \
		| xargs tmux switch-client -t
}
