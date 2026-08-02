import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoucherDetailPage extends StatelessWidget {
  final String title;
  final String desc;
  final String points;
  final Color color;

  const VoucherDetailPage({
    super.key,
    required this.title,
    required this.desc,
    required this.points,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol kembali
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F0FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF2A5DA8),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Kembali',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: const Color(0xFF2A5DA8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Judul halaman
              Text(
                'Voucher Detail',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2A5DA8),
                ),
              ),

              const SizedBox(height: 20),

              // Card utama
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Deskripsi voucher
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF2A5DA8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          points,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2A5DA8),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Nikmati voucher diskon 25% dari DentaLink! Voucher ini memberikan potongan seperempat dari harga normal untuk layanan pemeriksaan gigi pilihan.\n\n"
                          "Gunakan kesempatan ini untuk menjaga kesehatan gigimu dengan harga yang lebih hemat — baik untuk dirimu sendiri maupun orang terdekat.\n\n"
                          "Selamat menikmati perawatan dengan senyum yang lebih cerah!",
                          style: GoogleFonts.poppins(fontSize: 14, height: 1.6),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF2A5DA8)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Syarat dan Ketentuan",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tombol Redeem bawah
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A5DA8),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Redeem',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
