import 'package:flutter/material.dart';
import 'package:dentalink/core/constants/colors.dart';
import 'package:dentalink/core/widgets/custom_bottom_navigation_bar.dart';
import 'home_screen.dart';
import 'konsultasi.dart';
import 'profil_dokter.dart';
import 'dokter_artikel.dart';
import 'notification_detail.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _currentIndex = 3;

  void _onItemTapped(int index) {
    // 1. Jika menekan "Home" (index 0)
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const DoctorHomeScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
      return;
    }

    // 2. Jika menekan tab yang sama (index 3)
    if (_currentIndex == index) return;

    // 3. Jika menekan tab lain
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      // case 0 sudah ditangani di atas
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
      case 2:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const Konsultasi(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        break;
      // case 3 sudah ditangani di atas
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListBody(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
    );
  }
}

enum SortType { newest, oldest, az, za }

class NotificationListBody extends StatefulWidget {
  const NotificationListBody({Key? key}) : super(key: key);

  @override
  State<NotificationListBody> createState() => _NotificationListBodyState();
}

class _NotificationListBodyState extends State<NotificationListBody> {
  final List<Map<String, dynamic>> _dummyNotifications = [
    {
      'id': 'n1',
      'type': 'appointment_reminder',
      'icon': Icons.calendar_today_outlined,
      'status': 'Pengingat Janji',
      'title': 'Janji Temu Besok pukul 10:00',
      'time': '1 hari lagi',
      'isUnread': true,
      'timestamp': DateTime(2025, 10, 24, 10, 0),
      'detail_title': 'Pengingat Janji Temu',
      'detail_tanggal': '24 Oktober 2025, 10:00 AM',
      // ... (detail lainnya)
    },
    {
      'id': 'n2',
      'type': 'message',
      'icon': Icons.chat_bubble_outline,
      'status': 'Pesan',
      'title': 'Jonathan Joel',
      'time': 'Baru Saja',
      'isUnread': true,
      'timestamp': DateTime.now(),
      'detail_title': 'Pasien',
      'detail_tanggal': '10 Oktober 2025, 10:30 AM',
      // ... (detail lainnya)
    },
  ];

  Set<String> _readNotificationIds = {};
  SortType _currentSortType = SortType.newest;

  @override
  void initState() {
    super.initState();
    _sortNotifications(_currentSortType);
  }

  void _markAsRead(String notificationId) {
    if (!_readNotificationIds.contains(notificationId)) {
      setState(() {
        _readNotificationIds.add(notificationId);
      });
    }
  }

  void _sortNotifications(SortType sortType) {
    setState(() {
      _currentSortType = sortType;
      switch (sortType) {
        case SortType.newest:
          _dummyNotifications.sort(
            (a, b) => b['timestamp'].compareTo(a['timestamp']),
          );
          break;
        case SortType.oldest:
          _dummyNotifications.sort(
            (a, b) => a['timestamp'].compareTo(b['timestamp']),
          );
          break;
        case SortType.az:
          _dummyNotifications.sort((a, b) => a['title'].compareTo(b['title']));
          break;
        case SortType.za:
          _dummyNotifications.sort((a, b) => b['title'].compareTo(a['title']));
          break;
      }
    });
  }

  // --- WIDGET HELPER BARU ---
  // Method untuk membangun item menu kustom
  PopupMenuItem<SortType> _buildSortMenuItem(
    SortType value,
    String text,
    IconData icon,
  ) {
    bool isSelected = _currentSortType == value;
    return PopupMenuItem<SortType>(
      value: value,
      // Hapus padding default agar Container bisa di-stretch
      padding: EdgeInsets.zero,
      child: Container(
        // Beri padding di dalam container
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          // Atur warna background jika item terpilih
          color: isSelected
              ? AppColors.lightBlue.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.darkBlue : Colors.grey[700],
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? AppColors.darkBlue : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // --- AKHIR WIDGET HELPER ---

  @override
  Widget build(BuildContext context) {
    final unreadCount = _dummyNotifications
        .where((n) => !_readNotificationIds.contains(n['id']))
        .length;

    return Column(
      children: [
        Hero(tag: "header_gradient", child: _buildHeader(context, unreadCount)),
        Expanded(child: _buildNotificationList()),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, int unreadCount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.0,
        bottom: 40.0,
        left: 16.0,
        right: 16.0,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Gradient_Dot.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Notifikasi',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // --- MODIFIKASI: Menggunakan PopupMenuButton kustom ---
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: PopupMenuButton<SortType>(
                  icon: Icon(Icons.filter_list, color: AppColors.darkBlue),
                  tooltip: "Urutkan",
                  onSelected: (SortType result) {
                    _sortNotifications(result);
                  },
                  // Style untuk dropdown menu
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  // Padding untuk dropdown menu
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SortType>>[
                        // Panggil helper untuk setiap item
                        _buildSortMenuItem(
                          SortType.newest,
                          'Terbaru',
                          Icons.arrow_downward_rounded,
                        ),
                        _buildSortMenuItem(
                          SortType.oldest,
                          'Terlama',
                          Icons.arrow_upward_rounded,
                        ),
                        const PopupMenuDivider(height: 10), // Garis pemisah
                        _buildSortMenuItem(
                          SortType.az,
                          'A-Z',
                          Icons.sort_by_alpha_rounded,
                        ),
                        _buildSortMenuItem(
                          SortType.za,
                          'Z-A',
                          Icons.sort_by_alpha_rounded,
                        ),
                      ],
                ),
              ),
              // --- AKHIR MODIFIKASI ---
            ],
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'InstrumentSans',
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Anda memiliki '),
                  TextSpan(
                    text: '$unreadCount',
                    style: TextStyle(
                      fontFamily: 'InstrumentSans',
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  TextSpan(
                    text: ' notifikasi',
                    style: TextStyle(
                      fontFamily: 'InstrumentSans',
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  TextSpan(text: ' belum dibaca'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16),
      itemCount: _dummyNotifications.length,
      itemBuilder: (context, index) {
        final notif = _dummyNotifications[index];
        final bool isCurrentlyUnread = !_readNotificationIds.contains(
          notif['id'],
        );

        return NotificationItemTile(
          icon: notif['icon'],
          status: notif['status'],
          title: notif['title'],
          time: notif['time'],
          isUnread: isCurrentlyUnread,
          onTap: () {
            _markAsRead(notif['id']);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    NotificationDetailScreen(notificationData: notif),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
        );
      },
    );
  }
}

class NotificationItemTile extends StatelessWidget {
  final IconData icon;
  final String status;
  final String title;
  final String time;
  final bool isUnread;
  final VoidCallback onTap;

  const NotificationItemTile({
    Key? key,
    required this.icon,
    required this.status,
    required this.title,
    required this.time,
    required this.isUnread,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color.fromRGBO(
              170,
              170,
              170,
              0,
            ).withValues(alpha: 0.1),
            child: Icon(icon, color: const Color.fromRGBO(74, 74, 74, 1)),
          ),
          if (isUnread)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
        ],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: TextStyle(
              fontFamily: 'InstrumentSans',
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'InstrumentSans',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          time,
          style: TextStyle(
            fontFamily: 'InstrumentSans',
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
