import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_easey/utils/popup.dart';

class PhoneRegisterScreen extends StatefulWidget {
  const PhoneRegisterScreen({Key? key}) : super(key: key);

  @override
  _PhoneRegisterScreenState createState() => _PhoneRegisterScreenState();
}

class _PhoneRegisterScreenState extends State<PhoneRegisterScreen> {
  final phone = TextEditingController();
  final otp = TextEditingController();
  final username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.greenAccent.shade100,
                    Colors.white70,
                  ],
                )),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Row(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                        const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ]),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height / 15,
                        child: TextFormField(
                          controller: username,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: (BorderSide(
                                    color: Colors.red, width: 15.0)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.account_circle_rounded,
                                size: 25,
                              ),
                              labelText: 'Enter Username',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height / 15,
                        child: TextFormField(
                          controller: phone,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: (BorderSide(
                                    color: Colors.red, width: 15.0)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.phone,
                                size: 25,
                              ),
                              labelText: 'Enter Phone Number',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: phone.text,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {
                                FirebaseAuth.instance
                                    .signInWithCredential(credential);
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                if (e.code == 'invalid-phone-number') {
                                  popUp('Invalid Phone Number');
                                }
                              },
                              codeSent: (String verificationId,
                                  int? forceResendingToken) {
                                //show dialog to take input from the user
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => AlertDialog(
                                          title: const Text("Enter OTP"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              TextField(
                                                controller: otp,
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.redAccent
                                              ),
                                              child: const Text("Submit", style: TextStyle(color: Colors.white),),
                                              onPressed: () async {
                                                var smsCode = otp.text.trim();

                                                var _credential =
                                                    PhoneAuthProvider
                                                        .credential(
                                                            verificationId:
                                                                verificationId,
                                                            smsCode: smsCode);

                                                final userCred =
                                                    await FirebaseAuth.instance
                                                        .signInWithCredential(
                                                            _credential);

                                                final userInFirestore =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .where('uid',
                                                            isEqualTo: userCred
                                                                .user!.uid)
                                                        .get();

                                                if (userInFirestore
                                                    .docs.isEmpty) {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .add({
                                                    'signin': 'phone',
                                                    'username': username.text,
                                                    'uid': userCred.user!.uid,
                                                    'phone': phone.text
                                                  });
                                                }
                                                Navigator.pushNamed(
                                                    context, '/home');
                                              },
                                            )
                                          ],
                                        ));
                              },
                              timeout: const Duration(seconds: 120),
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          },
                          child: const Text('Register'))
                    ]))));
  }
}
