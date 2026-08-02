import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../booking/presentation/pages/booking_berhasil_screen.dart';

/// =========================================
/// KONFIRMASI PAGE
/// =========================================
class KonfirmasiPage extends StatefulWidget {
  const KonfirmasiPage({super.key});

  @override
  State<KonfirmasiPage> createState() => _KonfirmasiPageState();
}

class _KonfirmasiPageState extends State<KonfirmasiPage> {
  bool showAllServices = false;

  final List<String> mainServices = [
    "Pasang Kawat Gigi",
    "Kontrol Kawat Gigi",
    "Scaling Gigi",
    "Cabut Gigi",
    "Endodontik",
  ];

  final List<String> extraServices = [
    "Kontrol Gigi",
    "Pemeriksaan Jaringan Mulut",
    "Biopsi",
    "Diagnosa Penyakit Mulut",
  ];

  Future<void> openMaps() async {
    const url = 'https://maps.google.com'; // URL placeholder
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak bisa membuka Google Maps')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- GAYA KONSISTEN UNTUK JUDUL BOX ---
    final TextStyle titleStyle = GoogleFonts.instrumentSans(
      fontSize: 15,
      fontWeight: FontWeight.w600, // w600 adalah SemiBold
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol Kembali (Tidak Diubah)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF84BCEA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
                          color: Color(0xFF2158A1),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Kembali",
                        style: GoogleFonts.istokWeb(
                          color: const Color(0xFF2158A1),
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // Judul Halaman (Tidak Diubah)
                Text(
                  "Konfirmasi",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF2158A1),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- JUDUL LOKASI KLINIK ---
                  Text(
                    "Lokasi Klinik",
                    style: titleStyle, // <-- Menggunakan style konsisten
                  ),
                  const SizedBox(height: 8),

                  // --- BOX LOKASI KLINIK (DIRAPIKAN) ---
                  // --- BOX LOKASI KLINIK (DESAIN BARU) ---
                  ClipRRect(
                    // 1. Kita gunakan ClipRRect untuk 'memaksa' bentuknya
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // 2. Beri border yang sama dengan box lain
                        border: Border.all(color: const Color(0xFF4DAFFF)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 3. BAGIAN ATAS (Info Klinik)
                          Container(
                            color: Colors.grey[100], // Background putih/abu
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Yharnam Clinic",
                                  style: GoogleFonts.instrumentSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600, // SemiBold
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Ini garis pemisah biru
                                const Divider(
                                  color: Color(0xFF4DAFFF),
                                  height: 1,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Jl. Disana, belok kiri, belok kanan, lokasi di Kanan Jalan",
                                  style: GoogleFonts.instrumentSans(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 4. BAGIAN BAWAH (Tombol Google Maps)
                          GestureDetector(
                            onTap: openMaps, // Memanggil fungsi openMaps
                            child: Material(
                              // Tambah Material untuk splash effect
                              color: const Color(0xFF84BA1F), // Warna hijau
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Google Maps",
                                      style: GoogleFonts.instrumentSans(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.open_in_new, // Ikon "buka di baru"
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ------------------------------------
                  const SizedBox(height: 20),

                  // --- JUDUL JASA ---
                  Text(
                    "Jasa yang anda pilih",
                    style: titleStyle, // <-- Menggunakan style konsisten
                  ),
                  const SizedBox(height: 8),

                  // --- BOX JASA ---
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF4DAFFF)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: mainServices
                                      .map(
                                        (s) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.circle,
                                                size: 6,
                                                color: Color(0xFF84BCEA),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  s,
                                                  style: GoogleFonts
                                                      .instrumentSans(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              const SizedBox(width: 20),
                              if (showAllServices)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: extraServices
                                        .map(
                                          (s) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.circle,
                                                  size: 6,
                                                  color: Color(0xFF84BCEA),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    s,
                                                    style: GoogleFonts
                                                        .instrumentSans(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4DAFFF),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                7,
                              ), // Disesuaikan sedikit
                              bottomRight: Radius.circular(
                                7,
                              ), // Disesuaikan sedikit
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showAllServices = !showAllServices;
                              });
                            },
                            // Memberi 'splash effect'
                            child: Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Center(
                                  child: Text(
                                    showAllServices
                                        ? "Sembunyikan ▲"
                                        : "Lainnya ▼",
                                    style: GoogleFonts.instrumentSans(
                                      // <-- Dirapikan
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- JUDUL TANGGAL ---
                  Text(
                    "Tanggal Penanganan Anda",
                    style: titleStyle, // <-- Menggunakan style konsisten
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    readOnly: true,
                    style: GoogleFonts.instrumentSans(
                      // <-- Dirapikan
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: "10 Oktober 2025",
                      hintStyle: GoogleFonts.instrumentSans(
                        // <-- Dirapikan
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF4DAFFF)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF4DAFFF)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- JUDUL METODE PEMBAYARAN ---
                  Text(
                    "Metode Pembayaran",
                    style: titleStyle, // <-- Menggunakan style konsisten
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Pembayaran Jasa DentaLink dilaksanakan secara offline di klinik yang dipilih.",
                      style: GoogleFonts.instrumentSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600, // SemiBold
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- TOTAL ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: titleStyle, // <-- Menggunakan style konsisten
                      ),
                      Text(
                        "Rp 2.000.000.000",
                        style: GoogleFonts.instrumentSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // --- TOMBOL KONFIRMASI (STICKY FOOTER) ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingBerhasilPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2158A1),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Konfirmasi",
                style: GoogleFonts.instrumentSans(
                  fontWeight: FontWeight.w600, // Dibuat SemiBold
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
