import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'scheduled_detail_booking_screen.dart';
import 'completed_detail_booking_screen.dart';
import 'canceled_detail_booking_screen.dart';

// --- Model Data (Tidak ada perubahan) ---
enum BookingStatus { terjadwal, selesai, dibatalkan }

class Booking {
  final String imageUrl;
  final String clinicName;
  final String address;
  final String date;
  final String time;
  final BookingStatus status;

  Booking({
    required this.imageUrl,
    required this.clinicName,
    required this.address,
    required this.date,
    required this.time,
    required this.status,
  });
}

// --- LAYAR UTAMA ---
class JadwalBookingScreen extends StatefulWidget {
  const JadwalBookingScreen({super.key});

  @override
  State<JadwalBookingScreen> createState() => _JadwalBookingScreenState();
}

class _JadwalBookingScreenState extends State<JadwalBookingScreen> {
  // --- Data Dummy ---
  final List<Booking> _allBookings = [
    Booking(
      clinicName: 'Yharnam Clinic',
      address: 'Jl. Disana, belok kiri, belok kanan, lokasi di Kanan Jalan',
      date: 'Selasa, 10 Oktober 2025',
      time: '09:00',
      status: BookingStatus.terjadwal,
      imageUrl: 'assets/images/Rectangle_64.png',
    ),
    Booking(
      clinicName: 'Yharnam Clinic',
      address: 'Jl. Disana, belok kiri, belok kanan, lokasi di Kanan Jalan',
      date: 'Selasa, 10 Oktober 2025',
      time: '14:00',
      status: BookingStatus.selesai,
      imageUrl: 'assets/images/Rectangle_64.png',
    ),
    Booking(
      clinicName: 'Yharnam Clinic',
      address: 'Jl. Disana, belok kiri, belok kanan, lokasi di Kanan Jalan',
      date: 'Selasa, 10 Oktober 2025',
      time: '11:30',
      status: BookingStatus.dibatalkan,
      imageUrl: 'assets/images/Rectangle_64.png',
    ),
    Booking(
      clinicName: 'Central Clinic',
      address: 'Jl. Tengah Kota No. 123',
      date: 'Rabu, 11 Oktober 2025',
      time: '10:00',
      status: BookingStatus.terjadwal,
      imageUrl: 'assets/images/Rectangle_64.png',
    ),
  ];

  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Semua', 'Terjadwal', 'Selesai', 'Dibatalkan'];

  @override
  void initState() {
    super.initState();
  }

  List<Booking> get _filteredBookings {
    if (_selectedFilterIndex == 0) return _allBookings;
    String filter = _filters[_selectedFilterIndex];
    return _allBookings
      .where((b) => b.status.name.toLowerCase() == filter.toLowerCase())
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildHeader(context),
          _buildFilterChips(),
          _buildBookingList(),
          ],
        ),
    );
  }

  Widget _buildHeader(BuildContext context) {

    return Container(
      width: double.infinity, 
      padding: EdgeInsets.fromLTRB(32, 84, 32, 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        image: DecorationImage(
        image: AssetImage('assets/images/Gradient_Dot.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jadwal Booking',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Anda dapat melihat Jadwal Booking anda disini',
            style: GoogleFonts.instrumentSans( 
              textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              )
            )
          ),
        ],
      ),
    );
  }
 
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: Row(
        // Beri jarak antar chip kustom
        children: List<Widget>.generate(_filters.length, (index) {
          return Padding(
            // Jarak antar chip
            padding: const EdgeInsets.symmetric(horizontal: 4.0), 
            // Panggil widget chip kustom kita
            child: _buildCustomChip(
              label: _filters[index],
              isSelected: _selectedFilterIndex == index,
              onSelected: () {
                setState(() => _selectedFilterIndex = index);
              },
            ),
          );
        }),
      ),
    );
  }

  // --- TAMBAHKAN FUNGSI BARU INI ---
  Widget _buildCustomChip({
    required String label,
    required bool isSelected,
    required VoidCallback onSelected,
  }) {
    final Color selectedColor = Color(0xFF4DAFFF);
    final Color unselectedColor = Colors.black;
    final Color borderColor = isSelected ? selectedColor : Colors.white; // Border biru saat terpilih, putih saat tidak

    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(8.0), // Agar efek ripple sesuai bentuk
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0), // ATUR PADDING DI SINI
        decoration: BoxDecoration(
          color: Colors.white, // Background selalu putih
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: borderColor), // Border dinamis
        ),
        child: Text(
          label,
          style: GoogleFonts.instrumentSans(
            textStyle: TextStyle(
              color: isSelected ? selectedColor : unselectedColor,
              fontSize: 13, // Anda bisa atur lagi jika perlu
              fontWeight: FontWeight.w400,
              // textBaseline: TextBaseline.alphabetic, // Mungkin tidak perlu lagi
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _filteredBookings.length,
        itemBuilder: (context, index) {
          final booking = _filteredBookings[index];
          return _buildBookingCard(booking);
        },
      ),
    );
  }

  Widget _buildBookingCard(Booking booking) {
  Color statusColor = _getStatusColor(booking.status);

  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    child: InkWell(
      onTap: () {
        if (booking.status == BookingStatus.selesai) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CompletedDetailBookingScreen(booking: booking)));
        } else if (booking.status == BookingStatus.dibatalkan) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CanceledDetailBookingScreen(booking: booking)));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduledDetailBookingScreen(booking: booking)));
        }
      },
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: Color(0xFF84BCEA), // border biru tipis di semua sisi
            width: 1.0,
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Bagian kiri: Konten utama (98%)
              Expanded(
                flex: 98,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              booking.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.local_hospital, color: Colors.black, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      booking.clinicName,
                                      style: GoogleFonts.instrumentSans(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on, color: Colors.black, size: 14),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        booking.address,
                                        style: GoogleFonts.instrumentSans(
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          ),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          _getStatusChip(booking.status)
                        ],
                      ),
                      const Divider(height: 24),
                      Text(
                        '${booking.date} · ${booking.time}',
                        style: GoogleFonts.instrumentSans(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bagian kanan: Strip warna (2%)
              Container(
                width: 18, // 👈 INI ADALAH 2% DARI LEBAR CARD — SESUAI DESAIN FIGMA
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _getStatusChip(BookingStatus status) {
    String text; Color textColor;
    switch (status) {
      case BookingStatus.terjadwal: text = 'Terjadwal';  textColor = Color(0xFF2158A1); break;
      case BookingStatus.selesai: text = 'Selesai';  textColor = Color(0xFF84BA1F); break;
      case BookingStatus.dibatalkan: text = 'Dibatalkan';  textColor = Color(0xFFE94242); break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: textColor),
  ),
),
        child: Text(text,
            style: GoogleFonts.instrumentSans( textStyle: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w400))));
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.terjadwal: return Color(0xFF2158A1);
      case BookingStatus.selesai: return Color(0xFF84BA1F);
      case BookingStatus.dibatalkan: return Color(0xFFE94242);
    }
  }
}