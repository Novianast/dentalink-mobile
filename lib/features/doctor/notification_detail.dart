import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatelessWidget {
  final Map<String, dynamic> notificationData;

  const NotificationDetailScreen({
    Key? key,
    required this.notificationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String notificationType = notificationData['type'] ?? 'generic';
    final String title = notificationData['detail_title'] ?? 'Detail Notifikasi';
    final String tanggal = notificationData['detail_tanggal'] ?? '-';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.blue[800]),
            ),
          ),
        ),
        title: Text(
          'Kembali',
          style: TextStyle(
            fontFamily: 'IstokWeb',
            color: Colors.blue[800],
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Divider(color: Colors.blue[900], thickness: 1.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    _buildInfoRow('Tanggal', tanggal),
                    SizedBox(height: 16),

                    if (notificationType == 'message')
                      _buildMessageContent()
                    else
                      _buildGenericContent(),

                    SizedBox(height: 150),

                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                            fontFamily: 'InstrumentSans',
                            fontSize: 11,
                            color: Colors.grey[700]!.withValues(alpha: 0.7),
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                         ),
                        children: [
                          TextSpan(
                            text:
                                'Tim DentaLink siap membantu Anda! Jika ada kendala atau pertanyaan seputar pemesanan, silakan hubungi kami langsung melalui aplikasi atau email ke ',
                          ),
                          TextSpan(
                            text: 'help@dentalink.id',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4DAFFF).withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageContent() {
    final String patientName = notificationData['detail_patient_name'] ?? 'Pasien';
    final String patientAvatar = notificationData['detail_patient_avatar'] ?? 'assets/images/default_avatar.png';
    final String messageSnippet = notificationData['detail_message_snippet'] ?? '-';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontFamily: 'InstrumentSans',
                fontSize: 15,
                color: Colors.black,
                height: 1.5,
                fontWeight: FontWeight.w500,
             ),
            children: [
              TextSpan(text: 'Pasien atas Nama '),
              TextSpan(
                text: patientName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              TextSpan(text: ' menghubungi anda'),
            ],
          ),
        ),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[400],
                child: Builder(
                  builder: (BuildContext context) {
                    try {
                      return ClipOval(
                        child: Image.asset(
                          patientAvatar,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text(
                                patientName.isNotEmpty ? patientName[0].toUpperCase() : '?',
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            );
                          },
                        ),
                      );
                    } catch (e) {
                      return Center(
                        child: Text(
                          patientName.isNotEmpty ? patientName[0].toUpperCase() : '?',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      messageSnippet,
                      style: TextStyle(
                        fontFamily: 'InstrumentSans',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
               debugPrint('Tombol Lihat diklik!');
            },
            child: Text('Lihat'),
            style: ElevatedButton.styleFrom(
               backgroundColor: Color(0xFF3871B2),
               foregroundColor: Colors.white,
               padding: EdgeInsets.symmetric(vertical: 14),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),
               ),
               textStyle: TextStyle(
                 fontFamily: 'InstrumentSans',
                 fontSize: 16,
                 fontWeight: FontWeight.w500,
               ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenericContent() {
    final String status = notificationData['detail_status'] ?? 'N/A';
    final String username = notificationData['detail_username'] ?? 'Anda';
    final String klinik = notificationData['detail_klinik'] ?? 'N/A';
    final String alamat = notificationData['detail_alamat'] ?? 'N/A';
    final String waktu = notificationData['detail_waktu'] ?? 'N/A';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         _buildInfoRow('Status', status),
         SizedBox(height: 16),
         RichText(
            text: TextSpan(
              style: TextStyle(
                  fontFamily: 'InstrumentSans',
                  fontSize: 15,
                  color: Colors.black,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
               ),
              children: [
                TextSpan(text: 'Hai '),
                TextSpan(
                  text: username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4DAFFF),
                  ),
                ),
                TextSpan(text: ', notifikasi untuk Anda:'),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildDetailRow(
              Icons.medical_services_outlined, 'Klinik', klinik),
          SizedBox(height: 12),
          _buildDetailRow(
              Icons.location_on_outlined, 'Alamat', alamat),
          SizedBox(height: 12),
          _buildDetailRow(
              Icons.access_time_outlined, 'Waktu', waktu),
          SizedBox(height: 16),
           Text(
            'Detail notifikasi ini dapat dilihat pada bagian terkait di aplikasi.',
             style: TextStyle(
              fontFamily: 'InstrumentSans',
              fontSize: 14,
              color: Colors.black,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Best Regard',
            style: TextStyle(
              fontFamily: 'InstrumentSans',
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'DentaLink',
            style: TextStyle(
              fontFamily: 'InstrumentSans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4DAFFF),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'InstrumentSans',
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(' : ', style: TextStyle(fontSize: 15, color: Colors.black54)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
                fontFamily: 'InstrumentSans',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue[800], size: 20),
        SizedBox(width: 12),
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: TextStyle(
                fontFamily: 'InstrumentSans',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
        Text(' : ', style: TextStyle(fontSize: 15, color: Colors.black54)),
        Expanded(
          child: Text(
            value,
             style: TextStyle(
                fontFamily: 'InstrumentSans',
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}