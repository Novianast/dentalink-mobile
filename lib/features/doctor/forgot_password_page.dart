import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_password_page.dart';
import 'package:dentalink/core/constants/colors.dart'; // <-- IMPORT DITAMBAHKAN

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Tidak perlu lagi
    final screenHeight =
        MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white, // WARNA BARU
        elevation: 0,
        // --- MODIFIKASI TOMBOL KEMBALI ---
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
            bottom: 10,
            right: 4,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBlue, // WARNA BARU
              borderRadius: BorderRadius.circular(10), // RADIUS BARU
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              color: AppColors.darkBlue, // WARNA IKON BARU
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ),
        // --- AKHIR MODIFIKASI ---
        title: Text(
          "Login",
          style: GoogleFonts.istokWeb(
            color: AppColors.darkBlue, // WARNA BARU
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: SizedBox(
          height: screenHeight * 0.95,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lupa Password',
                style: TextStyle(
                  color: AppColors.darkBlue, // WARNA BARU
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Masukkan alamat email Anda yang terdaftar untuk menerima tautan pengaturan ulang kata sandi.',
                style: TextStyle(
                  color: AppColors.darkBlue.withValues(alpha: 0.7), // WARNA BARU
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Anda',
                  labelStyle: TextStyle(
                    color: AppColors.lightBlue,
                  ), // WARNA BARU
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.lightBlue,
                      width: 1.5,
                    ), // WARNA BARU
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.lightBlue,
                      width: 2.0,
                    ), // WARNA BARU
                  ),
                ),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const CreateNewPasswordPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue, // WARNA BARU
                  foregroundColor: Colors.white, // WARNA BARU
                  minimumSize: const Size(double.infinity, 55),
                  shape: const StadiumBorder(),
                  elevation: 3,
                ),
                child: const Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 27 + MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
