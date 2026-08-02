import 'package:flutter/material.dart';

class UserIdentityScreen extends StatelessWidget {
  const UserIdentityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: null, // <-- 1. HAPUS APPBAR
      body: SafeArea(
        // <-- 2. TAMBAHKAN SAFEAREAD
        child: SingleChildScrollView(
          // <-- BODY YANG SUDAH DIBUNGKUS
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  // --- TAMBAHKAN TOMBOL KEMBALI DI SINI ---
                  child: TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF84BCEA),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFF2158A1),
                          size: 16,
                        ),
                      ),
                    ),
                    label: const Text(
                      'Kembali',
                      style: TextStyle(
                        fontFamily: 'Istok Web',
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                    // Style ini penting agar tombolnya tidak punya padding internal
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      alignment: Alignment.centerLeft, // Rata kiri
                    ),
                  ),
                ),

                // Beri jarak antara tombol dan judul
                const SizedBox(height: 1),
                // ------------------------------------------

                // BAGIAN 1: JUDUL (SEKARANG AKAN SEJAJAR)
                // BAGIAN 1: JUDUL (TIDAK DIUBAH, SESUAI PERMINTAAN)
                const Text(
                  'Identitas Lengkap',
                  style: TextStyle(
                    fontFamily: 'Poppins', // <-- TETAP POLEKTINS
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0D47A1), // Biru gelap
                  ),
                ),
                const SizedBox(height: 30),

                // BAGIAN 2: FOTO PROFIL
                const CircleAvatar(
                  radius: 60,
                  // Ganti dengan URL gambar profil yang sesuai
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/seed/a042581f/200', // Ganti ke picsum agar jalan di web
                  ),
                ),
                const SizedBox(height: 30),

                // BAGIAN 3: KARTU INFORMASI
                _buildInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk kartu yang berisi data diri
  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Color(0xFF000000)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        // Kita pakai Stack agar bisa menumpuk tombol "Edit Profil"
        clipBehavior: Clip.none, // Izinkan tombol keluar dari batas kartu
        children: [
          // BAGIAN 3A: INFORMASI DATA DIRI
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: Color(0xFF000000)),
              const SizedBox(height: 30), // Beri jarak untuk tombol
              _buildInfoRow('Nama Lengkap', 'Tendou Souji'),
              _buildInfoRow('Email / No. Telepon', 'kabutonouji@gmail.com'),
              _buildInfoRow('Tanggal Lahir', '2 Oktober 1990'),
              _buildInfoRow('Jenis Kelamin', 'Laki - Laki'),
            ],
          ),

          // BAGIAN 3B: TOMBOL EDIT PROFIL
          Positioned(
            top: -10, // Sedikit di atas garis Divider
            right: 0,
            child: ElevatedButton(
              onPressed: () {
                // Aksi untuk edit profil
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                // <-- Tambahkan const
                'Edit Profil',
                style: TextStyle(
                  fontFamily: 'Instrument Sans', // <-- 2. UBAH DI SINI
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget untuk membuat baris info (Label & Value)
  // Helper widget untuk membuat baris info (Label & Value)
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. FONT UNTUK LABEL (DIUBAH KE w400)
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontWeight: FontWeight.w400, // <-- w400 (Regular)
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 0),
          // 2. FONT UNTUK VALUE (DIUBAH KE w600)
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w600, // <-- w600 (SemiBold)
            ),
          ),
        ],
      ),
    );
  }
}
