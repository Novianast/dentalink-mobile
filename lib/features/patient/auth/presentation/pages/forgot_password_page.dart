import 'package:flutter/material.dart';

class LupaPasswordPage extends StatelessWidget {
  const LupaPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar halaman
    return Scaffold(
      backgroundColor: Colors.white,

      // --- 1. APP BAR (DIHAPUS) ---
      // Kita hapus AppBar agar bisa mengatur posisi tombol kembali secara manual
      // di dalam body, sehingga lurus dengan konten di bawahnya.

      // --- 2. BODY (Bagian Isi Utama Halaman) ---
      // Kita bungkus dengan SafeArea agar tidak mentok status bar
      body: SafeArea(
        child: Padding(
          // Memberi jarak (padding) di sisi kiri, atas, dan kanan
          // Padding ini sekarang akan berlaku untuk SEMUA elemen di body
          padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0),
          // Column digunakan untuk menyusun widget-widget secara vertikal (ke bawah)
          child: Column(
            // 'crossAxisAlignment.stretch' membuat semua widget 'anak' (children)
            // seperti tombol, untuk melebar memenuhi layar secara horizontal
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBackButton(context),
              // Memberi jarak antara tombol kembali dan judul
              const SizedBox(height: 1),
              _buildHeader(context),
              // Memberi jarak vertikal antara Judul dan Form Email
              const SizedBox(height: 70),
              _buildEmailForm(context),
              // --- 5. SPACER (Pendorong ke Bawah) ---
              // 'Spacer' akan mengambil semua ruang kosong yang tersisa di dalam Column.
              // Ini akan "mendorong" tombol ke bagian paling bawah layar.
              const Spacer(),
              // --- 6. BAGIAN BAWAH (TOMBOL) ---
              _buildResetButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk tombol kembali
  Widget _buildBackButton(BuildContext context) {
    final Color darkBlueColor = Theme.of(context).primaryColorDark;
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade100.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: darkBlueColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Login",
            style: TextStyle(
              color: darkBlueColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk judul halaman
  Widget _buildHeader(BuildContext context) {
    final Color darkBlueColor = Theme.of(context).primaryColorDark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lupa Password",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            color: darkBlueColor,
          ),
        ),
        const SizedBox(height: 8), // Jarak antara judul dan teks kecil
        Text(
          "Masukkan Email anda untuk menerima Link reset password",
          style: TextStyle(
              fontSize: 14, color: darkBlueColor.withValues(alpha: 0.7)),
        ),
      ],
    );
  }

  // Widget untuk form input email
  Widget _buildEmailForm(BuildContext context) {
    final Color darkBlueColor = Theme.of(context).primaryColorDark;
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "contoh@email.com",
        labelStyle: TextStyle(color: darkBlueColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: darkBlueColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: darkBlueColor, width: 2.0),
        ),
      ),
    );
  }

  // Widget untuk tombol reset password
  Widget _buildResetButton(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0), // Posisi dinaikkan
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Link reset password telah dikirim ke email Anda (jika terdaftar).",
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 5,
          shadowColor: primaryColor.withValues(alpha: 0.8),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ), // Ukuran diperbesar
        ),
        child: const Text(
          "Reset Password",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
