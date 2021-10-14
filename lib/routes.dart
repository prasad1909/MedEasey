import 'package:flutter/material.dart';
import 'package:med_easey/screens/forgot_password.dart';
import 'screens/phone_register.dart';
import 'screens/search_screen.dart';
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
import 'screens/intermediate.dart';
import 'screens/about_us.dart';

final routes = {
  '/': (BuildContext context) => const SplashScreen(),
  '/home': (BuildContext context) => HomePage(),
  '/register': (BuildContext context) => const Register(),
  '/login': (BuildContext context) => const Login(),
  '/cart': (BuildContext context) => const CartScreen(),
  '/permission': (BuildContext context) => const NewAskeForPermission(),
  '/profile': (BuildContext context) => const ProfileScreen(),
  '/orders': (BuildContext context) => const OrderScreen(),
  '/search': (BuildContext context) => const SearchScreen(),
  '/success': (BuildContext context) => const SuccessScreen(),
  '/products': (BuildContext context) => Products(productList: ModalRoute.of(context)!.settings.arguments),
  '/upload-prescription': (BuildContext context) => const UploadPrescriptionScreen(),
  '/phone': (BuildContext context) => const PhoneRegisterScreen(), 
  '/checkout': (BuildContext context) => CheckoutScreen(int.parse(ModalRoute.of(context)!.settings.arguments.toString())),
  '/intermediate': (BuildContext context) => const Intermediate(),
  '/aboutus': (BuildContext context) => const AboutUs(),
  '/forgot': (BuildContext context) => const ForgotPassword(),
};
