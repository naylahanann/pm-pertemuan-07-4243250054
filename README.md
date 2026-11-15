(a) Identitas (nama, NIM, kelas)
  - Nama: Nayla Luthfiah Hanan
  - NIM: 4243250054
  - Kelas: Ilmu Komputer D 2024

(b) Tangkapan layar ketiga halaman.
  - Halaman daftar tugas: <img width="923" height="691" alt="Halaman-daftar-tugas" src="https://github.com/user-attachments/assets/2b1adc96-bf4c-4591-a863-f7f0fd162d5e" />

  - Halaman tambah tugas: <img width="155" height="344" alt="Screenshot 2026-11-15 202423" src="https://github.com/user-attachments/assets/8f50e437-19b5-4733-bc14-f7eeebebde95" />

  - Halaman statistik:  <img width="155" height="350" alt="Screenshot 2026-11-15 202458" src="https://github.com/user-attachments/assets/cb438d1b-75c6-4cb9-92cb-e2c900707aab" />

(c) Diagram sederhana letak setiap state (lokal/bersama) dan alasannya.
Diagram:
flowchart TD
    A["Planner Tugas Kuliah"]
    B["Provider (State Bersama)"]
    C["Halaman Daftar Tugas"]
    D["Halaman Tambah Tugas"]
    E["Halaman Statistik"]

    A --> B
    B --> C
    B --> D
    B --> E

    C --> F["State Lokal: Filter (setState)"]
    D --> G["State Lokal: Input dan Tenggat"]
    E --> H["Data Statistik dari Provider"]

Alasannya: 
Pada aplikasi Planner Tugas Kuliah, saya menggunakan `setState()` untuk mengatur filter pada halaman Daftar Tugas karena hanya memengaruhi tampilan halaman tersebut. Pada halaman Tambah Tugas, state lokal digunakan untuk mengelola input dan tanggal tenggat.
Sementara itu, Provider digunakan untuk mengelola data tugas yang dipakai di beberapa halaman. Jadi, ketika ada perubahan data, halaman Daftar Tugas dan Statistik bisa langsung menampilkan informasi terbaru tanpa perlu memperbaruinya secara manual.

(d) Penjelasan 150 sampai 250 kata tentang initState dan dispose, dan alasan memilih Provider.
Dalam pembuatan aplikasi Planner Tugas Kuliah, saya menggunakan lifecycle initState() dan dispose() untuk mengelola input pada halaman tambah tugas. Method initState() digunakan saat halaman pertama kali dibuat, yaitu untuk menginisialisasi TextEditingController yang berfungsi mengambil teks yang dimasukkan pengguna, seperti judul tugas dan nama mata kuliah. Sementara itu, dispose() digunakan ketika halaman sudah tidak digunakan lagi untuk membersihkan controller agar tidak terus menggunakan memori.
Untuk pengelolaan state, saya menggunakan setState() dan Provider sesuai dengan kebutuhan aplikasi. setState() digunakan untuk mengatur filter pada halaman daftar tugas, yaitu Semua, Aktif, dan Selesai. Filter ini termasuk state lokal karena hanya memengaruhi tampilan pada halaman tersebut.
Saya memilih Provider untuk mengelola data tugas karena data tersebut digunakan oleh beberapa halaman, seperti daftar tugas, tambah tugas, dan statistik. Dengan Provider, perubahan data dapat langsung diperbarui pada halaman yang membutuhkan tanpa harus mengirimkan data secara manual dari satu halaman ke halaman lainnya.
Menurut saya, Provider juga lebih mudah dipahami dan diterapkan karena struktur kodenya cukup sederhana. Dengan pembagian state seperti ini, pengelolaan data menjadi lebih teratur dan aplikasi lebih mudah dikembangkan.

(e) Pernyataan penggunaan AI.
Dalam pengerjaan tugas ini, saya menggunakan bantuan AI untuk membantu memahami konsep state management pada Flutter, membantu saya dalam memahami langkah-langkah pengerjaan tugas rutin 7 ini, memberikan penjelasan terkait penggunaan Provider, membantu menyusun dokumentasi README agar lebih rapi dan mudah dipahami, dan membantu saya untuk hal-hal yang saya pertanyakan karena bingung. Hasil bantuan AI tetap saya pelajari dan sesuaikan dengan implementasi aplikasi yang saya kerjakan.
