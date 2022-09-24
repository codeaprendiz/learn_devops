#!/bin/sh
 >/app/scripts/logdetails.txt
filename='/app/scripts/servers.txt'
IFS=$'\n'
for line in `cat $filename`
do
echo "$line">>/app/scripts/logdetails.txt
echo "*******************************">>/app/scripts/logdetails.txt
ssh -o StrictHostKeyChecking=no app@$line "find /app/tomcat7/ -mtime +5 -exec ls -lrt {} \;;find /app/tomcat7/ -mtime +5 -exec rm -rf {} \;">>/app/scripts/logdetails.txt
done
