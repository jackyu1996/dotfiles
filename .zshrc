# git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
source "${HOME}/.zgen/zgen.zsh"
if ! zgen-saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/common-aliases

    zgen load geometry-zsh/geometry
    zgen load wfxr/forgit
    zgen load RobSis/zsh-completion-generator
    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions src
    zgen load marzocchi/zsh-notify
    zgen load ael-code/zsh-colored-man-pages

    zgen save
fi
source ~/.fzf.zsh

export VISUAL=vim
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin:$HOME/.npm/bin:$HOME/.scripts/:
export TERM=xterm-256color

alias diff='diff --color=auto'
alias jn="jupyter notebook &> /dev/null &"
alias pro="export http_proxy=http://127.0.0.1:8080;export https_proxy=http://127.0.0.1:8080"
alias ra="ranger"
alias v="vim"
alias xc="xclip -sel clip"
alias ytd="youtube-dl -i --proxy='socks5://127.0.0.1:1080/' -o '%(title)s.%(ext)s'"
alias ch="chromium --proxy-server=socks5://127.0.0.1:1080 --disk-cache-dir=/tmp/chromium_cache"
