import 'package:flutter/material.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER & DENTA POINT ---
            Column(
              children: [
                // Header dengan background biru dan konten
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const _HeaderBackground(),
                    const SafeArea(child: _HeaderContent()),
                  ],
                ),

                // Denta Point Card di bawah header dengan sedikit overlap
                Transform.translate(
                  offset: const Offset(0, -15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: _DentaPointCard(),
                  ),
                ),
              ],
            ),

            // --- MENU DAN PROMOSI ---
            const SizedBox(
              height: 20,
            ), // Jarak dikurangi agar menu lebih dekat ke kartu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: Column(
                children: [
                  _MenuButtons(),
                  const SizedBox(height: 24),
                  const _PromotionSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// 1️⃣ LATAR BELAKANG HEADER
//
class _HeaderBackground extends StatelessWidget {
  const _HeaderBackground();

  @override
  Widget build(BuildContext context) {
    final Color headerColor = Colors.blue[700] ?? Colors.blue;
    return Container(
      height: 228,
      decoration: BoxDecoration(
        color: headerColor,
        image: const DecorationImage(
          image: AssetImage('assets/images/Gradient_Dot.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
    );
  }
}

//
// 2️⃣ KONTEN HEADER (LOGO & PROFIL)
//
class _HeaderContent extends StatelessWidget {
  const _HeaderContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo & Nama App
          Row(
            children: [
              Image.asset('assets/images/logo.png', width: 38, height: 46),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Graha Dental App",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12,
                      fontFamily: 'InstrumentSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Text(
                    "Dentalink",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ), // Jarak dikurangi agar profil lebih ke atas
          // Profil Pengguna
          Padding(
            padding: const EdgeInsets.only(left: 9.0),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 24, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang,",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Username235547",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// 3️⃣ KARTU DENTA POINT
//
class _DentaPointCard extends StatelessWidget {
  const _DentaPointCard();

  // Mengubah menjadi non-const karena menggunakan context untuk navigasi

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      width: MediaQuery.of(context).size.width - 42,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2158A1), Color(0xFF84BCEA)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2158A1).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "DP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text(
                      "20.000.000.000",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'InstrumentSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Denta Point",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                        fontFamily: 'InstrumentSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/denta-points');
                  },
                  child: Container(
                    height: 21,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tukar Poin menjadi Voucher",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 9,
                            fontFamily: 'InstrumentSans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//
// 4️⃣ MENU BUTTONS
//
class _MenuButtons extends StatelessWidget {
  const _MenuButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StyledMenuButton(
                icon: Icons.calendar_month_outlined,
                text: "Booking Klinik",
                onTap: () {
                  Navigator.pushNamed(context, '/booking-klinik');
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StyledMenuButton(
                icon: Icons.medical_services_outlined,
                text: "Konsultasi",
                onTap: () {
                  Navigator.pushNamed(context, '/consultation');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StyledMenuButton(
                icon: Icons.psychology_outlined,
                text: "Denta AI",
                onTap: () {
                  Navigator.pushNamed(context, '/diagnosis');
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: _ArtikelButton()),
          ],
        ),
      ],
    );
  }
}

class _StyledMenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const _StyledMenuButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double buttonHeight = 58.0; // Tinggi tombol ditambah

    return Container(
      height: buttonHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.25),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Row(
          children: [
            Container(
              width: buttonHeight,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2158A1), Color(0xFF4DAFFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Center(child: Icon(icon, color: Colors.white, size: 26.0)),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          height: 1.2,
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
    );
  }
}

class _ArtikelButton extends StatelessWidget {
  const _ArtikelButton();

  @override
  Widget build(BuildContext context) {
    const double buttonHeight = 58.0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/artikel');
      },
      child: Container(
        height: buttonHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.25),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Row(
            children: [
              Container(
                width: buttonHeight,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2158A1), Color(0xFF4DAFFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.article_outlined,
                    color: Colors.white,
                    size: 26.0,
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'Jelajahi Artikel',
                        style: TextStyle(
                          color: const Color(0xFF0D47A1),
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
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

//
// 5️⃣ PROMOSI
//
class _PromotionSection extends StatelessWidget {
  const _PromotionSection();

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk gambar promosi, bisa diganti dengan data dari internet nanti
    final List<String> promotionImages = [
      'assets/artikel1.png',
      'assets/artikel2.png',
      'assets/artikel3.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Promosi",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 1.8, // Ketebalan garis
                color: Colors.black54, // Warna garis (hitam transparan)
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200, // Ketinggian gambar promosi diturunkan
          child: PageView.builder(
            // PageController untuk mengatur tampilan halaman (agar item sebelah terlihat)
            controller: PageController(viewportFraction: 0.9),
            itemCount: promotionImages.length,
            itemBuilder: (context, index) {
              // Beri jarak di sisi kanan setiap item, kecuali item terakhir
              return Padding(
                padding: EdgeInsets.only(
                  right: index == promotionImages.length - 1 ? 0 : 16,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: const Color(0xFFD9D9D9),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      promotionImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: const Color(0xFFD9D9D9),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2158A1), Color(0xFF4DAFFF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ], // Penutup yang benar untuk Column
    );
  }
}
