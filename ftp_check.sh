#!/bin/bash
 
#Version 1.1
#######################################
#Nagios scrept to check ftp server##
#Commands : wget --quiet --spider --tries=1 -P /tmp ftp://user:password@ftp.ftp-server.co.uk 
#Status check for nagios script
 
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

 
#Define All the variables for commands
 
declare -rx SCRIPT=${0##*/}
declare  -rx CMD_WGET="/usr/bin/wget"

USER_NAME=$1
USER_PASS=$2
FTP_ADDR=$3

	$CMD_WGET --quiet --spider --tries=1 -P /tmp ftp://$USER_NAME:$USER_PASS@$FTP_ADDR
		result=$?
	
			if [ $result != 0  ] 
			then
					echo "ftp server is offline:"$result
					exit $STATE_CRITICAL
			else
				echo "ftp server is online: "$result
				exit $STATE_OK
		fi
		
		