import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Uint8List imageBytes = Uint8List(0);
  bool isUploaded = false;
  final formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Register', style: TextStyle(fontSize: 30)),
                  const SizedBox(height: 30,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill out this field';
                        }
                      },
                      controller: username,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Username',
                          labelStyle: TextStyle(color: Colors.black)),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Email',
                          labelStyle: TextStyle(color: Colors.black)),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20,),
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
                          border: OutlineInputBorder(),
                          labelText: 'Enter Password',
                          labelStyle: TextStyle(color: Colors.black)),
                      obscureText: true,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      validator: (value) {
                        if (value != password.text) {
                          return 'Passwords don\'t match';
                        }
                      },
                      controller: password2,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.black)),
                      obscureText: true,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: isUploaded
                          ? Image.memory(
                              imageBytes,
                              height: 100,
                            )
                          : Container()),
                          const SizedBox(height: 20,),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          XFile? img = await _picker.pickImage(
                              source: ImageSource.gallery);
                          final imgBytes = await img!.readAsBytes();
                          setState(() {
                            imageBytes = imgBytes;
                            isUploaded = true;
                          });
                        },
                        child: const Text('Upload Profile Picture'),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            UserCredential userCred = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);

                            // await userCred.user!
                            //     .updateDisplayName(username.text);
                            final user = userCred.user;

                            print(userCred.user!.uid);
                            await FirebaseFirestore.instance
                                .collection('users')
                                .add({
                              'uid': user!.uid,
                              'email': email.text,
                              'username': username.text,
                            });
                            print(imageBytes.isNotEmpty);
                            if (imageBytes.isNotEmpty) {
                              final firebaseStorageRef = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child(email.text);
                              await firebaseStorageRef.putData(imageBytes,
                                  SettableMetadata(contentType: 'image/jpeg'));
                            }
                            Navigator.pushNamed(context, '/home');
                          }
                        },
                        child: const Text('Register'),
                      )),
                      const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already Have an Account? ',
                            style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 10,),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text('Login',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue.shade900,
                                  decoration: TextDecoration.underline)),
                        ),
                    ],
                  )
                ],
              ),
            )));
  }
}
