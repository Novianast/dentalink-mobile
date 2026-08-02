import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'booking_klinik2.dart'; // halaman booking

class KlinikListScreen extends StatefulWidget {
  const KlinikListScreen({super.key});

  @override
  State<KlinikListScreen> createState() => _KlinikListScreenState();
}

class _KlinikListScreenState extends State<KlinikListScreen> {
  Position? _currentPosition;
  bool _isLoading = true;
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  StreamSubscription<Position>? _positionStream;

  // Filter states
  String _filterType = 'all'; // 'all', 'open', 'nearest'

  // --- MODIFIKASI 1: Tambahkan key 'image' ---
  final List<Map<String, dynamic>> _klinikList = [
    {
      'nama': 'Dentalink Klinik Utama',
      'alamat': 'Jl. Jend. Sudirman No. 123, Jakarta Pusat',
      'lat': -6.180000,
      'lng': 106.826666,
      'status': 'Buka',
      'image': 'assets/images/Rectangle_64.png',
    },
    {
      'nama': 'Senyum Sehat Dental Clinic',
      'alamat': 'Jl. HR Rasuna Said No. 45, Jakarta Selatan',
      'lat': -6.234567,
      'lng': 106.832109,
      'status': 'Buka',
      'image': 'assets/images/Rectangle_64.png',
    },
    {
      'nama': 'Gigi Indah Dental Care',
      'alamat': 'Jl. Thamrin No. 78, Jakarta Pusat',
      'lat': -6.179876,
      'lng': 106.812345,
      'status': 'Tutup',
      'image': 'assets/images/Rectangle_64.png',
    },
    {
      'nama': 'Senyum Ceria Dental Center',
      'alamat': 'Jl. Gatot Subroto No. 101, Jakarta Selatan',
      'lat': -6.241586,
      'lng': 106.802416,
      'status': 'Segera Tutup',
      'image': 'assets/images/Rectangle_64.png',
    },
    {
      'nama': 'Dentalink Premium',
      'alamat': 'Jl. MH Thamrin No. 55, Jakarta Pusat',
      'lat': -6.192345,
      'lng': 106.834567,
      'status': 'Buka',
      'image': 'assets/images/Rectangle_64.png',
    },
    {
      'nama': 'Senyum Anak Bangsa',
      'alamat': 'Jl. Kuningan No. 89, Jakarta Selatan',
      'lat': -6.223456,
      'lng': 106.815678,
      'status': 'Buka',
      'image': 'assets/images/Rectangle_64.png',
    },
    {
      'nama': 'Gigi Sehat Klinik',
      'alamat': 'Jl. Casablanca No. 112, Jakarta Selatan',
      'lat': -6.219876,
      'lng': 106.843210,
      'status': 'Tutup',
      'image': 'assets/images/Rectangle_64.png',
    },
    {
      'nama': 'Perawatan Gigi Terbaik',
      'alamat': 'Jl. Cikini Raya No. 67, Jakarta Pusat',
      'lat': -6.185432,
      'lng': 106.828765,
      'status': 'Buka',
      'image': 'assets/images/Rectangle_64.png',
    },
  ];

  // Gunakan _klinikList sebagai data statis, jangan generate klinik baru

  List<Map<String, dynamic>> _sortedKlinikList = [];
  List<Map<String, dynamic>> _filteredKlinikList = [];

  @override
  void initState() {
    super.initState();
    // Add a small delay to ensure the app loads properly
    Future.delayed(const Duration(milliseconds: 500), () {
      _getUserLocationAndSortList();
      _startLocationStream(); // Mulai stream lokasi real time setelah mendapatkan lokasi awal
    });

    // Tambahkan listener untuk search controller
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _applyFilter(); // Gunakan fungsi applyFilter yang sudah mencakup pencarian dan filter
  }

