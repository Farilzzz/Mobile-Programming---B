# UTS Mobile Programming: Aplikasi Faril Fit

Aplikasi panduan latihan gym berbasis Flutter yang dikembangkan untuk memenuhi Ujian Tengah Semester mata kuliah Pemrograman Mobile.

## Tema dan Tujuan Aplikasi

Aplikasi ini bertema kebugaran (fitness) dan bertujuan untuk menjadi panduan bagi pengguna pemula hingga menengah dalam melakukan latihan di gym. Tujuannya adalah menyediakan alur yang jelas, mulai dari pemilihan bagian tubuh hingga detail setiap gerakan, sehingga pengguna dapat berlatih dengan benar dan terstruktur.

## Daftar Halaman dan Fungsinya

Aplikasi ini terdiri dari beberapa halaman utama:
- **Loading Page (`loading_page.dart`)**: Splash screen yang muncul saat aplikasi dibuka.
- **Home Page (`home_page.dart`)**: Halaman utama yang berisi sapaan, kategori latihan, dan navigasi utama.
- **Focus Exercise Page (`focus_exercise_page.dart`)**: Halaman untuk memilih bagian tubuh yang akan dilatih (misal: Dada, Punggung).
- **List All Exercise Page (`list_all_exercise_page.dart`)**: Menampilkan daftar semua latihan untuk bagian tubuh yang dipilih.
- **Detail Exercise Page (`detail_exercise_page.dart`)**: Menampilkan informasi rinci dari satu latihan, termasuk deskripsi, target otot, dan cara pelaksanaan.
- **Profile Page (`profile_page.dart`)**: Halaman untuk menampilkan data pengguna dan pengaturan.

## Langkah-langkah Menjalankan Aplikasi

Berikut adalah cara untuk menjalankan proyek ini di komputer Anda:
1.  Clone repositori `Mobile-Programming---B`: `git clone https://github.com/Farilzzz/Mobile-Programming---B.git`
2.  Masuk ke folder proyek UTS: `cd Mobile-Programming---B/"UTS MOBILE PROGRAMMING"` *(Gunakan tanda kutip karena ada spasi)*
3.  Buka proyek menggunakan VS Code atau Android Studio.
4.  Jalankan perintah `flutter pub get` di terminal untuk menginstal semua dependensi.
5.  Pastikan emulator atau perangkat fisik terhubung.
6.  Jalankan aplikasi dengan menekan `F5` atau menggunakan perintah `flutter run`.
