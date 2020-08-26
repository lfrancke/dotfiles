#!/usr/bin/env bash
# Source: https://github.com/amarendra/.dotfiles/blob/master/restic.backup.sh

# Exit on failure, pipe failure
set -e -o pipefail

# Clean up lock if we are killed.
# If killed by systemd, like $(systemctl stop restic), then it kills the whole cgroup and all it's subprocesses.
# However if we kill this script ourselves, we need this trap that kills all subprocesses manually.
exit_hook() {
  echo "In exit_hook(), being killed" >&2
  jobs -p | xargs kill
  restic unlock
}
trap exit_hook INT TERM

# Set all environment variables like
# B2_ACCOUNT_ID, B2_ACCOUNT_KEY, RESTIC_REPOSITORY etc.
source ~/.restic/restic_env.sh


# NOTE start all commands in background and wait for them to finish.
# Reason: bash ignores any signals while child process is executing and thus my trap exit hook is not triggered.
# However if put in subprocesses, wait(1) waits until the process finishes OR signal is received.
# Reference: https://unix.stackexchange.com/questions/146756/forward-sigterm-to-child-in-bash


# TODO: Show a notification that the backup started

# How many backups to keep.
RETENTION_LAST=14
RETENTION_DAYS=7
RETENTION_WEEKS=4
RETENTION_MONTHS=12
RETENTION_YEARS=3

BACKUP_TAG=lars-t14
B2_CONNECTIONS=50

{
  printf "*** RESTIC BACKUP SCRIPT STARTED AT %s\n" "$(date -R)"

  # Remove locks from other stale processes to keep the automated backup running.
  restic unlock &
  wait $!

  # Do the backup!
  # See restic-backup(1) or http://restic.readthedocs.io/en/latest/040_backup.html
  # --one-file-system makes sure we only backup exactly those mounted file systems specified in $BACKUP_PATHS, and thus not directories like /dev, /sys etc.
  # --tag lets us reference these backups later when doing restic-forget.
  restic backup \
    --verbose \
    --option b2.connections=$B2_CONNECTIONS \
    --one-file-system \
    --tag $BACKUP_TAG \
    --exclude-caches \
    --exclude-file="$RESTIC_EXCLUDE_FILE" \
    /home/lars &
  wait $!

  # Dereference and delete/prune old backups.
  # See restic-forget(1) or http://restic.readthedocs.io/en/latest/060_forget.html
  # --group-by only the tag and path, and not by hostname. This is because I create a B2 Bucket per host, and if this hostname accidentially change some time, there would now be multiple backup sets.
  restic forget \
    --verbose \
    --tag $BACKUP_TAG \
    --option b2.connections=$B2_CONNECTIONS \
    --prune \
    --group-by "paths,tags" \
    --keep-last $RETENTION_LAST \
    --keep-daily $RETENTION_DAYS \
    --keep-weekly $RETENTION_WEEKS \
    --keep-monthly $RETENTION_MONTHS \
    --keep-yearly $RETENTION_YEARS &
  wait $!

  printf "\n*** RESTIC BACKUP SCRIPT FINISHED %s\n" "$(date -R)"

  printf "\n===================================================================\n\n\n"
} >> "$RESTIC_LOG_FILE" 2>&1
