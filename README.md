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
cd /opt/backup
git clone https://github.com/<username>/<repo-name>.git /opt/backup
### 2️⃣ Buat File .env
### 3️⃣ Jalankan Setup Otomatis
chmod +x /opt/backup/database-backup/script/setup.sh
 ./setup.sh
### 4️⃣ Pasang Rclone (jika belum)
sudo apt install rclone -y
mkdir /root/.config/rclone
cp rclone.conf.example /root/.config/rclone/rclone.conf
rclone config reconnect <nama-konfigurasi>:
Ini akan membuka proses reautorisasi:
1. Download Rclone untuk Windows dari:
👉 https://rclone.org/downloads/
2. Extract (misal di D:\rclone-v1.xx.x-windows-amd64).
3. Buka PowerShell di folder tersebut, lalu jalankan:
4. Rclone akan menampilkan perintah rclone authorize "drive" "...".
5. Jalankan itu di komputer Windows yang punya browser.
6. Login ulang ke akun Google kamu.
7. Setelah berhasil, copy token ke rclone.conf 
    
## 🧪 Testing Manual
### Jalankan Backup Secara Manual
cd /opt/backup/database-backup/script/
./database-backup.sh
### Cek Hasil Backup
ls -lh /var/backups/mysql/

## ☁️ Verifikasi Upload Google Drive
Setelah selesai, cek di Google Drive