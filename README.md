# Praktikum Mobile Programming
# Geo_Catatan

## Nama : Yossy Fira Rosdiana
## NIM : 362458302022
## Kelas : TRPL 2B

1. Kustomisasi Marker:Ubah ikon marker agar berbeda-beda tergantung jenis catatan (misal:Toko,Rumah,Kantor).
  A. Input jenis catatan melalui dialog

  <img width="952" height="92" alt="image" src="https://github.com/user-attachments/assets/d90f31a2-e171-4579-9357-8424f089b4d7" />

  Pada fungsi:

  <img width="1404" height="124" alt="image" src="https://github.com/user-attachments/assets/a00837f0-8370-427d-9fc6-bd0c5ee1362e" />

  Saat dipilih, data jenis disimpan:

  <img width="1252" height="234" alt="image" src="https://github.com/user-attachments/assets/495b149b-288e-4159-98a9-37c0c28f44ed" />

  B. Fungsi memilih ikon berdasarkan jenis

  <img width="996" height="328" alt="image" src="https://github.com/user-attachments/assets/5636ee5b-46d3-4512-9b41-0819c02f79c1" />
  
  C. Fungsi memberi warna yang berbeda

  <img width="988" height="280" alt="image" src="https://github.com/user-attachments/assets/2a867211-4054-4d2d-a5ef-43fbc88d14d0" />

  D. Marker pada peta

  <img width="934" height="422" alt="image" src="https://github.com/user-attachments/assets/c0b545f0-a097-45cb-b658-9df1619e5b9f" />

  Penjelasan: saya menambahkan fitur untuk mengubah ikon marker berdasarkan jenis catatan. Setiap marker bisa berupa Rumah, Toko, atau Kantor. Pada saat pengguna melakukan long-press pada peta, muncul
  dialog pemilihan jenis. Jenis yang dipilih akan menentukan ikon dan warna marker menggunakan fungsi _getIconForType() dan _getColorForType(), sehingga setiap marker dapat dibedakan
  dengan mudah.

2. Hapus Data:Tambahkan fitur untuk menghapus marker yang sudah dibuat.
  A. Marker bisa ditekan

  <img width="990" height="46" alt="image" src="https://github.com/user-attachments/assets/ec814b67-8655-48dd-a787-a2fc0e6eaf23" />

  B. Dialog konfirmasi hapus

  <img width="1114" height="782" alt="image" src="https://github.com/user-attachments/assets/64c9e6e9-ea5d-479c-a9a6-387a8a57dd9d" />

  Penjelasan: saya menambahkan fitur untuk menghapus marker. Saat marker ditekan, aplikasi menampilkan dialog konfirmasi. Jika pengguna memilih "Hapus", marker tersebut dihapus dari list dan peta
  diperbarui. Fitur ini membuat pengguna dapat mengelola data dengan lebih fleksibel.

3. Simpan Data: (Opsional) Gunakan SharedPreferences atau Hive agar data tidak hilang saat aplikasi ditutup.
   A. Menyimpan catatan ke SharedPreferences

   <img width="992" height="322" alt="image" src="https://github.com/user-attachments/assets/dee3da82-382a-43aa-b855-7a82949b3aa6" />
  
   B. Memuat catatan ketika aplikasi dibuka

   <img width="988" height="472" alt="image" src="https://github.com/user-attachments/assets/ae2c067f-09fd-4e89-a0e0-7b2f4369b5f4" />

   C. Dipanggil pada initState()

   <img width="1004" height="212" alt="image" src="https://github.com/user-attachments/assets/efc29e53-23c8-4f3f-94cb-9e74fc584d66" />

   D. Tambahan di Catatan Model

   <img width="1012" height="818" alt="image" src="https://github.com/user-attachments/assets/b0041b83-1e36-4171-96c8-1eb805f9329f" />

   Penjelasan: saya menggunakan SharedPreferences untuk menyimpan daftar catatan dalam format JSON. Setiap kali marker ditambahkan atau dihapus, data diperbarui dan disimpan. Saat aplikasi dibuka
   kembali, data otomatis dimuat menggunakan fungsi _loadNotes(). Dengan cara ini, semua marker tetap tersimpan meskipun aplikasi ditutup atau direstart.
  
Hasil
* tampilan awal
  
![WhatsApp Image 2025-11-22 at 06 24 20_070ff128](https://github.com/user-attachments/assets/993a1403-b737-4a21-aca2-81ff7c23b4b1)

* menambahkan catatan
  
![WhatsApp Image 2025-11-22 at 10 20 35_654af98d](https://github.com/user-attachments/assets/82634c34-2bd0-4039-bca2-fd15b0de8dcf)

* tampilan catatan yang telah dibuat

![WhatsApp Image 2025-11-22 at 06 24 20_227176ba](https://github.com/user-attachments/assets/76ae980f-b76b-40b6-86f8-d57bd0cf16b3)

* hapus toko

![WhatsApp Image 2025-11-22 at 06 24 20_c74622ce](https://github.com/user-attachments/assets/50a82663-5ff8-45ca-a2a9-5b50132c69f1)

* setelah dihapus toko

![WhatsApp Image 2025-11-22 at 06 24 21_8db7d6c3](https://github.com/user-attachments/assets/51cb0160-9ab8-439c-a4a2-e9c32135526a)
