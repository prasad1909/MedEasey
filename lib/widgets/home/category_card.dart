import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imgUrl;
  final List productsList;

  const CategoryCard({Key? key, required this.title, required this.imgUrl, required this.productsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/products', arguments: productsList);
        },
        child: SizedBox(
          width: 200,
          height: 120,
          child: Stack(children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(imgUrl, fit: BoxFit.cover, width: 1000.0),
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ]),
        ));
  }
}
