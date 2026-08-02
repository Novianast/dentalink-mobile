import 'package:flutter/material.dart';
import 'package:dentalink/features/doctor/splash_screen.dart';
import 'package:dentalink/features/doctor/home_screen.dart';
import 'package:dentalink/features/patient/app/patient_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DentaLink',
      debugShowCheckedModeBanner: false,
      routes: {
        ...PatientRoutes.routes,
        '/doctor-home': (context) => const DoctorHomeScreen(),
        '/splash': (context) => const Splash_Screen(),
      },
      home: const Splash_Screen(),
    );
  }
}