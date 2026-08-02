import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBookingScreen extends StatefulWidget {
  const DetailBookingScreen({super.key});

  @override
  State<DetailBookingScreen> createState() => _DetailBookingScreenState();
}

class _DetailBookingScreenState extends State<DetailBookingScreen> {
  // State untuk menyimpan layanan yang dipilih
  final Map<String, bool> _selectedServices = {};

  // Controller untuk field "Perawatan Lainnya"
  final _lainnyaController = TextEditingController();

  // Data layanan (diambil dari gambar)
  final List<Map<String, String>> spesialisBehel = [
    {'name': 'Pasang Kawat Gigi', 'price': 'Rp. 350.000'},
    {'name': 'Kontrol Kawat Gigi', 'price': 'Rp. 200.000'},
  ];

  final List<Map<String, String>> dokterGigiUmum = [
    {'name': 'Scaling Gigi', 'price': 'Rp. 100.000'},
    {'name': 'Cabut Gigi', 'price': 'Rp. 500.000'},
    {'name': 'Endodontik', 'price': 'Rp. 600.000'},
    {'name': 'Kontrol Gigi', 'price': 'Rp. 200.000'},
  ];

  final List<Map<String, String>> spesialisPatologi = [
    {'name': 'Pemeriksaan Jaringan Mulut', 'price': 'Rp. 1.000.000'},
    {'name': 'Biopsi', 'price': 'Rp. 1.000.000'},
    {'name': 'Diagnosa Penyakit Mulut (Kanker, dll)', 'price': 'Rp. 2.000.000'},
  ];

  final List<Map<String, String>> kebutuhanKhusus = [
    {'name': 'Perawatan Spesial', 'price': 'Rp. 500.000'},
  ];

  @override
  void dispose() {
    _lainnyaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Tanpa AppBar
      backgroundColor: Colors.white,
      extendBody: true, // Agar body bisa tembus ke bawah tombol
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER KUSTOM ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(), // Tombol Kembali (sama seperti screen_booking)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      "Detail Booking",
                      style: GoogleFonts.poppins(
                        color: Color(0xFF2158A1), // Warna biru (sesuai request)
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Text(
                    "Tarif Jasa masih Estimasi",
                    style: GoogleFonts.instrumentSans(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),

            // --- DAFTAR LAYANAN (Bisa di-scroll) ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                    16, 14, 20, 120), // Padding untuk tombol
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildServiceCategory("Spesialis Behel", spesialisBehel),
                    _buildServiceCategory("Dokter Gigi Umum", dokterGigiUmum),
                    _buildServiceCategory(
                        "Spesialis Patologi", spesialisPatologi),
                    _buildServiceCategory("Kebutuhan Khusus", kebutuhanKhusus),
                    _buildLainnyaSection(),
                    _buildPembayaranSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // --- TOMBOL BOOKING (Mengambang) ---
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigasi ke halaman konfirmasi
            Navigator.pushNamed(context, '/konfirmasi');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text("Booking",
              style: GoogleFonts.instrumentSans(
                  fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // Widget untuk tombol "Kembali"
  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
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

  // Widget untuk satu KATEGORI layanan
  Widget _buildServiceCategory(
      String title, List<Map<String, String>> services) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                GoogleFonts.istokWeb(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          ...services.map((service) {
            return _buildServiceItem(service['name']!, service['price']!);
          }),
        ],
      ),
    );
  }

  // Widget untuk satu ITEM layanan (Checkbox, Nama, Harga)
  Widget _buildServiceItem(String name, String price) {
    final bool isSelected = _selectedServices[name] ?? false;

    // Check if the name contains parentheses and format accordingly
    Widget serviceNameWidget;
    if (name.contains('(') && name.contains(')')) {
      // Split the text to separate the main text from the content in parentheses
      int openParenIndex = name.indexOf('(');
      int closeParenIndex = name.indexOf(')');

      String mainText = name.substring(0, openParenIndex).trim();
      String parenText =
          name.substring(openParenIndex + 1, closeParenIndex).trim();

      serviceNameWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainText,
            style: GoogleFonts.instrumentSans(
                fontSize: 16, fontWeight: FontWeight.normal),
          ),
          Text(
            '($parenText)',
            style: GoogleFonts.instrumentSans(
                fontSize: 16), // Same size as main text
          ),
        ],
      );
    } else {
      serviceNameWidget = Text(
        name,
        style: GoogleFonts.instrumentSans(fontSize: 16),
        overflow: TextOverflow.ellipsis,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align items to the center vertically
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (bool? value) {
              setState(() {
                _selectedServices[name] = value ?? false;
              });
            },
            activeColor: Colors.blue,
          ),
          Expanded(
            child: serviceNameWidget,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              price,
              style: GoogleFonts.inter(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // Widget khusus untuk section "Lainnya" (Checkbox + Textfield)
  Widget _buildLainnyaSection() {
    final bool isSelected = _selectedServices['Lainnya'] ?? false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lainnya",
            style:
                GoogleFonts.istokWeb(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    _selectedServices['Lainnya'] = value ?? false;
                  });
                },
                activeColor: Colors.blue,
              ),
              Text("Perawatan Lainnya:",
                  style: GoogleFonts.inter(fontSize: 16)),
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(color: Colors.blue)
                  : Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _lainnyaController,
              enabled: isSelected, // Hanya aktif jika dicentang
              decoration: InputDecoration(
                hintText: "Isi di sini...",
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk section "Pembayaran"
  Widget _buildPembayaranSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pembayaran",
            style:
                GoogleFonts.istokWeb(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Pembayaran Jasa Dental.ink Dilaksanakan secara Offline di Klinik yang dipilih",
            style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
