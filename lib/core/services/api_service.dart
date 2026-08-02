import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Base headers untuk semua request
  Map<String, String> getHeaders({String? token}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Helper method untuk handle response
  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    Map<String, dynamic> body;

    try {
      body = json.decode(response.body);
    } catch (e) {
      throw ApiException('Terjadi kesalahan pada respons server', statusCode);
    }

    if (statusCode >= 200 && statusCode < 300) {
      return body;
    } else {
      // Handle error response
      // Jika ada validation errors dari Laravel
      if (body.containsKey('errors') && body['errors'] is Map) {
        final errors = body['errors'] as Map<String, dynamic>;
        // Ambil error pertama dari setiap field dan gabungkan
        final errorMessages = <String>[];
        errors.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            errorMessages.add(value.first.toString());
          }
        });

        final errorMessage = errorMessages.isNotEmpty
            ? errorMessages.join(', ')
            : (body['message'] ?? 'Terjadi kesalahan');
        throw ApiException(errorMessage, statusCode);
      }

      final errorMessage = body['message'] ?? 'Terjadi kesalahan';
      throw ApiException(errorMessage, statusCode);
    }
  }

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}'),
        headers: getHeaders(),
        body: json.encode({'email': email, 'password': password}),
      );

      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        'Gagal terhubung ke server. Periksa koneksi internet Anda.',
        0,
      );
    }
  }

  // Register
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required String gender,
    required String birthDate,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}'),
        headers: getHeaders(),
        body: json.encode({
          'full_name': fullName,
          'email': email,
          'phone': phone,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'gender': gender,
          'birth_date': birthDate,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        'Gagal terhubung ke server. Periksa koneksi internet Anda.',
        0,
      );
    }
  }

  // Logout
  Future<void> logout(String token) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.logoutEndpoint}'),
        headers: getHeaders(token: token),
      );

      _handleResponse(response);
    } catch (e) {
      // Even if logout fails, we should still clear local token
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Gagal logout. Periksa koneksi internet Anda.', 0);
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}
