import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';

class CarouselDemo extends StatefulWidget {
  const CarouselDemo({Key? key}) : super(key: key);

  @override
  State<CarouselDemo> createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {

  final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg"
];
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      autoPlay: true,
      enlargeMainPage: true,
      pagination: true,
      activeIndicator: Colors.pink,
      passiveIndicator: Colors.white,
      items: imageList.map(
        (url) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
            ),
          );
        },
      ).toList(),
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
