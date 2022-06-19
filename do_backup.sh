#!/bin/bash

# check to make sure script isn't still running
# if it's still running then exit this script
SCRIPT_NAME="$(basename $0)"

if [ $(pidof -x ${SCRIPT_NAME}| wc -w) -gt 2 ]; then 
    exit
fi

BACKUP_HOST="lirael.prod.gear.haus"
BACKUP_USER="john"
BACKUP_SSH_KEY="/home/john/.ssh/id_rsa"
BACKUP_PATH="/volume1/backup/homes/$(hostname)"
LOG_FILE="/var/log/home-backup.log"

resolvedIp=$(nslookup "$BACKUP_HOST" | awk -F':' '/^Address: / { matched = 1 } matched { print $2 }' | xargs)

echo Got ip "$resolvedIp"

if [ -n "$resolvedIp" ]
then
	rsync -avz \
		  --delete \
		  --append-verify \
		  --partial \
		  --progress \
		  -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i /home/john/.ssh/id_rsa" \
		  --exclude ".cache" \
		  --exclude "*.iso" \
		  --exclude "*.ova" \
		  --exclude "node_modules" \
		  --exclude ".local/share/virtualenvs" \
		  --exclude "/.snapshots" \
		  --exclude "Dropbox" \
		  --exclude "VirtualBox VMs" \
		  --exclude ".local/share/Trash" \
		  --exclude ".config/google-chrome" \
		  --exclude ".cargo" \
		  --exclude "dev/*/target" \
		  --filter ":- .gitignore" \
		  --log-file=$LOG_FILE \
	      /home/ "$BACKUP_USER"@"$BACKUP_HOST":"$BACKUP_PATH"

	echo "$(tail -n 5000 $LOG_FILE)" > $LOG_FILE
fi
