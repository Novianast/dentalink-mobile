import 'package:flutter/material.dart';
// Impor halaman home
import '../home/presentation/pages/home_screen.dart';
import '../consultation/presentation/pages/consultation_screen.dart';
import '../booking/presentation/pages/booking_schedule.dart';
import '../articles/presentation/pages/artikel_screen.dart';
import '../profile/presentation/pages/profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Variabel ini untuk melacak tab mana yang sedang aktif
  int _selectedIndex = 0;

  // Daftar halaman/widget yang akan ditampilkan sesuai tab.
  // Dibuat sebagai instance variable (bukan static) untuk menghindari masalah state.

  // Fungsi yang akan dipanggil saat user menekan tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pindahkan deklarasi daftar widget ke dalam build method.
    // Ini adalah perbaikan kunci untuk masalah 'Duplicate GlobalKey'.
    final List<Widget> widgetOptions = <Widget>[
      const PatientHomeScreen(),
      const ConsultationScreen(),
      const JadwalBookingScreen(),
      const ArtikelDentaLinkScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      // Menggunakan IndexedStack untuk menjaga state setiap halaman saat berpindah tab
      body: IndexedStack(index: _selectedIndex, children: widgetOptions),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, Icons.home, 'Home', 0),
              _buildNavItemWithToothIcon('Konsultasi', 1),
              _buildNavItem(
                Icons.calendar_month_outlined,
                Icons.calendar_month,
                'Booking',
                2,
              ),
              _buildNavItem(Icons.school_outlined, Icons.school, 'Edukasi', 3),
              _buildNavItem(Icons.person_outline, Icons.person, 'Profil', 4),
            ],
          ),
        ),
      ),
    );
  }

  /// Method untuk membangun item navigasi dengan icon gigi dari assets.
  Widget _buildNavItemWithToothIcon(String label, int index) {
    final bool isSelected = _selectedIndex == index;

    // Jika item terpilih, tampilkan widget dengan latar belakang gradien.
    if (isSelected) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2158A1), Color(0xFF4DAFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/navbar/tooth.png',
                    width: 20.0,
                    height: 20.0,
                    color: Colors.white,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, color: Colors.white, size: 20.0);
                    },
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Jika item tidak terpilih, tampilkan widget biasa dengan icon gigi outline.
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/navbar/tooth_outline.png',
              width: 24.0,
              height: 24.0,
              color: Colors.black,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: Colors.black, size: 24.0);
              },
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(color: Colors.black, fontSize: 14.0),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Method untuk membangun setiap item navigasi.
  Widget _buildNavItem(
    IconData icon,
    IconData activeIcon,
    String label,
    int index,
  ) {
    final bool isSelected = _selectedIndex == index;

    // Jika item terpilih, tampilkan widget dengan latar belakang gradien.
    if (isSelected) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2158A1), Color(0xFF4DAFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(activeIcon, color: Colors.white, size: 24.0),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Jika item tidak terpilih, tampilkan widget biasa.
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.black, size: 28.0),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(color: Colors.black, fontSize: 14.0),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
