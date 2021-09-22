import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/upload_prescription.dart';
import 'screens/splash_screen.dart';
import 'screens/register_page.dart';
import 'screens/login.dart';
import 'screens/homepage.dart';
import 'screens/maps.dart';
import 'permission/location_permission.dart';

final routes = {
  '/': (BuildContext context) => const SplashScreen(),
  '/home': (BuildContext context) => const HomePage(),
  '/register': (BuildContext context) => const Register(),
  '/login': (BuildContext context) => const Login(),
  '/map': (BuildContext context) => const MapSample(),
  '/permission': (BuildContext context) => NewAskeForPermission(),
  '/profile': (BuildContext context) => const ProfileScreen(),
  '/upload-prescription': (BuildContext context) => const UploadPrescriptionScreen()
};
