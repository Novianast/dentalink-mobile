import 'package:flutter/material.dart';

// --- DATA MODEL UNTUK PESAN ---
// (Model sederhana untuk menampung data chat)
class ChatMessage {
  final String text;
  final String time;
  final bool isSender;

  ChatMessage({required this.text, required this.time, required this.isSender});
}

// --- LAYAR CHAT ---
// Kita gunakan StatefulWidget untuk mengelola TextEditingController
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  // --- DATA DUMMY (Sesuai Gambar) ---
  // Dibuat urut secara kronologis (dari paling lama ke paling baru)
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Selamat Pagi Dok', time: '11:43', isSender: true),
    ChatMessage(text: 'Selamat Pagi juga Kak', time: '11:45', isSender: false),
    ChatMessage(
      text:
          'Saya ada keluhan gusi bengkak di bagian belakang dok, kira-kira kenapa ya?',
      time: '11:46',
      isSender: true,
    ),
    ChatMessage(
      text: 'Padahal saya sudah sikat gigi teratur.',
      time: '11:46',
      isSender: true,
    ),
    ChatMessage(
      text: 'Baik Kak, bisa coba difotokan dulu bagian yang bengkak?',
      time: '11:47',
      isSender: false,
    ),
    ChatMessage(
      text: 'Oh iya, bengkaknya sudah berapa lama?',
      time: '11:47',
      isSender: false,
    ),
    ChatMessage(text: 'Sudah 2 harian ini dok.', time: '11:47', isSender: true),
    // Tambahkan pesan lain di sini agar bisa di-scroll
    ChatMessage(
      text: 'Ok, fotonya saya kirim ya',
      time: '11:48',
      isSender: true,
    ),
    ChatMessage(
      text: 'Diterima Kak, saya periksa dulu fotonya.',
      time: '11:49',
      isSender: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background abu-abu muda seperti di desain
      backgroundColor: const Color(0xFFF5F5F5),

      // --- APPBAR KUSTOM (Poin 1) ---
      appBar: _buildCustomAppBar(),

      body: Column(
        children: [
          // --- AREA CHAT YANG BISA SCROLL (Poin 3) ---
          Expanded(
            child: ListView.builder(
              // reverse: true membuat list mulai dari bawah (standar chat)
              reverse: true,
              padding: const EdgeInsets.all(10.0),
              // Kita balik list-nya agar pesan terbaru ada di index 0
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                // Balik urutan list agar sesuai dengan 'reverse: true'
                final message = _messages.reversed.toList()[index];
                return _ChatBubble(message: message);
              },
            ),
          ),

          // --- AREA INPUT TEKS (Poin 4) ---
          _buildTextInputArea(),
        ],
      ),
    );
  }

  // --- WIDGET UNTUK APPBAR KUSTOM ---
  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      elevation: 1.0,
      backgroundColor: const Color(0xFFF5F5F5), // Samakan dgn background
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black54),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0,
      title: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/profil-dokter');
        },
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFE0E0E0),
              child: Icon(Icons.person, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'dr. Bagas',
                  style: TextStyle(
                    color: Color(0xFF2158A1), // Warna biru sesuai permintaan
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily:
                        'Poppins', // Gunakan font Poppins sesuai permintaan
                  ),
                ),
                // Chip "Online"
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF4DAFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily:
                          'InstrumentSans', // Gunakan font Instrument Sans sesuai permintaan
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        // Tombol "Review Dokter"
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/review');
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey, // Efek ripple
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Row(
            children: [
              Text(
                'Review Dokter',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontFamily:
                      'InstrumentSans', // Gunakan font Instrument Sans sesuai permintaan
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black87),
            ],
          ),
        ),
      ],
    );
  }

  // --- WIDGET UNTUK AREA INPUT TEKS ---
  Widget _buildTextInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      color: Colors.white, // Latar belakang area input putih
      child: SafeArea(
        child: Row(
          children: [
            // --- TextField ---
            Expanded(
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Tulis pesan',
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5), // Warna field abu-abu
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none, // Tanpa border
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // --- Tombol Kirim ---
            GestureDetector(
              onTap: () {
                // TODO: Tambahkan fungsi kirim pesan
                debugPrint('Mengirim pesan: ${_textController.text}');
                _textController.clear();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFF2158A1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGET UNTUK BUBBLE CHAT (Poin 2) ---
class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Rata kanan jika pengirim, rata kiri jika penerima
      alignment:
          message.isSender ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        constraints: BoxConstraints(
          // Atur lebar maksimum bubble
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          // Warna bubble
          color: message.isSender ? const Color(0xFFD0E6FF) : Colors.white,
          // --- Trik "Ekor" Bubble ---
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: message.isSender
                ? const Radius.circular(16)
                : const Radius.circular(0), // Ekor di kiri bawah
            bottomRight: message.isSender
                ? const Radius.circular(0) // Ekor di kanan bawah
                : const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // --- Teks Pesan ---
            Text(
              message.text,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
            const SizedBox(height: 4),
            // --- Waktu & Status ---
            Row(
              mainAxisSize: MainAxisSize.min, // Agar row tidak selebar bubble
              children: [
                Text(
                  message.time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                if (message.isSender) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.done_all, // Icon centang dua
                    color: Colors.blue,
                    size: 16,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
