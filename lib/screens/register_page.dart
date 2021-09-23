import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();

  Future googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

// Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

// Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

// Once signed in, return the UserCredential
    final userCred =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final userInFirestore = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: userCred.user!.uid)
        .get();

    if (userInFirestore.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('users').add({
        'username': userCred.user!.displayName,
        'uid': userCred.user!.uid,
        'email': userCred.user!.email,
        'signin': 'google',
        'profilePic': userCred.user!.photoURL,
      });
    }

    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: formKey,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade600,
                    Colors.white70,
                  ],
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(children: const [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Register',
                        style: TextStyle(fontSize: 40),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    const Text(
                      'Register with one the following options',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Row(children: [
                      const SizedBox(
                        width: 40,
                      ),
                      SizedBox(
                          width: 150,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              googleSignIn();
                            },
                            child: Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                                fit: BoxFit.cover),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 150,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.call,
                              size: 45,
                              color: Colors.blue,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )),
                    ]),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 15.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.account_circle_rounded,
                              size: 35,
                            ),
                            labelText: 'Enter Username',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 15.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              size: 35,
                            ),
                            labelText: 'Enter Email',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill out this field';
                          }
                        },
                        controller: password,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 15.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                )),
                            prefixIcon: Icon(
                              Icons.vpn_key_outlined,
                              size: 35,
                            ),
                            labelText: 'Enter Password',
                            labelStyle: TextStyle(color: Colors.black)),
                        obscureText: true,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please fill out this field';
                          }
                        },
                        controller: password,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 15.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                )),
                            prefixIcon: Icon(
                              Icons.vpn_key_outlined,
                              size: 35,
                            ),
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Colors.black)),
                        obscureText: true,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text);
                                Navigator.pushNamed(context, '/');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            }
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already Have an Account? ',
                            style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Login',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
