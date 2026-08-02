import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal
import 'detail_booking.dart'; // Impor untuk navigasi ke halaman selanjutnya

class BookingScreen extends StatefulWidget {
  // --- PERUBAHAN 1: Definisikan parameter untuk menerima data ---
  final Map<String, dynamic> clinicData; // Ubah dari '?' menjadi wajib

  // --- PERUBAHAN 2: Constructor untuk menerima data ---
  const BookingScreen({super.key, required this.clinicData});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  final TextEditingController _dateController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this); // Ubah jumlah tab menjadi 1
  }

  @override
  void dispose() {
    _dateController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- PERUBAHAN 3: Ambil data spesifik dari widget.clinicData ---
    final String clinicName = widget.clinicData['nama'] ?? 'Nama Klinik Tidak Ada';
    final String clinicAddress = widget.clinicData['alamat'] ?? 'Alamat Tidak Ada';
    final String clinicImage =
        widget.clinicData['image'] ?? 'assets/images/Rectangle_64.png';
    final String clinicStatus = widget.clinicData['status'] ?? 'Tutup';
    // Jarak perlu dihitung ulang atau diambil jika sudah dihitung sebelumnya
    final String clinicDistance = widget.clinicData.containsKey('distance')
        ? (widget.clinicData['distance'] / 1000).toStringAsFixed(1) + ' km'
        : '-- km'; // Tampilkan '-- km' jika jarak belum dihitung

    return Scaffold(
      appBar: null,
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        // --- PERUBAHAN 4: Gunakan SingleChildScrollView agar bisa scroll ---
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBackButton(context), // Tombol Kembali
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Booking Klinik",
                        style: GoogleFonts.poppins(
                          color: Color(0xFF2158A1),
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                    ),

                    // Gambar Klinik
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        clinicImage, // --- PERUBAHAN 5: Gunakan variabel clinicImage ---
                        height: 260,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: Center(
                              child: Icon(Icons.broken_image,
                                  color: Colors.grey, size: 40),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      clinicName, // --- PERUBAHAN 6: Gunakan variabel clinicName ---
                      style: GoogleFonts.istokWeb(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 0),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Divider(
                        color: Colors.grey.shade700,
                        thickness: 1,
                        height: 40,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),

              // Hanya menampilkan konten tentang klinik tanpa tab
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildTentangKlinikTab(clinicAddress, clinicStatus, clinicDistance),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent, // Latar transparan jika extendBody true
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _dateController.text.isEmpty 
            ? null // Nonaktifkan tombol jika tanggal belum dipilih
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailBookingScreen(),
                  ),
                );
              },
          style: ElevatedButton.styleFrom(
            backgroundColor: _dateController.text.isEmpty 
              ? Colors.grey.shade400 // Warna abu-abu jika tombol dinonaktifkan
              : Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text("Booking", style: GoogleFonts.instrumentSans(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back_ios, size: 16, color: Colors.blue),
              SizedBox(width: 4),
              Text("Kembali",
                  style: GoogleFonts.instrumentSans(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTentangKlinikTab(String address, String status, String distance) {
    return SingleChildScrollView( // Bungkus lagi dengan SingleChildScrollView
      padding:
          const EdgeInsets.fromLTRB(16.0, 0, 16.0, 100.0), // Padding untuk tombol
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tulisan "Tentang Klinik" tanpa border
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              "Tentang Klinik",
              style: GoogleFonts.istokWeb(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                
              ),
            ),
          ),
          // Border widget utama tanpa bagian tanggal
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade700),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jam Operasional",
                  style: GoogleFonts.istokWeb(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade700),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("07:00",
                          style:
                              GoogleFonts.instrumentSans(fontSize: 18, fontWeight: FontWeight.w500)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("s.d",
                            style:
                                GoogleFonts.instrumentSans(fontSize: 16,fontWeight: FontWeight.w500)),
                      ),
                      Text("15:30", // Anda mungkin perlu data jam dari clinicData juga
                          style:
                              GoogleFonts.instrumentSans(fontSize: 18, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Alamat Klinik",
                  style: GoogleFonts.istokWeb(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  address, // --- PERUBAHAN 10: Tampilkan alamat ---
                  style: GoogleFonts.instrumentSans(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    // Tambahkan logika buka Google Maps di sini
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFFE6F4EA),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Color(0xFFB7DDBF)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Google Maps",
                          style: GoogleFonts.istokWeb(
                            color: Color(0xFF1E8E3E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.launch,
                          color: Color(0xFF1E8E3E),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Status Klinik :",
                        style: GoogleFonts.instrumentSans(fontSize: 16, color: Colors.grey[700])),
                    // --- PERUBAHAN 11: Gunakan _buildStatusChip ---
                    _buildStatusChip(status),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text("Estimasi Jarak :",
                        style: GoogleFonts.instrumentSans(fontSize: 16, color: Colors.grey[700])),
                    Spacer(),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      // --- PERUBAHAN 12: Tampilkan jarak ---
                      child: Text(distance.replaceAll(' km', ''), // Hapus ' km'
                          style: GoogleFonts.instrumentSans(
                              color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text("Km",
                          style: GoogleFonts.instrumentSans(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Tulisan "Pilih Tanggal Penanganan" di atas border
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Pilih Tanggal Penanganan",
              style: GoogleFonts.istokWeb(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Border khusus untuk pemilihan tanggal
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade700),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: TextFormField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "DD/MM/YYYY",
                fillColor: Colors.grey.shade50,
                filled: true,
                suffixIcon:
                    Icon(Icons.calendar_today, color: Colors.blue.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blue.shade700),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blue.shade700),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blue.shade700),
                ),
              ),
              onTap: () => _selectDate(context),
            ),
          ),
        ],
      ),
    );
  }

  // --- PERUBAHAN 13: Pindahkan _buildStatusChip ke sini agar bisa dipakai ---
  Widget _buildStatusChip(String status) {
    Color color;
    if (status == "Tutup") {
      color = Colors.red;
    } else if (status == "Segera Tutup") {
      color = Colors.orange;
    } else {
      color = Colors.green; // Default 'Buka'
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: GoogleFonts.istokWeb(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

} // Akhir dari _BookingScreenState

