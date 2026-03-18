#!/bin/bash
# Auto-setup script for tmux devserver sessions

# Only run if this is a new session with a single window and single pane
WINDOW_COUNT=$(tmux list-windows | wc -l)
PANE_COUNT=$(tmux list-panes | wc -l)

if [ "$WINDOW_COUNT" -eq 1 ] && [ "$PANE_COUNT" -eq 1 ]; then
    # Change to fbsource and start claude in the current pane
    tmux send-keys 'exec fish -lc "cd ~/fbsource && exec claude"' C-m
fi
