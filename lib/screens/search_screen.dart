import 'dart:convert';

import 'package:med_easey/widgets/product/product_card.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_easey/widgets/common/appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List namelist = [];
  List productList = [];
  String queryValue = '';
  @override
  void initState() {
    getList();
    super.initState();
  }

  Future getList() async {
    List l = [];
    final String response =
        await rootBundle.loadString('assets/data/FinalData.json');
    final data = await json.decode(response);
    for (var i = 0; i < data.length; i++) {
      if (!l.contains(data[i]['Brand Name'])) {
        l.add(data[i]['Brand Name']);
      }
      if (!l.contains(data[i]['Generic Name'])) {
        l.add(data[i]['Generic Name']);
      }
    }
    setState(() {
      namelist = l;
      productList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BasicAppbar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 16,
                  child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          queryValue = value;
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: const Icon(Icons.search),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 5.0),
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          color: Colors.teal,
                        ),
                      ))),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (StringSimilarity.compareTwoStrings(
                          namelist[index].toLowerCase(),
                          queryValue.toLowerCase()) >
                      0.5) {
                    try {
                      var product = {};
                      try {
                        product = productList.firstWhere(
                            (e) => e['Brand Name'] == namelist[index]);
                      } catch (e) {
                        product = productList.firstWhere(
                            (e) => e['Generic Name'] == namelist[index]);
                      }
                      return ProductCard(
                          product['Brand Name'], product['Price'], product['Image Name']);
                    } catch (e) {
                      return const SizedBox();
                    }
                  }
                  return const SizedBox();
                },
                itemCount: namelist.length,
              )
            ],
          ),
        ));
  }
}
