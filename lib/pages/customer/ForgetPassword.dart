import 'package:flutter/material.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/localization/application.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/utils/ConectivityUtil.dart';
import 'package:itenders/utils/PhoneUtility.dart';
import 'package:itenders/utils/RouteLink.dart';

// Create a Form widget.
class ForgetPassword extends StatefulWidget {
  @override
  ForgetPasswordState createState() {
    return ForgetPasswordState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ForgetPasswordState extends State<ForgetPassword> {
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

    TextEditingController nameController= new TextEditingController();
  TextEditingController orgController= new TextEditingController();
  TextEditingController mobileController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  TextEditingController confPassController= new TextEditingController();
  TextEditingController imeiController= new TextEditingController();
  TextEditingController ssnController= new TextEditingController();





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

                    style: TextStyle(fontSize: 15),),
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
                  padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),

                  child: Image(
                    image: AssetImage('assets/images/itenders_logo.png'),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(100, 5, 200, 0),
                child: Column(children: <Widget>[
                  Container(

                    child: Text(
                      AppTranslations.of(context).text(LangFile.FORGET_PASSWORD),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[600],
                        fontSize: 15.0,
                      ),

                    ),
                  ),

                ],),


              ),
Divider(height: 10,),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.fromLTRB(150, 5, 150, 0),
                      child: new Text(
                        AppTranslations.of(context).text(
                            LangFile.MOBILE_NUMBER),
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
                      padding: const EdgeInsets.fromLTRB(130, 5, 100, 0),
                      child: new TextFormField(
                        keyboardType: TextInputType.number,
                        controller: mobileController,

                        validator: (value) {
                          if (value.isEmpty) {
                            return AppTranslations.of(context).text(
                                LangFile.ENTER_MOBILE);
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
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    String imei= "";
                    imei=await PhoneUtility.getIMEI().asStream().toString();

                    MyWidgets.showGreenToast(imei);
                     bool con = await ConnectivityUtil.isConnected();
                     String message="con";
                    if (con) {
                     if (_formKey.currentState.validate()) {
                  MyWidgets.showGreenToast(message);

                      } else {

                      }
                    }else{
                       MyWidgets.showRedToast(AppTranslations.of(context).text(LangFile.MESSAGE_NO_INTERNET));
                    }

                  },
                  child: Text(
                      AppTranslations.of(context).text(LangFile.BUTTON_GET_NEW_PASSWORD)),
                ),
              ),

              Divider(height: 10),
              Container(
                  padding: const EdgeInsets.fromLTRB(200, 5, 200, 0),

                  child:
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context,RouteLink.ROUTE_FORGET_PASSWORD);
                      },
                      child: Text(AppTranslations.of(context).text(LangFile.FORGET_PASSWORD)),
                    )

              )
              ,

            ],
          ),
        ),
      ),
    );
  }
}