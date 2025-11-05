# 🗄️ Server MySQL Auto Backup & Google Drive Sync

Sistem otomatis untuk **backup database MySQL**, **kompresi**, **rotasi file lama**, dan **sinkronisasi ke Google Drive** menggunakan `rclone`.

Dirancang agar bisa dipasang di banyak server dengan konfigurasi yang seragam melalui Git.

---

## 🚀 Fitur Utama

* Backup beberapa database MySQL otomatis (multi-database)
* Kompres hasil backup ke `.sql.gz`
* Menghapus backup lama (> 60 hari)
* Upload otomatis ke Google Drive via `rclone`
* Logging terpisah untuk MySQL & rclone
* Konfigurasi menggunakan `.env`
* Cronjob otomatis tiap minggu (default: Minggu 02:00)

---

## 📂 Struktur Folder (clone pada folder berikut)

```
/opt/backup/database_backup
├── database_backup.sh      # Skrip utama backup
├── .env                    # File konfigurasi server (tidak diupload ke Git)
├── .env.example            # Template .env untuk server baru
├── rclone.conf             # Konfigurasi Google Drive (manual)
├── setup.sh                # Setup otomatis symlink & cron
└── README.md
```

---

## ⚙️ Persiapan Awal

### 1️⃣ Clone Repository

Jalankan perintah berikut di server:

```bash
cd /opt/backup
git clone https://github.com/<username>/<repo-name>.git /opt/backup
```

### 2️⃣ Buat File `.env`
Salin dari `.env.example` 
```
cp .env.example /opt/backup/database-backup/script/.env
sudo nano .env
```
lalu edit sesuai environment Anda.

#### Verifikasi file .env dan database-backup.sh
Jalankan
```
./database-backup.sh
```
Jika tidak ada eror, berarti backup lokal berhasil. Lanjut ke script otomatis backup dan konfigurasi Google Drive 

### 3️⃣ Jalankan Setup Otomatis

```bash
chmod +x /opt/backup/database-backup/script/setup.sh
cd /opt/backup/database-backup/script/
./setup.sh
```

### 4️⃣ Pasang Rclone (jika belum)

```bash
sudo apt install rclone -y
mkdir -p /root/.config/rclone
cd /opt/backup/database-backup/script/
cp rclone.conf.example /root/.config/rclone/rclone.conf
```

### 5️⃣ Konfigurasi Rclone
```bash
cd /root/.config/rclone
rclone config reconnect <nama-konfigurasi>:

Already have a token - refresh?
y

Use auto config?
n
```
Setelah itu akan muncul perintah seperti ini di terminal:
```
rclone authorize "drive" "..........."
```
⚠️ Jangan tutup terminal Linux ini!
Karena perlu menyalin hasil token dari langkah berikut di Windows.

> membuat token rclone via windows suport browser:
>
> 1. Download Rclone untuk Windows dari: [https://rclone.org/downloads/](https://rclone.org/downloads/)
> 2. Extract (misal di `D:\rclone-v1.xx.x-windows-amd64`).
> 3. Buka PowerShell / Terminal di folder tersebut lalu jalankan perintah yang muncul di terminal Linux,dengan menambahkan awalan `.\`:
  ```
  .\rclone authorize "drive" "xxxxxxxxxxxxx"
  ```
> 4. Login ulang ke akun Google.
> 5. Setelah berhasil, copy token ke `rclone.conf`
> 6. Paste pada bagian `config_token>` di terminal linux.
---

## 🧪 Testing Manual

### Jalankan Backup Secara Manual

```bash
cd /opt/backup/database-backup/script/
./database-backup.sh
```

### Cek Hasil Backup

```bash
ls -lh /var/backups/mysql/
```

---

## ☁️ Verifikasi Upload Google Drive

Setelah proses selesai, cek di Google Drive (`My Drive → server-backup → mysql`) untuk memastikan file terunggah.

---
