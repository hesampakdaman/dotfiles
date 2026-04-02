#
# ~/.bashrc
#
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

### editor
export EDITOR="emacsclient -c"
export SUDO_EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"

### history
HISTCONTROL=ignoreboth
HISTFILE=~/.bash_history
HISTSIZE=9999
shopt -s histappend

# update window size after each line
shopt -s checkwinsize

### misc
TERM="xterm-256color"
GREP_COLOR="32"
LC_ALL=en_US.UTF-8
dotfiles=$HOME/dotfiles

PROMPT_DIRTRIM=2
export PS1="[\h][\w]\$ "
if [[ "$TERM" != "dumb" ]]; then
    # This runs the source command only in "real" terminals like Ghostty
    PROMPT_COMMAND='[ -f ~/.bash_ps1.sh ] && source ~/.bash_ps1.sh'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# alias
[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# disable freeze C-s
[[ $- == *i* ]] && stty -ixon

if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    . /usr/share/doc/fzf/examples/key-bindings.bash
fi

if command -v zoxide >/dev/null 2>&1; then
    export _ZO_ECHO=1
    eval "$(zoxide init bash)"
fi

[[ -f /usr/bin/keychain ]] && keychain --nogui --quiet ~/.ssh/id_ed25519
[[ -f $HOME/.keychain/$HOSTNAME-sh ]] && source $HOME/.keychain/$HOSTNAME-sh
