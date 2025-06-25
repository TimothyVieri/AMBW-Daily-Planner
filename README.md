# Daily Planner App (Flutter x Supabase)

Aplikasi Flutter sederhana untuk mencatat kegiatan harian (to-do list) yang dibuat sebagai Proyek Ujian Akhir Semester. Aplikasi ini mencakup fitur autentikasi, database cloud real-time, dan UI yang bersih serta modern.

## 📸 Screenshot Aplikasi

| Halaman Utama | Tambah Tugas | Halaman Login |
| :---: |:---:|:---:|
| ![Tampilan Daftar Tugas](screenshots/home.png) | ![Dialog Tambah Tugas](screenshots/add_task.png) | ![Tampilan Halaman Login](screenshots/login.png) |

*(Catatan: Ganti nama file `home.png`, `add_task.png`, dan `login.png` sesuai dengan nama file screenshot yang kamu simpan di dalam folder `screenshots`)*

## ✨ Fitur Utama

-   [x] **Get Started Screen**: Halaman perkenalan yang hanya muncul satu kali saat aplikasi pertama kali di-install.
-   [x] **Autentikasi Pengguna Penuh**: Sign Up, Sign In, dan Sign Out.
-   [x] **Penyimpanan Sesi**: Pengguna tetap login setelah menutup dan membuka kembali aplikasi.
-   [x] **Manajemen Tugas Real-time (CRUD)**: Create, Read, Update, dan Delete tugas.
-   [x] **Keamanan Data**: Menggunakan Row Level Security (RLS) di Supabase.
-   [x] **UI Modern**: Tampilan yang bersih dan profesional.

## 🛠️ Teknologi yang Digunakan

-   **Framework**: Flutter 3.x
-   **Bahasa**: Dart
-   **Backend & Database**: Supabase
-   **Penyimpanan Lokal**: `shared_preferences`
-   **Styling & UI**: `google_fonts`, Sistem Tema Kustom.
-   **Formatting**: `intl`

---

## 🚀 Panduan Menjalankan Proyek untuk Penilaian

Bagian ini adalah panduan bagi dosen atau penguji untuk menjalankan proyek ini dengan cepat.

### **Prasyarat**
-   [Flutter SDK](https://flutter.dev/docs/get-started/install) (versi 3.x atau lebih baru)
-   [Git](https://git-scm.com/downloads)

### **Langkah-langkah**

1.  **Dapatkan Kode Proyek (Clone)**
    Buka terminal dan jalankan perintah di bawah ini:

    ```bash
    # Ganti dengan URL repositori GitHub-mu
    git clone [https://github.com/TimothyVieri/AMBW-Daily-Planner.git](https://github.com/TimothyVieri/AMBW-Daily-Planner.git)

    # Masuk ke folder proyek
    cd NAMA_REPO
    ```

2.  **Install Dependencies**
    Jalankan perintah ini untuk mengunduh semua package yang diperlukan:
    ```bash
    flutter pub get
    ```

3.  **Jalankan Aplikasi**
    Semua konfigurasi backend (URL dan Kunci API Supabase) **sudah termasuk** di dalam kode untuk kemudahan penilaian. Anda hanya perlu menjalankan perintah berikut:
    ```bash
    flutter run
    ```
    Aplikasi akan berjalan dan terhubung langsung ke database yang sudah disiapkan.
    
    **PASTIKAN SETELAH INSERT, EDIT, UPDATE, DAN DELETE LAKUKAN HOT RESET BUKAN HOT RELOAD**

---

## 🧑‍💻 Akun Dummy untuk Pengujian

Untuk mencoba aplikasi secara langsung, silakan login menggunakan akun dummy yang sudah disiapkan di bawah ini. Anda juga bisa mencoba mendaftar akun baru.

-   **Email**: `user@gmail.com`
-   **Password**: `user123`

*(Catatan: Akun ini sudah saya daftarkan di dalam database proyek).*
