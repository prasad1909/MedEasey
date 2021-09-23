import 'package:flutter/material.dart';
import '../../screens/login.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF01D2A1),
                Color(0xFF55EF9C),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 150, 10),
          child: Text(
            "MedEasey",
            style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                color: Colors.black.withRed(1)),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                child: const Icon(
                  Icons.shopping_cart_rounded,
                  size: 26.0,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/cart');
                })),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
