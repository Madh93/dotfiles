# Zshrc:
#   1) ZSH
#   2) Zplug
#   3) Tools
#   4) Aliases
#   5) External

# Requirements:
# - Packages: 'git', 'fzf'
# - Fonts: 'Nerd Fonts'

#--------#
# 1) ZSH #
#--------#

DEFAULT_USER='migue'
DEFAULT_HOME="/home/$DEFAULT_USER"

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
setopt AUTO_CD            # Change directory by typing directory name

# Bindkeys
# To show current bindkeys run: bindkey
# To get shortcuts run: cat -v (and press whatever)
bindkey '^[[3~' delete-char         # Del: delete character
bindkey '^H' vi-backward-kill-word  # Ctrl + Backspace: delete word
bindkey '^[[3;5~' delete-word       # Ctrl + Del: delete word alternative
bindkey '^[[1;5C' forward-word      # Ctrl + Left Arrow: go to the beginning of word
bindkey '^[[1;5D' backward-word     # Ctrl + Right Arrow: go to the end of word
bindkey '^K' vi-kill-line           # Ctrl + K: delete line
bindkey '^[[H' beginning-of-line    # Home: go to the beginning of line
bindkey '^[[1~' beginning-of-line   # Home: go to the beginning of line in Tmux
bindkey '^[[F' end-of-line          # End: go to the end of line
bindkey '^[[4~' end-of-line         # End: go to the end of line in Tmux
bindkey '^R' history-incremental-search-backward  # Ctrl + R: search history in Tmux

# Completion
zstyle ':completion:*' menu select  # Show interactive menu to select directory
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'  # CD with autocompletion

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
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme, as:theme

# Plugins
zplug "plugins/git", from:oh-my-zsh   # Useful git aliases
zplug "plugins/pj", from:oh-my-zsh    # Projects jump directly
zplug "plugins/terraform", from:oh-my-zsh   # Terraform completions
zplug "rupa/z", use:z.sh              # Directories jump based on frecency
zplug "changyuheng/fz", defer:1       # Fuzzy search to tab completion of z
zplug "junegunn/fzf", use:shell/key-bindings.zsh  # Ctrl+R using fuzzy search
zplug "tmuxinator/tmuxinator", use:"completion/tmuxinator.zsh"  # Tmuxinator completions
zplug "lukechilds/zsh-better-npm-completion", defer:2   # NPM completions
zplug "plugins/pip", from:oh-my-zsh   # Pip completions

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

#------ Powerlevel9k Theme ------#
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  root_indicator
  host
  dir
  custom_ruby
  custom_virtualenv
  vcs
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status
  command_execution_time
)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰─> "
POWERLEVEL9K_SSH_ICON="\uf489"
POWERLEVEL9K_DIR_HOME_BACKGROUND='darkcyan'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='darkcyan'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='darkcyan'
POWERLEVEL9K_DIR_ETC_BACKGROUND='darkcyan'
POWERLEVEL9K_CARRIAGE_RETURN_ICON="\u2718"
POWERLEVEL9K_EXECUTION_TIME_ICON="\uf251"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='white'
POWERLEVEL9K_VCS_BRANCH_ICON="\uf126"
POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uf113"
POWERLEVEL9K_VCS_GIT_GITLAB_ICON="\uf296"

custom_ruby() {
  [[ ! -f "Gemfile" ]] && return
  echo -n "\ue739 $RUBY_VERSION"
}
POWERLEVEL9K_CUSTOM_RUBY='custom_ruby'
POWERLEVEL9K_CUSTOM_RUBY_BACKGROUND='red'

custom_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  [[ ! -f "requirements.txt" ]] && return
  if [[ "$virtualenv_path" ]]; then
    echo -n "\ue235 ${virtualenv_path:t}"
  else
    echo -n "\ue235"
  fi
}
POWERLEVEL9K_CUSTOM_VIRTUALENV='custom_virtualenv'
POWERLEVEL9K_CUSTOM_VIRTUALENV_BACKGROUND='blue'

#------ PJ ------#
PROJECT_PATHS=($DEFAULT_HOME/Workspace $DEFAULT_HOME/Workspace/repos)
c() {
  pj $@
}


#----------#
# 3) Tools #
#----------#

#----- Android ----#
if [[ -d $DEFAULT_HOME/.androidsdk ]]; then
  # NOTES:
  # It requiers Java 8 (jdk8-openjdk)
  # - sdkmanager --update
  # - sdkmanager "platform-tools" "build-tools;28.0.3"
  # - sdkmanager --licenses

  [ -d /usr/lib/jvm/java-8-openjdk ] && export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
  export ANDROID_HOME=$DEFAULT_HOME/.androidsdk
  export PATH=$ANDROID_HOME/tools/bin:$PATH
  alias adb="$ANDROID_HOME/platform-tools/adb"
