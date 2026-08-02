import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import file sebelumnya agar bisa menggunakan class 'Booking'
import 'booking_schedule.dart';

class ScheduledDetailBookingScreen extends StatelessWidget {
  final Booking booking;

  const ScheduledDetailBookingScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 CUSTOM HEADER (Menggantikan AppBar)
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Baris 1: Tombol "Kembali" — SUDAH DIPERBAIKI
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Kotak biru untuk ikon panah — HANYA IKON YANG BISA DIKLIK
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Color(0xFF84BCEA), // 🎨 WARNA BIRU MUDA
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.chevron_left, // ⭐ GANTI KE INI — LEBIH SIMETRIS
                  color: Color(0xff2158A1),
                  size: 30, // ⭐ UKURAN LEBIH BESAR UNTUK VISIBILITAS
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Teks "Kembali" di luar kotak — TIDAK BISA DIKLIK
          Text(
            "Kembali",
            style: GoogleFonts.istokWeb(
              textStyle: TextStyle(
                color: Color(0xFF2158A1),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      // Baris 2: Judul "Detail Booking"
      const SizedBox(height: 10),
      Text(
        "Detail Booking",
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Color(0xFF2158A1),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
),

            // 🔹 ISI UTAMA — DITURUNKAN KE BAWAH DENGAN JARAK
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0), // ⭐ JARAK ATAS UNTUK CARD
                child: Column(
                  children: [
                    // Kartu utama berisi detail
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Color(0xFF84BCEA), // 🎨 BORDER BIRU MUDA
                          width: 1.0,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Gambar Klinik
                            Padding(
                              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9, // misalnya
                                  child: Image.asset(booking.imageUrl, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            // Konten detail
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailRow(
                                    icon: Icons.local_hospital_outlined,
                                    title: "Nama Klinik",
                                    subtitle: booking.clinicName,
                                  ),
                                  const SizedBox(height: 24),
                                  _buildDetailRow(
                                    icon: Icons.location_on_outlined,
                                    title: "Alamat Klinik",
                                    subtitle: booking.address,
                                  ),
                                  const SizedBox(height: 24),
                                  _buildDetailRow(
                                    icon: Icons.calendar_today_outlined,
                                    title: "Tanggal Reservasi",
                                    subtitle: '${booking.date} - ${booking.time}',
                                  ),
                                  const SizedBox(height: 24),
                                  // Status Booking
                                  Text(
                                    "Status Booking",
                                    style: GoogleFonts.instrumentSans( 
                                      textStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Color(0xFF2158A1),
                                      ),
                                    ),
                                    child: Text(
                                      _capitalizeFirstLetter(booking.status.name),
                                      style: GoogleFonts.instrumentSans(
                                        textStyle:  TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF2158A1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Tombol Batalkan Reservasi
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE94242),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          "Batalkan Reservasi",
                          style: GoogleFonts.instrumentSans(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.instrumentSans(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                subtitle,
                style: GoogleFonts.instrumentSans(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}