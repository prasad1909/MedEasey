import 'package:flutter/material.dart';
import '../../utils/app_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    nextPage();
  }

  nextPage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('firstOpen')) {
      Future.delayed(
          const Duration(seconds: 3),
          () => Navigator.pushNamedAndRemoveUntil(
              context, '/home', (route) => false));
    } else {
      await _prefs.setBool('firstOpen', true);
      Future.delayed(
          const Duration(seconds: 10),
          () => Navigator.pushNamedAndRemoveUntil(
              context, '/permission', (route) => false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            color: Colors.white,
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(110),
                  child: Image.asset(
                    "assets/images/Logo.png",
                    width: 160,
                  ),
                ),
                const Text(
                  "MedEasey",
                  style: TextStyle(fontSize: 50),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Think Medicines? Think Medeasey",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 50,
                ),
                const AppLoader(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
