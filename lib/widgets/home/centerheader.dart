import 'package:flutter/material.dart';

class CenterHeader extends StatelessWidget {
  const CenterHeader({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(22,0,22,0),
        child: Row(
          children: [
            Expanded(

              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 30, 20),
                child: Row(
                  children: [
                    Expanded(

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [

                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 40, 10),
                                child: const Text(
                                  'Shop By Category',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        ));
  }
}
