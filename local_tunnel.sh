#!/usr/bin/env bash
tmux new-window 'ssh -L 10000:localhost:10000 cloudlab; tmux detach'
