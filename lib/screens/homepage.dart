import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import '../widgets/home/categories.dart';
import '../widgets/common/bottomnavbar.dart';
import '../widgets/common/appbar.dart';
import '../widgets/common/appdrawer.dart';
import '../widgets/home/carousel.dart';
import '../widgets/home/centerbox.dart';
import '../widgets/home/searchbar.dart';
import '../widgets/home/centerheader.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const BasicAppbar(),
      drawer: AppDrawer(),
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
                CenterBox("Previous \nOrders", "Repeat Order", "Book Now"),
                GestureDetector(
                  onTap: () {
                    FlutterWebBrowser.openWebPage(
                      url: "https://selfregistration.cowin.gov.in/",
                    );
                  },
                  child: CenterBox("Covid \nVaccination", "#GetJabbed",
                      "Book Your \nSlot Now"),
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
