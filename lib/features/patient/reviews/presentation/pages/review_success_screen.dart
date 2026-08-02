import 'package:flutter/material.dart';

class ReviewBerhasilPage extends StatelessWidget {
  const ReviewBerhasilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      const Text(
                        'Ulasan Telah Direkam',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4DAFFF),
                          fontFamily: 'Poppins',
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Subtitle
                      const Text(
                        'Catatan Ulasan Dapat Dilihat di Rekaman Ulasan\ndalam Profil',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4DAFFF),
                          fontFamily: 'Instrument Sans',
                          height: 1.5,
                          letterSpacing: 0.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      // Check Icon with Sparkles
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Sparkle top-left (small)
                            Positioned(
                              left: 35,
                              top: 25,
                              child: Image.asset(
                                'assets/images/Tooth.png',
                                width: 18,
                                height: 18,
                                color: const Color(0xFF4DAFFF),
                              ),
                            ),
                            // Sparkle top-right (large)
                            Positioned(
                              right: 20,
                              top: 35,
                              child: Image.asset(
                                'assets/images/Tooth.png',
                                width: 26,
                                height: 26,
                                color: const Color(0xFF4DAFFF),
                              ),
                            ),
                            // Sparkle bottom-left (tiny)
                            Positioned(
                              left: 40,
                              bottom: 45,
                              child: Image.asset(
                                'assets/images/Tooth.png',
                                width: 12,
                                height: 12,
                                color: const Color(0xFF4DAFFF),
                              ),
                            ),

                            // Main Check Circle
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4DAFFF),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4DAFFF)
                                        .withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 60,
                                weight: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Selesai Button at Bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/main',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2158A1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Selesai',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
