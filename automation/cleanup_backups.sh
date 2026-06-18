#!/bin/bash

BACKUP_DIR="/var/log/backup"
RETENTION_DAYS=7

echo "Starting backup rotation script..."

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: Directory $BACKUP_DIR does not exist."
    exit 1
fi

find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

if [ $? -eq 0 ]; then
    echo "Old backups successfully removed. Rotation completed."
else
    echo "Error occurred during backup rotation."
    exit 2
fi
