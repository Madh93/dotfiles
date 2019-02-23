# Zshrc:
#   1) ZSH
#   2) Zplug
#   3) Tools
#   4) Aliases
#   5) External


#--------#
# 1) ZSH #
#--------#

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000   # Lines in memory
SAVEHIST=100000   # Lines in disk
setopt EXTENDED_HISTORY   # Add timestamps to history
setopt APPEND_HISTORY     # Append history instead of replace
setopt INC_APPEND_HISTORY # Append command inmediately is entered
setopt HIST_IGNORE_SPACE  # Do not remember commands that start with a whitespace

# General options
setopt CORRECT            # Suggest command corrections
setopt COMPLETE_ALIASES   # Aliases completions as if they were commands
setopt IGNORE_EOF         # Explicit exit with 'logout' or 'exit'
setopt AUTO_CD            # change directory by typing directory name

# Bindkeys
# To show current bindkeys run: bindkey
bindkey '^[[3~' delete-char       # Del: delete character
bindkey '^[[3;5~' delete-word     # Ctrl + Del: delete word
bindkey '^[[1;5C' forward-word    # Ctrl + Left Arrow: go to the beginning of word
bindkey '^[[1;5D' backward-word   # Ctrl + Right Arrow: go to the end of word
bindkey '^K' kill-line            # Ctrl + K: delete line
bindkey '^[[H' beginning-of-line  # Home: go to the beginning of line
bindkey '^[[1~' beginning-of-line # Home: go to the beginning of line in Tmux
bindkey '^[[F' end-of-line        # End: go to the end of line
bindkey '^[[4~' end-of-line       # End: go to the end of line in Tmux
bindkey '^R' history-incremental-search-backward  # Ctrl + R: search history in Tmux

# Completion
zstyle ':completion:*' menu select  # Show interactive menu to select directory

# Disable 'Ctrl-s'
stty -ixon

#----------#
# 2) Zplug #
#----------#

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

# Load zplug
source ~/.zplug/init.zsh

# Theme
zplug "themes/agnoster", from:oh-my-zsh, as:theme

# Plugins
zplug "plugins/git", from:oh-my-zsh   # Useful git aliases
zplug "plugins/pj", from:oh-my-zsh    # Projects jump directly
zplug "rupa/z", use:z.sh              # Directories jump based on frecency

# Install plugins
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Load plugins
zplug load

# Plugins Configuration

#------ PJ ------#
PROJECT_PATHS=(~/Workspace ~/Workspace/repos)
c() {
  pj $@
}


#----------#
# 3) Tools #
#----------#

#------ Ruby ------#

RUBY_VERSION='2.6.1'

# Load chruby
[ -f /usr/share/chruby/chruby.sh ] && source /usr/share/chruby/chruby.sh

# Enable chruby auto-switching feature
[ -f /usr/share/chruby/auto.sh ] && source /usr/share/chruby/auto.sh

# Set default ruby version
if [[ -d ~/.rubies/ruby-$RUBY_VERSION ]]; then
  chruby ruby-$RUBY_VERSION
else
  echo -e "\e[5m\e[43m[WARNING]\e[25m\e[49m Ruby $RUBY_VERSION is not installed!"
fi

#------ Vim ------#

EDITOR=vim


#------------#
# 4) Aliases #
#------------#

# Basics
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias l='ls -la --color=auto'
alias md='mkdir -p'
alias df='df -h'
alias free='free -m'
alias vi='vim'

# Utils
alias dot='~/.dotfiles'
alias h='fc -lt "| %d-%m-%Y %H:%M:%S |" 1'  # Pretty history output
alias pubkey='more ~/.ssh/id_rsa.pub | xclip -selection clipboard | echo '\''=> Public key copied to pasteboard.'\' # Get publick key

# Manjaro/Pacman
alias pacman-clean='sudo pacman -Sc'
alias pacman-list-date='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort'
alias pacman-list-size='expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'
alias pacman-remove='sudo pacman -Rsdn $(pacman -Qqdt)'

# Git
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d' # Delete merged branches

# Python
alias pipr='pip install -r requirements.txt'
alias venv='source .venv/bin/activate'
alias venvc='virtualenv -p python3 .venv && source .venv/bin/activate && pip install -r requirements.txt'


#-------------#
# 5) External #
#-------------#

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
