

//import 'package:imei_plugin/imei_plugin.dart';
import 'dart:async';

import 'package:android_multiple_identifier/android_multiple_identifier.dart';


class PhoneUtility {

//  String getIMEI() async{
//
//    var imei = await ImeiPlugin.getImei();
//    var uuid = await ImeiPlugin.getId();
//  }
  static Future<String> getIMEI() async {
   await AndroidMultipleIdentifier.requestPermission();
    String      imei = await AndroidMultipleIdentifier.imeiCode;

    return imei.toString();
  }

  static Future<String> getId() async {
    String device_id = await AndroidMultipleIdentifier.androidID;
        return device_id.toString();
  }
  static Future<String> getSerialCode() async{
    String  se= await AndroidMultipleIdentifier.serialCode;
    return se.toString();
  }
}