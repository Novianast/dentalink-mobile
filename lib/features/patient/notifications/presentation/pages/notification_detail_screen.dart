import 'package:flutter/material.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        toolbarHeight: 60.0,
        leading: Center(
          child: Container(
            width: 29,
            height: 29,
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF84BCEA),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF2158A1),
              ),
              onPressed: () => Navigator.pop(context),
              iconSize: 18.0,
            ),
          ),
        ),
        title: const Text(
          'Kembali',
          style: TextStyle(
            color: Color(0xFF2158A1),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: 'Istok Web',
          ),
        ),
        titleSpacing: 7.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF4DAFFF)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Judul dan garis biru
              Row(
                children: [
                  const Text(
                    'Booking Berhasil',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2158A1),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 100,
                    height: 2.5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2158A1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              buildInfoRow('Tanggal', '10 Oktober 2025, 10:30 AM'),
              const SizedBox(height: 8),
              buildInfoRow('Status', 'Berhasil'),

              const SizedBox(height: 24),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF000000),
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Instrument Sans',
                    letterSpacing: 0.2,
                  ),
                  children: [
                    TextSpan(text: 'Hai '),
                    TextSpan(
                      text: 'Username235547',
                      style: TextStyle(color: Color(0xFF4DAFFF)),
                    ),
                    TextSpan(text: ', Booking kamu berhasil dibuat'),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              buildDetailRow(
                Icons.home_outlined,
                'Klinik',
                'Nama Klinik DentaLink',
              ),
              const SizedBox(height: 5),
              buildDetailRow(
                Icons.location_on_outlined,
                'Alamat',
                'Jl. Mijen Utara Selatan Barat Daya',
              ),
              const SizedBox(height: 5),
              buildDetailRow(
                Icons.access_time,
                'Waktu',
                '12 Oktober 2025, pukul 10:00 WIB',
              ),

              const SizedBox(height: 24),
              const Text(
                'Terima kasih telah melakukan pemesanan melalui aplikasi kami. Kami sangat menghargai kepercayaan Anda terhadap layanan DentaLink. Diharapkan hadir 30 menit sebelum waktu yang telah dijadwalkan untuk proses registrasi dan persiapan pemeriksaan.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF000000),
                  height: 1.6,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Instrument Sans',
                  letterSpacing: 0.2,
                ),
              ),

              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Best Regard',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Instrument Sans',
                    ),
                  ),
                  Text(
                    'DentaLink',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4DAFFF),
                      fontFamily: 'Instrument Sans',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 80),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Instrument Sans',
                  ),
                  children: [
                    TextSpan(
                      text:
                          'Tim DentaLink siap membantu Anda! Jika ada kendala atau pertanyaan seputar pemesanan, silakan hubungi kami langsung melalui aplikasi atau email ke help',
                    ),
                    TextSpan(
                      text: '@dentalink.id',
                      style: TextStyle(color: Color(0xFF4DAFFF)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontFamily: 'Instrument Sans',
              letterSpacing: 0.2,
            ),
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontFamily: 'Instrument Sans',
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontFamily: 'Instrument Sans',
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF000000)),
        const SizedBox(width: 12),
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontFamily: 'Instrument Sans',
            ),
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontFamily: 'Instrument Sans',
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontFamily: 'Instrument Sans',
            ),
          ),
        ),
      ],
    );
  }
}