#!/bin/bash
# Setup script otomatis

echo "Menyiapkan direktori backup dan link..."
chmod +x /opt/backup/database-backup/script/database-backup.sh

# Pastikan log folder
mkdir -p /var/log /var/backups/mysql

# Tambahkan cron hanya jika belum ada
CRON_JOB="0 2 * * 0 /usr/local/bin/mysql_backup.sh >> /var/log/mysql_backup.log 2>&1"

# Cek apakah sudah ada di crontab
(crontab -l 2>/dev/null | grep -F "$CRON_JOB") >/dev/null 2>&1
if [ $? -ne 0 ]; then
    (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
    echo "✅ Cron job ditambahkan: $CRON_JOB"
else
    echo "ℹ️ Cron job sudah ada, tidak ditambahkan ulang."
fi

echo "Setup selesai!"
