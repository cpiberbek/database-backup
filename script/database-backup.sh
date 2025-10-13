#!/bin/bash
set -a
source /opt/backup/database-backup/script/.env
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
if rclone copy "$BACKUP_DIR" "$RCLONE_REMOTE:$RCLONE_TARGET" \
    --progress \
    --log-file "$RCLONE_LOG_FILE" \
    --log-level INFO; then
    echo "$(date) - ✅ Upload ke Google Drive selesai." >> "$MYSQL_LOG_FILE"
else
    echo "$(date) - ❌ Gagal mengunggah ke Google Drive!" >> "$MYSQL_LOG_FILE"
    echo "Peringatan: Upload ke Google Drive gagal. Cek log di $RCLONE_LOG_FILE"
    exit 1
fi
