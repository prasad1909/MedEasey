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
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text('Total ₹${widget.price}')
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
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
                    Navigator.popAndPushNamed(context, '/success');
                  },
                  child: const Text('Continue'))
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Location Details'),
        const SizedBox(
          height: 10,
        ),
        Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                isEditing
                    ? SizedBox(
                        height: 120,
                        child: TextFormField(
                            maxLines: 4,
                            controller: addressController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            )))
                    : Text(address),
              ],
            )),
        ElevatedButton(
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
                ? const Text('Save Address')
                : const Text('Edit Address')),
        const SizedBox(
          height: 20,
        ),
        const Text('Select Payment'),
        const SizedBox(
          height: 10,
        ),
        Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.12,
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
                const Text('Cash On Delivery')
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
                const Text('RazorPay')
              ]),
            ]))
      ]),
    );
  }
}
