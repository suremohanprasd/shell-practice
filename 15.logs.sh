#!/bin/bash

R="-e \e[31m"
G="-e \e[32m"
Y="-e \e[33m"
N="\e[0m"

LOGS_FOLDER="/var/logs/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." f1)    # $0 -> have the script name
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "Script started executing at : $(date)" &>>$LOG_FILE


USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo $R "ERROR:: Please run this script with root access" $N | tea -a $LOG_FILE
    exit 1 #give other than 0 upto 127
else
    echo $G "You are running with root access" $N | tea -a $LOG_FILE
fi

# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo $G "Installing $2 is ... SUCCESS" $N | tea -a $LOG_FILE
    else
        echo $R "Installing $2 is ... FAILURE" $N | tea -a $LOG_FILE
        exit 1
    fi
}

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo $R "MySQL is not installed... going to install it" $N | tea -a $LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "MySQL"
else
    echo $G "MySQL is already installed...Nothing to do" $N | tea -a $LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo $R "python3 is not installed... going to install it" $N | tea -a $LOG_FILE
    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo $G "python3 is already installed...Nothing to do" $N | tea -a $LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo $R "nginx is not installed... going to install it" $N | tea -a $LOG_FILE
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo $G "nginx is already installed...Nothing to do" $N | tea -a $LOG_FILE
fi