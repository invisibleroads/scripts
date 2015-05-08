#!/bin/bash
if pgrep "rhythmbox" > /dev/null; then
    rhythmbox-client --pause
fi
xflock4
