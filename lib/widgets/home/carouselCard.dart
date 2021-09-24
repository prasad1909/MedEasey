import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {

  final url, title;
  CarouselCard(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),

        child:Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: Image.network(this.url, fit: BoxFit.cover,),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                this.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]));
  }
}
