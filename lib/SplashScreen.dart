import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:itenders/Home.dart';
import 'package:itenders/pages/customer/RegisterCustomer.dart';
import 'package:itenders/services/CustomerService.dart';
import 'package:itenders/services/FBCustomerService.dart';
import 'package:itenders/utils/PhoneUtility.dart';
import 'package:itenders/utils/RouteLink.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
            child: Image(
              image: AssetImage('assets/images/itenders_logo.png'),
            ),
          ),
        ),
      ),
    );
  }

  startTime() async {
    try {
      var _duration = new Duration(seconds: 3);
      int cid = await SharedPreferencHelper.getCustomerId();
      //  print("CUD==" + cid.toString());
      if (cid > 0) {
        return new Timer(_duration, gotoHomePage);
      } else {
        String imei = await PhoneUtility.getIMEI();
        var res = await FBCustomerService.isPhoneRegistered(imei);
        if (res != 'error') {
          return new Timer(_duration, gotoLoginPage);
        } else {
          return new Timer(_duration, gotoRegistrationPage);
        }

//        Response response = await CustomerService.isPhoneRegistered(imei);
//        var js = jsonDecode(response.body);
//        if (js['status']) {
//          return new Timer(_duration, gotoLoginPage);
//        } else {
//          return new Timer(_duration, gotoRegistrationPage);
//        }
      }
    } catch (e) {
      print(e);
    }
  }

  void gotoHomePage() {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new TenderHome(),
      ),
    );
  }

  void gotoRegistrationPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new RegisterCustomer(),
      ),
    );
  }

  void gotoLoginPage() {
    Navigator.of(context).pushNamed(RouteLink.ROUTE_LOGIN);
  }
}
