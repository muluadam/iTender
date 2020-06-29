import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:itenders/Home.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/pages/category/FilterCategory.dart';
import 'package:itenders/pages/region/FilterRegion.dart';
import 'package:itenders/pages/category/UpdateCategory.dart';
import 'package:itenders/pages/region/UpdateRegion.dart';

import 'package:itenders/pages/customer/ForgetPassword.dart';
import 'package:itenders/pages/customer/Login.dart';
import 'package:itenders/pages/customer/RegisterCustomer.dart';
import 'package:itenders/services/CustomerService.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/utils/PhoneUtility.dart';
import 'package:itenders/utils/RouteLink.dart';
import 'package:itenders/localization/appt_translations_delegate.dart';
import 'package:itenders/localization/application.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';
//
//Future<Null> main() async {
//  runApp(MaterialApp(home:   MiddlePage()));
//}

class MiddlePage extends StatefulWidget {
  @override
  _MiddlePageState createState() => _MiddlePageState();
}

class _MiddlePageState extends State<MiddlePage> {
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  String label = languagesList[0];

  @override
  void initState() {
    super.initState();
    application.onLocaleChanged = onLocaleChange;
    onLocaleChange(Locale(languagesMap["Amharic"]));
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  load() {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LocalisedApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: load(),
    );
  }
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  void onLocaleChange(Locale locale) async {
    AppTranslations.load(locale);

    startTime();
  }

  @override
  void initState() {
    super.initState();
    print("MOTO==" + AppTranslations.of(context).text(LangFile.ITENDER_MOTO));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        //  '/':(context)=>RegisterCustomer(),
        RouteLink.ROUTE_LOGIN: (context) => LoginCustomer(),
        RouteLink.ROUTE_FORGET_PASSWORD: (context) => ForgetPassword(),
        RouteLink.ROUTE_REGISTER_CUSTOMER: (context) => RegisterCustomer(),
        RouteLink.ROUTE_FILTER_CATEGORY: (context) => FilterCategory(),
        RouteLink.ROUTE_FILTER_REGION: (context) => FilterRegion(),
        RouteLink.ROUTE_HOMME: (context) => TenderHome(),
        RouteLink.ROUTE_UPDATE_CATEGORY: (context) => UpdateCategory(),
        RouteLink.ROUTE_UPDATE_REGION: (context) => UpdateRegion(),
        // RouteLink.ROUTE_TENDER_DETAIL:(context)=>MyApp(),
      },
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
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
      ),
      localizationsDelegates: [
        _newLocaleDelegate,
        //  AppTranslationsDelegate(newLocale: Locale('am', "")),
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("am", ""),
        const Locale("en", ""),
      ],
    );
  }

  Future<void> checkLocaled() async {
    int lang = await SharedPreferencHelper.getLanguageId();
    Locale locale = new Locale('am', 'ET');
    if (lang < 2) {
      locale = new Locale('en', 'US');
    }
    setState(() {
      AppTranslations.load(locale);
    });

    return null;
  }

  startTime() async {
    try {
      //  AppTranslations.load(Locale('am', "ET"));
      var _duration = new Duration(seconds: 3);
      int cid = await SharedPreferencHelper.getCustomerId();
      print("CUD==" + cid.toString());
      if (cid > 0) {
        return new Timer(_duration, gotoHomePage);
      } else {
        print('registration');
        String imei = PhoneUtility.getIMEI().toString();
        Response response = await CustomerService.isPhoneRegistered(imei);
        var js = jsonDecode(response.body);
        print("JS==" + js);
        // print("CODE="+locale.languageCode);
        //   print("MOTO="+AppTranslations.of(context).text(LangFile.ITENDER_MOTO));
        return new Timer(_duration, gotoRegistrationPage);
      }
    } catch (e) {
      print(e);
    }
  }

  void gotoHomePage() {
    print("Going to ===Home page");
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new TenderHome(),
      ),
    );
  }

  void gotoRegistrationPage() {
    print("Going to ===RegistrationPage page");

    //  AppTranslations.load(Locale('am','ET'));
    //onLocaleChange(locale);

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
