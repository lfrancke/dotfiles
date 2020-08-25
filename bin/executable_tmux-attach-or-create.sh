#!/usr/bin/env bash
tmux attach -t `~/bin/tmux-first-unattached-session.sh` 2> /dev/null || tmux
