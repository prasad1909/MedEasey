import 'dart:math';
import 'package:flutter/material.dart';
import '../../utils/app_loader.dart';

class Intermediate extends StatefulWidget {
  const Intermediate({Key? key}) : super(key: key);
  @override
  _IntermediateState createState() => _IntermediateState();
}

class _IntermediateState extends State<Intermediate> {
  @override
  void initState() {
    super.initState();
    nextPage();
    nextText();
  }

  String text='Finding nearest pharmacy';

  nextPage() async {
    Future.delayed(
        const Duration(seconds: 10),
            () => Navigator.pushNamedAndRemoveUntil(
            context, '/success', (route) => false));
  }

  nextText() {
    var rng = Random();
    var num = rng.nextInt(6)+2;
    Future.delayed(
        const Duration(seconds: 5),
        () => setState(() {
          text = 'Found $num pharmacies near you.' ;
        }));
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
                    "assets/images/Shop.jpg",
                    width: 160,
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  height: 10,
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
