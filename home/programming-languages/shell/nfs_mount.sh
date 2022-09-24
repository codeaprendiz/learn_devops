#!/bin/bash

# This is NFS mount script place to mount on directory /george_camel_nfsshared directory.
# Version 1.0
# Author : Ankit Rathi.

# Directory creation and unmount incase of already mount.
ifdfwhost=`hostname -f | grep dfw | wc -l`
if [ "${ifdfwhost}" -eq 1 ] ; then 
		mkdir -p /home/looker/looker/models-share && umount -f -l /home/looker/looker/models-share
                chown -R looker:looker /home/looker/looker/models-share
                chown looker:looker /home/looker/looker/models-share
                mount -t nfs -o vers=3 dfw-nfs3-vs10.prod.com:/dfw_prd_asda_looker_01  /home/looker/looker/models-share
	        count=`cat /etc/fstab | grep "/home/looker/looker/models-share" | grep dfw_prd_asda_looker_01 | wc -l` 
		if [ "${count}" -eq 0 ] ; then 
			echo "Entry isn't there in /etc/fstab, It will be adding...... "
			sleep 5
			echo "dfw-nfs3-vs10.prod.com:/dfw_prd_asda_looker_01 /home/looker/looker/models-share  nfs defaults 0 0" >> /etc/fstab
		else 
			echo "Entry is exists in /etc/fstab"
		fi
else 
	echo "It not dfw host"
fi

ifcdchost=`hostname -f | grep cdc | wc -l`
if [ "${ifcdchost}" -eq 1 ] ; then 
		mkdir -p /home/looker/looker/models-share && umount -f -l /home/looker/looker/models-share
                chown -R looker:looker /home/looker/looker/models-share
                chown looker:looker /home/looker/looker/models-share

                mount -t nfs -o vers=3 cdc-nfs1-vs20.prod.com:/cdc_prd_asda_looker_01 /home/looker/looker/models-share
	        count=`cat /etc/fstab | grep "/home/looker/looker/models-share" | grep cdc_prd_asda_looker_01 | wc -l` 
		if [ "${count}" -eq 0 ] ; then 
			echo "Entry isn't there in /etc/fstab, It will be adding...... "
			sleep 5
			echo "cdc-nfs1-vs20.prod.com:/cdc_prd_asda_looker_01 /home/looker/looker/models-share  nfs defaults 0 0" >> /etc/fstab
		else 
			echo "Entry is exists in /etc/fstab"
		fi
else 
	echo "It not cdc host"
fi




