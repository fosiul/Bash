#!/bin/bash
 
#Version 1.1
#######################################
#Nagios script to check ftp server status##
#Commands : wget --quiet --spider --tries=1 -P /tmp ftp://user:password@ftp.ftp-server.co.uk 

 
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3


 
#Define All the variables for commands
 
declare -rx SCRIPT=${0##*/}
declare  -rx CMD_WGET="/usr/bin/wget"


MINPARAMS=4 # This script needs 3 parameter
USER_NAME=$1 # ftp username
USER_PASS=$2 # ftp password
FTP_ADDR=$3   # ftp address
WGET_DIR=$4   # Define a directory where "wget" will dump files.
              #Nagios script should have writable permission on this directory, 
              #other wise wget will return error code 3

SUCCESS=0  # 

#Find out if user has provided 3 parameters .


if [ $# -lt "$MINPARAMS" ]
then 
	echo "This scripts needs at least $MINPARAMS command-line arguments!"
	exit $STATE_UNKNOWN
fi



	$CMD_WGET --quiet --spider --tries=1 -P "$4" ftp://$USER_NAME:$USER_PASS@$FTP_ADDR
		
	
			if [ $? -ne  $SUCCESS  ] 
			then
					echo "ftp server $FTP_ADDR is offline"
					exit $STATE_CRITICAL
			else
				echo "ftp server $FTP_ADDR is online "
				exit $STATE_OK
		fi


		
