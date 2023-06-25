# Setup fzf
# ---------
if [[ ! "$PATH" == */home/carrot/.config/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/carrot/.config/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/carrot/.config/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/carrot/.config/fzf/shell/key-bindings.zsh"
