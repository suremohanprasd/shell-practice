#!/bin/bash

R="-e \e[31m"
G="-e \e[32m"
Y="-e \e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)    # $0 -> have the script name
mkdir -p $LOGS_FOLDER
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "python3" "nginx" "httpd")


echo "Script started executing at : $(date)" &>>$LOG_FILE


USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo $R "ERROR:: Please run this script with root access" $N | tee -a $LOG_FILE
    exit 1 #give other than 0 upto 127
else
    echo $G "You are running with root access" $N | tee -a $LOG_FILE
fi

# validate functions takes input as exit status, what command they tried to install
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo $G "Installing $2 is ... SUCCESS" $N | tee -a $LOG_FILE
    else
        echo $R "Installing $2 is ... FAILURE" $N | tee -a $LOG_FILE
        exit 1
    fi
}

for package in ${PACKAGES[@]}
do
   dnf list installed $package &>>$LOG_FILE
   if [ $? -ne 0 ]
   then
       echo $R "$package is not installed... going to install it" $N | tee -a $LOG_FILE
       dnf install $package -y &>>$LOG_FILE
       VALIDATE $? "$package"
    else
       echo $G "$package is already installed...Nothing to do" $N | tee -a $LOG_FILE
    fi
done
