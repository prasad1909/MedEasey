import 'package:flutter/material.dart';

import 'loader/color_loader_4.dart';
import 'loader/dot_type.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ColorLoader4(
          dotOneColor: Colors.red,
          dotTwoColor: Colors.deepOrange,
          dotThreeColor: Colors.deepOrangeAccent,
          dotType: DotType.circle,
          duration: Duration(seconds: 1)),
    );
  }
}