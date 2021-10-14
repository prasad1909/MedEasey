import 'package:flutter/material.dart';

class CenterBox extends StatelessWidget {
final String header;
final String title;
final String subtitle;
final String image;

 const CenterBox(
    this.header,
    this.title,
    this.subtitle,
    this.image, {Key? key}
    ) : super(key: key);


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
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFF37F3F3),
                      image: DecorationImage(image:  AssetImage(image),),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10,),
                      Column(

                        children: [
                          Text(header,  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10,height: 40,),
                      Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(
                          0xF3260247))),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10,height: 40,),
                      Text(subtitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.black)),
                      const Icon(Icons.arrow_forward, color: Color(0xF3551490),),

                    ],
                  ),
                ],
              ),
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors:[
                  Color(0xFF3EFFC8),
                  Color(0xFF2094CD),
                ],
              ),
            ),);
  }
}
