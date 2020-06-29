import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:itenders/Home.dart';
import 'package:itenders/SplashScreen.dart';
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

Future<Null> main() async {
  runApp(new LocalisedApp());
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
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
      home:  SplashScreen(),
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", ""),
        const Locale("am", ""),
      ],
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
