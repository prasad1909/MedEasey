import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/search');
        },
        child: Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width / 1.1,
          height: MediaQuery.of(context).size.height / 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all()
            ),
          child: Row(
            children: [
              const SizedBox(width: 10,),
              const Text('Search', style: TextStyle(color: Colors.teal),),
              SizedBox(width: MediaQuery.of(context).size.width * 0.65),
              const Icon(Icons.search),
            ],
          ),
            ),
        );
  }
}
