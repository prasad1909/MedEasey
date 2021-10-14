import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {

  final String url, title;
  const CarouselCard(this.url, this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),

        child:Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Image.network(url, fit: BoxFit.cover,),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]));
  }
}
