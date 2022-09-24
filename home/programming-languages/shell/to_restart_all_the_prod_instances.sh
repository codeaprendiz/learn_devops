#!bin/sh
#Add all the affected hosts into /tmp/1

# If we are on peak time make the sleep count as 100+ else it can be below 30
for u in `cat /tmp/1 `; do grep -i $u prod__all; done > name_of_the_file_containing_hostnames

for u in `cat name_of_the_file_containing_hostnames`;
do
ssh -o StrictHostKeyChecking=no app@$u "[ -f /log/server.log ] && echo "$u - Server Log File Exists" || /etc/init.d/jboss-container restart ; sleep 120";
done
