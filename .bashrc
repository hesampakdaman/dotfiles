# ==============================================================================
# ENVIRONMENT VARIABLES
# ==============================================================================
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR="emacsclient -c"
export SUDO_EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"
export TERM="xterm-256color"
export dotfiles="$HOME/dotfiles"
export GREP_COLORS='ms=01;32'

# ==============================================================================
# SHELL OPTIONS & BEHAVIOR
# ==============================================================================
[[ $- == *i* ]] && stty -ixon # Disable freeze C-s for interactive shells

# Sane defaults
shopt -s histappend   # append to the history file, don't overwrite it
shopt -s cmdhist      # save multi-line commands as one entry
shopt -s lithist      # conserve newlines and formatting

# ==============================================================================
# HISTORY SETTINGS
# ==============================================================================
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE="ls:cd:exit:pwd:clear"
export HISTTIMEFORMAT="%F %T "

# Initialize PROMPT_COMMAND with history sync
PROMPT_COMMAND="history -a"

# ==============================================================================
# PROMPT SETTINGS
# ==============================================================================
export PROMPT_DIRTRIM=2
export PS1="[\h][\w]\$ "

if [[ "$TERM" != "dumb" ]]; then
    # Append the theme source to the history-save command
    PROMPT_COMMAND="$PROMPT_COMMAND; [ -f ~/.bash_ps1.sh ] && source ~/.bash_ps1.sh"
fi

# ==============================================================================
# ALIASES & COLORS
# ==============================================================================
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Load external aliases if they exist
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# ==============================================================================
# EXTERNAL TOOLS & COMPLETIONS
# ==============================================================================

# Bash Completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# FZF (Key bindings and Completion)
if [ -f /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/key-bindings.bash
    source /usr/share/fzf/completion.bash
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
    export FZF_DEFAULT_OPTS='--height=100% --layout=reverse --border'

    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="
      --preview 'bat --color=always --style=numbers {}'
    "
fi

# zoxide (smart cd)
if command -v zoxide >/dev/null 2>&1; then
    export _ZO_ECHO=1
    eval "$(zoxide init bash)"
fi

# keychain (ssh agent)
if command -v keychain >/dev/null 2>&1 && [ -f ~/.ssh/id_ed25519 ]; then
    keychain --nogui --quiet ~/.ssh/id_ed25519
    [[ -f $HOME/.keychain/$(hostname)-sh ]] && source $HOME/.keychain/$(hostname)-sh
fi
