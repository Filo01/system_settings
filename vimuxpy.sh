###Starts vim inside a split tmux window

exec 2>/dev/null

function start_tmux {
	fbname=$(basename "$1" | cut -d. -f1)	
	if `tmux has-session -t $fbname`; then
		tmux attach-session -t $fbname
	else
		create_new $fbname $1
	fi
}

function create_new {
	
	tmux new-session -s $fbname \; \
	       	send-keys 'vim ' "$2" C-m \; \
		split-window -v -p 20 \; \
		select-pane -U \;	
} 


if `git rev-parse --show-toplevel` ; then
	start_tmux `git rev-parse --show-toplevel`
else
	start_tmux $1
fi

