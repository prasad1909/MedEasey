import 'package:flutter/material.dart';
import 'category_card.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          SizedBox(width: 20,),
          CategoryCard(title: 'Covid Essentials', imgUrl: "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg"),
          SizedBox(width: 20,),
          CategoryCard(title: 'Medical Devices', imgUrl: "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg"),
          SizedBox(width: 20,),
          CategoryCard(title: 'Nutrition & Fitness Supplements', imgUrl: "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg"),
          SizedBox(width: 20,),
          CategoryCard(title: 'Personal Care', imgUrl: "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg"),
          SizedBox(width: 20,),
          CategoryCard(title: 'General Medication', imgUrl: "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg"),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}
