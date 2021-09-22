import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imgUrl;
  const CategoryCard({Key? key, required this.title, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 120,
      child: Stack(children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              width: 1000.0),
        ),
        Text(title,
          style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ]),
    );
  }
}
