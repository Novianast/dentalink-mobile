import 'package:flutter/material.dart';

class ResepDokterPage extends StatelessWidget {
  const ResepDokterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: true,
        left: false,
        right: false,
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 35),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/Gradient_Dot.png"),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "Kembali",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    "Resep Dokter",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Resep yang anda peroleh dari dokter",
                    style: TextStyle(
                      fontFamily: "InstrumentSans",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- LIST ----------------
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: List.generate(4, (index) => buildResepCard()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResepCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3092E9).withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 45,
                  height: 45,
                  color: Colors.blue[100],
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.blue[800],
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "dr. Bagas Sumanto",
                      style: TextStyle(
                        fontFamily: "InstrumentSans",
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    // ✅ 1. SPESIALIS — UKURAN FONT DIPERKECIL & WARNA HITAM
                    Text(
                      "Spesialis Konservasi Gigi",
                      style: TextStyle(
                        fontFamily: "IstokWeb",
                        fontSize: 14, // <-- INI YANG DIUBAH (dari 16)
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "21/10/2025",
                style: TextStyle(
                  fontFamily: "InstrumentSans",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Color(0xFF1F74D9), Color(0xFF5AAFF7)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              "Resep Digital untuk Gigi Berlubang",
              style: TextStyle(
                fontFamily: "InstrumentSans",
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
