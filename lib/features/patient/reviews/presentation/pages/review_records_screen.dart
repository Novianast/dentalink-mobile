import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'review_records_detail_screen.dart';

class RekamanUlasanPage extends StatelessWidget {
  const RekamanUlasanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = [
      {
        'name': 'dr. Bagas',
        'rating': '5/5',
        'image': 'assets/images/ava.jpg'
      },
      {
        'name': 'dr. Amelia',
        'rating': '4.5/5',
        'image': 'assets/images/ava.jpg'
      },
      {
        'name': 'dr. Fadli',
        'rating': '4/5',
        'image': 'assets/images/ava.jpg'
      },
      {
        'name': 'dr. Rani',
        'rating': '5/5',
        'image': 'assets/images/ava.jpg'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔙 Tombol kembali (keyboard_arrow_left)
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 29,
                      width: 29,
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFF84BCEA), // ✅ Background biru muda
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Color(0xFF2158A1), // ✅ Ikon biru tua
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Kembali",
                    style: GoogleFonts.istokWeb(
                      color: const Color(0xFF2158A1), // ✅ Warna teks biru tua
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🏷️ Judul halaman
              Text(
                "Rekaman Ulasan",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              Text(
                "Rekaman ulasan anda ke Dokter",
                style: GoogleFonts.instrumentSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // 🔍 Search bar + filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue.shade200),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // 🧑‍⚕️ List Dokter
              Expanded(
                child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doc = doctors[index];
                    return _DoctorCard(
                      name: doc['name']!,
                      rating: doc['rating']!,
                      imagePath: doc['image']!,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewSummaryScreen(
                              name: doc['name']!,
                              rating: doc['rating']!,
                              imagePath: doc['image']!,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final String name;
  final String rating;
  final String imagePath;
  final VoidCallback onTap;

  const _DoctorCard({
    required this.name,
    required this.rating,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Foto dokter persegi dengan radius 25
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              imagePath,
              height: 84,
              width: 84,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),

          // Info dokter
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    text: "Rating anda : ",
                    style: GoogleFonts.instrumentSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: rating,
                        style: GoogleFonts.instrumentSans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tombol panah kanan — persegi panjang vertikal (43x84)
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 43,
              height: 84,
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
