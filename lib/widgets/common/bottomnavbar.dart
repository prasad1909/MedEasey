import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_easey/utils/popup.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  const BottomNavBar(this.index, {Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.index,
      backgroundColor: colorScheme.surface,
      selectedItemColor: Colors.blue.shade700,
      unselectedItemColor: Colors.lightBlue.shade500,
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
        // BottomNavigationBarItem(
        //   label: 'Accounts',
        //   icon: Icon(Icons.account_circle_rounded),
        // ),
      ],
    );
  }
}
