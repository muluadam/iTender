import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyWidgets {
      static Future<bool> showGreenToast(String message ){
        return Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            backgroundColor: Colors.green[300],
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      static Future<bool> showRedToast(String message ){
        return Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIos: 1,
            backgroundColor: Colors.red[100],
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
}