fi

#------- AWS ------#
[ -f /usr/bin/aws_zsh_completer.sh ] && source /usr/bin/aws_zsh_completer.sh

#------- C --------#
export MAKEFLAGS="-j$(($(nproc)+1))"


#----- Docker -----#
dockexec() {
  docker exec -it $(docker ps --format '{{.Names}}' | fzf) ${1:-sh}
}

#------ Java ------#
if [[ ! -d $DEFAULT_HOME/.androidsdk ]]; then
  [ -d /usr/lib/jvm/default ] && export JAVA_HOME=/usr/lib/jvm/default
fi

#------ Node ------#
MY_NODE_VERSION='12.4.0'

# (Lazy) Load nvm
if [ -f /usr/share/nvm/nvm.sh ]; then
  export NVM_DIR="$DEFAULT_HOME/.nvm"
  alias nvm='unalias nvm node npm && source /usr/share/nvm/nvm.sh && nvm'
  alias node='unalias nvm node npm && source /usr/share/nvm/nvm.sh && node'
  alias npm='unalias nvm node npm && source /usr/share/nvm/nvm.sh && npm'
fi

# Check my node version
if [[ ! -d $DEFAULT_HOME/.nvm/versions/node/v$MY_NODE_VERSION ]]; then
  echo -e "\e[5m\e[43m[WARNING]\e[25m\e[49m Node $MY_NODE_VERSION is not installed! Try: nvm install $MY_NODE_VERSION"
fi

#----- Python -----#
if [[ ! -f $DEFAULT_HOME/.pythonrc ]]; then
  echo "import rlcompleter, readline" >> $DEFAULT_HOME/.pythonrc
  echo "readline.parse_and_bind('tab:complete')" >> $DEFAULT_HOME/.pythonrc
fi

export PYTHONSTARTUP=$DEFAULT_HOME/.pythonrc

#------ Ruby ------#
MY_RUBY_VERSION='2.6.2'

# Load chruby
[ -f /usr/share/chruby/chruby.sh ] && source /usr/share/chruby/chruby.sh

# Enable chruby auto-switching feature
[ -f /usr/share/chruby/auto.sh ] && source /usr/share/chruby/auto.sh

# Set default ruby version
if [[ -d $DEFAULT_HOME/.rubies/ruby-$MY_RUBY_VERSION ]]; then
  [[ $USER == $DEFAULT_USER ]] && chruby ruby-$MY_RUBY_VERSION
else
  echo -e "\e[5m\e[43m[WARNING]\e[25m\e[49m Ruby $MY_RUBY_VERSION is not installed! Try: ruby-install ruby $MY_RUBY_VERSION"
fi

#------ Vim ------#
export EDITOR=vim


#------------#
# 4) Aliases #
#------------#

# Basics
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias l='ls -la --color=auto'
alias grep='grep --color=auto'
alias md='mkdir -p'
alias df='df -h'
alias free='free -m'
alias vi='vim'
alias path='echo -e "${PATH//:/\n}"'
alias ...='cd ../../'
alias ....='cd ../../../'

# Utils
alias dot="$DEFAULT_HOME/.dotfiles"
alias h='fc -lt "| %d-%m-%Y %H:%M:%S |" 1'  # Pretty history output
alias pubkey='more ~/.ssh/id_rsa.pub | xclip -selection clipboard | echo '\''=> Public key copied to pasteboard.'\' # Get publick key

# Powerlevel9k Theme
alias theme-down='prompt_powerlevel9k_teardown'
alias theme-up='prompt_powerlevel9k_setup'

# Manjaro/Pacman
alias pacman-clean='sudo pacman -Sc'
alias pacman-list-date='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort'
alias pacman-list-size='expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'
alias pacman-remove='sudo pacman -Rsdn $(pacman -Qqdt)'

# Git
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d' # Delete merged branches
alias gpom='git pull origin master'
alias gpod='git pull origin develop'
unalias gco
gco() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
gcr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Python
alias pipr='pip install -r requirements.txt'
alias venv='source .venv/bin/activate'
venvc() {
  virtualenv -p python3 .venv && source .venv/bin/activate
  [ -f requirements.txt ] && pip install -r requirements.txt
  [ -f test_requirements.txt ] && pip install -r test_requirements.txt
}

#-------------#
# 5) External #
#-------------#

if [[ -f $DEFAULT_HOME/.zshrc.local ]]; then
    source $DEFAULT_HOME/.zshrc.local
fi
