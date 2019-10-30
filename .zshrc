# git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
source "${HOME}/.zgen/zgen.zsh"
if ! zgen-saved; then
    zgen load ael-code/zsh-colored-man-pages
    zgen load mafredri/zsh-async async.zsh
    zgen load marzocchi/zsh-notify
    zgen load RobSis/zsh-completion-generator
    zgen load sindresorhus/pure pure.zsh
    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions src

    zgen save
fi

zstyle ':prompt:pure:path' color white
zstyle ':prompt:pure:prompt:error' color white
zstyle ':prompt:pure:prompt:success' color blue
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''

zstyle ':notify:*' error-title "WHAT!!!"
zstyle ':notify:*' success-title "Meh"
zstyle ':notify:*' activate-terminal yes
zstyle ':notify:*' command-complete-timeout 5

zle -N edit-command-line
autoload -Uz edit-command-line
bindkey -v
bindkey -M vicmd 'v' edit-command-line

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^r' history-incremental-search-backward
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt HIST_IGNORE_SPACE

WORDCHARS='*?-[]~=&;!#$%^(){}<>_'

HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000

export FZF_DEFAULT_COMMAND='fd -L --type f --type d'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export GO111MODULE=auto
export GOPATH="$HOME/.go"
export PATH="${PATH}:$GOPATH/bin:$HOME/.npm/bin:$HOME/.local/bin"
export VISUAL=vim

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/z.lua/z.lua.plugin.zsh
source ~/.aliases

