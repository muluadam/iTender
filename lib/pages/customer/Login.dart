import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:itenders/Home.dart';
import 'package:itenders/model/customer.dart';
import 'package:itenders/services/CustomerService.dart';
import 'package:itenders/services/FBCustomerService.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/localization/application.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/utils/ConectivityUtil.dart';
import 'package:itenders/utils/LoginUtility.dart';
import 'package:itenders/utils/PhoneUtility.dart';
import 'package:itenders/utils/RouteLink.dart';

// Create a Form widget.
class LoginCustomer extends StatefulWidget {

  @override
  LoginCustomerState createState() {
    return LoginCustomerState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginCustomerState extends State<LoginCustomer> {
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
          body: Column(
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
                  padding: const EdgeInsets.fromLTRB(40.0, 20, 40, 0),
                  child: Image(
                    image: AssetImage('assets/images/itenders_logo.png'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10.0, 10, 10),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        AppTranslations.of(context).text(LangFile.ITENDER_MOTO),
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
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.fromLTRB(100.0, 0, 100, 0),
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
                      padding: const EdgeInsets.fromLTRB(100.0, 0, 100, 0),
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
                      padding: const EdgeInsets.fromLTRB(100.0, 0, 100, 0),
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
                      padding: const EdgeInsets.fromLTRB(100.0, 0, 100, 0),
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
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(100, 5, 100, 0),
                child: RaisedButton(
                  color: Colors.blue[600],
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  splashColor: Colors.grey,
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    bool con = await ConnectivityUtil.isConnected();
                    String message = "con";
                    if (con) {
                      message = "Connection is available";
                     // MyWidgets.showGreenToast(message);

                      String imei = await PhoneUtility.getIMEI();

                 //     MyWidgets.showGreenToast(imei);
//                      print("Mobile="+mobileController.text.toString());
//                      print("IMEI=22 "+imei);
//                      print("Password="+passwordController.text.toString());
                   //   Response re=await CustomerService.loginWith(mobileController.text, imei, passwordController.text);
                    //  print(re.body);

                      var loginresponse= await FBCustomerService.loginWith(mobileController.text, imei, passwordController.text);
                      if(loginresponse!='error'){

                       Customer cs= await FBCustomerService.getCustomerByID(loginresponse);
                       LoginUtility.setLoginInfo(
                            cs.customerId, cs.fullName, cs.companyName);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TenderHome(),
//
                            ));
                      }


                    } else {
                      message = "Login Failled";
                     // MyWidgets.showRedToast(message);
                      MyWidgets.showRedToast(message);
                    }
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
//                      Scaffold.of(context)
//                          .showSnackBar(SnackBar(content: Text('Processing Data')));

                    } else {

                    }
                  },
                  child: Text(
                      AppTranslations.of(context).text(LangFile.BUTTON_LOGIN)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(100, 5, 100, 0),
                child: RaisedButton(
                  color: Colors.blue[600],
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  splashColor: Colors.grey,
                  onPressed: () async {
                    String imei = await PhoneUtility.getIMEI();
                    var response = await FBCustomerService.isPhoneRegistered(imei);

                    if(response){

                      MyWidgets.showRedToast(' You Allready Registered!!');
                    }else{
                      Navigator.pushNamed(context, RouteLink.ROUTE_REGISTER_CUSTOMER);

                    }
                  },
                  child: Text(AppTranslations.of(context)
                      .text(LangFile.BUTTON_REGISTER)),
                ),
              ),
              Divider(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(130, 5, 100, 0),

                child: InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RouteLink.ROUTE_FORGET_PASSWORD);
                  },

                child: Text(AppTranslations.of(context).text(LangFile.FORGET_PASSWORD),
                style: TextStyle(
                   color: Colors.blue[700],


                ),),
              ),)            ],
          ),
        ),
      ),
    );
  }
}
