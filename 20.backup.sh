#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

USAGE(){
    echo "USAGE :: sh.usage.sh <source-directory> <destination-directory> <days(optional)>"
}

if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo "Source Directory $SOURCE_DIR does not exit. Please check"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo "Destination Directory $DEST_DIR does not exit. Please check"
    exit 1
fi

FILES=$(find SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ ! -z $FILES ]
then
    echo "Files to zip are : $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo $FILES | zip -@ $ZIP_FILE

    if [ -f $ZIP_FILE ]
    then
        echo "Succesfully created zip file"
        while IFS= read -r filepath
        do
          echo "Deleting file : $filepath"
          rm -rf $filepath
        done <<< $FILES

        echo "Log files older than $DAYS from source directory removed.... SUCCESFULLY"
    else
        echo "Zip file creation... FAILURE"
    fi
else
    echo "No log files older than 14 days... SKIPPING"
fi

