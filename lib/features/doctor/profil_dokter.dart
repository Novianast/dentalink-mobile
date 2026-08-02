import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dentalink/core/services/auth_service.dart';
import 'konsultasi.dart'; // halaman konsultasi
import 'forgot_password_page.dart';
import 'package:dentalink/core/widgets/custom_bottom_navigation_bar.dart';
import 'home_screen.dart';
import 'notification.dart';
import 'dokter_artikel.dart';

class ProfilDokterScreen extends StatelessWidget {
  const ProfilDokterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 4,
        onTap: (index) {
          if (index == 4) return;
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const DoctorHomeScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const ArticleListScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const Konsultasi(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const NotificationScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
          }
        },
        items: [
          CustomBottomNavigationBarItem(icon: Icons.home_filled, label: 'Home'),
          CustomBottomNavigationBarItem(
            icon: Icons.query_stats,
            label: 'Statistik',
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.local_hospital,
            label: 'Konsultasi',
            customIcon: Image.asset(
              'assets/navbar/tooth.png',
              width: 20.0,
              height: 20.0,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 20.0);
              },
            ),
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.notifications_none,
            label: 'Notifikasi',
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.account_circle,
            label: 'Profil',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🟦 Header biru hanya di bagian atas dengan lengkungan bawah
            Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('component/bg.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🧑‍⚕ Foto profil di kiri
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                    ),
                  ),
                  const SizedBox(width: 15),
                  // 🧾 Nama dan email di kanan foto
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "dr. Bagas",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "drbagas@gmail.com",
                        style: GoogleFonts.instrumentSans(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // 🦷 Tombol Dokter DentaLink
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const Konsultasi(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                icon: Image.asset('assets/images/Tooth.png', height: 24),
                label: Text(
                  "Dokter DentaLink",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: const BorderSide(color: Colors.blueAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Menu Identitas & Riwayat
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent.shade100),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    menuItem(Icons.account_circle, "Identitas Lengkap Dokter"),
                    const Divider(height: 20, color: Colors.black12),
                    menuItem(Icons.history, "Riwayat Konsultasi"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 🔹 Menu Reset Password & Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent.shade100),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
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
                      child: menuItem(Icons.lock_outline, "Reset Password"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await AuthService().logout();
                        if (!context.mounted) return;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                          (Route<dynamic> route) => false,
                        );
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔸 Komponen menu item (ikon + teks)
  static Widget menuItem(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
