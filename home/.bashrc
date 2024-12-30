# +------------------------------------+
# |    _               _               |
# |   | |__   __ _ ___| |__  _ __ ___  |
# |   | '_ \ / _` / __| '_ \| '__/ __| |
# |  _| |_) | (_| \__ \ | | | | | (__  |
# | (_)_.__/ \__,_|___/_| |_|_|  \___| |
# +------------------------------------+

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# bash prompt
# ┬─[user@hostname:pwd]─[HH:mm:ss]
# ╰─>$ command
PS1='\[\e[0;32m\]┬─[\[\e[0m\e[0;33m\]\u\[\e[0m@\[\e[0;36m\]\h\[\e[0m:\W\[\e[0;32m\]]─[\t]\n╰─>\[\e[0m\e[0;31m\]\$\[\e[0m\] '

# neovim
export EDITOR='nvim'
alias v='vi'
alias vi='vim'
alias vim='nvim'

# bat
export PAGER='bat'

# language
export LANG=en_US.UTF-8
export LANGUAGE=en_US

# thefuck
eval "$(thefuck --alias)"

# tgpt
alias a='tgpt'
alias ai='a -i'
alias am='a -m'
alias draw='tgpt -img'

# kitty
alias diff='kitten-diff'
alias icat='kitten-icat'

# alias
alias c='clear'
alias grep='grep --color=auto'
alias t='tmux'
alias h='history | sort -nr | bat'
alias ls='eza --icons --git'
alias lll='eza -l --icons --git'
alias ran='ranger'
alias df='duf'
alias top='htop'
alias whats='gh copilot explain'
alias howto='gh copilot suggest'
alias timeshift='sudo timeshift'
alias aafire='aafire -driver curses'
alias swaylock='swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 25x25 --effect-vignette 0.5:0.5 --ring-color b7bdf8 --key-hl-color f5bde6'

# functions
transzh() {
	trans :zh "$1"
}
transen() {
	trans :en "$1"
}

weather() {
	curl wttr.in/"$1"
}

frp-start() {
	sudo systemctl start sshd frpc
}

frp-stop() {
	sudo systemctl stop sshd frpc
}

frp-enable() {
	sudo systemctl enable --now sshd frpc
}

frp-disable() {
	sudo systemctl disable --now sshd frpc
}

frp-status() {
	systemctl status sshd frpc
}

pdf() {
	pdftotext "$1" - | bat
}

content() { # list all files recursively whose content contains the given string
	find . -type f -exec /bin/grep --color=auto -l "$1" {} +
}

kitten-icat() {
	kitty +kitten icat "$1"
}

kitten-diff() {
	kitty +kitten diff "$1" "$2"
}

export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:~/.dotnet/tools

source "$HOME"/.local/bin/env
