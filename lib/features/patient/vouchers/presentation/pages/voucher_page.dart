import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                'Voucher',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2A5DA8),
                ),
              ),

              const SizedBox(height: 20),

              // Search bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                        hintStyle: GoogleFonts.poppins(fontSize: 14),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFF2A5DA8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color(0xFF2A5DA8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFE3F0FF),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.filter_alt_rounded,
                      color: Color(0xFF2A5DA8),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Daftar voucher
              voucherCard(
                title: 'Diskon 5% Pemeriksaan',
                date: '27 Oktober 2026',
                gradient: const LinearGradient(
                  colors: [Color(0xFF002F6C), Color(0xFF5BB7FF)],
                ),
              ),
              voucherCard(
                title: 'Diskon Transaksi 200.000',
                date: '30 November 2026',
                gradient: const LinearGradient(
                  colors: [Color(0xFF0A4B16), Color(0xFF58D26B)],
                ),
              ),
              voucherCard(
                title: 'Gacor 100.000',
                date: '30 November 2026',
                gradient: const LinearGradient(
                  colors: [Color(0xFF8A8000), Color(0xFFE6E056)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget voucherCard({
    required String title,
    required String date,
    required LinearGradient gradient,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // bagian atas: gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // bagian bawah: tanggal
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kadaluwarsa :',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
