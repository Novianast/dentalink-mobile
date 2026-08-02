import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewSummaryScreen extends StatelessWidget {
  final String name;
  final String rating;
  final String imagePath;

  const ReviewSummaryScreen({
    super.key,
    required this.name,
    required this.rating,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🟦 Ubah background menjadi putih penuh agar tampak full-screen
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔙 Tombol Kembali
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 29,
                      height: 29,
                      decoration: BoxDecoration(
                        color: const Color(0xFF84BCEA), // 🟦 Background baru
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Color(0xFF2158A1), // 🟦 Icon biru tua
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Kembali',
                      style: GoogleFonts.istokWeb(
                        color: const Color(0xFF2158A1),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // === Judul Rekap Ulasan ===
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Rekap Ulasan',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 19),
                  Container(
                    height: 2,
                    width: 160,
                    color: const Color(0xFF3C84DF),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // === Info Dokter ===
              Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 52,
                      height: 52,
                      color: const Color(0xFFD9D9D9),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 26,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF012A4A),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // === Detail Informasi ===
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(text: 'Tanggal Review'),
                    TextSpan(
                      text: '  :  ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: '10 Oktober 2025, 10:30 AM',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Setelah anda melakukan Review, dapat dilihat bahwa dokter ini telah Terkualifikasi dalam kategori berikut:',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 10),

              _bulletPoint('Memberikan Respons yang Baik'),
              _bulletPoint('Memberikan Pelayanan yang Memuaskan'),
              _bulletPoint('Memberikan Diagnosis'),
              _bulletPoint('Bersikap Ramah'),
              _bulletPoint('Berperilaku Sopan dan Profesional'),
              const SizedBox(height: 16),

              const Text(
                'Tindakan yang Dilakukan oleh Dokter:',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _bulletPoint('Konsultasi Online'),
              const SizedBox(height: 16),

              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    const TextSpan(text: 'Anda memberikan Bintang'),
                    const TextSpan(
                      text: '  :  ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: rating,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3C84DF),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Dengan Catatan :',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF3C84DF)),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              const Center(
                child: Text(
                  'Tim DentalLink siap membantu Anda! Jika ada kendala atau pertanyaan seputar pemesanan, silakan hubungi kami langsung melalui aplikasi atau email ke help@dentalink.id',
                  style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•  ',
            style: TextStyle(color: Color(0xFF3C84DF), fontSize: 14),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
