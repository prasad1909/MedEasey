import 'package:flutter/material.dart';
import 'package:med_easey/widgets/common/appbar.dart';
import 'package:med_easey/widgets/common/appdrawer.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      drawer: const AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Your Order has been placed Successfully'),
          const Text('You can track your order details'),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/orders');
              },
              child: const Text('Your Orders'))
        ],
      ),
    );
  }
}
