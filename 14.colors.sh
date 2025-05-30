#!/bin/bash

R="-e \e[31m"
G="-e \e[32m"
Y="-e \e[33m"
N="\e[0m"

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo $R "ERROR:: Please run this script with root access" $N
    exit 1 #give other than 0 upto 127
else
    echo $G "You are running with root access" $N
fi

# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo $G "Installing $2 is ... SUCCESS" $N
    else
        echo $R "Installing $2 is ... FAILURE" $N
        exit 1
    fi
}

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo $R "MySQL is not installed... going to install it" $N
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo $G "MySQL is already installed...Nothing to do" $N
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    echo $R "python3 is not installed... going to install it" $N
    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo $G "python3 is already installed...Nothing to do" $N
fi

dnf list installed nginx
if [ $? -ne 0 ]
then
    echo $R "nginx is not installed... going to install it" $N
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo $G "nginx is already installed...Nothing to do" $N
fi