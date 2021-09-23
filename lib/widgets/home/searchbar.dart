import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      child: TextField(
        decoration: new InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIcon: Icon(Icons.search),
          focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.white, width: 5.0),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(20),
          ),

          hintText: 'Search',
          hintStyle: TextStyle(
            color: Colors.teal,

          ),
        ),
      ),
    );
  }
}
