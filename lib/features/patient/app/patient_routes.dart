import 'package:flutter/material.dart';

import '../all_screens_page.dart';
import '../booking_klinik.dart';
import '../detail_booking.dart';
import '../layouts/navbar.dart';
import '../articles/presentation/pages/artikel_screen.dart';
import '../auth/presentation/pages/forgot_password_page.dart';
import '../auth/presentation/pages/login_page.dart';
import '../auth/presentation/pages/register_page.dart';
import '../auth/presentation/pages/reset_password_page.dart';
import '../auth/presentation/pages/update_password_page.dart';
import '../booking/presentation/pages/booking_berhasil_screen.dart';
import '../booking/presentation/pages/booking_schedule.dart';
import '../confirmation/presentation/pages/confirmation_screen.dart';
import '../consultation/presentation/pages/consultation_screen.dart';
import '../consultation/presentation/pages/history/consultation_history_screen.dart';
import '../diagnosis/presentation/pages/diagnosis_screen.dart';
import '../doctors/presentation/pages/doctor_profile_screen.dart';
import '../home/presentation/pages/home_screen.dart';
import '../notifications/presentation/pages/notification_detail_screen.dart';
import '../notifications/presentation/pages/notification_screen.dart';
import '../points/presentation/pages/denta_point_screen.dart';
import '../prescriptions/presentation/pages/resep_screen.dart';
import '../profile/presentation/pages/edit_profile_page.dart';
import '../profile/presentation/pages/identity_screen.dart';
import '../profile/presentation/pages/profile_screen.dart';
import '../chat/presentation/pages/chat_screen.dart';
import '../reviews/presentation/pages/review_doctor_screen.dart';
import '../reviews/presentation/pages/review_page.dart';
import '../reviews/presentation/pages/review_records_screen.dart';
import '../reviews/presentation/pages/review_success_screen.dart';
import '../vouchers/presentation/pages/voucher_page.dart';

class PatientRoutes {
  static Map<String, WidgetBuilder> get routes => {
        '/home': (context) => const PatientHomeScreen(),
        '/main': (context) => const MainPage(),
        '/profile': (context) => const ProfileScreen(),
        '/edit-profil': (context) => const EditProfilePage(),
        '/identity': (context) => const UserIdentityScreen(),
        '/artikel': (context) => const ArtikelDentaLinkScreen(),
        '/consultation-history': (context) =>
            const ConsultationHistoryScreen(),
        '/booking-screen': (context) => const JadwalBookingScreen(),
        '/select-doctor': (context) => const ConsultationScreen(),
        '/booking-klinik': (context) => const KlinikListScreen(),
        '/booking-berhasil': (context) => const BookingBerhasilPage(),
        '/detail-booking': (context) => const DetailBookingScreen(),
        '/resep': (context) => const ResepDokterPage(),
        '/denta-points': (context) => const DentaPointPage(),
        '/vouchers': (context) => const VoucherPage(),
        '/notifications': (context) => const NotificationScreen(),
        '/notification-detail': (context) => const NotificationDetail(),
        '/chat': (context) => const ChatScreen(),
        '/rekaman-ulasan': (context) => const RekamanUlasanPage(),
        '/review': (context) => const ReviewDokterPage(),
        '/review-form': (context) => const ReviewPage(),
        '/review-berhasil': (context) => const ReviewBerhasilPage(),
        '/profil-dokter': (context) => const ProfilDokterPage(),
        '/consultation': (context) => const ConsultationScreen(),
        '/diagnosis': (context) => const DiagnosisScreen(),
        '/konfirmasi': (context) => const KonfirmasiPage(),
        '/all-screens': (context) => const AllScreensPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => const LupaPasswordPage(),
        '/reset-password': (context) => const ResetPasswordPage(),
        '/update-password': (context) => const UpdatePasswordPage(),
      };
}

