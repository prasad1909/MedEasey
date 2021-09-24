import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:med_easey/utils/popup.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  const BottomNavBar(this.index, {Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.index,
      backgroundColor: colorScheme.surface,
      selectedItemColor: Colors.green.shade700,
      unselectedItemColor: Colors.teal,
      selectedLabelStyle: textTheme.caption,
      unselectedLabelStyle: textTheme.caption,
      onTap: (value) {
        if (widget.index != value) {
          if (value == 0) {
            Navigator.popAndPushNamed(context, '/home');
          } else if (value == 1) {
            if (widget.index != 0) {
              Navigator.popAndPushNamed(context, '/upload-prescription');
            } else {
              Navigator.pushNamed(context, '/upload-prescription');
            }
          } else if (value == 2) {
            if (user != null) {
              if (widget.index != 0) {
                Navigator.popAndPushNamed(context, '/orders');
              } else {
                Navigator.pushNamed(context, '/orders');
              }
            } else {
              popUp('Kindly Login to proceed');
            }
          } else if (value == 3) {
            if (user != null) {
              if (widget.index != 0) {
                Navigator.popAndPushNamed(context, '/profile');
              } else {
                Navigator.pushNamed(context, '/profile');
              }
            } else {
              popUp('Kindly Login to proceed');
            }
          }
        }
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Scanner',
          icon: Icon(Icons.document_scanner_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Orders',
          icon: Icon(Icons.shopping_bag_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Accounts',
          icon: Icon(Icons.account_circle_rounded),
        ),
      ],
    );
  }
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    textTheme: _buildShrineTextTheme(base.textTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
