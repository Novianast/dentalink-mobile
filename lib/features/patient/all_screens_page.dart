import 'package:flutter/material.dart';

class AllScreensPage extends StatelessWidget {
  const AllScreensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_RouteItem> routes = [
      _RouteItem('Home', '/home'),
      _RouteItem('Main', '/main'),
      _RouteItem('Profil', '/profile'),
      _RouteItem('Edit Profil', '/edit-profil'),
      _RouteItem('Identitas', '/identity'),
      _RouteItem('Artikel', '/artikel'),
      _RouteItem('Riwayat Konsultasi', '/consultation-history'),
      _RouteItem('Jadwal Booking', '/booking-screen'),
      _RouteItem('Pilih Dokter', '/select-doctor'),
      _RouteItem('Booking Klinik', '/booking-klinik'),
      _RouteItem('Booking Berhasil', '/booking-berhasil'),
      _RouteItem('Detail Booking', '/detail-booking'),
      _RouteItem('Resep', '/resep'),
      _RouteItem('Denta Points', '/denta-points'),
      _RouteItem('Vouchers', '/vouchers'),
      _RouteItem('Notifikasi', '/notifications'),
      _RouteItem('Chat', '/chat'),
      _RouteItem('Rekaman Ulasan', '/rekaman-ulasan'),
      _RouteItem('Review', '/review'),
      _RouteItem('Profil Dokter', '/profil-dokter'),
      _RouteItem('Konfirmasi', '/konfirmasi'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Halaman'),
      ),
      body: ListView.separated(
        itemCount: routes.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = routes[index];
          return ListTile(
            title: Text(item.label),
            subtitle: Text(item.routeName),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pushNamed(item.routeName);
            },
          );
        },
      ),
    );
  }
}

class _RouteItem {
  final String label;
  final String routeName;
  const _RouteItem(this.label, this.routeName);
}
