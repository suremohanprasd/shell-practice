#!/bin/bash

USERID=$(id -u)

# if [ $USERID -ne 0 ]
# then
#     echo "ERROR:: Please run the script with root access"
# else
#     echo "Changing to root user"
# sudo su -
# fi

if [ $USERID -eq 0 ]
then
    echo "You are running with root access"
    exit 1
else
        echo "changing to root user"
        sudo su -
fi

dnf install mysql -y

if [ $? -eq 0 ]
then
    echo "Installing MySQL is Succcess"
else
    echo "Installing MySQL is Failed"
    exit 1
fi