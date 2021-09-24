import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

popUp(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 4,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
  );
}