#!/usr/bin/env bash

tmux attach -t `first-unattached-tmux-session` 2> /devnull || tmux

