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
                          Text(this.header,  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10,height: 40,),
                      Text(this.title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(
                          0xF3260247))),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10,height: 40,),
                      Text(this.subtitle, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.black)),
                      Icon(Icons.arrow_forward, color: Color(0xF3551490),),

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
                  Color(0xFF3EFFC8),
                  Color(0xFF19B675),
                ],
              ),
            ),);
  }
}
