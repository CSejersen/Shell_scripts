#!/usr/bin/env bash
selected=$(cat /Users/sejersen/dev/shell_scripts/.tmux-cht-languages /Users/sejersen/dev/shell_scripts/.tmux-cht-command | fzf)
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" /Users/sejersen/dev/shell_scripts/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    # tmux neww bash -c "curl cht.sh/$selected/$query?T & while [ : ]; do sleep 1; done"
    tmux neww bash -c "curl -s cht.sh/$selected/$query | less"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
