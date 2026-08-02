import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dentalink/core/widgets/custom_bottom_navigation_bar.dart';
import 'home_screen.dart';
import 'notification.dart';
import 'profil_dokter.dart';
import 'dokter_artikel.dart';
import 'chat.dart';

class Konsultasi extends StatefulWidget {
  const Konsultasi({super.key});

  @override
  State<Konsultasi> createState() => _KonsultasiState();
}

class _KonsultasiState extends State<Konsultasi> {
  final List<Map<String, String>> _messages = [
    {
      "name": "Jonathan Joel",
      "msg": "Dok, gawat!! gigi saya copot",
      "time": "Baru Saja",
      "unread": "1",
    },
    {
      "name": "Wowok Sumowok",
      "msg": "Selamat Pagi Dok, saya sakit...",
      "time": "21/10/2025",
      "unread": "21",
    },
    {"name": "Ohim", "msg": "Dok, saya ditikung", "time": "21/10/2025"},
    {
      "name": "ESP32",
      "msg": "Board at COM3 not Available",
      "time": "21/10/2025",
    },
  ];

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredMessages = _messages
        .where(
          (msg) =>
              msg["name"]!.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 2) return;
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const DoctorHomeScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const ArticleListScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const NotificationScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const ProfilDokterScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
              break;
          }
        },
        items: [
          CustomBottomNavigationBarItem(icon: Icons.home_filled, label: 'Home'),
          CustomBottomNavigationBarItem(
            icon: Icons.query_stats,
            label: 'Statistik',
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.local_hospital,
            label: 'Konsultasi',
            customIcon: Image.asset(
              'assets/navbar/tooth.png',
              width: 20.0,
              height: 20.0,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 20.0);
              },
            ),
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.notifications_none,
            label: 'Notifikasi',
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.account_circle,
            label: 'Profil',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🟦 Header biru dengan teks & search di dalamnya
            Container(
              width: double.infinity,
              height: 230,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('component/bg.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 "Konsultasi" tetap di kiri, agak turun
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 25),
                      child: Text(
                        "Konsultasi",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // 🔍 Search bar di dalam area biru (nempel lengkung bawah)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Cari nama pasien...',
                              hintStyle: GoogleFonts.instrumentSans(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(top: 8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 💬 List chat
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                itemCount: filteredMessages.length,
                itemBuilder: (context, index) {
                  final item = filteredMessages[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const ChatScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"]!,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  item["msg"]!,
                                  style: GoogleFonts.instrumentSans(
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item["time"]!,
                                style: GoogleFonts.instrumentSans(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              if (item.containsKey("unread"))
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.lightBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    item["unread"]!,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
