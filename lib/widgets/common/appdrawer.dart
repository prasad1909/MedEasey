import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    if (user != null) {
      getUser();
    }
    super.initState();
  }

  bool isLoggedin = false;
  var userData;

  Future getUser() async {
    final userCred = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: user!.uid)
        .get();
    userData = userCred.docs.single.data();
    setState(() {
      isLoggedin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xFF09ECC3),
        //This will change the drawer background to blue.
        //other styles
      ),
      child: Drawer(
        child: isLoggedin
            ? ListView(
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                        radius: 20, 
                        backgroundColor: const Color(0xF352FFE2),
                        child: ClipOval(child: userData['profilePic'] != null ? Image.network(userData['profilePic']) : Image.asset('assets/images/Logo.png', )),)
                  ),
                  const SizedBox(
                    height: 22,
                    width: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Hey, ${userData['username']}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                    child: Text(
                      userData['signin'] == 'phone' ? userData['phone'] : userData['email'],
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ListTile(
                    tileColor: const Color(0xF352FFE2),
                    title: const Text('Your Orders'),
                    trailing: const Icon(
                      Icons.add_to_home_screen,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    tileColor: Colors.lightBlueAccent,
                    title: const Text('About Us'),
                    trailing: const Icon(
                      Icons.login_rounded,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  ListTile(
                    tileColor: const Color(0xF352FFE2),
                    title: const Text('Contact Us'),
                    trailing: const Icon(
                      Icons.payment_rounded,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    tileColor: Colors.lightBlueAccent,
                    title: const Text('Logout'),
                    trailing: const Icon(
                      Icons.logout_rounded,
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            : ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: SizedBox(
                              height: 40,
                              width: 240,
                              child: ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  elevation: 3,
                                ),
                                onPressed: () {
                                Navigator.pushNamed(context, '/login',);
                              },
                               child: const Text('Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
                              ),
                            ),
                          ),
                        ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Text('Kindly Login To See All Features', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black45),),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
