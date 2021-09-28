import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:med_easey/utils/popup.dart';
import '../widgets/home/categories.dart';
import '../widgets/common/bottomnavbar.dart';
import '../widgets/common/appbar.dart';
import '../widgets/common/appdrawer.dart';
import '../widgets/home/carousel.dart';
import '../widgets/home/centerbox.dart';
import '../widgets/home/searchbar.dart';
import '../widgets/home/centerheader.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const BasicAppbar(),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SearchBar(),
            const SizedBox(
              height: 20,
            ),
            const CarouselDemo(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      if (user == null) {
                        popUp('Kindly Login to continue');
                      } else {
                        Navigator.pushNamed(context, '/orders');
                      }
                    },
                    child: CenterBox("Previous \nOrders", "Repeat Order",
                        "Book Now", "assets/images/orderagain.png")),
                GestureDetector(
                  onTap: () {
                    FlutterWebBrowser.openWebPage(
                      url: "https://selfregistration.cowin.gov.in/",
                    );
                  },
                  child: CenterBox("Covid \nVaccination", "#GetJabbed",
                      "Book Your \nSlot Now", "assets/images/vaccine2.png"),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CenterHeader(),
            const Categories(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(0),
    );
  }
}
