import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dentalink/core/utils/resep_saver.dart';

class ResepDetailPage extends StatefulWidget {
  final String nama;
  final String spesialis;
  final String judul;

  const ResepDetailPage({
    super.key,
    required this.nama,
    required this.spesialis,
    required this.judul,
  });

  @override
  State<ResepDetailPage> createState() => _ResepDetailPageState();
}

class _ResepDetailPageState extends State<ResepDetailPage> {
  final GlobalKey _resepKey = GlobalKey();

  Future<void> _captureAndSave() async {
    try {
      RenderRepaintBoundary boundary =
          _resepKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final msg = await savePrescriptionPng(pngBytes);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal mengunduh resep: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Tombol kembali
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color(0xFF2158A1),
                  ),
                  label: const Text(
                    "Kembali",
                    style: TextStyle(
                      color: Color(0xFF2158A1),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'IstokWeb',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // 🔹 Profil Dokter
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 116, 172, 199),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/3774/3774299.png',
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nama,
                        style: const TextStyle(
                          fontFamily: 'InstrumentSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.spesialis,
                        style: const TextStyle(
                          fontFamily: 'IstokWeb',
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🔹 Tombol Resep Digital
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4DAFFF),
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  widget.judul,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'InstrumentSans',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Kartu Resep
              RepaintBoundary(
                key: _resepKey,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 🔸 Header Klinik
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: 60,
                            height: 60,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Klinik Gigi DentaLink",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF2158A1),
                            ),
                          ),
                          const Text(
                            "Jl. Mawar No. 10, Ngawen - Blora",
                            style: TextStyle(
                              fontFamily: 'InstrumentSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          const Text(
                            "Telp. (0296) 123456",
                            style: TextStyle(
                              fontFamily: 'InstrumentSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                        height: 25,
                      ),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "RESEP DOKTER GIGI",
                          style: TextStyle(
                            fontFamily: 'InstrumentSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // 🔸 Detail Resep dengan DefaultTextStyle
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontFamily: 'InstrumentSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: Colors.black,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Tanggal : 14 Oktober 2025"),
                            const Text("Dokter  : drg. Bagas Sumanto"),
                            const Text("SIP     : 4412/123/KES/2025"),
                            const SizedBox(height: 15),
                            const Text(
                              "R/",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Amoxicillin 500 mg      #10   S 3 dd 1",
                            ),
                            const Text("Asam Mefenamat 500 mg  #9    S 3 dd 1"),
                            const Text("Paracetamol 500 mg     #9    S 3 dd 1"),
                            const Text(
                              "Chlorhexidine mouthwash      S kumur 2x sehari",
                            ),
                            const SizedBox(height: 15),
                            const Text("Nama   : [Nama Pasien]"),
                            const Text("Usia   : [Umur Pasien] tahun"),
                            const Text("Alamat : [Alamat Lengkap]"),
                            const SizedBox(height: 25),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text("Semarang, 5 Mei 2025"),
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/images/Rectangle_64.png',
                                    width: 100,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "drg. Bagas Sumanto",
                                    style: TextStyle(
                                      fontFamily: 'InstrumentSans',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 🔹 Tombol Unduh Resep
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2158A1),
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _captureAndSave,
                child: const Text(
                  "Unduh Resep Digital",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'InstrumentSans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
