import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../reviews/presentation/pages/review_page.dart';

/// =========================================
/// BOOKING BERHASIL PAGE (versi bintang jauh + besar)
/// =========================================
class BookingBerhasilPage extends StatefulWidget {
  const BookingBerhasilPage({super.key});

  @override
  State<BookingBerhasilPage> createState() => _BookingBerhasilPageState();
}

class _BookingBerhasilPageState extends State<BookingBerhasilPage>
    with TickerProviderStateMixin {
  late AnimationController _checkController;
  late Animation<double> _checkScale;
  late AnimationController _starController;

  @override
  void initState() {
    super.initState();

    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _checkScale = CurvedAnimation(
      parent: _checkController,
      curve: Curves.elasticOut,
    );

    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 400), () {
      _checkController.forward();
    });
  }

  @override
  void dispose() {
    _checkController.dispose();
    _starController.dispose();
    super.dispose();
  }

  Widget _buildStar(double top, double left, double size, double delay) {
    return Positioned(
      top: top,
      left: left,
      child: FadeTransition(
        opacity: Tween(begin: 0.3, end: 1.0).animate(
          CurvedAnimation(
            parent: _starController,
            curve: Interval(delay, 1.0, curve: Curves.easeInOut),
          ),
        ),
        child: Icon(
          Icons.star,
          color: Colors.white.withValues(alpha: 0.95),
          size: size,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E63D0), Color(0xFF4FAAF8)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                "Booking Berhasil",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Catatan Booking Dapat dilihat di Tab Jadwal",
                style: GoogleFonts.instrumentSans(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 40),

              /// Icon centang + bintang
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        // bintang lebih jauh dan besar
                        _buildStar(0, 50, 16, 0.1),
                        _buildStar(-10, 100, 18, 0.3),
                        _buildStar(30, 130, 16, 0.4),
                        _buildStar(90, 40, 20, 0.6),
                        _buildStar(70, 120, 18, 0.8),
                        _buildStar(10, 10, 15, 0.5),
                      ],
                    ),
                  ),
                  ScaleTransition(
                    scale: _checkScale,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(24), // sedikit diperbesar
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF4DAFFF),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(18),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      /// Tombol bawah
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (_, _, _) => ReviewPage(),
                  transitionsBuilder: (_, animation, _, child) =>
                      FadeTransition(opacity: animation, child: child),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 3,
            ),
            child: Text(
              "Selesai",
              style: GoogleFonts.instrumentSans(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
