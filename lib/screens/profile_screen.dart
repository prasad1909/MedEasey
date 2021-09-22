import 'package:flutter/material.dart';
import '../widgets/profile/body.dart';
import '../widgets/common/bottomnavbar.dart';
import '../widgets/common/appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: Body(),
      bottomNavigationBar: const BottomNavBar(3),
    );
  }
}
