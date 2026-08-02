import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_artikel_screen.dart'; // Import detail artikel

// Main screen with the article list and gradient header with pattern.
class ArtikelDentaLinkScreen extends StatelessWidget {
  const ArtikelDentaLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔹 Header with gradient and dot pattern
          Container(
            height: 240,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2158A1), Color(0xFF4DAFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Stack(
              children: [
                // 🔸 Dot pattern overlay (semi-transparent dots)
                CustomPaint(
                  size: Size.infinite,
                  painter: DotPatternPainter(dotColor: Colors.white),
                ),

                // 🔸 Header content (back button, title, search bar)
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back button
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 29,
                                height: 29,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF84BCEA),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 14.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Kembali',
                                style: GoogleFonts.istokWeb(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        Text(
                          'Artikel DentaLink',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Search bar
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              const Icon(
                                Icons.search,
                                color: Color(0xFFB3B3B3),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Search',
                                style: GoogleFonts.instrumentSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFB3B3B3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Article List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ArticleCard(
                  imageUrl: 'assets/artikel1.png',
                  labels: [
                    ArticleLabel(
                      text: 'Kesehatan Gigi',
                      backgroundColor: Color(0x8084BCEA),
                      textColor: Color(0xFF4DAFFF),
                      borderColor: Color(0xFF4DAFFF),
                    ),
                    ArticleLabel(
                      text: 'Tips and Trick',
                      backgroundColor: Color(0x80A2E22B),
                      textColor: Color(0xFF537E03),
                      borderColor: Color(0xFF537E03),
                    ),
                  ],
                  title: 'Tips Menjaga Kesehatan Gigi Tanpa Perlu Periksa',
                  author: 'Nama Penulis',
                  date: '12 Agustus 2025',
                  content:
                      '''Ini adalah Tulisan Artikel yang bakal di Upload sama si Admin. Jalan Kanan-Kiri TERUS LURR

BTW, GoodNight aku pengen tutu.

Siapa nih? kan bukal aku, video izin, apaller ga yah, tidurnya di rumah kalis ini

Lorem Ipsum Dol Doler si Blebleble, per ticcin-den imatto mulateno

El ol nomene, hambre defunta. Pluta, caleron''',
                ),
                SizedBox(height: 16),
                ArticleCard(
                  imageUrl: 'assets/artikel2.png',
                  labels: [
                    ArticleLabel(
                      text: 'Kesehatan Gigi',
                      backgroundColor: Color(0x8084BCEA),
                      textColor: Color(0xFF4DAFFF),
                      borderColor: Color(0xFF4DAFFF),
                    ),
                    ArticleLabel(
                      text: 'Peran Dokter',
                      backgroundColor: Color(0x80FFD700),
                      textColor: Color(0xFFB8860B),
                      borderColor: Color(0xFFB8860B),
                    ),
                  ],
                  title: 'Text Judul Artikel Wattpad Admin',
                  author: 'Nama Penulis',
                  date: '12 Agustus 2025',
                  content:
                      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.''',
                ),
                SizedBox(height: 16),
                ArticleCard(
                  imageUrl: 'assets/artikel3.png',
                  labels: [
                    ArticleLabel(
                      text: 'Kesehatan Gigi',
                      backgroundColor: Color(0x8084BCEA),
                      textColor: Color(0xFF4DAFFF),
                      borderColor: Color(0xFF4DAFFF),
                    ),
                    ArticleLabel(
                      text: 'Peran Dokter',
                      backgroundColor: Color(0x80FFD700),
                      textColor: Color(0xFFB8860B),
                      borderColor: Color(0xFFB8860B),
                    ),
                    ArticleLabel(
                      text: 'Tips and Trick',
                      backgroundColor: Color(0x80A2E22B),
                      textColor: Color(0xFF537E03),
                      borderColor: Color(0xFF537E03),
                    ),
                  ],
                  title: 'Nasihat kepada Orang yang Gapernah Sikat Gigi',
                  author: 'Nama Penulis',
                  date: '12 Agustus 2025',
                  content:
                      '''Nasihat penting untuk menjaga kesehatan gigi dan mulut. Menyikat gigi secara teratur adalah kunci utama.

Gunakan pasta gigi berfluoride dan sikat gigi dengan bulu yang lembut. Sikat gigi minimal 2 kali sehari.

Jangan lupa untuk berkumur dengan mouthwash dan flossing untuk hasil yang maksimal.''',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 Custom Card for Article - UPDATED WITH NAVIGATION
class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final List<ArticleLabel> labels;
  final String title;
  final String author;
  final String date;
  final String content; // Added content parameter

  const ArticleCard({
    super.key,
    required this.imageUrl,
    required this.labels,
    required this.title,
    required this.author,
    required this.date,
    required this.content, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imageUrl.isNotEmpty;

    return GestureDetector(
      onTap: () {
        // Navigate to detail artikel screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArtikelScreen(
              imageUrl: imageUrl,
              title: title,
              author: author,
              date: date,
              labels: labels,
              content: content,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 176,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                color: const Color(0xFFD9D9D9),
              ),
              child: hasImage
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: const Color(0xFFD9D9D9)),
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Color(0xFFB3B3B3),
                        size: 40,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(spacing: 6, runSpacing: 6, children: labels),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 23,
                        height: 23,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        author,
                        style: GoogleFonts.istokWeb(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        date,
                        style: GoogleFonts.instrumentSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Article Label
class ArticleLabel extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const ArticleLabel({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        text,
        style: GoogleFonts.instrumentSans(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
    );
  }
}

// 🔹 Dot Pattern CustomPainter
class DotPatternPainter extends CustomPainter {
  final Color dotColor;
  final double dotSize;
  final double spacing;

  DotPatternPainter({
    required this.dotColor,
    this.dotSize = 3,
    this.spacing = 18,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = dotColor.withValues(alpha: 0.2);

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
