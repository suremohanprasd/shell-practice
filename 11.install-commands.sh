#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run the script with root access"
else
    echo "You are running with root access"
fi


dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "MySQL is not insalled... going to install it."
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
        echo "Installing MySQL is Succcess"
    else
        echo "Installing MySQL is Failed"
    exit 1
fi
else
    echo "MySQL is already installed.. Nothing to do"
fi


