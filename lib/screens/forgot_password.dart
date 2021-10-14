import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_easey/utils/popup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final email = TextEditingController();
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
                          'Forgot Password?',
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
                          controller: email,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: (BorderSide(
                                    color: Colors.red, width: 15.0)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                size: 25,
                              ),
                              labelText: 'Enter Email',
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
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email.text);
                              popUp('Any email has been sent to you');
                              Navigator.pop(context);
                            } catch (e) {
                              popUp('Something went wrong, please try again');
                            }
                          },
                          child: const Text('Send Email'))
                    ]))));
  }
}
