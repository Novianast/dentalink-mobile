import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_password_page.dart';
import 'home_screen.dart';
import 'package:dentalink/core/constants/colors.dart'; // <-- IMPORT DITAMBAHKAN

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Tidak perlu lagi

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        titleSpacing: 5.0,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login ke DentaLink",
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue, // WARNA BARU
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Masuk untuk mengelola pesanan pemeriksaan gigi Anda',
                      style: GoogleFonts.instrumentSans(
                        color: AppColors.darkBlue.withValues(alpha: 
                          0.7,
                        ), // WARNA BARU
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email / Phone Number',
                        labelStyle: GoogleFonts.instrumentSans(
                          color: AppColors.lightBlue,
                        ), // WARNA BARU
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.lightBlue,
                            width: 1.5,
                          ), // WARNA BARU
                        ),
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
                    const SizedBox(height: 15),
                    TextField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: GoogleFonts.instrumentSans(
                          color: AppColors.lightBlue,
                        ), // WARNA BARU
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.lightBlue,
                            width: 1.5,
                          ), // WARNA BARU
                        ),
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
                          ), // WARNA BARU
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const ForgotPasswordPage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                        child: Text(
                          "Lupa Password?",
                          style: GoogleFonts.instrumentSans(
                            color: AppColors.darkBlue, // WARNA BARU
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const DoctorHomeScreen(),
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
              child: Text(
                "Login",
                style: GoogleFonts.instrumentSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 50 + MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
