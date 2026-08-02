import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dentalink/core/constants/colors.dart';

class PasienDetailPage extends StatelessWidget {
  // Data pasien yang akan ditampilkan
  final String namaPasien;
  final String namaLengkap;
  final String jenisKelamin;
  final String umur;
  final String emailTelepon;
  final String alamat;

  const PasienDetailPage({
    super.key,
    this.namaPasien = 'Yosan Sonjaya',
    this.namaLengkap = 'Yosan Sonjaya Sunakro Malkoto Yokai',
    this.jenisKelamin = 'Laki - Laki',
    this.umur = '99 Tahun',
    this.emailTelepon = 'ohimthebestbashgdhsmaiom',
    this.alamat = 'Jl. Sumedang cinta Damai, papua, kec. Mijen',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 30),
              _buildPasienCard(),
            ],
          ),
        ),
      ),
    );
  }

  // Bagian Header (Tombol Kembali)
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            // Logika untuk kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.textBlue,
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Kembali',
          style: GoogleFonts.poppins(
            color: AppColors.textBlue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Bagian Utama Informasi Pasien
  Widget _buildPasienCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Atas Nama Pasien,',
          style: GoogleFonts.istokWeb(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          namaPasien,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
        ),
        const SizedBox(height: 20),

        // Card Informasi
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.lightBlue.withValues(alpha: 0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Nama', namaLengkap),
                const SizedBox(height: 15),
                _buildInfoRow('Jenis Kelamin', jenisKelamin),
                const SizedBox(height: 15),
                _buildInfoRow('Umur', umur),
                const SizedBox(height: 15),
                _buildInfoRow('Email / No. Telepon', emailTelepon),
                const SizedBox(height: 15),
                _buildInfoRow('Alamat', alamat, isMultiLine: true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper Widget untuk setiap baris informasi
  Widget _buildInfoRow(String label, String value, {bool isMultiLine = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.istokWeb(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Label lebih redup
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.instrumentSans(
            fontSize: 15,
            color: Colors.black, // Nilai lebih jelas
          ),
          maxLines: isMultiLine ? 3 : 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
