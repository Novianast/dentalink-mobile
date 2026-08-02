// --- PASTE SELURUH KODE INI KE resep.dart ---

import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb; // Untuk cek platform Web
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart'; // Tambahkan import Google Fonts
import 'package:flutter_quill/flutter_quill.dart' as quill; // Import flutter_quill

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  // Inisialisasi controller dengan document kosong
  final quill.QuillController _textController = quill.QuillController(
    document: quill.Document(),
    selection: const TextSelection(baseOffset: 0, extentOffset: 0),
  );
  final TextEditingController _sipController = TextEditingController();
  final FocusNode _editorFocusNode = FocusNode();

  final List<String> _history = [];
  int _historyIndex = -1;

  final ImagePicker _picker = ImagePicker();
  final List<XFile> _attachments = [];

  @override
  void initState() {
    super.initState();
    _saveHistory(); // Simpan state awal
    // Listener untuk mendeteksi perubahan teks dan seleksi
    _textController.addListener(_handleTextChange);
    _sipController.addListener(_saveHistory);
  }

  // Listener dipisah agar bisa handle perubahan seleksi juga (untuk update tombol bold)
  void _handleTextChange() {
    _saveHistory();
    // Update UI tombol bold berdasarkan style saat ini
    // Memanggil setState() di sini akan rebuild seluruh UI setiap ketikan,
    // Kita panggil setState() hanya saat undo/redo/format saja.
    // setState(() {});
  }

  void _saveHistory() {
    String combinedText =
        '${_textController.document.toPlainText()}|||${_sipController.text}';
    // Hanya simpan jika ada perubahan dari state terakhir di history
    if (_history.isEmpty || (_historyIndex >= 0 && combinedText != _history[_historyIndex])) {
        // Hapus history setelah index saat ini jika ada pengetikan baru setelah undo
        while (_history.length > _historyIndex + 1) {
            _history.removeLast();
        }
        _history.add(combinedText);
        _historyIndex = _history.length - 1;

        // Update UI tombol undo/redo setelah state baru disimpan
        // Kita panggil setState hanya jika perlu update UI tombol undo/redo
        // Ini lebih efisien daripada memanggilnya setiap ketikan
        WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() {});
        });

    } else if (_history.isEmpty) {
        // Simpan state awal jika history kosong
        _history.add(combinedText);
        _historyIndex = 0;
        WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() {}); // Update UI tombol undo/redo
        });
    }
  }


  @override
  void dispose() {
    _textController.removeListener(_handleTextChange);
    _sipController.removeListener(_saveHistory);
    _textController.dispose();
    _sipController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        leadingWidth: 130,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF84BCEA),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Color(0xFF2158A1),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Kembali",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF2158A1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _sendPrescription();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4DAFFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text("Kirim Resep"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildKopResepCard(),
            _buildEditorToolbar(),
            _buildResepInputArea(), // <-- Isinya sudah diperbaiki
          ],
        ),
      ),
    );
  }

  // --- FUNGSI LOGIKA ---

  void _sendPrescription() {
    String prescriptionText = _textController.document.toPlainText();
    // TODO: Implementasi logika pengiriman resep (misal ke API)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Resep berhasil dikirim "$prescriptionText" dengan ${_attachments.length} lampiran!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          _attachments.add(pickedFile);
        });
        _saveHistory(); // Simpan state setelah menambah lampiran
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengambil gambar: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _toggleBold() {
    final isApplied = _textController.getSelectionStyle().containsKey(quill.Attribute.bold.key);

    // Toggle format pada teks yang diseleksi atau pada style pengetikan berikutnya
    if (isApplied) {
      _textController.formatSelection(quill.Attribute.clone(quill.BoldAttribute(), null));
    } else {
      _textController.formatSelection(quill.BoldAttribute());
    }
    // Update tombol bold setelah format
    setState(() {});
    // _saveHistory() akan dipanggil oleh listener
  }


  void _undoAction() {
    if (_historyIndex > 0) {
      _historyIndex--;
      _restoreStateFromHistory();
    }
  }

  void _redoAction() {
    if (_historyIndex < _history.length - 1) {
      _historyIndex++;
      _restoreStateFromHistory();
    }
  }

  void _restoreStateFromHistory() {
    // Hentikan listener sementara
    _textController.removeListener(_handleTextChange);
    _sipController.removeListener(_saveHistory);

    String historyText = _history[_historyIndex];
    List<String> parts = historyText.split('|||');
    String newQuillText = parts.isNotEmpty ? parts[0] : '';
    String newSipText = parts.length > 1 ? parts[1] : '';

    // Simpan posisi kursor saat ini
    final currentSelection = _textController.selection;

    // Restore state
    _textController.document = quill.Document()..insert(0, newQuillText);
    _sipController.text = newSipText;

    // Coba kembalikan kursor ke posisi sebelumnya (atau ke akhir jika tidak valid)
    try {
      // Gunakan ChangeSource.local (lowercase based on common pattern)
      _textController.updateSelection(currentSelection, quill.ChangeSource.local);
      // Jika kursor jadi tidak valid setelah teks berubah, pindah ke akhir
      if(!_textController.selection.isValid || _textController.selection.baseOffset > _textController.document.length){
         _textController.moveCursorToEnd();
      }
    } catch (e){
        _textController.moveCursorToEnd(); // Fallback ke akhir
    }

    _sipController.selection = TextSelection.fromPosition(
      TextPosition(offset: _sipController.text.length),
    );

    // Aktifkan kembali listener
    _textController.addListener(_handleTextChange);
    _sipController.addListener(_saveHistory);

    // Update UI (terutama untuk tombol undo/redo dan bold)
    setState(() {});
  }


  // --- WIDGET BUILDER ---

  Widget _buildKopResepCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kop Resep",
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            "14 Oktober 2025  |  20:33", // Format waktu diperbaiki
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorToolbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Pusatkan tombol
        children: [
          _buildToolbarButton(Icons.image_outlined, _pickImage),
          _buildToolbarButton(Icons.format_bold, _toggleBold, color: _getBoldButtonColor()),
          _buildToolbarButton(Icons.undo, _undoAction, canExecute: _historyIndex > 0),
          _buildToolbarButton(Icons.redo, _redoAction, canExecute: _historyIndex < _history.length - 1),
        ],
      ),
    );
  }


  Color? _getBoldButtonColor() {
    // Cek apakah style bold aktif pada seleksi saat ini ATAU akan aktif saat mengetik
    try {
      final style = _textController.getSelectionStyle();
      final isAppliedOnSelection = style.containsKey(quill.Attribute.bold.key);
      final isToggledForTyping = _textController.toggledStyle.containsKey(quill.Attribute.bold.key);

      if (isAppliedOnSelection || isToggledForTyping) {
        return const Color(0xFF2563EB); // Biru
      }
    } catch (e) {
      // Tangani error jika controller belum siap (jarang terjadi)
      // debugPrint("Error getting selection style: $e");
    }
    return null; // Default
  }

  Widget _buildToolbarButton(IconData icon, VoidCallback onPressed,
      {Color? color, bool canExecute = true}) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: IconButton(
        // Nonaktifkan tombol jika canExecute false (untuk undo/redo)
        onPressed: canExecute ? onPressed : null,
        icon: Icon(
          icon,
          // Warna abu-abu jika dinonaktifkan
          color: canExecute ? (color ?? Colors.black54) : Colors.grey[400],
        ),
      ),
    );
  }

  Widget _buildAttachmentList() {
    if (_attachments.isEmpty) {
      return const SizedBox.shrink(); // Jangan tampilkan apa-apa jika kosong
    }
    return Container(
      height: 100, // Sedikit lebih kecil agar pas
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lampiran:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Expanded( // Agar bisa di-scroll jika banyak
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontal
              itemCount: _attachments.length,
              itemBuilder: (context, index) {
                final file = _attachments[index];
                return Container(
                  margin: const EdgeInsets.only(right: 8.0), // Jarak antar gambar
                  child: Stack( // Gunakan Stack untuk tombol hapus
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: kIsWeb
                            ? Image.network( // Tampilkan gambar dari Web
                                file.path,
                                width: 70, // Ukuran thumbnail disesuaikan
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                    width: 70, height: 70, color: Colors.grey[200],
                                    child: Icon(Icons.broken_image, color: Colors.grey[400])),
                              )
                            : Image.file( // Tampilkan gambar dari file (Mobile/Desktop)
                                File(file.path),
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                    width: 70, height: 70, color: Colors.grey[200],
                                    child: Icon(Icons.broken_image, color: Colors.grey[400])),
                              ),
                      ),
                      // Tombol Hapus (X)
                      Container(
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                           color: Colors.black.withValues(alpha: 0.6), // Sedikit lebih gelap
                           shape: BoxShape.circle,
                        ),
                        // Perkecil ukuran target tap
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _attachments.removeAt(index);
                              });
                              _saveHistory(); // Simpan state setelah hapus lampiran
                            },
                            child: const Icon(Icons.close, color: Colors.white, size: 14), // Perkecil ikon
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  // --- INI ADALAH FUNGSI YANG DIPERBAIKI ---
  Widget _buildResepInputArea() {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Dokter
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    "Dokter",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  ": ",
                  style: GoogleFonts.instrumentSans(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Auto Fill Name Doktr", // Harusnya ini dinamis nanti
                    style: GoogleFonts.instrumentSans(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),

            // Info SIP
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 60,
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.0), // Sesuaikan padding agar lurus
                    child: Text(
                      "SIP",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0), // Sesuaikan padding agar lurus
                  child: Text(
                    ": ",
                    style: GoogleFonts.instrumentSans(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _sipController,
                    decoration: InputDecoration(
                      hintText: "Masukkan nomor SIP",
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero, // Hapus padding default
                      hintStyle: GoogleFonts.instrumentSans(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    style: GoogleFonts.instrumentSans(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),

            // --- PERBAIKAN AREA EDITOR QUILL ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100], // Background abu-abu
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: quill.QuillEditor(
                        controller: _textController,
                        scrollController: ScrollController(),
                        focusNode: _editorFocusNode,
                      ),
                    ),
                    // Placeholder teks yang hilang saat user mulai ketik
                    if (_textController.document.toPlainText().replaceAll('\n', '').trim().isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                        child: Text(
                          "Tulis Resep Disini...",
                          style: GoogleFonts.instrumentSans(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // --- AKHIR PERBAIKAN AREA EDITOR ---

            // Daftar lampiran
            _buildAttachmentList(),
          ],
        ),
      ),
    );
  }
}