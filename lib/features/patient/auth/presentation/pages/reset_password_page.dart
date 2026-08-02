import 'package:flutter/material.dart';

void main() {
  runApp(const ResetPasswordPage()); //
}

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. App Bar (Header dan Tombol Kembali)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            // Logika kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Kembali',
          style: TextStyle(color: Colors.blue, fontSize: 16),
        ),
        leadingWidth: 90, // Untuk memberi ruang pada teks Kembali
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 2. Judul Halaman
            const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2), // Biru tua
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Masukkan Email untuk Merestart Password',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // 3. Input Email
            const TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            const Spacer(), // Mendorong tombol ke bawah
            // 4. Tombol Reset Password (di bagian bawah)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Logika untuk mengirim email reset password
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2), // Biru tua
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20), // Padding di bawah tombol
          ],
        ),
      ),
    );
  }
}
