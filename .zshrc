# Zshrc:
#   1) ZSH
#   2) Zplug
#   3) Tools
#   4) Aliases


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
bindkey '^[[F' end-of-line        # End: go to the end of line


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
# ...

# Install plugins
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Load plugins
zplug load --verbose


#----------#
# 3) Tools #
#----------#

#------ Ruby ------#

# Load chruby
[ -f /usr/share/chruby/chruby.sh ] && source /usr/share/chruby/chruby.sh

# Enable chruby auto-switching feature
[ -f /usr/share/chruby/auto.sh ] && source /usr/share/chruby/auto.sh

# Set default ruby version
chruby ruby-2.6.1
