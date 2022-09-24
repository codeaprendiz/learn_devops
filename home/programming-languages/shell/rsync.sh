if [ $# -lt 3 ]; then
	echo "USAGE: rsync.sh <DFWHostName> <CDCHostname> <FolderToSync> [cdc|dfw] [true|false]"
	echo "sample: rsync.sh hostname1.dfw5.prod.com hostname2.cdcprod01.prod.com /george_camel_nfsshared/stage dfw true"
	exit 1;
else
	dfwHostname="$1"
	cdcHostname="$2"	
	folderToSync="$3"
        if [[ $domain == *"cdc"* ]]; then
                DATACENTER="cdc"
        else
                DATACENTER="dfw"
        fi
fi
date
echo "dfwHostname:$dfwHostname"
echo "cdcHostname:$cdcHostname"
echo "folderToSync:$folderToSync"
echo "DATACENTER:$DATACENTER"
if [ -f "${folderToSync}/activeDC" ]; then
		activeDC=$(cat ${folderToSync}/activeDC)
		echo "${folderToSync}/activeDC:$activeDC"
	else
		#defaulting dfw as primary data center
		activeDC="dfw"
fi
if [ $# -gt 3 ]; then
	argActiveDC="$4"
	persist="$5"		
	if [ "$activeDC" != "$argActiveDC" -a "$persist" == true ]; then		
		if [ "$activeDC" == "dfw" ]; then
			if [ "$DATACENTER" == "cdc" ]; then
						ssh app@$dfwHostname "echo $activeDC > ${folderToSync}/activeDC"
						echo $argActiveDC > ${folderToSync}/activeDC
			elif [ "$DATACENTER" == "dfw" ]; then
						echo $argActiveDC > ${folderToSync}/activeDC
						ssh app@$cdcHostname "echo $activeDC > ${folderToSync}/activeDC"
			fi
		elif [ "$activeDC" == "cdc" ]; then
			if [ "$DATACENTER" == "cdc" ]; then
						echo $argActiveDC > ${folderToSync}/activeDC
						ssh app@$dfwHostname "echo $activeDC > ${folderToSync}/activeDC"
			elif [ "$DATACENTER" == "dfw" ]; then
						ssh app@$cdcHostname "echo $activeDC > ${folderToSync}/activeDC"				
						echo $argActiveDC > ${folderToSync}/activeDC
			fi
		fi
	fi
	activeDC="$argActiveDC"
fi
echo "activeDC:$activeDC"
if [ "$activeDC" == "dfw" ]; then
	if [ "$DATACENTER" == "cdc" ]; then
		#dfw is primary and current host is cdc, so pull changes from remote:dfw to local:cdc
		rsync --exclude=activeDC* --delete -arvc -e 'ssh -o StrictHostKeyChecking=no' app@$dfwHostname:${folderToSync}/ ${folderToSync}/
	elif [ "$DATACENTER" == "dfw" ]; then
		#dfw is primary and current host is dfw, so push changes from local:dfw to remote:cdc
		rsync --exclude=activeDC* --delete -arvc -e 'ssh -o StrictHostKeyChecking=no' ${folderToSync}/  app@$cdcHostname:${folderToSync}/
	fi
elif [ "$activeDC" == "cdc" ]; then
	if [ "$DATACENTER" == "cdc" ]; then
		#cdc is primary and current host is cdc, so push changes from local:cdc to remote:dfw
		rsync --exclude=activeDC* --delete -arvc -e 'ssh -o StrictHostKeyChecking=no' ${folderToSync}/  app@$dfwHostname:${folderToSync}/
	elif [ "$DATACENTER" == "dfw" ]; then
		#cdc is primary and current host is dfw, so pull changes from remote:cdc to local:dfw
		rsync --exclude=activeDC* --delete -arvc -e 'ssh -o StrictHostKeyChecking=no' app@$cdcHostname:${folderToSync}/  ${folderToSync}/
	fi
fi
