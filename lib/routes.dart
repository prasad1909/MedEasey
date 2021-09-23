import 'package:flutter/material.dart';
import 'screens/success_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/products.dart';
import 'screens/profile_screen.dart';
import 'screens/upload_prescription.dart';
import 'screens/splash_screen.dart';
import 'screens/register_page.dart';
import 'screens/login.dart';
import 'screens/homepage.dart';
import 'permission/location_permission.dart';

final routes = {
  '/': (BuildContext context) => const SplashScreen(),
  '/home': (BuildContext context) => const HomePage(),
  '/register': (BuildContext context) => const Register(),
  '/login': (BuildContext context) => const Login(),
  '/cart': (BuildContext context) => const CartScreen(),
  '/permission': (BuildContext context) => NewAskeForPermission(),
  '/profile': (BuildContext context) => const ProfileScreen(),
  '/orders': (BuildContext context) => const OrderScreen(),
  '/success': (BuildContext context) => const SuccessScreen(),
  '/products': (BuildContext context) => Products(productList: ModalRoute.of(context)!.settings.arguments),
  '/upload-prescription': (BuildContext context) => const UploadPrescriptionScreen(),
  '/checkout': (BuildContext context) => CheckoutScreen(ModalRoute.of(context)!.settings.arguments),
};
