#!/bin/bash
set -a
source /opt/backup/.env
set +a

mkdir -p "$BACKUP_DIR"

DATE=$(date +%F_%H-%M-%S)

for DB in $MYSQL_DATABASES; do
    echo "Backup database: $DB"
    mysqldump -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$DB" > "$BACKUP_DIR/${DB}_${DATE}.sql"
    gzip "$BACKUP_DIR/${DB}_${DATE}.sql"
    echo "$(date) - Selesai backup database: $DB"
done

# Hapus file lama
find "$BACKUP_DIR" -type f -mtime +$BACKUP_RETENTION_DAYS -delete

# Upload ke Google Drive
echo "Mengunggah ke Google Drive..."
rclone copy "$BACKUP_DIR" "$RCLONE_REMOTE:$RCLONE_TARGET" \
    --progress \
    --log-file "$RCLONE_LOG_FILE" \
    --log-level INFO
echo "$(date) - Upload selesai." >> "$MYSQL_LOG_FILE"
