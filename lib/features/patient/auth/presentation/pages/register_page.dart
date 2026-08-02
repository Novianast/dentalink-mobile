import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dentalink/core/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;
  String? selectedGender;
  DateTime? selectedDate;
  bool _isLoading = false;
  final _authService = AuthService();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 48,
        titleSpacing: -8,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Register',
          style: TextStyle(
            fontFamily: 'Istok Web',
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Color(0xFF2158A1),
            height: 1.0,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Register ke DentaLink',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Color(0xFF2158A1),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Buat Akun anda Dibawah ini',
                      style: TextStyle(
                        fontFamily: 'Istok Web',
                        fontSize: 14,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField('Nama Lengkap', _fullNameController),
                    const SizedBox(height: 14),
                    _buildTextField(
                      'Email',
                      _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 14),
                    _buildTextField(
                      'Nomor Telepon',
                      _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 14),
                    _buildPasswordField(
                      'Password',
                      _passwordController,
                      showPassword,
                      () => setState(() => showPassword = !showPassword),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Password Minimal 8 Karakter',
                      style: TextStyle(
                        fontFamily: 'Istok Web',
                        fontSize: 12,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildPasswordField(
                      'Konfirmasi Password',
                      _confirmPasswordController,
                      showConfirmPassword,
                      () => setState(
                        () => showConfirmPassword = !showConfirmPassword,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(child: _buildDateField()),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: _selectDate,
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4DAFFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.date_range,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Format DD/MM/YYYY',
                      style: TextStyle(
                        fontFamily: 'Istok Web',
                        fontSize: 12,
                        color: Color(0xFF6B6B6B),
                      ),
                    ),
                    const SizedBox(height: 25),
                    _buildGenderDropdown(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ), // 🔹 jarak bawah sesuai Figma
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2158A1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 2,
                      ),
                      onPressed: _isLoading ? null : _handleRegister,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Register',
                              style: TextStyle(
                                fontFamily: 'Istok Web',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleRegister() async {
    // Validasi
    if (_fullNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama lengkap harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nomor telepon harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password minimal 8 karakter'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konfirmasi password tidak sesuai'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gender harus dipilih'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal lahir harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Konversi gender ke format API: 'Laki-laki' -> 'L', 'Perempuan' -> 'P'
    final genderCode = selectedGender == 'Laki-laki' ? 'L' : 'P';

    // Format birth_date ke YYYY-MM-DD
    final birthDateString = DateFormat('yyyy-MM-dd').format(selectedDate!);

    final result = await _authService.register(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
      passwordConfirmation: _confirmPasswordController.text,
      gender: genderCode,
      birthDate: birthDateString,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success'] == true) {
      // Register selalu untuk pasien, jadi selalu navigate ke /main
      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);

      // Tampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Registrasi berhasil!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Registrasi gagal'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2158A1),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontFamily: 'Istok Web',
        fontSize: 14,
        color: Color(0xFF2158A1),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Istok Web',
          fontSize: 14,
          color: Color(0xFF84BCEA),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4DAFFF), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4DAFFF), width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String hint,
    TextEditingController controller,
    bool visible,
    VoidCallback toggle,
  ) {
    return TextField(
      controller: controller,
      obscureText: !visible,
      style: const TextStyle(
        fontFamily: 'Istok Web',
        fontSize: 14,
        color: Color(0xFF2158A1),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Istok Web',
          fontSize: 14,
          color: Color(0xFF84BCEA),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF4DAFFF),
            size: 22,
          ),
          onPressed: toggle,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4DAFFF), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4DAFFF), width: 2),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    final dateText = selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
        : 'Tanggal Lahir';

    return TextField(
      readOnly: true,
      controller: TextEditingController(text: dateText),
      style: TextStyle(
        fontFamily: 'Istok Web',
        fontSize: 14,
        color: selectedDate != null
            ? const Color(0xFF2158A1)
            : const Color(0xFF84BCEA),
      ),
      decoration: InputDecoration(
        hintText: 'Tanggal Lahir',
        hintStyle: const TextStyle(
          fontFamily: 'Istok Web',
          fontSize: 14,
          color: Color(0xFF84BCEA),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4DAFFF), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4DAFFF), width: 2),
        ),
      ),
      onTap: _selectDate,
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: selectedGender,
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        hintText: 'Gender',
        hintStyle: const TextStyle(
          fontFamily: 'Istok Web',
          fontSize: 14,
          color: Color(0xFF84BCEA),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4DAFFF), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4DAFFF), width: 2),
        ),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Color(0xFF4DAFFF),
        size: 26,
      ),
      style: const TextStyle(
        fontFamily: 'Istok Web',
        fontSize: 14,
        color: Color(0xFF84BCEA),
      ),
      items: const [
        DropdownMenuItem(
          value: 'Laki-laki',
          child: Text(
            'Laki-laki',
            style: TextStyle(
              fontFamily: 'Istok Web',
              fontSize: 14,
              color: Color(0xFF84BCEA),
            ),
          ),
        ),
        DropdownMenuItem(
          value: 'Perempuan',
          child: Text(
            'Perempuan',
            style: TextStyle(
              fontFamily: 'Istok Web',
              fontSize: 14,
              color: Color(0xFF84BCEA),
            ),
          ),
        ),
      ],
      onChanged: (value) => setState(() => selectedGender = value),
    );
  }
}
