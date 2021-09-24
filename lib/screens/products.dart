import 'package:flutter/material.dart';
import '../widgets/product/product_card.dart';
import '../widgets/common/appbar.dart';

class Products extends StatelessWidget {
  final productList;
  const Products({Key? key, required this.productList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppbar(),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var category = productList[index]['Category'];
            var imageName;
            if (category == 'Covid Essentials') {
              imageName = (index + 1).toString() + 'CE.png';
            } else if (category == 'Personal Care') {
              imageName = (index + 1).toString() + 'PC.png';
            } else if (category == 'General Medication') {
              imageName = (index + 1).toString() + 'GM.png';
            } else if (category == 'Medical Devices') {
              imageName = (index + 1).toString() + 'MD.png';
            } else {
              imageName = (index + 1).toString() + 'NS.png';
            }
            return ProductCard(
                productList[index]['Brand Name'],
                productList[index]['Price'],
                imageName);
          },
          itemCount: productList.length,
        ));
  }
}
