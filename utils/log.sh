#!/usr/bin/env bash

# Reset the log files
printf '' > info-log.txt
printf '' > debug-log.txt

# Tail the info logfile as a background process so the contents of the
# info logfile are output to stdout.
tail -f info-log.txt &

# Set an EXIT trap to ensure your background process is
# cleaned-up when the script exits
trap "pkill -P $$" EXIT

# Redirect both stdout and stderr to write to the debug logfile
exec 1>>debug-log.txt 2>>debug-log.txt

function log() {
    echo "$1" | tee -a info-log.txt
}