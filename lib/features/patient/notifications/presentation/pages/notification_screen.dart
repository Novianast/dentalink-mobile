import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Warna utama
  // Warna utama dipindah ke tema global; konstanta khusus tidak diperlukan di sini

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🟦 Background gradasi biru dengan titik-titik dan lengkungan bawah
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                gradient: LinearGradient(
                  colors: [Color(0xFF2158A1), Color(0xFF4DAFFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Konten utama
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 55),
                _buildNotificationList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifikasi',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'InstrumentSans',
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(text: 'Anda memiliki '),
                      TextSpan(
                        text: '2 ',
                        style: TextStyle(
                          color: Color(0xFF2158A1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'notifikasi ',
                        style: TextStyle(
                          color: Color(0xFF2158A1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'hari ini',
                        style: TextStyle(
                          color: Colors.white, // balik ke putih biasa
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.filter_list,
                color: Color(0xFF1258E3),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            _buildNotificationItem(
              context: context,
              title: 'Berhasil',
              subtitle: 'Booking telah berhasil',
              time: '30 Menit yang lalu',
              hasRedDot: true,
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: const Divider(
                  height: 1,
                  thickness: 0.3,
                  color: Colors.grey,
                ),
              ),
            ),
            _buildNotificationItem(
              context: context,
              title: 'Rangkuman Pemesanan',
              subtitle: 'Laporan Pemesanan',
              time: '3 Jam yang lalu',
              hasRedDot: true,
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: const Divider(
                  height: 1,
                  thickness: 0.3,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String time,
    required bool hasRedDot,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/notification-detail');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.notifications_active_outlined,
                color: Color(0xFF2158A1),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'InstrumentSans',
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'InstrumentSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontFamily: 'InstrumentSans',
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom navigation dihapus; navigasi global disediakan oleh MainPage
}

// 🎨 Pola titik seperti pada gambar biru kiri
class DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    const double dotRadius = 2.0;
    const double spacing = 28.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
