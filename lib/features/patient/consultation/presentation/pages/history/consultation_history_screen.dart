import 'package:flutter/material.dart';

class ConsultationHistoryScreen extends StatelessWidget {
  const ConsultationHistoryScreen({super.key});

  // Data dummy untuk ditampilkan di list
  final List<Map<String, String>> consultationHistory = const [
    // ... (data dummy tetap sama)
    {
      "doctor": "dr. Bagas Sumanto",
      "specialty": "Spesialis Konservasi Gigi",
      "date": "21/10/2025",
      "avatar": "https://picsum.photos/seed/img1/200",
    },
    {
      "doctor": "dr. Anisa Putri",
      "specialty": "Dokter Gigi Umum",
      "date": "15/09/2025",
      "avatar": "https://picsum.photos/seed/img2/200",
    },
    {
      "doctor": "dr. Bagas Sumanto",
      "specialty": "Spesialis Konservasi Gigi",
      "date": "21/10/2025",
      "avatar": "https://picsum.photos/seed/img1/200",
    },
    {
      "doctor": "dr. Anisa Putri",
      "specialty": "Dokter Gigi Umum",
      "date": "15/09/2025",
      "avatar": "https://picsum.photos/seed/img2/200",
    },
    {
      "doctor": "dr. Bagas Sumanto",
      "specialty": "Spesialis Konservasi Gigi",
      "date": "21/10/2025",
      "avatar": "https://picsum.photos/seed/img1/200",
    },
    {
      "doctor": "dr. Anisa Putri",
      "specialty": "Dokter Gigi Umum",
      "date": "15/09/2025",
      "avatar": "https://picsum.photos/seed/img2/200",
    },
    {
      "doctor": "dr. Bagas Sumanto",
      "specialty": "Spesialis Konservasi Gigi",
      "date": "21/10/2025",
      "avatar": "https://picsum.photos/seed/img1/200",
    },
    {
      "doctor": "dr. Anisa Putri",
      "specialty": "Dokter Gigi Umum",
      "date": "15/09/2025",
      "avatar": "https://picsum.photos/seed/img2/200",
    },
    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null, // <-- 1. HAPUS APPBAR
      body: SafeArea(
        // <-- 2. TAMBAHKAN SAFEAREAD
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 3. PINDAHKAN TOMBOL KEMBALI KE SINI ---
              TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFF84BCEA),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF2158A1),
                      size: 16,
                    ),
                  ),
                ),
                label: const Text(
                  'Kembali',
                  style: TextStyle(
                    fontFamily: 'Istok Web',
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                // Style ini penting agar tombolnya rata kiri
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  alignment: Alignment.centerLeft,
                ),
              ),
              const SizedBox(height: 1), // Jarak antara tombol dan judul
              // ------------------------------------------

              // BAGIAN 1: JUDUL HALAMAN (SEKARANG AKAN SEJAJAR)
              const Text(
                'Riwayat Konsultasi',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0D47A1), // Biru gelap
                ),
              ),
              const SizedBox(height: 1),
              const Text(
                'Sejarah Konsultasi anda',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),

              // BAGIAN 2: SEARCH & FILTER
              _buildSearchAndFilter(),
              const SizedBox(height: 20),

              // BAGIAN 3: DAFTAR RIWAYAT
              Expanded(child: _buildHistoryList()),
            ],
          ),
        ),
      ),
    );
  }

  // ... (fungsi _buildSearchAndFilter dan _buildHistoryList tetap sama)
  // ... (pastikan font di dalamnya sudah kamu sesuaikan juga)
  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        // Search Bar
        Expanded(
          child: TextField(
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Color(0xFF4DAFFF), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Color(0xFF2158A1), width: 2.0),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Tombol Filter
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
          style: IconButton.styleFrom(
            backgroundColor: Colors.blue[50],
            foregroundColor: Colors.blue[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ],
    );
  }

  // GANTI FUNGSI LAMA DENGAN FUNGSI BARU INI
  Widget _buildHistoryList() {
    return ListView.separated(
      itemCount: consultationHistory.length,
      itemBuilder: (context, index) {
        final item = consultationHistory[index];
        // Kita ganti ListTile dengan Row manual di dalam Card
        return Card(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.grey.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // Kita bungkus dengan InkWell agar tetap bisa di-tap
          child: InkWell(
            onTap: () {
              // Aksi saat item di tap, misal buka detail konsultasi
            },
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.all(
                16.0,
              ), // Padding standar seperti ListTile
              child: Row(
                children: [
                  // 1. AVATAR (Leading)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item['avatar']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.person, color: Colors.grey[600]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 15), // Jarak antara avatar dan teks
                  // 2. KOLOM TEKS (Menggantikan Title, Subtitle, Trailing)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 3. BARIS ATAS (DOKTER & TANGGAL)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Teks Dokter
                            Text(
                              item['doctor']!,
                              style: const TextStyle(
                                fontFamily: 'Instrument Sans',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            // Teks Tanggal (Sekarang sejajar)
                            Text(
                              item['date']!,
                              style: const TextStyle(
                                fontFamily: 'Instrument Sans',
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ), // Jarak antara baris atas dan bawah
                        // 4. BARIS BAWAH (Spesialis)
                        Text(
                          item['specialty']!,
                          style: const TextStyle(
                            fontFamily: 'Istok Web',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}
