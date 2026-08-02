import 'package:flutter/material.dart';
import 'package:dentalink/core/services/auth_service.dart';
import 'package:dentalink/core/constants/colors.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    // Load auth data dari storage terlebih dahulu
    await AuthService().loadAuthData();
    
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final user = AuthService().getCurrentUser();
    if (user != null) {
      // Navigate berdasarkan role: "pasien" -> /main, "dokter" -> /doctor-home
      if (user.role == 'doctor' || user.roleName == 'dokter') {
        Navigator.pushReplacementNamed(context, '/doctor-home');
      } else {
        Navigator.pushReplacementNamed(context, '/main');
      }
    }
    // Jika tidak ada user, tetap di splash screen (user bisa klik tombol Login)
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 16.0),
                  child: Image.asset(
                    'assets/images/Rectangle_64.png',
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: screenHeight * 0.6,
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 100,
                            color: AppColors.darkBlue.withValues(alpha: 0.5),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Text(
                'DentaLink',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              Text(
                'Gigi sehat, hanya dengan satu Klik',
                style: TextStyle(
                  fontFamily: 'Istokweb',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: const StadiumBorder(),
                    elevation: 3,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'InstrumentSans',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
