import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.1,
      height: MediaQuery.of(context).size.height/16,
      child: TextField(
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: Icon(Icons.search),
          focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.white, width: 5.0),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(15),
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
