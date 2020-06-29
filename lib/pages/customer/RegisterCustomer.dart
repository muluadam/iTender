import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:itenders/model/customer.dart';
import 'package:itenders/pages/category/FilterCategory.dart';
import 'package:itenders/pages/region/FilterRegion.dart';
import 'package:itenders/services/CustomerService.dart';
import 'package:itenders/services/FBCustomerService.dart';
import 'package:itenders/utils/FlutterIdGenerator.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/localization/application.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/utils/ConectivityUtil.dart';
import 'package:itenders/utils/LoginUtility.dart';
import 'package:itenders/utils/PhoneUtility.dart';
import 'package:itenders/utils/RouteLink.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';

// Create a Form widget.
class RegisterCustomer extends StatefulWidget {
  @override
  RegisterCustomerState createState() {
    return RegisterCustomerState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegisterCustomerState extends State<RegisterCustomer> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  final _formKey = GlobalKey<FormState>();
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };
  String label = languagesList[0];

  void _select(String language) {
    //  print("dd "+language);
    onLocaleChange(Locale(languagesMap[language]));
    setState(() {
      if (language == "Amharic") {
        label = "አማርኛ ";
      } else {
        label = language;
      }
    });
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }
  Future<void> checkLocale() async {
    int lang= await SharedPreferencHelper.getLanguageId();
    Locale locale= new Locale('am','ET');
    if(lang<2){
      locale=new Locale('en','US');
    }
    setState(() {
      AppTranslations.load(locale);
    });
    return null;
  }
  @override
  void initState() {
    super.initState();

    checkLogin();
    checkLocale();

  }
  void checkLogin()async{
    int cid= await SharedPreferencHelper.getCustomerId();
    String customerName= await SharedPreferencHelper.getCustomerName();
    if(customerName==null){
      MyWidgets.showRedToast("Register first Please!");
     // Navigator.pushNamed(context, RouteLink.ROUTE_REGISTER_CUSTOMER);
    }else{
      Navigator.pushNamed(context, RouteLink.ROUTE_HOMME);
      MyWidgets.showGreenToast("Welcome Back "+customerName);
      //  HomeOnePage();
    }
    if (mounted) { // Avoid calling `setState` if the widget is no longer in the widget tree.
      setState(() {


      });
    }
  }


  TextEditingController nameController = new TextEditingController();
  TextEditingController orgController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confPassController = new TextEditingController();
  TextEditingController imeiController = new TextEditingController();
  TextEditingController ssnController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      child: Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: new AppBar(
            actions: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              PopupMenuButton<String>(
                // overflow menu
                onSelected: _select,

                icon: new Icon(Icons.language, color: Colors.white),
                itemBuilder: (BuildContext context) {
                  return languagesList
                      .map<PopupMenuItem<String>>((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.05), BlendMode.dstATop),
                      image: AssetImage('assets/images/itenders_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                    child: Image(
                      image: AssetImage('assets/images/itenders_logo.png'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 10, 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            AppTranslations.of(context).text(
                                LangFile.ITENDER_MOTO),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600],
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(60, 10.0, 60, 10),
                          child: Text(
                            AppTranslations.of(context)
                                .text(LangFile.REGISTER_TODAY),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600],
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                        child: new Text(
                          AppTranslations.of(context).text(LangFile.FULL_NAME),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                        child: new TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppTranslations.of(context)
                                  .text('form_enter_full_name');
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                        child: new Text(
                          AppTranslations.of(context).text('company_name'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                        child: new TextFormField(
                          controller: orgController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppTranslations.of(context)
                                  .text('form_enter_org_name');
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: new Text(
                          AppTranslations.of(context)
                              .text(LangFile.MOBILE_NUMBER),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                        child: new TextFormField(
                          keyboardType: TextInputType.number,
                          controller: mobileController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppTranslations.of(context)
                                  .text(LangFile.ENTER_MOBILE);
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        //    padding: const EdgeInsets.only(left: 40.0),

                        padding: EdgeInsets.fromLTRB(40, 0, 30, 0),
                        child: new Text(
                          AppTranslations.of(context).text(LangFile.PASSWORD),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: new TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppTranslations.of(context)
                                  .text(LangFile.ENTER_PASSWORD);
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),


                Divider(
                  height: 0.0,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: const EdgeInsets.fromLTRB(100, 5, 100, 0),
                  child: RaisedButton(
                    color: Colors.blue[600],
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
                    onPressed: () async {
                      bool con = await ConnectivityUtil.isConnected();
                      String imei = await PhoneUtility.getIMEI();
                      String ssn = await PhoneUtility.getId();
                      if (con) {

                     var response=await   FBCustomerService.saveCustomer(
                            nameController.text,
                            orgController.text,
                            mobileController.text,
                            imei,
                            ssn,
                            'email',
                            passwordController.text);
//if(response!='error' ){
//
//  MyWidgets.showGreenToast(AppTranslations.of(context)
//      .text(LangFile.MESAGE_REGISTRATION_SUCCESSFULL));
//}
//                        Response response = await CustomerService.checkLogin(
//                            nameController.text,
//                            orgController.text,
//                            mobileController.text,
//                            imei,
//                            ssn,
//                            'email',
//                            passwordController.text);



                        if (response != 'error') {
                          MyWidgets.showGreenToast(AppTranslations.of(context)
                              .text(LangFile.MESAGE_REGISTRATION_SUCCESSFULL));
var login=await FBCustomerService.loginWith(
    mobileController.text,
    imei,
    //   print("LoginBody=" + login.body) ;
    //  Navigator.pushNamed(context, RouteLink.ROUTE_FILTER_CATEGORY);
    passwordController.text
);
//
//                          Response login = await CustomerService.loginWith(
//                              mobileController.text,
//                              imei,
//                              //   print("LoginBody=" + login.body) ;
//                              //  Navigator.pushNamed(context, RouteLink.ROUTE_FILTER_CATEGORY);
//                              passwordController.text);

                          if (login!= 'error') {


                           Customer cs= await FBCustomerService.getCustomerByID(login);

                            LoginUtility.setLoginInfo(
                                int.parse(login), cs.fullName, cs.companyName);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FilterCategory(),
//
                                ));
                          }
                        }
                      } else {
//                        bool isRegistred=await FBCustomerService.isPhoneRegistered(imei);
//                       print("ID="+ await FlutterIdGenerator.getID().toString());
//                        FBCustomerService.saveCustomer(
//                            nameController.text,
//                            orgController.text,
//                            mobileController.text,
//                            imei,
//                            ssn,
//                            'email',
//                            passwordController.text) ;
                        MyWidgets.showRedToast(AppTranslations.of(context)
                            .text(LangFile.MESSAGE_NO_INTERNET));
                      }
                    },
                    child: Text(AppTranslations.of(context)
                        .text(LangFile.BUTTON_REGISTER)),
                  ),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: const EdgeInsets.fromLTRB(100, 5, 100, 0),
                  child: RaisedButton(
                    color: Colors.blue[600],
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
                    onPressed: () async {
                      String imei = await PhoneUtility.getIMEI();
                      var response = await FBCustomerService.isPhoneRegistered(imei);
//                      print('IMEI=='+imei);
//                      print('RESTPonse='+response.toString());
                      if(!response){
                        MyWidgets.showRedToast(' You need to Register first!!');
                      }else{
                        Navigator.pushNamed(context, RouteLink.ROUTE_LOGIN);
                      }


                    },
                    child: Text(
                        AppTranslations.of(context).text(
                            LangFile.BUTTON_LOGIN)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
