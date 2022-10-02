#!/usr/bin/env bash
foo=$(~/bin/tmux-first-unattached-session.sh 2> /dev/null)
if [ -z "${foo}" ]; then
  tmux
else
  tmux attach -t $foo
fi

