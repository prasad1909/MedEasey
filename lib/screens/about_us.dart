import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_easey/widgets/common/bottomnavbar.dart';
import '../widgets/common/appbar.dart';
import '../widgets/common/appdrawer.dart';
import '../widgets/common/bottomnavbar.dart';

class AboutUs extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: const BasicAppbar(),
        drawer: AppDrawer(),
        bottomNavigationBar: const BottomNavBar(0),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 310,
                  height: 125,
                  decoration: BoxDecoration(
                      color: Color(0xFF80FFFF),
                      border: Border.all(
                        width: 1,
                        color: Colors.teal,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Row(
                    children: [ Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:15),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text("Prasad Iyer",
                              style: TextStyle(color: Colors.teal,
                                  fontSize: 21, fontWeight: FontWeight.bold),
                              textDirection: TextDirection.ltr,),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text("Backend Developer",
                              style: TextStyle(
                                color: Colors.teal.shade400,
                                fontSize: 18.0,
                              ),),
                          ],
                        ),
                        SizedBox(height: 8,width: 8),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            CircleAvatar(
                              backgroundColor: Colors.teal,
                              radius: 12,
                              child: Icon(
                                Icons.email_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'prasadiyer12345@gmail.com',
                              style: TextStyle(
                                color: Colors.teal.shade700,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),],
                    ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(width: 12,),
                      Column(
                        children: [
                          SizedBox(height: 30,),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            backgroundImage: AssetImage('assets/images/prasad.jpeg'),
                          )
                        ],
                      ),],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),

                Container(
                  width: 310,
                  height: 125,
                  decoration: BoxDecoration(
                      color: Color(0xFF80FFFB),
                      border: Border.all(
                        width: 1,
                        color: Colors.teal,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Row(
                    children: [ Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:15),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text("Prithvi Jadwani",
                              style: TextStyle(color: Colors.teal,
                                  fontSize: 21, fontWeight: FontWeight.bold),
                              textDirection: TextDirection.ltr,),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text("Frontend Developer",
                              style: TextStyle(
                                color: Colors.teal.shade400,
                                fontSize: 18.0,
                              ),),
                          ],
                        ),
                        SizedBox(height: 8,width: 8),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            CircleAvatar(
                              backgroundColor: Colors.teal,
                              radius: 12,
                              child: Icon(
                                Icons.email_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'prithvijadwani71@gmail.com',
                              style: TextStyle(
                                color: Colors.teal.shade700,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),],
                    ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(width: 12,),
                      Column(
                        children: [
                          SizedBox(height: 30,),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            backgroundImage: AssetImage('assets/images/prithvi.jpeg'),
                          )
                        ],
                      ),],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),

                Container(
                  width: 310,
                  height: 125,
                  decoration: BoxDecoration(
                      color: Color(0xFF80FFFB),
                      border: Border.all(
                        width: 1,
                        color: Colors.teal,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Row(
                    children: [ Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:15),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text("Aanchal Jogeshwar",
                              style: TextStyle(color: Colors.teal,
                                  fontSize: 21, fontWeight: FontWeight.bold),
                              textDirection: TextDirection.ltr,),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text("Design",
                              style: TextStyle(
                                color: Colors.teal.shade400,
                                fontSize: 18.0,
                              ),),
                          ],
                        ),
                        SizedBox(height: 8,width: 8),
                        Row(
                          children: [
                            SizedBox(width: 20,),
                            CircleAvatar(
                              backgroundColor: Colors.teal,
                              radius: 12,
                              child: Icon(
                                Icons.email_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              'aanchal123@gmail.com',
                              style: TextStyle(
                                color: Colors.teal.shade700,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),],
                    ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(width: 12,),
                      Column(
                        children: [
                          SizedBox(height: 30,),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            backgroundImage: AssetImage('assets/images/image.png'),
                          )
                        ],
                      ),],
                  ),
                ),
              ],
            ),

          ),
        )
    );
  }
}
