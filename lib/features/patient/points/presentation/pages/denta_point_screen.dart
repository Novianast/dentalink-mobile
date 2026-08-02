import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../vouchers/presentation/pages/voucher_detail_screen.dart';

class DentaPointPage extends StatelessWidget {
  const DentaPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol kembali
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
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

              Text(
                'Denta Point',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2A5DA8),
                ),
              ),

              const SizedBox(height: 20),

              // Card poin
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF5BB7FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'DP 1.200',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'Point Details',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '1.200 points expiring on 31/12/2023',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '5 vouchers available',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),
                  ],
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

              // Grid voucher
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.8,
                children: [
                  voucherCard(
                    context,
                    "5% Voucher Discount",
                    "Diskon 5% Pemeriksaan",
                    "500 Points",
                    Colors.blue[900]!,
                  ),
                  voucherCard(
                    context,
                    "10% Voucher Discount",
                    "Diskon 10% Pemeriksaan",
                    "1000 Points",
                    Colors.blue[400]!,
                  ),
                  voucherCard(
                    context,
                    "Cashback Terbatas 15% Setiap Pemeriksaan",
                    "Cashback 15%",
                    "1200 Points",
                    Colors.blue[900]!,
                  ),
                  voucherCard(
                    context,
                    "Cashback DentaLink Sebesar 30%",
                    "Cashback 30%",
                    "1800 Points",
                    Colors.blue[400]!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget voucherCard(
    BuildContext context,
    String title,
    String desc,
    String points,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoucherDetailPage(
              title: title,
              desc: desc,
              points: points,
              color: color,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(desc, style: GoogleFonts.poppins(fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(
                    points,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF2A5DA8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF2A5DA8)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Redeem',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF2A5DA8),
                        fontSize: 12,
                      ),
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
}
