import 'dart:io';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  // API Key untuk Gemini - Anda perlu mengganti ini dengan API key Anda sendiri
  // Dapatkan di: https://makersuite.google.com/app/apikey
  static const String _apiKey = 'AIzaSyC3V_ORWaEZji58YyxmQFGsmbvTGJndTtA';

  // Model akan dibuat langsung di method untuk menghindari masalah caching

  // Method untuk diagnosa dari gambar
  static Future<Map<String, dynamic>> diagnoseFromImage(
    File? imageFile,
    List<String> symptoms,
  ) async {
    try {
      // Validasi API key - hanya cek apakah empty
      if (_apiKey.isEmpty || _apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
        throw Exception(
            'API Key belum diatur. Silakan set API key Gemini di gemini_service.dart');
      }

      String prompt = _buildPrompt(symptoms);

      // Buat model instance baru setiap kali untuk menghindari masalah caching
      // Gunakan model yang tersedia: gemini-2.5-flash (terbaru dan cepat)
      final model = GenerativeModel(
        model:
            'gemini-2.5-flash', // Model yang tersedia berdasarkan list models
        apiKey: _apiKey,
      );

      // Jika ada gambar, gunakan multi-part content
      if (imageFile != null) {
        final imageBytes = await imageFile.readAsBytes();

        // Pastikan format gambar benar
        final imageData = DataPart('image/jpeg', imageBytes);
        final textPart = TextPart(prompt);

        final content = Content.multi([textPart, imageData]);

        final response = await model.generateContent([content]);

        // Cek apakah ada error dalam response
        if (response.candidates.isEmpty) {
          // Cek apakah ada error message
          if (response.promptFeedback != null) {
            throw Exception(
                'Gemini API Error: ${response.promptFeedback?.blockReasonMessage ?? 'Unknown error'}');
          }
          throw Exception('Tidak ada response dari Gemini API');
        }

        final candidate = response.candidates.first;
        if (candidate.content.parts.isEmpty) {
          throw Exception('Response kosong dari Gemini API');
        }

        String responseText = response.text ?? '';

        if (responseText.isEmpty) {
          throw Exception('Gemini API tidak mengembalikan teks');
        }

        return _parseResponse(responseText);
      } else {
        // Jika tidak ada gambar, gunakan text content saja
        final response = await model.generateContent([Content.text(prompt)]);

        // Cek apakah ada error dalam response
        if (response.candidates.isEmpty) {
          // Cek apakah ada error message
          if (response.promptFeedback != null) {
            throw Exception(
                'Gemini API Error: ${response.promptFeedback?.blockReasonMessage ?? 'Unknown error'}');
          }
          throw Exception('Tidak ada response dari Gemini API');
        }

        final candidate = response.candidates.first;
        if (candidate.content.parts.isEmpty) {
          throw Exception('Response kosong dari Gemini API');
        }

        String responseText = response.text ?? '';

        if (responseText.isEmpty) {
          throw Exception('Gemini API tidak mengembalikan teks');
        }

        return _parseResponse(responseText);
      }
    } catch (e) {
      // Jika error terkait API key atau authentication
      String errorMessage = e.toString();
      String diagnosis = 'Tidak dapat melakukan diagnosa';
      String description = 'Terjadi kesalahan saat memproses diagnosa.';

      // Deteksi jenis error yang lebih spesifik
      if (errorMessage.contains('API') ||
          errorMessage.contains('key') ||
          errorMessage.contains('401') ||
          errorMessage.contains('403') ||
          errorMessage.contains('authentication') ||
          errorMessage.contains('unauthorized') ||
          errorMessage.contains('invalid') ||
          errorMessage.contains('permission')) {
        diagnosis = 'Error Autentikasi API';
        description =
            'API key Gemini tidak valid atau tidak memiliki akses. Silakan periksa API key Anda di https://aistudio.google.com/app/apikey';
      } else if (errorMessage.contains('network') ||
          errorMessage.contains('connection') ||
          errorMessage.contains('timeout') ||
          errorMessage.contains('SocketException')) {
        diagnosis = 'Error Koneksi';
        description =
            'Tidak dapat terhubung ke server Gemini. Periksa koneksi internet Anda.';
      } else if (errorMessage.contains('quota') ||
          errorMessage.contains('429') ||
          errorMessage.contains('rate limit')) {
        diagnosis = 'Kuota Habis';
        description = 'Kuota API Gemini telah habis. Silakan coba lagi nanti.';
      } else if (errorMessage.contains('400') ||
          errorMessage.contains('bad request')) {
        diagnosis = 'Error Request';
        description =
            'Request yang dikirim tidak valid. Silakan coba lagi dengan data yang berbeda.';
      }

      return {
        'error': true,
        'message': errorMessage,
        'diagnosis': diagnosis,
        'severity':
            'sedang', // Gunakan 'sedang' bukan 'unknown' agar UI bisa handle
        'description': description + ' Detail: $errorMessage',
        'suggestions': [
          'Periksa koneksi internet Anda',
          'Pastikan API key Gemini valid',
          'Cek apakah kuota API masih tersedia',
          'Silakan coba lagi nanti'
        ],
        'recommendation': 'ya',
      };
    }
  }

  // Method untuk diagnosa hanya dari gejala (tanpa gambar)
  static Future<Map<String, dynamic>> diagnoseFromSymptoms(
    List<String> symptoms,
  ) async {
    return diagnoseFromImage(null, symptoms);
  }

  // Method untuk chat dengan context hasil diagnosa
  static Future<String> chatWithContext(
    String userMessage,
    Map<String, dynamic> diagnosisResult,
  ) async {
    try {
      if (_apiKey.isEmpty || _apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
        throw Exception('API Key belum diatur');
      }

      final diagnosis = diagnosisResult['diagnosis'] ?? 'Konsultasi diperlukan';
      final severity = diagnosisResult['severity'] ?? 'sedang';
      final description = diagnosisResult['description'] ?? '';
      final suggestions =
          diagnosisResult['suggestions'] as List<dynamic>? ?? [];

      // Build prompt dengan context hasil diagnosa
      final prompt =
          '''Kamu adalah asisten dokter gigi AI yang membantu menjawab pertanyaan pasien tentang diagnosa mereka.

HASIL DIAGNOSA SEBELUMNYA:
- Diagnosis: $diagnosis
- Tingkat Keparahan: $severity
- Penjelasan: $description
- Saran: ${suggestions.join(', ')}

PERTANYAAN PASIEN: $userMessage

INSTRUKSI:
- Jawab pertanyaan dengan singkat dan mudah dipahami (maksimal 3 kalimat)
- Gunakan bahasa yang ramah dan profesional
- Berikan informasi yang relevan berdasarkan diagnosa di atas
- Jika pertanyaan tidak terkait dengan diagnosa, arahkan kembali ke topik kesehatan gigi
- Jangan memberikan diagnosa baru, fokus pada penjelasan diagnosa yang sudah ada

Jawab dengan singkat dan jelas:''';

      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: _apiKey,
      );

      final response = await model.generateContent([Content.text(prompt)]);

      if (response.candidates.isEmpty) {
        if (response.promptFeedback != null) {
          throw Exception(
              'Gemini API Error: ${response.promptFeedback?.blockReasonMessage ?? 'Unknown error'}');
        }
        throw Exception('Tidak ada response dari Gemini API');
      }

      final candidate = response.candidates.first;
      if (candidate.content.parts.isEmpty) {
        throw Exception('Response kosong dari Gemini API');
      }

      String responseText = response.text ?? '';

      if (responseText.isEmpty) {
        throw Exception('Gemini API tidak mengembalikan teks');
      }

      return responseText.trim();
    } catch (e) {
      return 'Maaf, terjadi kesalahan saat memproses pertanyaan Anda. Silakan coba lagi.';
    }
  }

  // Build prompt untuk Gemini
  static String _buildPrompt(List<String> symptoms) {
    String symptomsText = symptoms.isEmpty
        ? 'Tidak ada gejala spesifik yang dipilih'
        : symptoms.join(', ');

    return '''Kamu adalah dokter gigi AI yang berpengalaman. Analisislah kondisi gigi berdasarkan informasi berikut:

Gejala yang dipilih: $symptomsText

PERHATIAN PENTING:
1. Jika ada gambar: PERTAMA-TAMA pastikan gambar tersebut adalah gambar gigi/mulut. Jika bukan gambar gigi (misalnya tangan, wajah, benda lain), gunakan severity: "error" dan diagnosis: "Gambar bukan gigi"
2. Jika gambar menunjukkan gigi sehat tanpa masalah: gunakan severity: "sehat" atau "ringan" dan diagnosis: "Gigi sehat"
3. Jika ada masalah pada gigi: gunakan severity sesuai tingkat keparahan (ringan, sedang, berat, kritis)
4. Deskripsi harus SINGKAT, JELAS, dan MUDAH DIPAHAMI (maksimal 2 kalimat)

Berdasarkan informasi di atas (dan gambar gigi jika tersedia), berikan diagnosa dalam format JSON berikut:

{
  "diagnosis": "Nama penyakit/kondisi gigi yang terdiagnosa",
  "severity": "sehat|ringan|sedang|berat|kritis|error",
  "description": "Penjelasan singkat dan mudah dipahami (maksimal 2 kalimat)",
  "suggestions": ["Saran 1", "Saran 2", "Saran 3"],
  "recommendation": "ya|tidak|tidak mendesak"
}

ATURAN SEVERITY:
- "sehat": Gigi sehat tanpa masalah
- "ringan": Masalah kecil yang bisa ditangani sendiri
- "sedang": Perlu perawatan, sebaiknya ke dokter
- "berat": Perlu perawatan dokter segera
- "kritis": Perlu perawatan darurat
- "error": Gambar bukan gigi atau tidak bisa dianalisis

ATURAN DESCRIPTION:
- Maksimal 2 kalimat
- Gunakan bahasa sederhana dan mudah dipahami
- Jelaskan kondisi secara singkat

ATURAN SUGGESTIONS:
- Berikan 3 saran perawatan yang praktis
- Saran harus spesifik dan bisa dilakukan

Jawab HANYA dengan JSON tanpa teks tambahan apapun.
''';
  }

  // Parse response dari Gemini menjadi structured data
  static Map<String, dynamic> _parseResponse(String responseText) {
    try {
      // Hapus markdown code blocks jika ada
      String cleaned =
          responseText.replaceAll('```json', '').replaceAll('```', '').trim();

      // Coba parse JSON langsung dulu
      try {
        final decoded = json.decode(cleaned) as Map<String, dynamic>;
        return {
          'diagnosis':
              decoded['diagnosis']?.toString() ?? 'Konsultasi diperlukan',
          'severity': decoded['severity']?.toString() ?? 'sedang',
          'description': decoded['description']?.toString() ??
              'Konsultasi dengan dokter gigi diperlukan untuk diagnosa yang lebih akurat',
          'suggestions': decoded['suggestions'] is List
              ? List<String>.from(
                  (decoded['suggestions'] as List).map((e) => e.toString()))
              : _getDefaultSuggestions(),
          'recommendation': decoded['recommendation']?.toString() ?? 'ya',
        };
      } catch (_) {
        // Jika parse langsung gagal, cari JSON dalam text
      }

      // Cari JSON object di dalam text menggunakan regex yang lebih robust
      final jsonMatch = RegExp(r'\{[\s\S]*\}').firstMatch(cleaned);
      if (jsonMatch != null) {
        final jsonString = jsonMatch.group(0);
        if (jsonString != null) {
          try {
            final decoded = json.decode(jsonString) as Map<String, dynamic>;
            return {
              'diagnosis':
                  decoded['diagnosis']?.toString() ?? 'Konsultasi diperlukan',
              'severity': decoded['severity']?.toString() ?? 'sedang',
              'description': decoded['description']?.toString() ??
                  'Konsultasi dengan dokter gigi diperlukan untuk diagnosa yang lebih akurat',
              'suggestions': decoded['suggestions'] is List
                  ? List<String>.from(
                      (decoded['suggestions'] as List).map((e) => e.toString()))
                  : _getDefaultSuggestions(),
              'recommendation': decoded['recommendation']?.toString() ?? 'ya',
            };
          } catch (_) {
            // Ignore parsing error
          }
        }
      }

      // Jika JSON parsing gagal, coba extract secara manual
      return {
        'diagnosis':
            _extractValue(cleaned, 'diagnosis', 'Konsultasi diperlukan'),
        'severity': _extractValue(cleaned, 'severity', 'sedang'),
        'description': _extractValue(cleaned, 'description',
            'Konsultasi dengan dokter gigi diperlukan untuk diagnosa yang lebih akurat'),
        'suggestions': _extractArray(cleaned, 'suggestions'),
        'recommendation': _extractValue(cleaned, 'recommendation', 'ya'),
      };
    } catch (_) {
      // Fallback jika parsing gagal
      return {
        'diagnosis': 'Konsultasi diperlukan',
        'severity': 'sedang',
        'description': responseText.isNotEmpty
            ? (responseText.length > 200
                ? responseText.substring(0, 200) + '...'
                : responseText)
            : 'Konsultasi dengan dokter gigi diperlukan untuk diagnosa yang lebih akurat',
        'suggestions': _getDefaultSuggestions(),
        'recommendation': 'ya',
      };
    }
  }

  static String _extractValue(String text, String key, String defaultValue) {
    try {
      final regex = RegExp('"$key"\\s*:\\s*"([^"]+)"');
      final match = regex.firstMatch(text);
      return match?.group(1) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  static List<String> _extractArray(String text, String key) {
    try {
      final regex = RegExp('"$key"\\s*:\\s*\\[([^\\]]+)\\]');
      final match = regex.firstMatch(text);
      if (match != null) {
        String arrayContent = match.group(1) ?? '';
        List<String> items = arrayContent
            .split(',')
            .map((e) => e.trim().replaceAll('"', ''))
            .where((e) => e.isNotEmpty)
            .toList();
        return items.isNotEmpty ? items : _getDefaultSuggestions();
      }
      return _getDefaultSuggestions();
    } catch (e) {
      return _getDefaultSuggestions();
    }
  }

  static List<String> _getDefaultSuggestions() {
    return [
      'Kunjungi dokter gigi untuk pemeriksaan lebih lanjut',
      'Jaga kebersihan gigi dan mulut dengan rutin',
      'Gunakan obat kumur antiseptik jika diperlukan'
    ];
  }
}
