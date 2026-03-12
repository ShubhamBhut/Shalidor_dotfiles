function ff --description "Launch tmux sessionizer"
    ~/.config/tmux/tmux-sessionizer
end

# Create keybinding for tmux sessionizer (Ctrl+F)
if status is-interactive
    bind \cf 'ff'
end
