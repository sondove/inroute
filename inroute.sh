#!/bin/bash

#
# Abstract:
#
#  Simple script that watches a folder and 
#  executes a command based upon a regular expression match
#  on the file name
#
# Dependencies:
#
#  inotify (inotifywait)
#
# Configure:
#
#  Modify this script to bind routes
#
# Use:
#
#  inroute.sh <folder to watch>
#

#
# Define your events here
#

events="modify,moved_to,create"

#
# Define your routes here
#
# Routes are consumed in pairs where ther first defines
#  a regular expression to match against the file and 
#  the second the command to execute
#
# $file and $event is available in the command for execution 
# in addition to $1 or $path for the file path beeing watched 
#

routes=( 
    '.*' 'echo "$event made to $path/$file" >> output.txt' 
)

let END=${#routes[*]} 

path=$1

echo -e "$0 listening for $events on $path\n"

printf "%-20s %-20s %-20s %-20s %-40s\n" "Timestamp" "Event" "File" "Regex" "Command"
while true; do

    change=$(inotifywait -q -e $events $path)

    carr=($change)
    file=${carr[2]}
    event=${carr[1]} 

    i=0;while ((i<END)); do
        match=${routes[$i]}
        if [[ $file =~ $match ]]; 
        then
            command=${routes[$i+1]}; 
            printf "%-20s %-20s %-20s %-20s %-40s\n" "$(date +"%Y-%m-%d %H:%M:%S")" "$event" "$file" "$match" "$command"
            eval $command
        fi 
        let i+=2
    done
done

