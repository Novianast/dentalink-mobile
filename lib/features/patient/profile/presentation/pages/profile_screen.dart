import 'package:flutter/material.dart';
import 'package:dentalink/core/services/auth_service.dart';
import '../../../consultation/presentation/pages/history/consultation_history_screen.dart';
import 'identity_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Letakkan fungsi ini di dalam class ProfileScreen
  // (Misalnya, letakkan setelah method _buildBottomNavBar)

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User harus menekan tombol!
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          // Membuat sudut pop up melengkung
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),

          // Teks utama di tengah
          content: const Text(
            'Apakah anda Yakin ingin Logout\ndari Aplikasi ini?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Instrument Sans",
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          // Mengatur perataan tombol
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 20,
          ),

          // Daftar tombol aksi
          actions: <Widget>[
            // Tombol "Tidak, kembali"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB9B9B9),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Tidak, kembali',
                style: TextStyle(
                  fontFamily: "Instrument Sans",
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                // Tutup dialog
                Navigator.of(dialogContext).pop();
              },
            ),

            const SizedBox(width: 10), // Jarak antar tombol
            // Tombol "Iya, lanjutkan"
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Iya, lanjutkan',
                style: TextStyle(
                  fontFamily: "Instrument Sans",
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              onPressed: () async {
                // Tutup dialog
                Navigator.of(dialogContext).pop();
                // Logout dari AuthService
                await AuthService().logout();
                // Navigasi ke login page dan hapus semua route sebelumnya
                if (!context.mounted) return;
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Warna latar belakang abu-abu seperti di gambar
      backgroundColor: Colors.grey[100],
      // Kita tidak perlu AppBar di halaman ini
      appBar: null,
      body: ListView(
        children: [
          // BAGIAN 1: HEADER PROFIL (BIRU)
          _buildProfileHeader(),

          // BAGIAN 2: KARTU MEMBERSHIP
          _buildMembershipCard(),

          // BAGIAN 3: MENU UTAMA
          _buildMainMenu(context),

          // Akses ke semua halaman untuk memastikan tidak ada halaman yatim
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Color(0xFF4DAFFF)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.apps, color: Colors.black),
                title: const Text(
                  'Semua Halaman',
                  style: TextStyle(
                    fontFamily: "Instrument Sans",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.black),
                onTap: () {
                  Navigator.pushNamed(context, '/all-screens');
                },
              ),
            ),
          ),

          // BAGIAN 4: MENU AKSI (RESET & LOGOUT)
          _buildActionMenu(context),
        ],
      ),
    );
  }

  // Widget untuk Header Profil (Bagian Biru)
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Gradient_Dot.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: const Column(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://picsum.photos/seed/a042581f/200',
            ), // Ganti dengan URL gambar profil
          ),
          SizedBox(height: 15),
          Text(
            'Tendou Souji',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0),
          Text(
            'kabutonouji@gmail.com',
            style: TextStyle(
              fontFamily: "Instrument Sans",
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget untuk Kartu Membership
  Widget _buildMembershipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      // Menggeser kartu ini sedikit ke atas agar menumpuk dengan header biru
      child: Transform.translate(
        offset: const Offset(0, -30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 100, // Atur ukuran sesuai yang kamu inginkan
                height: 30,
              ),
              SizedBox(width: 15),
              Expanded(
                child: const Text(
                  'Silver Membership',
                  style: TextStyle(
                    fontFamily: "Instrument Sans",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk Menu Utama (Identitas, Riwayat, dll)
  // KODE BARU (PERBAIKAN)
  Widget _buildMainMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Transform.translate(
        offset: const Offset(0, -20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Color(0xFF4DAFFF)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                // Tulis ListTile secara manual
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  'Identitas Lengkap Pengguna',
                  style: TextStyle(
                    fontFamily: "Instrument Sans",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.black),
                onTap: () {
                  // INI KODE UNTUK PINDAH HALAMAN
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserIdentityScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.history, color: Colors.black),
                title: const Text(
                  'Riwayat Konsultasi',
                  style: TextStyle(
                    fontFamily: "Instrument Sans",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.black),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConsultationHistoryScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.history_toggle_off_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  'Rekaman Ulasan',
                  style: TextStyle(
                    fontFamily: "Instrument Sans",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.black),
                onTap: () {
                  Navigator.pushNamed(context, '/rekaman-ulasan');
                },
              ),
              ListTile(
                leading: Icon(Icons.local_offer_outlined, color: Colors.black),
                title: const Text(
                  'Voucher Pengguna',
                  style: TextStyle(
                    fontFamily: "Instrument Sans",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.black),
                onTap: () {
                  Navigator.pushNamed(context, '/vouchers');
                },
              ),
              ListTile(
                leading: Image.asset(
                  'assets/images/Tooth.png',
                  width: 21,
                  height: 21,
                ),
                title: const Text(
                  'Denta Poin Pengguna',
                  style: TextStyle(
                    fontFamily: "Instrument Sans",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.black),
                onTap: () {
                  Navigator.pushNamed(context, '/denta-points');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk Menu Aksi (Reset & Logout)
  Widget _buildActionMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Color(0xFF4DAFFF)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.lock_outline, color: Colors.black),
              title: const Text(
                'Reset Password',
                style: TextStyle(
                  fontFamily: "Instrument Sans",
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.black),
              onTap: () {
                Navigator.pushNamed(context, '/reset-password');
              },
            ),
            // Tombol Logout dibuat khusus karena warnanya berbeda
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  _showLogoutDialog(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: "Instrument Sans",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16,
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

  // Bottom navigation dihapus; navigasi global disediakan oleh MainPage
}
