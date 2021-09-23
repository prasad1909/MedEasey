import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/common/appbar.dart';
import '../widgets/product/product_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    call();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;
  List products = [];
  int total = 0;
  var prices = {};

  Future call() async {
    await getItems();
    await calculateTotal();
  }

  Future getItems() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final keys = preferences.getKeys().toList();
    final String response =
        await rootBundle.loadString('assets/data/dummy.json');
    final data = await json.decode(response);
    List items = [];
    var p = {};
    for (var i = 0; i < keys.length; i++) {
      if (keys[i] != 'latitude' &&
          keys[i] != 'longitude' &&
          keys[i] != 'firstOpen') {
        var item = data.firstWhere((e) => e['Brand Name'] == keys[i]);
        items.add(item);
        p[item['Brand Name']] = item['Price'];
      }
    }
    setState(() {
      products = items;
      prices = p;
    });
  }

  Future calculateTotal() async {
    int t = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final keys = preferences.getKeys().toList();
    for (var i = 0; i < keys.length; i++) {
      if (keys[i] != 'latitude' &&
          keys[i] != 'longitude' &&
          keys[i] != 'firstOpen') {
        int? quantity = preferences.getInt(keys[i]);
        t += int.parse((quantity! * prices[keys[i]]).toString());
      }
    }
    setState(() {
      total = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
        appBar: const BasicAppbar(),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                     shrinkWrap: true,
                     itemBuilder: (BuildContext context, int index) {
                       return ProductCard(
                        products[index]['Brand Name'],
                        products[index]['Price'],
                        products[index]['Source Image'],
                        callback: call);
                    },
                        itemCount: products.length,
                )),
                SizedBox(height: MediaQuery.of(context).size.height/50,),
                Positioned(
                  bottom: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Container(
                        height: 40,
                        width : MediaQuery.of(context).size.width/2.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text('₹ $total', style: TextStyle(fontSize:23, color: Colors.black, fontWeight: FontWeight.w300))),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/checkout',
                                arguments: total);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                            fixedSize: Size(MediaQuery.of(context).size.width/2.5, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                          child: const Text('Checkout  >', style: TextStyle(fontSize:21, color: Colors.black, fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/40,),
              ],
            ),
        ),);
  }
}
