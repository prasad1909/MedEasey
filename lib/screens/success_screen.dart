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
      body: Padding(
        padding: const EdgeInsets.all(55.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Your Order Has Been Placed',style: TextStyle(fontSize: 20), ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Successfully',style: TextStyle(fontSize: 20),),
                Icon(Icons.assignment_turned_in_rounded, color: Colors.tealAccent.shade700,),
              ],
            ), SizedBox(
              width: 20,
              height: 20,
            ),
            const Text('Track Your Order Details Below',style: TextStyle(fontSize: 15),),
            Icon(Icons.arrow_downward_outlined),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.tealAccent.shade700)
              ),
                onPressed: () {
                  Navigator.pushNamed(context, '/orders');
                },
                child: const Text('Your Orders',style: TextStyle(fontSize: 16),),

            )
          ],
        ),
      ),
    );
  }
}
