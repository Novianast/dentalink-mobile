import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dentalink/core/constants/colors.dart';
import 'notification.dart';
import 'konsultasi.dart';
import 'detail_patient.dart';
import 'dokter_artikel.dart';
import 'profil_dokter.dart';
import 'package:dentalink/core/widgets/custom_bottom_navigation_bar.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DoctorHomeScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;

    if (!mounted) return; // Guard untuk memastikan widget masih mounted

    switch (index) {
      case 0:
        setState(() => _currentIndex = 0);
        break;
      case 1:
        setState(() => _currentIndex = index);
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
      case 4:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const ProfilDokterScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan padding bottom untuk menghindari area navbar
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final navbarHeight = 90.0; // Tinggi navbar
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: navbarHeight + bottomPadding + 20, // Navbar height + safe area padding + extra space
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- MODIFIKASI: HERO TETAP DI SINI ---
            Hero(
              tag: "header_gradient",
              // Child-nya adalah _buildHeader() yang strukturnya sudah diubah
              child: _buildHeader(),
            ),

            // --- AKHIR MODIFIKASI ---
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildCalendar(), // Calendar is the base
                Positioned(
                  top: -30,
                  left: 0,
                  right: 0,
                  child: _buildSchedule(),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildMedicalRecordButton(),
            _buildExploreArticleButton(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
    );
  }

  // --- MODIFIKASI: STRUKTUR WIDGET DIUBAH ---
  // Diubah dari Stack menjadi Container agar sama dengan notification.dart
  Widget _buildHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 269,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/Gradient_Dot.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: SafeArea(
        bottom: false, // SafeArea hanya untuk top dan sides
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Graha Dental App',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        'DentaLink',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 45),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang,',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  Text(
                    'dr. Bagas Sumanto',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  // --- AKHIR MODIFIKASI ---

  Widget _buildSchedule() {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                color: AppColors.darkBlue,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Jadwal Praktek Hari ini',
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '16:45',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Yosan Sonjaya....',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.darkBlue,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.lightBlue, width: 1),
              ),
              shadowColor: Colors.black26,
              elevation: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jadwal',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Lainnya',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      height: 396,
      margin: const EdgeInsets.fromLTRB(
        20,
        50,
        20,
        0,
      ), // Increased top margin to move it down
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.darkBlue,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.darkBlue,
            shape: BoxShape.circle,
          ),
          todayTextStyle: const TextStyle(color: Colors.white),
          selectedTextStyle: const TextStyle(color: Colors.white),
          weekendTextStyle: const TextStyle(color: Colors.black),
          defaultTextStyle: const TextStyle(color: Colors.black),
        ),
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          headerPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          // Handle day selection if needed
        },
      ),
    );
  }

  Widget _buildMedicalRecordButton() {
    return Container(
      height: 37,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const PasienDetailPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.white24,
          highlightColor: AppColors.darkBlue.withValues(alpha: 0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rekam Medis Pasien Terjadwal',
                style: TextStyle(color: Colors.white),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExploreArticleButton() {
    return Container(
      height: 47,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.darkBlue, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const ArticleListScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
          borderRadius: BorderRadius.circular(10),
          splashColor: AppColors.darkBlue.withValues(alpha: 0.2),
          highlightColor: Colors.grey.withValues(alpha: 0.3),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.darkBlue, AppColors.lightBlue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ), // Dark blue background for icon
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Icon(Icons.article, color: Colors.white),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Jelajahi Artikel',
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.darkBlue, // Warna gelap (atas)
                      AppColors.lightBlue, // Warna terang (bawah)
                    ],
                    begin: Alignment.topCenter, // Awal gradien dari atas
                    end: Alignment.bottomCenter, // Akhir gradien di bawah
                  ), // Dark blue background for icon
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: const Icon(Icons.file_copy, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
