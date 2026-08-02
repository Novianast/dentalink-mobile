import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class User {
  final int id;
  final String role;
  final String name;
  final String email;
  final int roleId;
  final String roleName;

  User({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.roleId,
    required this.roleName,
  });

  // Factory constructor untuk membuat User dari JSON
  factory User.fromJson(Map<String, dynamic> json) {
    // Normalize role name: "pasien" -> "patient", "dokter" -> "doctor"
    String roleName = json['role_name']?.toString().toLowerCase() ?? '';
    String role = roleName;
    if (roleName == 'pasien') {
      role = 'patient';
    } else if (roleName == 'dokter') {
      role = 'doctor';
    }

    return User(
      id: json['id'] ?? json['user_id'] ?? 0,
      role: role,
      name: json['name'] ?? json['full_name'] ?? '',
      email: json['email'] ?? '',
      roleId: json['role_id'] ?? 0,
      roleName: roleName,
    );
  }

  // Convert User ke JSON untuk penyimpanan
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'email': email,
      'role_id': roleId,
      'role_name': roleName,
    };
  }
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static User? _currentUser;
  static String? _accessToken;
  final ApiService _apiService = ApiService();
  final String _tokenKey = 'access_token';
  final String _userKey = 'user_data';

  // Login dengan API
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);

      // Simpan token dan user data
      _accessToken = response['access_token'];
      if (_accessToken == null) {
        throw ApiException('Token tidak ditemukan dalam response', 0);
      }

      // Parse user data
      final userData = response['user'];
      if (userData == null) {
        throw ApiException('Data user tidak ditemukan', 0);
      }

      _currentUser = User.fromJson(userData);

      // Simpan ke SharedPreferences
      await _saveAuthData();

      return {
        'success': true,
        'message': response['message'] ?? 'Login berhasil!',
      };
    } on ApiException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }

  // Register dengan API
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
      final response = await _apiService.register(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
        gender: gender,
        birthDate: birthDate,
      );

      // Simpan token dan user data
      _accessToken = response['access_token'];
      if (_accessToken == null) {
        throw ApiException('Token tidak ditemukan dalam response', 0);
      }

      // Parse user data
      final userData = response['user'];
      if (userData == null) {
        throw ApiException('Data user tidak ditemukan', 0);
      }

      _currentUser = User.fromJson(userData);

      // Simpan ke SharedPreferences
      await _saveAuthData();

      return {
        'success': true,
        'message': response['message'] ?? 'Registrasi berhasil!',
      };
    } on ApiException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }

  // Ambil user saat ini
  User? getCurrentUser() {
    return _currentUser;
  }

  // Ambil access token
  String? getAccessToken() {
    return _accessToken;
  }

  // Check apakah user sudah login
  bool isLoggedIn() {
    return _currentUser != null && _accessToken != null;
  }

  // Load auth data dari SharedPreferences
  Future<void> loadAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);
      final userJson = prefs.getString(_userKey);

      if (token != null && userJson != null) {
        _accessToken = token;
        final userData = json.decode(userJson) as Map<String, dynamic>;
        _currentUser = User.fromJson(userData);
      }
    } catch (e) {
      // Jika ada error loading, clear data
      await logout();
    }
  }

  // Simpan auth data ke SharedPreferences
  Future<void> _saveAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (_accessToken != null) {
        await prefs.setString(_tokenKey, _accessToken!);
      }
      
      if (_currentUser != null) {
        await prefs.setString(_userKey, json.encode(_currentUser!.toJson()));
      }
    } catch (e) {
      // Handle error saving
      print('Error saving auth data: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      // Logout dari API jika ada token
      if (_accessToken != null) {
        try {
          await _apiService.logout(_accessToken!);
        } catch (e) {
          // Even if API logout fails, continue with local logout
          print('Error logging out from API: $e');
        }
      }
    } catch (e) {
      // Ignore API logout errors, continue with local logout
    }

    // Clear local data
    _currentUser = null;
    _accessToken = null;

    // Clear SharedPreferences
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      await prefs.remove(_userKey);
    } catch (e) {
      print('Error clearing auth data: $e');
    }
  }
}