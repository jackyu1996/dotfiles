source "/usr/share/zinit/zinit.zsh"
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit wait lucid for \
    ael-code/zsh-colored-man-pages \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    marzocchi/zsh-notify \
    agkozak/zsh-z

zstyle ':prompt:pure:path' color white
zstyle ':prompt:pure:prompt:error' color white
zstyle ':prompt:pure:prompt:success' color blue
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle ':notify:*' error-title "WHAT!!!"
zstyle ':notify:*' success-title "Meh"
zstyle ':notify:*' activate-terminal yes

zle -N edit-command-line
autoload -Uz edit-command-line
bindkey -v
bindkey -M vicmd 'v' edit-command-line

autoload -Uz compinit
compinit

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^r' history-incremental-search-backward
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHDMINUS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

WORDCHARS='*?-[]~=&;!#$%^(){}<>_'

HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000

export FZF_DEFAULT_COMMAND="fd -L --type f --type d"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export GO111MODULE=on
export GOPROXY="https://goproxy.cn,direct"
export GOPATH="$HOME/.go"
export PIPENV_PYPI_MIRROR="https://pypi.tuna.tsinghua.edu.cn/simple"
export ANDROID_SDK_ROOT="$HOME/.android/sdk/"
export PATH="${PATH}:$HOME/.local/bin:$GOPATH/bin"
export VISUAL=vim
export NVM_DIR="$HOME/.nvm"

source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source ~/.aliases
source ~/.functions
