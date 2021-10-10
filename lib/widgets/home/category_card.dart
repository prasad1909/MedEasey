import 'package:flutter/material.dart';

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
              child: Image.asset('assets/Products/$imgUrl', width: 200, height: 120,),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                    )
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
