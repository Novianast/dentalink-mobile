import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'artikel_screen.dart'; // Import ArticleLabel dan DotPatternPainter

// Detail Article Screen
class DetailArtikelScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String date;
  final List<ArticleLabel> labels;
  final String content;

  const DetailArtikelScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.date,
    required this.labels,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 Header with white background
          Container(
            color: Colors.white,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Row(
                  children: [
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
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Color(0xFF2158A1),
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Kembali',
                            style: GoogleFonts.istokWeb(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2158A1),
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

          // 🔹 Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article Image
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: const Color(0xFFD9D9D9),
                    child: imageUrl.isNotEmpty
                        ? Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: const Color(0xFFD9D9D9),
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Color(0xFFB3B3B3),
                                  size: 40,
                                ),
                              ),
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

                  // Content Container
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // DentaLink and Date in one row
                        Row(
                          children: [
                            Text(
                              'DentaLink',
                              style: GoogleFonts.instrumentSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF9E9E9E),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Color(0xFF9E9E9E),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              date,
                              style: GoogleFonts.instrumentSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF9E9E9E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Divider line
                        Container(height: 1, color: const Color(0xFFE0E0E0)),
                        const SizedBox(height: 16),

                        // Penulis section
                        Row(
                          children: [
                            Text(
                              'Penulis :',
                              style: GoogleFonts.instrumentSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF9E9E9E),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD9D9D9),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              author,
                              style: GoogleFonts.instrumentSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Divider line
                        Container(height: 1, color: const Color(0xFFE0E0E0)),
                        const SizedBox(height: 20),

                        // Article Content
                        Text(
                          content,
                          style: GoogleFonts.instrumentSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            height: 1.6,
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
    );
  }
}
