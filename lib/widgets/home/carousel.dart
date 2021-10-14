import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'carousel_card.dart';

class CarouselDemo extends StatefulWidget {
  const CarouselDemo({Key? key}) : super(key: key);

  @override
  State<CarouselDemo> createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {

  @override
  void initState() {
    readJson();
    super.initState();
  }

  List covid = [];
  List devices = [];
  List nutriton = [];
  List personal = [];
  List daily = [];

  Future<void> readJson() async {
    var a = [];
    var b = [];
    var c = [];
    var d = [];
    var e = [];
    final String response =
    await rootBundle.loadString('assets/data/FinalData.json');
    final data = await json.decode(response);
    for (var i = 0; i < data.length; i++) {
      if (data[i]['Category'] == 'Covid Essentials') {
        a.add(data[i]);
      } else if (data[i]['Category'] == 'Personal Care') {
        b.add(data[i]);
      } else if (data[i]['Category'] == 'General Medication') {
        c.add(data[i]);
      } else if (data[i]['Category'] == 'Nutrition & Fitness Suppliments') {
        d.add(data[i]);
      } else {
        e.add(data[i]);
      }
    }
    setState(() {
      covid = a;
      personal = b;
      daily = c;
      nutriton = d;
      devices = e;
    });
  }

  final List<String> imageList = [
  "https://images.unsplash.com/photo-1557683316-973673baf926?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2329&q=80",
  "https://images.unsplash.com/photo-1521449256184-170b4a4c437c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2369&q=80",
  "https://images.unsplash.com/photo-1557682250-33bd709cbe85?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2329&q=80",
  "https://images.unsplash.com/photo-1557682250-33bd709cbe85?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2329&q=80",
  "https://images.unsplash.com/photo-1614852206732-6728910dc175?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80"
  // "https://images.unsplash.com/photo-1557682260-96773eb01377?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2329&q=80"
];

  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      autoPlay: true,
      enlargeMainPage: true,
      pagination: true,
      pagerSize: 8,
      autoPlayAnimationDuration: const Duration(milliseconds: 700),
      activeIndicator: Colors.greenAccent.shade200,
      passiveIndicator: Colors.white,
      items: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/products', arguments: covid);
          },
            child: CarouselCard(imageList[0], 'Safegaurd yourself\nfrom Corona Virus'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/products', arguments: devices);
          },
          child: CarouselCard(imageList[1], 'Track your health\nregularly'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/products', arguments: nutriton);
          },
          child: CarouselCard(imageList[2], 'Eat Good or\nDie Bad'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/products', arguments: personal);
          },
          child: CarouselCard(imageList[3], 'Defining Beauty\nDefining You'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/products', arguments: daily);
          },
          child: CarouselCard(imageList[4], 'Pain Pain\nGo Away'),
        ),
      ],
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
