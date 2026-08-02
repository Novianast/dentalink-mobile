import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'resep.dart'; // Impor file resep Anda

// --- DATA MODEL ---
class ChatMessage {
  final String text;
  final String sender; // 'me' atau 'other'
  final String time;
  final bool isSeen; // Status apakah pesan telah dilihat

  ChatMessage({
    required this.text,
    required this.sender,
    required this.time,
    this.isSeen = false,
  });
}

// --- WIDGET UTAMA HALAMAN CHAT ---
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Daftar pesan (List) - Pastikan mutable (tidak final)
  List<ChatMessage> _messages = [
    ChatMessage(text: "Selamat Pagi Dok", sender: "other", time: "11.45"),
    ChatMessage(text: "Gigi saya nyeri dok", sender: "other", time: "11.45"),
    ChatMessage(
      text: "Selamat Pagi juga Bro, Apakah ada yang berlubang giginya??",
      sender: "me",
      time: "11.46",
      isSeen: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Menandai semua pesan 'me' sebagai dilihat ketika layar dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _markAllMessagesAsSeen();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // --- FUNGSI LOGIKA ---

  void _handleSendPressed() {
    // Pastikan controller terhubung dan teks tidak kosong
    if (_textController.text.isEmpty) return;

    final newMessage = ChatMessage(
      text: _textController.text,
      sender: 'me',
      time:
          "${DateTime.now().hour}.${DateTime.now().minute.toString().padLeft(2, '0')}",
      isSeen: false,
    );

    // Update state untuk menambahkan pesan baru
    setState(() {
      _messages.add(newMessage);
    });

    _textController.clear(); // Kosongkan input field

    // Auto-scroll ke paling bawah setelah UI diperbarui
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _markAllMessagesAsSeen() {
    bool shouldUpdate = false;
    // Gunakan List.generate untuk membuat list baru (best practice for immutability)
    final updatedMessages = List<ChatMessage>.generate(_messages.length, (i) {
      if (_messages[i].sender == 'me' && !_messages[i].isSeen) {
        shouldUpdate = true;
        return ChatMessage(
          // Buat objek baru dengan isSeen = true
          text: _messages[i].text,
          sender: _messages[i].sender,
          time: _messages[i].time,
          isSeen: true,
        );
      }
      return _messages[i]; // Kembalikan objek lama jika tidak berubah
    });

    if (shouldUpdate && mounted) {
      setState(() {
        _messages = updatedMessages; // Ganti list lama dengan list baru
      });
    }
  }

  // --- FUNGSI BUILD ---

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            // 1. Area List Chat
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(10.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ChatBubble(
                    key: ValueKey(
                      _messages[index],
                    ), // Tambahkan key untuk performa
                    text: message.text,
                    time: message.time,
                    isMe: message.sender == 'me',
                    isSeen: message.isSeen,
                  );
                },
              ),
            ),
            // 2. Area Input Teks
            _buildTextComposer(),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1.0,
      scrolledUnderElevation: 1.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF555555), size: 24),
        onPressed: () {
          _markAllMessagesAsSeen();
          Navigator.pop(context);
        },
      ),
      titleSpacing: 0,
      title: Row(
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
                "Jonathan Joel",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    // Perbaikan GoogleFonts
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2158A1),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF4DAFFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Online",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      // Perbaikan GoogleFonts
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(height: 1.0, color: Colors.grey[300]),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          // 'Pill' with black border
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: Row(
                children: [
                  // --- PERBAIKAN TOMBOL KIRIM ---
                  Expanded(
                    // 1. PASTIKAN TIDAK ADA 'const' DI SINI
                    child: TextField(
                      controller:
                          _textController, // 2. PASTIKAN CONTROLLER TERHUBUNG
                      decoration: const InputDecoration(
                        hintText: "Tulis pesan",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                      // Opsional: Kirim pesan saat menekan Enter/Done di keyboard
                      onSubmitted: (_) => _handleSendPressed(),
                    ),
                  ),
                  // Tombol Paperclip (ikon standar)
                  IconButton(
                    icon: Icon(Icons.medical_services, color: Colors.grey[600]),
                    onPressed: () {
                      _showAksiDokterPopup(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          // Tombol Kirim
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF2158A1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 18),
              onPressed: _handleSendPressed, // <-- Ini memanggil fungsi kirim
            ),
          ),
        ],
      ),
    );
  }

  // --- POPUP AlertDialog SESUAI GAMBAR TERAKHIR ---
  void _showAksiDokterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Tutup popup
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const PrescriptionScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                icon: Icon(Icons.medical_services, color: Colors.white),
                label: Text(
                  "Buat Resep",
                  style: GoogleFonts.poppins(
                    // Perbaikan GoogleFonts
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4DAFFF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- WIDGET KUSTOM UNTUK GELEMBUNG CHAT ---
// (Menggunakan struktur asli Anda + perbaikan GoogleFonts)
class ChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isMe;
  final bool isSeen;

  const ChatBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isMe,
    this.isSeen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: isMe ? const Color(0xFFD9EFFF) : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isMe
                    ? const Radius.circular(16)
                    : const Radius.circular(0),
                bottomRight: isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.instrumentSans(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(height: 5.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              time,
                              style: GoogleFonts.instrumentSans(
                                // Changed to Instrument Sans
                                fontSize: 11.0,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            if (isMe) ...[
                              const SizedBox(width: 4),
                              Icon(
                                isSeen ? Icons.done_all : Icons.done,
                                size: 14,
                                color: isSeen ? Colors.blue : Colors.grey[600],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
