import 'package:flutter/material.dart';
import '../../../chat/presentation/pages/chat_screen.dart';

// --- DATA MODEL UNTUK DOKTER ---
class Doctor {
  final String name;
  final String specialty;
  final bool isOnline;
  final String imageUrl;

  const Doctor({
    required this.name,
    required this.specialty,
    required this.isOnline,
    required this.imageUrl,
  });
}

// --- LAYAR FITUR: KONSULTASI ---
class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  // Data dummy dengan path asset yang sudah benar
  final List<Doctor> _allDoctors = [
    Doctor(
      name: 'dr. Bagas Permana',
      specialty: 'Spesialis Konservasi Gigi',
      isOnline: true,
      imageUrl: 'assets/images/ava.jpg',
    ),
    Doctor(
      name: 'dr. Citra Lestari',
      specialty: 'Spesialis Ortodonti (Behel)',
      isOnline: false,
      imageUrl: 'assets/images/ava.jpg',
    ),
    Doctor(
      name: 'dr. Adit Nugroho',
      specialty: 'Spesialis Bedah Mulut',
      isOnline: false,
      imageUrl: 'assets/images/ava.jpg',
    ),
    Doctor(
      name: 'dr. Dewi Anggraini',
      specialty: 'Spesialis Gigi Anak (Pedodonti)',
      isOnline: true,
      imageUrl: 'assets/images/ava.jpg',
    ),
  ];

  late List<Doctor> _displayedDoctors;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayedDoctors = _allDoctors;
    _searchController.addListener(_filterDoctors);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterDoctors);
    _searchController.dispose();
    super.dispose();
  }

  void _filterDoctors() {
    final RegExp nonAlphabetic = RegExp(r'[^a-zA-Z]');
    String query = _searchController.text.toLowerCase().replaceAll(
          nonAlphabetic,
          '',
        );

    setState(() {
      _displayedDoctors = _allDoctors.where((doctor) {
        final nameSanitized = doctor.name.toLowerCase().replaceAll(
              nonAlphabetic,
              '',
            );
        final specialtySanitized = doctor.specialty.toLowerCase().replaceAll(
              nonAlphabetic,
              '',
            );

        return nameSanitized.contains(query) ||
            specialtySanitized.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- ATUR PADDING KIRI/KANAN LIST DI SINI ---
    const double listHorizontalPadding = 16.0; // Misal: 16.0, 24.0, 32.0, dst.
    // --- ------------------------------------ ---

    return Scaffold(
      appBar: null,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            // Header Anda (Tidak Berubah)
            _buildHeader(context),

            // Jarak antara header dan list
            const SizedBox(height: 16.0),

            // --- INI ADALAH LIST DOKTER (BAGIAN PUTIH) ---
            Expanded(
              child: ListView.builder(
                // --- FIX: Gunakan variabel padding ---
                padding: const EdgeInsets.only(
                  left: listHorizontalPadding, // Menggunakan variabel
                  right: listHorizontalPadding, // Menggunakan variabel
                  bottom: 16.0,
                ),
                // --- ---------------------------- ---
                itemCount: _displayedDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = _displayedDoctors[index];
                  // --- Gunakan DoctorCard yang sudah diperbarui ---
                  return DoctorCard(
                    doctor: doctor,
                    onTap: () {
                      _showConfirmationDialog(context, doctor);
                    },
                  );
                  // --- --------------------------------------- ---
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HEADER (BERDASARKAN PNG ANDA + TINGGI 199 + BoxFit.fill) ---
  Widget _buildHeader(BuildContext context) {
    // Gunakan tinggi dari desain Anda
    const double headerHeight = 199.0;

    return SizedBox(
      height: headerHeight,
      child: Stack(
        children: [
          // --- LAYER 1: Gambar PNG Anda sebagai Background ---
          Positioned.fill(
            child: Image.asset(
              'assets/images/Gradient_Dot.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // --- LAYER 2: Konten (Tombol, Teks, Search) ---
          Padding(
            padding: EdgeInsets.fromLTRB(
              16.0,
              MediaQuery.of(context).padding.top,
              16.0,
              16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ELEMEN 1: Tombol Kembali (Istok Web + Ikon Material dalam Box Biru Kustom)
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Container(
                    width: 29,
                    height: 29,
                    decoration: BoxDecoration(
                      color: const Color(0xFF84BCEA),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 14.5,
                      ),
                    ),
                  ),
                  label: const Text(
                    'Kembali',
                    style: TextStyle(
                      fontFamily: 'Istok Web',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white.withAlpha(128),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),

                // ELEMEN 2: Teks Konsultasi (Poppins)
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Konsultasi',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // ELEMEN 3: Search Bar
                _buildSearchBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- _buildSearchBar (Dengan Ukuran Font Hint Kustom) ---
  Widget _buildSearchBar() {
    const double searchBarHeight = 37.0;
    const double searchBarWidth = 480.0;
    const double horizontalIconPadding = 13.0;
    const double verticalTextPadding = 13.0; // Sesuaikan jika perlu
    const double iconSize = 25.0;
    const double hintFontSize = 14.0;

    return Container(
      height: searchBarHeight,
      width: searchBarWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(
            fontFamily: 'InstrumentSans',
            color: Colors.grey,
            fontSize: hintFontSize,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: horizontalIconPadding, right: 8.0),
            child: Icon(Icons.search, color: Colors.grey, size: iconSize),
          ),
          prefixIconConstraints: BoxConstraints(
            minHeight: searchBarHeight,
            minWidth: 40,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: verticalTextPadding,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // --- FUNGSI POP-UP (Tidak Berubah) ---
  void _showConfirmationDialog(BuildContext context, Doctor doctor) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Apakah Anda Yakin Ingin Konsultasi dengan Dokter Ini?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'InstrumentSans',
                  ),
                ),
                const SizedBox(height: 21.8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB9B9B9),
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text(
                          'Tidak, kembali',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'InstrumentSans',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2158A1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ChatScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Iya, lanjutkan',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'InstrumentSans',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- KARTU DOKTER (Layout Vertikal + Font Baru + Warna Status Baru) ---
class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  // Gunakan super parameter
  const DoctorCard({super.key, required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // --- KUSTOMISASI AVATAR DI SINI ---
    const double avatarSize = 84.0; // Ukuran sisi kotak avatar
    const double avatarRadius = 25.0; // Tingkat lengkungan sudut
    // --- --------------------------- ---

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      color: Colors.white, // Set background color to white
      elevation: 2.0, // Efek shadow
      shadowColor: Colors.grey.withAlpha(500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // --- Layout Row(Avatar, Expanded(Column)) ---
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Avatar Kotak ---
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(avatarRadius),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(avatarRadius),
                  child: Image.asset(
                    doctor.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFD9D9D9),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16.0),

              // --- Expanded agar Column mengisi sisa ruang ---
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- ELEMEN 1: Nama Dokter ---
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 4.0),

                    // --- ELEMEN 2: Spesialis ---
                    Text(
                      doctor.specialty,
                      style: const TextStyle(
                        fontFamily: 'Istok Web',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 8.0),

                    // --- ELEMEN 3: Status Online/Offline ---
                    SizedBox(
                      width: 71.0, // Set specific width
                      child: Chip(
                        label: Text(
                          doctor.isOnline ? 'Online' : 'Offline',
                          style: const TextStyle(
                            fontFamily: 'InstrumentSans',
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: doctor.isOnline
                            ? const Color(0xFF4DAFFF) // Warna Online baru
                            : const Color(0xFFBA311F), // Warna Offline baru
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        labelPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
  }
}
