#!/bin/bash

echo "All variables passed to the script : $@"
echo "Number of variables : $@"
echo "Script name : $0"
echo "Current directory : $PWD"
echo "User running the script : $USER"
echo "Home directory of the user : $HOME"
echo "PID of the script : $PID"
sleep 100 &
echo "PID of last command in background : $!"