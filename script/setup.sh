#!/bin/bash
# Setup script otomatis

echo "Menyiapkan direktori backup dan link..."
chmod +x /opt/backup/database_backup.sh

# Symlink supaya bisa dijalankan dengan mysql_backup.sh
ln -sf /opt/backup/database_backup.sh /usr/local/bin/mysql_backup.sh

# Pastikan log folder
mkdir -p /var/log /var/backups/mysql

# Tambahkan cron (tiap minggu jam 2 pagi)
(crontab -l 2>/dev/null; echo "0 2 * * 0 /usr/local/bin/mysql_backup.sh >> /var/log/mysql_backup.log 2>&1") | crontab -

echo "Setup selesai!"
