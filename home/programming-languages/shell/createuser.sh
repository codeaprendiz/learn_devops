lookerUserName="looker"

userExists=`cat /etc/passwd | grep looker | wc -l`

if [ $userExists -eq 0 ]; then 
  sudo groupadd looker
  sudo useradd -m  -g looker  looker
  sudo su - looker
  mkdir ~/looker
else 
 echo "Looker user already exists" 
fi
