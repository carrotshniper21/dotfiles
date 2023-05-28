# Setting language and localization variables
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM="xterm-256color"

# Setting $PATH
## If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:/home/cum/.local/bin

# export PATH=/usr/local/bin:$PATH
## Path for LLVM install
export PATH=/usr/local/opt/llvm/bin:$PATH
## Path for Golang
export GOPATH=$HOME/golang
export GOROOT=/usr/lib/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Setting R variables
export R_LIBS_USER=$HOME/Library/R/3.x/library

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# vim Bindings
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"

ZSH_THEME="dracula"

# Uncooment the following line to autoupdate without prompt
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git colorize github jira vagrant virtualenv pip
#          python brew)
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
setopt autocd
# source ~/.fonts/*.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export EDITOR='nvim'

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

alias wp="feh --bg-fill --randomize $HOME/wallpapers"
alias config="nvim $HOME/.zshrc"
alias ls='exa --group-directories-first --icons -GaF'
alias venv='python -m venv venv && source venv/bin/activate'
alias reqs='pip install -r requirements.txt'
alias gp='git pull'
alias gb='go build'
alias gt='go mod tidy'
alias ga='git add .'
alias x='exit'
alias src='source $HOME/.zshrc'
alias cls='clear'
alias cat='bat'
alias pb='picom -b'
alias vconfig='nvim $HOME/.config/nvim/init.vim'
alias dconfig='nvim $HOME/dwm/config.h'
alias network='sudo systemctl restart NetworkManager'
alias tree='exa --tree --icons'
alias chat='python -m revChatGPT.V1'
alias orphans='[[ -n $(pacman -Qdt) ]] && sudo pacman -Rs $(pacman -Qdtq) || echo "no orphans to remove"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh