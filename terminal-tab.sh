#!/bin/sh
#
# Open a new terminal emulator tab in the current working directory.
# Modify `open-terminal-here` for open elementary Terminal(`io.elementary.terminal`)
# in the current directory on Atom Editor of Elementary OS(Ubuntu base).
#
# Usage:
# ./terminal-tab.sh [-t terminal_emulator] [-w window_name] [-k keystroke]
#
# Requires xdotool:
# http://www.semicomplete.com/projects/xdotool/
#
# Copyright 2015, Sebastian Tschan
# https://blueimp.net
#
# Licensed under the MIT license:
# https://opensource.org/licenses/MIT
#

# Keyboard shortcut to open a new terminal emulator tab:
KEYSTROKE='ctrl+shift+t'
# Pattern to identify a terminal emulator window by name:
WINDOW_NAME="$USER@$(hostname)"
WINDOW_CLASS="io.elementary.terminal"
# Terminal emulator command:
TERMINAL_EMULATOR='x-terminal-emulator'

# Parse command-line options:
while getopts t:w:k: opt; do
  case $opt in
    t) TERMINAL_EMULATOR="$OPTARG"
       ;;
    w) WINDOW_NAME="$OPTARG"
       ;;
    k) KEYSTROKE="$OPTARG"
       ;;
    ?) echo "Usage: $0 [-t terminal_emulator] [-w window_name] [-k keystroke]"
       exit 2
       ;;
  esac
done


# Search for an open terminal emulator window and bring it into focus:
xdotool search --limit 1  --onlyvisible  --class "$WINDOW_CLASS" windowactivate

if [ $? -eq 0 ]; then # if an open terminal emulator exists
  # Open a new tab of terminal emulator in the current working directory:
  xdotool key "$KEYSTROKE" && xdotool sleep 1 && xdotool type --delay 1 --clearmodifiers "cd '$(pwd | sed "s/'/'\\\''/g")';clear" && xdotool key Return
else
  # Open a new terminal emulator window:
  $TERMINAL_EMULATOR
  xdotool sleep 2
  # Search for an open terminal emulator window and bring it into focus:
  xdotool search --limit 1  --onlyvisible  --class "$WINDOW_CLASS" windowactivate
  # Open a new terminal emulator tab in the current working directory:
  xdotool key "$KEYSTROKE" && xdotool sleep 1 && xdotool type --delay 1 --clearmodifiers "cd '$(pwd | sed "s/'/'\\\''/g")';clear" && xdotool key Return
fi
