#!/bin/bash

BACKUP_HOST="lirael"
BACKUP_USER="john"
BACKUP_SSH_KEY="/home/john/.ssh/id_rsa"
BACKUP_PATH="/volume1/backup/homes/$(hostname)/daily"

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
		  /home/ "$BACKUP_USER"@"$BACKUP_HOST":"$BACKUP_PATH"
fi
