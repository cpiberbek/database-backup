# 🗄️ Server MySQL Auto Backup & Google Drive Sync

Sistem otomatis untuk **backup database MySQL**, **kompresi**, **rotasi file lama**, dan **sinkronisasi ke Google Drive** menggunakan `rclone`.

Dirancang agar bisa dipasang di banyak server dengan konfigurasi yang seragam melalui Git.

---

## 🚀 Fitur Utama

- Backup beberapa database MySQL otomatis (multi-database)
- Kompres hasil backup ke `.sql.gz`
- Menghapus backup lama (> 60 hari)
- Upload otomatis ke Google Drive via `rclone`
- Logging terpisah untuk MySQL & rclone
- Konfigurasi menggunakan `.env`
- Cronjob otomatis tiap minggu (default: Minggu 02:00)
- Portable & bisa digunakan di banyak server

---

## 📂 Struktur Folder (clone pada folder berikut)
/opt/backup/
├── database_backup.sh # Skrip utama backup
├── .env # File konfigurasi server (tidak diupload ke Git)
├── .env.example # Template .env untuk server baru
├── rclone.conf # Konfigurasi Google Drive (manual)
├── setup.sh # Setup otomatis symlink & cron
└── README.md

## ⚙️ Persiapan Awal
### 1️⃣ Clone Repository
Jalankan perintah berikut di server:
```bash
git clone https://github.com/<username>/<repo-name>.git /opt/backup
cd /opt/backup
### 2️⃣ Buat File .env
### 3️⃣ Pasang Rclone (jika belum)
sudo apt install rclone -y
copy file rclone.conf.example ke /root/.config/rclone/
### 4️⃣ Jalankan Setup Otomatis
bash /opt/backup/setup.sh

## 🧪 Testing Manual
### Jalankan Backup Secara Manual
mysql_backup.sh
### Cek Hasil Backup
ls -lh /var/backups/mysql/

## ☁️ Verifikasi Upload Google Drive
Setelah selesai, cek di Google Drive