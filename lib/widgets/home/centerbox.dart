import 'package:flutter/material.dart';

class CenterBox extends StatelessWidget {
final header;
final title;
final subtitle;

CenterBox(
    this.header,
    this.title,
    this.subtitle
    );


  @override
  Widget build(BuildContext context) {
    return Container(
            width: 150,
            height: 225,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Column(

                        children: [
                          Text(this.header,  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10,height: 40,),
                      Text(this.title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10,height: 40,),
                      Text(this.subtitle, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.yellow)),
                      Icon(Icons.arrow_forward, color: Colors.yellow,),

                    ],
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors:[
                  Colors.deepPurpleAccent.shade700,
                  Colors.deepPurpleAccent.shade200,
                ],
              ),
            ),);
  }
}