  /// Fungsi yang diperbaiki untuk mendapatkan lokasi pengguna dengan akurasi lebih tinggi
  Future<void> _getUserLocationAndSortList() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLoading = false;
        _sortedKlinikList = _klinikList;
      });
      _applyFilter(); // Terapkan filter setelah pengaturan awal
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        _isLoading = false;
        _sortedKlinikList = _klinikList;
      });
      _applyFilter(); // Terapkan filter setelah pengaturan awal
      return;
    }

    try {
      // Coba dapatkan lokasi dengan akurasi tinggi
      _currentPosition = await _getAccurateCurrentPosition();

      if (_currentPosition != null) {
        // Jika lokasi ditemukan, urutkan klinik dan tampilkan di peta
        List<Map<String, dynamic>> calculatedList = [];
        for (var clinic in _klinikList) {
          double distanceInMeters = Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            clinic['lat'],
            clinic['lng'],
          );
          var newClinic = Map<String, dynamic>.from(clinic);
          newClinic['distance'] = distanceInMeters;
          calculatedList.add(newClinic);
        }

        calculatedList.sort((a, b) => a['distance'].compareTo(b['distance']));
        setState(() {
          _sortedKlinikList = calculatedList;
          _isLoading = false;
        });
        _applyFilter(); // Terapkan filter setelah pengurutan

        _moveCameraToUser();
      } else {
        // Jika tidak bisa mendapatkan lokasi yang akurat, gunakan data klinik statis
        List<Map<String, dynamic>> calculatedList = [];
        for (var clinic in _klinikList) {
          double distanceInMeters = Geolocator.distanceBetween(
            -6.200000, // Lokasi default
            106.816666,
            clinic['lat'],
            clinic['lng'],
          );
          var newClinic = Map<String, dynamic>.from(clinic);
          newClinic['distance'] = distanceInMeters;
          calculatedList.add(newClinic);
        }

        calculatedList.sort((a, b) => a['distance'].compareTo(b['distance']));
        setState(() {
          _sortedKlinikList = calculatedList;
          _isLoading = false;
        });
        _applyFilter(); // Terapkan filter setelah pengurutan
      }
    } catch (e) {
      // Jika error, gunakan data klinik statis
      List<Map<String, dynamic>> calculatedList = [];
      for (var clinic in _klinikList) {
        double distanceInMeters = Geolocator.distanceBetween(
          -6.200000, // Lokasi default
          106.816666,
          clinic['lat'],
          clinic['lng'],
        );
        var newClinic = Map<String, dynamic>.from(clinic);
        newClinic['distance'] = distanceInMeters;
        calculatedList.add(newClinic);
      }

      calculatedList.sort((a, b) => a['distance'].compareTo(b['distance']));
      setState(() {
        _sortedKlinikList = calculatedList;
        _isLoading = false;
      });
      _applyFilter(); // Terapkan filter setelah pengurutan
    }
  }

  /// Fungsi baru untuk mendapatkan lokasi dengan akurasi tertentu
  Future<Position?> _getAccurateCurrentPosition(
      {int maxRetries = 5, int maxWaitSeconds = 25}) async {
    Position? currentPosition;
    int attempts = 0;
    int secondsWaited = 0;
    const int maxWaitSecondsInterval =
        5; // Tunggu maksimal 5 detik per permintaan

    while (attempts < maxRetries && secondsWaited < maxWaitSeconds) {
      try {
        // Dapatkan posisi dengan akurasi tertinggi
        Position newPosition = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.best, // Gunakan akurasi terbaik yang tersedia
          ),
        );

        debugPrint(
            'Lokasi diperoleh: ${newPosition.latitude}, ${newPosition.longitude}, akurasi: ${newPosition.accuracy}m');

        // Cek apakah posisi memiliki akurasi yang diterima (kurang dari 50 meter)
        // Kita gunakan 50m sebagai batas maksimum, tetapi tetap prioritaskan yang lebih akurat
        if (newPosition.accuracy < 50.0) {
          if (newPosition.accuracy < 25.0) {
            // Jika akurasinya sangat baik (< 25m), langsung gunakan
            currentPosition = newPosition;
            debugPrint(
                'Lokasi akurat ditemukan: ${currentPosition.latitude}, ${currentPosition.longitude}, akurasi: ${currentPosition.accuracy}m');
            break; // Keluar dari loop jika akurasi sangat baik
          } else if (currentPosition == null) {
            // Jika ini adalah hasil pertama dengan akurasi < 50m, simpan
            currentPosition = newPosition;
            debugPrint(
                'Menyimpan posisi dengan akurasi memadai: ${currentPosition.accuracy}m');
          } else if (newPosition.accuracy < currentPosition.accuracy) {
            // Jika akurasinya lebih baik dari yang sebelumnya, ganti
            currentPosition = newPosition;
            debugPrint(
                'Memperbarui posisi dengan akurasi lebih baik: ${currentPosition.accuracy}m');
          }
        } else if (currentPosition == null && newPosition.accuracy < 100.0) {
          // Sebagai fallback, terima akurasi hingga 100m jika tidak ada pilihan lain
          currentPosition = newPosition;
          debugPrint(
              'Menyimpan posisi dengan akurasi yang lebih rendah: ${currentPosition.accuracy}m');
        }
      } catch (e) {
        debugPrint("Error getting position: $e");
      }

      attempts++;
      secondsWaited += maxWaitSecondsInterval;

      if (attempts < maxRetries && secondsWaited < maxWaitSeconds) {
        await Future.delayed(Duration(seconds: maxWaitSecondsInterval));
      }
    }

    if (currentPosition != null) {
      debugPrint(
          'Posisi akhir: ${currentPosition.latitude}, ${currentPosition.longitude}, akurasi: ${currentPosition.accuracy}m');
    } else {
      debugPrint('Gagal mendapatkan posisi akurat');
    }

    return currentPosition;
  }

  void _moveCameraToUser() {
    if (_currentPosition != null) {
      // Pindahkan kamera ke lokasi pengguna dengan animasi
      _mapController.move(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        15.0, // Zoom level lebih dekat untuk melihat posisi dengan jelas
      );
    }
  }

  /// Fungsi untuk memulai stream lokasi real time
  void _startLocationStream() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Tampilkan pesan bahwa service lokasi tidak aktif
      debugPrint('Layanan lokasi tidak aktif');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Izin lokasi ditolak');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint('Izin lokasi ditolak selamanya');
      return;
    }

    // Hentikan stream sebelumnya jika ada
    _positionStream?.cancel();

    // Mulai stream lokasi baru
    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5, // Update setiap 5 meter perubahan
      ),
    ).listen((Position position) {
      debugPrint(
          'Lokasi baru diterima: ${position.latitude}, ${position.longitude}, akurasi: ${position.accuracy}m');

      // Selalu update posisi pengguna saat ini
      setState(() {
        _currentPosition = position;
      });

      // Urutkan klinik berdasarkan lokasi terbaru (menggunakan data statis)
      List<Map<String, dynamic>> calculatedList = [];
      for (var clinic in _klinikList) {
        double distanceInMeters = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          clinic['lat'],
          clinic['lng'],
        );
        var newClinic = Map<String, dynamic>.from(clinic);
        newClinic['distance'] = distanceInMeters;
        calculatedList.add(newClinic);
      }

      calculatedList.sort((a, b) => a['distance'].compareTo(b['distance']));
      setState(() {
        _sortedKlinikList = calculatedList;
      });
      _applyFilter(); // Terapkan filter setelah pengurutan

      // Pindahkan kamera ke lokasi baru (opsional - bisa di-disable jika terlalu mengganggu)
      _moveCameraToUser();
    }, onError: (error) {
      debugPrint('Error dalam stream lokasi: $error');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _positionStream?.cancel(); // Pastikan stream dibatalkan saat dispose
    super.dispose();
  }

  // Fungsi untuk filter klinik yang buka
  List<Map<String, dynamic>> _filterOpenClinics(
      List<Map<String, dynamic>> clinics) {
    return clinics.where((clinic) => clinic['status'] == 'Buka').toList();
  }

  // Fungsi untuk filter klinik terdekat (sudah diurutkan berdasarkan jarak)
  List<Map<String, dynamic>> _filterNearestClinics(
      List<Map<String, dynamic>> clinics) {
    return List.from(clinics)
      ..sort((a, b) => a['distance'].compareTo(b['distance']));
  }

  // Fungsi untuk menerapkan filter berdasarkan tipe filter
  void _applyFilter() {
    List<Map<String, dynamic>> filteredList = List.from(_sortedKlinikList);

    // Terapkan filter pencarian terlebih dahulu
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      filteredList = filteredList.where((clinic) {
        return clinic['nama'].toLowerCase().contains(query) ||
            clinic['alamat'].toLowerCase().contains(query);
      }).toList();
    }

    // Terapkan filter berdasarkan tipe
    switch (_filterType) {
      case 'open':
        filteredList = _filterOpenClinics(filteredList);
        break;
      case 'nearest':
        filteredList = _filterNearestClinics(filteredList);
        break;
      default:
        // Jika filterType adalah 'all', tidak perlu filter tambahan
        break;
    }

    setState(() {
      _filteredKlinikList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildMapSection(),
              _buildListHeader(),
              _buildClinicListView(),
            ],
          ),
        ),
      ),
      // --- MODIFIKASI: Hapus Bottom Nav Bar ---
      bottomNavigationBar: null,
    );
  }

  Widget _buildHeader() {
    return HeaderWithPolkaDots(
      onBackButtonPressed: () => Navigator.pop(context),
      onFilterPressed: () =>
          _showFilterDialog(), // Tambahkan callback untuk filter
      searchController: _searchController,
    );
  }

  // Fungsi untuk menampilkan dialog filter
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Filter Klinik", style: GoogleFonts.instrumentSans()),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<String>(
                    title: Text("Semua Klinik",
                        style: GoogleFonts.instrumentSans()),
                    value: "all",
                    // ignore: deprecated_member_use
                    groupValue: _filterType,
                    // ignore: deprecated_member_use
                    onChanged: (String? value) {
                      setState(() {
                        _filterType = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Klinik Buka",
                        style: GoogleFonts.instrumentSans()),
                    value: "open",
                    // ignore: deprecated_member_use
                    groupValue: _filterType,
                    // ignore: deprecated_member_use
                    onChanged: (String? value) {
                      setState(() {
                        _filterType = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Klinik Terdekat",
                        style: GoogleFonts.instrumentSans()),
                    value: "nearest",
                    // ignore: deprecated_member_use
                    groupValue: _filterType,
                    // ignore: deprecated_member_use
                    onChanged: (String? value) {
                      setState(() {
                        _filterType = value!;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Batal",
                  style: GoogleFonts.instrumentSans(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                // Terapkan filter yang dipilih
                _applyFilter();
                Navigator.of(context)
                    .pop(); // Tutup dialog setelah menerapkan filter
              },
              child: Text("Terapkan",
                  style: GoogleFonts.instrumentSans(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMapSection() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color.fromARGB(255, 104, 163, 241), // Warna biru sesuai tema
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 240,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _currentPosition != null
                          ? LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude)
                          : const LatLng(-6.200000, 106.816666),
                      initialZoom: 12,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', // OpenStreetMap yang mirip Google Maps
                        subdomains: const ['a', 'b', 'c'],
                        userAgentPackageName: 'com.example.dentalink',
                      ),
                      MarkerLayer(markers: _buildMarkers()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = [];

    // Tambahkan marker pengguna jika lokasi tersedia
    if (_currentPosition != null) {
      try {
        markers.add(
          Marker(
            point:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            width: 30,
            height: 30,
            child: Stack(
              children: [
                // Lingkaran luar (ripple effect)
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                // Lingkaran tengah
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                ),
                // Lingkaran dalam
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      } catch (e) {
        debugPrint('Error saat membuat marker pengguna: $e');
      }
    }

    // Tambahkan marker klinik
    for (var clinic in _sortedKlinikList) {
      try {
        markers.add(
          Marker(
            point: LatLng(clinic['lat'], clinic['lng']),
            width: 35,
            height: 35,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.8),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: const Icon(Icons.local_hospital,
                  color: Colors.white, size: 18),
            ),
          ),
        );
      } catch (e) {
        debugPrint('Error saat membuat marker klinik: $e');
      }
    }

    return markers;
  }

  Widget _buildListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Klinik Terdekat",
            style: GoogleFonts.istokWeb(
              fontSize: 22, // Memperbesar ukuran font
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicListView() {
    return ListView.builder(
      itemCount: _filteredKlinikList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 6),
      itemBuilder: (context, index) {
        final clinic = _filteredKlinikList[index];
        final distance = clinic.containsKey('distance')
            ? (clinic['distance'] / 1000).toStringAsFixed(1)
            : '1.0';
        return _buildClinicCard(clinic, distance);
      },
    );
  }

  Widget _buildClinicCard(Map<String, dynamic> clinic, String distance) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8), // Meningkatkan padding vertikal
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // Meningkatkan radius
          boxShadow: [
            BoxShadow(
                color: Colors.grey
                    .withValues(alpha: 0.25), // Meningkatkan opacity shadow
                blurRadius: 8, // Meningkatkan blur
                offset: const Offset(0, 4)) // Meningkatkan offset
          ],
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.all(16), // Menambahkan padding dalam list tile
          leading: ClipRRect(
            borderRadius:
                BorderRadius.circular(16.0), // Meningkatkan radius gambar
            child: SizedBox(
              width: 70, // Menetapkan lebar kontainer gambar
              height:
                  180, // Menetapkan tinggi kontainer gambar - lebih tinggi dari sebelumnya
              child: Image.asset(
                clinic['image'], // Ambil path gambar dari data
                width: 60, // Menetapkan lebar gambar
                height:
                    140, // Menetapkan tinggi gambar - lebih tinggi dari sebelumnya
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika gambar error
                  return Container(
                    width: 100,
                    height: 140,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.local_hospital,
                        color: Colors.grey,
                        size: 45), // Meningkatkan ukuran ikon
                  );
                },
              ),
            ),
          ),
          title: Text(clinic['nama'],
              style: GoogleFonts.instrumentSans(
                fontWeight: FontWeight.bold,
                fontSize: 16, // Meningkatkan ukuran font judul
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("~$distance km • 07:00-19:00",
                  style: GoogleFonts.instrumentSans(
                      fontSize: 14,
                      color: Colors.black87)), // Meningkatkan ukuran font
              const SizedBox(height: 4), // Meningkatkan jarak
              Text(clinic['alamat'],
                  style: GoogleFonts.instrumentSans(
                      fontSize: 13,
                      color: Colors.grey[600]), // Meningkatkan ukuran font
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          trailing: _buildStatusChip(clinic['status']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingScreen(clinicData: clinic),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String displayText = status;

    // Tentukan warna dan teks berdasarkan status spesifik
    if (status == "Tutup") {
      color = Colors.red;
      displayText = "Tutup";
    } else if (status == "Segera Tutup") {
      color = Colors.orange;
      displayText = "Segera Tutup";
    } else if (status == "Buka") {
      color = Colors.green;
      displayText = "Buka";
    } else {
      // Default case jika status tidak dikenal
      color = Colors.grey;
      displayText = status.isNotEmpty ? status : "Status Tidak Diketahui";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1), // Latar belakang transparan
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        displayText,
        style: GoogleFonts.instrumentSans(
          color: color, // Warna teks
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // --- MODIFIKASI: Hapus fungsi _buildBottomNavBar ---
}

// Class untuk membuat pola polkadot
class PolkaDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 2;

    const dotRadius = 3.0;
    const spacing = 20.0;

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        if ((x / spacing + y / spacing) % 2 == 0) {
          canvas.drawCircle(Offset(x, y), dotRadius, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Widget untuk header dengan polkadot
class HeaderWithPolkaDots extends StatelessWidget {
  final VoidCallback onBackButtonPressed;
  final VoidCallback onFilterPressed; // Tambahkan callback untuk filter
  final TextEditingController? searchController;

  const HeaderWithPolkaDots({
    super.key,
    required this.onBackButtonPressed,
    required this.onFilterPressed, // Tambahkan parameter ini
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xFF2158A1), // Biru tua
            Color.fromARGB(255, 127, 184, 248), // Biru muda
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Polkadot overlay di bawah konten
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              child: CustomPaint(
                size: Size(double.infinity, 200),
                painter: PolkaDotPainter(),
              ),
            ),
          ),
          // Konten di atas overlay
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: onBackButtonPressed,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.arrow_back_ios,
                            size: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text("Kembali",
                        style: GoogleFonts.instrumentSans(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Booking Klinik",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 40), // Meningkatkan jarak dari atas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: GoogleFonts.instrumentSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFB3B3B3),
                            ),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 8),
                              child: const Icon(
                                Icons.search,
                                color: Color(0xFFB3B3B3),
                                size: 20,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minHeight: 40,
                              minWidth: 40,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 13,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 14), // Jarak antara search bar dan icon
                    // Icon filter dengan shape khusus di luar search bar
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 249, 249, 249),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: IconButton(
                        onPressed: onFilterPressed, // Gunakan callback
                        icon: const Icon(Icons.filter_list, color: Colors.blue),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
