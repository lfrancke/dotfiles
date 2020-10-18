#!/usr/bin/env bash

paused=$(dunstctl is-paused)

if [[ "$paused" == "true" ]]; then
  echo -e 'No Notifications'
else 
  echo "Notifications"
fi
