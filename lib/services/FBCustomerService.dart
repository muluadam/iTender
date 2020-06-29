import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:itenders/model/customer.dart';
import 'package:itenders/utils/DateUtility.dart';
import 'package:itenders/utils/FlutterIdGenerator.dart';
import 'package:itenders/utils/PasswordUtility.dart';
import 'package:itenders/utils/UrlNames.dart';

class FBCustomerService {
  static final _firestore = Firestore.instance;

  static Future<String> saveCustomer(String name, String org, String mobile,
      String imei, String ssn, String email, String password) async {
    var status = "error";
    var data = {
      "USER_FULL_NAME": name,
      "ORGANIZATION_NAME": org,
      "MOBILE": mobile,
      "IMEI": imei,
      "SSN": ssn,
      "EMAIL": email,
      "PASSWORD": await PasswordUtility.toSHA1(password),
      'REGISTRATION_DATE': await DateUtility.getCurrentTimeStamp(),
      'STATUS': 'new',
      'EXP_DATE': await DateUtility.getEXPDates(),
      'LAST_LOGIN': await DateUtility.getCurrentTimeStamp()
    };
    var newID = await FlutterIdGenerator.getID();
    await _firestore
        .collection('/customers')
        .document(newID)
        .setData(data)
        .then((doc) {
          status = newID.toString();
          print("doc save successful with ID=" + newID);
        })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          print("doc save error");
          print(error);
        });
    return status;
//_firestore.collection('/customers').document(await FlutterIdGenerator.getID()).setData({
//  "USER_FULL_NAME": name,
//  "ORGANIZATION_NAME": org,
//  "MOBILE": mobile,
//  "IMEI": imei,
//  "SSN": ssn,
//  "EMAIL": email,
//  "PASSWORD": password,
//  'REGISTRATION_DATE':await DateUtility.getCurrentTimeStamp(),
//  'STATUS':'new',
//  'EXP_DATE': await DateUtility.getEXPDates(),
//  'LAST_LOGIN':await DateUtility.getCurrentTimeStamp()
//});
  }

  static Future<bool> isPhoneRegistered(String imei) async {
    var dd = [];
    try {
      print('IMEI inside='+imei);
      QuerySnapshot snapshot = await Firestore.instance
          .collection("customers")
          .where('IMEI', isEqualTo: imei)
          .getDocuments();
      snapshot.documents.toList().forEach((jj) => {
            print(jj.data['USER_FULL_NAME']),
        dd.add(jj)
          });
      if (dd.length > 0) {
        // print(dd['name']);
        return true;
      } else {
        return false;
      }
    } catch (Ex) {
      return false;
    }
  }


  static Future<String> loginWith(
      String mobile, String imei, String password) async {
    var loginResponse = 'error';
    try {
      QuerySnapshot snapshot = await Firestore.instance
          .collection("customers")
          .where('MOBILE', isEqualTo: mobile)
          .where('PASSWORD', isEqualTo: await PasswordUtility.toSHA1(password))
          .where('IMEI', isEqualTo: imei)
          .limit(1)
          .getDocuments();

      snapshot.documents.toList().forEach((jj) => {
            loginResponse = jj.documentID,
          });
      return loginResponse;
    } catch (Ex) {
      return loginResponse;
    }
  }

  static Future<Customer> getCustomerByID(String id) async {
    Map<String, dynamic> requestBody;
    Customer customer;
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('customers').document(id).get();

      Customer cs = Customer.fromJson(documentSnapshot.data);

      return cs;
    } catch (ex) {
      print(ex);
//print(ex);
      return null;
    }
  }
}
