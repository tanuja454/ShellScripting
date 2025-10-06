#!/bin/bash
# ===========================================================
# Script Name : backup_script.sh
# Description : Takes backup of given directories and stores with timestamp.
#               Sends email alert after successful backup.
# Author      : Tanuja (DevOps Practice)
# Date        : $(date +%Y-%m-%d)
# ===========================================================

# Directories to backup (Add your paths here)
SOURCE_DIRS=("/etc" "/var/www")

# Backup destination
BACKUP_DIR="/backup"

# Email for notification
EMAIL="admin@example.com"

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Timestamp for filename
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Backup filename
BACKUP_FILE="$BACKUP_DIR/system_backup_$DATE.tar.gz"

# Create backup archive
tar -czf "$BACKUP_FILE" "${SOURCE_DIRS[@]}" 2>/dev/null

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "✅ Backup successful! File created: $BACKUP_FILE"
    echo "Backup completed successfully on $(hostname) at $(date)." | mail -s "Backup Success: $(hostname)" "$EMAIL"
else
    echo "🚨 Backup failed!"
    echo "Backup FAILED on $(hostname) at $(date)." | mail -s "Backup Failed: $(hostname)" "$EMAIL"
fi
