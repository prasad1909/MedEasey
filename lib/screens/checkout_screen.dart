import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:getwidget/getwidget.dart';
import 'package:med_easey/widgets/common/appbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutScreen extends StatefulWidget {
  final price;
  const CheckoutScreen(this.price, {Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _razorpay = Razorpay();
  final user = FirebaseAuth.instance.currentUser;
  var products = {};
  int price = 0;
  String street = '';
  String sub = '';
  String city = '';
  String pin = '';
  String address = '';
  bool isEditing = false;
  int paymentValue = 0;
  var addressController = TextEditingController();

  @override
  void initState() {
    getLocation();
    getItems();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future getItems() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final keys = preferences.getKeys().toList();
    var items = {};
    for (var i = 0; i < keys.length; i++) {
      if (keys[i] != 'latitude' &&
          keys[i] != 'longitude' &&
          keys[i] != 'firstOpen') {
        int? q = preferences.getInt(keys[i]);
        items[keys[i]] = q;
      }
    }
    setState(() {
      products = items;
    });
  }

  Future clearCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final keys = preferences.getKeys().toList();

    for (var i = 0; i < keys.length; i++) {
      if (keys[i] != 'latitude' &&
          keys[i] != 'longitude' &&
          keys[i] != 'firstOpen') {
        await preferences.remove(keys[i]);
      }
    }
  }

  Future getLocation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var latitude = preferences.getDouble('latitude');
    var longitude = preferences.getDouble('longitude');

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude!, longitude!);

    setState(() {
      street = placemarks[0].street!;
      sub = placemarks[0].subAdministrativeArea!;
      city = placemarks[0].locality!;
      pin = placemarks[0].postalCode!;
      address = street + '\n' + sub + '\n' + city + '\n' + pin;
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BasicAppbar(),
      body: Column(
          children: [
        SizedBox(
          height: MediaQuery.of(context).size.height/40,
        ),
        const Text('Location Details',
        textAlign: TextAlign.start,
        style: TextStyle(color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),),
        SizedBox(
          height: MediaQuery.of(context).size.height/100,
        ),
        Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width/1.2,
            height: MediaQuery.of(context).size.height/6,
            decoration: BoxDecoration(
              color:Colors.greenAccent.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/80,
                ),
                isEditing
                    ? Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: MediaQuery.of(context).size.height/7,
                    child: TextFormField(
                      autofocus: true,
                      style: TextStyle(fontSize: 20),
                        maxLines: 4,
                        controller: addressController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        )))
                    : Row(
                  children:[
                    SizedBox(width: MediaQuery.of(context).size.width/20,),
                    Text(address,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )
              ],
            )),
        Row(
          children:[
            SizedBox(width: MediaQuery.of(context).size.width/1.3,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(50, 50),
                  shape: const CircleBorder(),
                  elevation: 2.0,
                ),
                onPressed: () {
                  if (isEditing) {
                    setState(() {
                      address = addressController.text;
                      isEditing = false;
                    });
                  } else {
                    setState(() {
                      addressController.text = address;
                      isEditing = true;
                    });
                  }
                },
                child: isEditing
                //? const Text('Save Address')
                    ? const Icon(Icons.check, color: Colors.white,)
                    : const Icon(Icons.create_rounded, color: Colors.white,)),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height/100,
        ),
            const Text('Select Payment Mode',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),),
        SizedBox(
            height: MediaQuery.of(context).size.height/120
        ),
        Container(
            margin: const EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width/1.2,
            height: MediaQuery.of(context).size.height/8,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const SizedBox(
                  width: 10,
                ),
                GFRadio(
                  size: GFSize.SMALL,
                  value: 0,
                  groupValue: paymentValue,
                  onChanged: (int value) {
                    setState(() {
                      paymentValue = value;
                    });
                  },
                  inactiveIcon: null,
                  activeBorderColor: GFColors.SUCCESS,
                  radioColor: GFColors.SUCCESS,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text('Cash On Delivery', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),)
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                const SizedBox(
                  width: 10,
                ),
                GFRadio(
                  size: GFSize.SMALL,
                  value: 1,
                  groupValue: paymentValue,
                  onChanged: (int value) {
                    setState(() {
                      paymentValue = value;
                    });
                  },
                  inactiveIcon: null,
                  activeBorderColor: GFColors.SUCCESS,
                  radioColor: GFColors.SUCCESS,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text('RazorPay', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),)
              ]),
            ])),
            SizedBox(height: MediaQuery.of(context).size.height/5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/15,
                  ),
                  Text('₹ ${widget.price}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        fixedSize: Size(MediaQuery.of(context).size.width/1.7,
                            MediaQuery.of(context).size.height/15),
                        elevation: 2.0,
                      ),
                      onPressed: () async {
                        if (paymentValue == 1) {
                          _razorpay.open({
                            'key': 'rzp_test_VOOdqc5o5o3nF0',
                            'amount': widget.price * 100,
                            'name': 'MedEasey',
                            'description': 'Meds',
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {'email': user!.email},
                            'external': {
                              'wallets': ['paytm']
                            }
                          });
                        }
                        await FirebaseFirestore.instance
                            .collection('orders')
                            .add({'uid': user!.uid, 'items': products, 'paymentType': paymentValue, 'address': address, 'price': widget.price, 'time': DateTime.now().millisecondsSinceEpoch});
                        await clearCart();
                        Navigator.popAndPushNamed(context, '/intermediate');
                      },
                      child: const Text('Continue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/15,
                  ),
                ],
              ),
            SizedBox(height: MediaQuery.of(context).size.height/30),
            ],
        ),
    );
  }
}
