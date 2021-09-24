import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_easey/widgets/common/appbar.dart';
import 'package:med_easey/widgets/common/bottomnavbar.dart';
import 'package:getwidget/getwidget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppbar(),
        bottomNavigationBar: BottomNavBar(2),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .where('uid', isEqualTo: user!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  var text = '';
                  print(document['items']);

                  var payment = document['paymentType'] == 0? 'Cash on Delivery':'RazorPay';
                  return Column(
                    children: [
                      const SizedBox(height: 10,),
                      GFAccordion(
                          title: 'Order Id : ' + document['time'].toString(),
                          content: 'Items : \nPrice: \t\t'+document['price'].toString()+'\nPayment Type : \t' + payment,
                      )
                    ],
                  );
                }).toList(),
              );
            }));
  }
}
