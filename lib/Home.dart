/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/localization/application.dart';
import 'package:itenders/localization/appt_translations_delegate.dart';
import 'package:itenders/pages/category/AllCatWidget.dart';
import 'package:itenders/pages/category/AllCategoryWidgets.dart';
import 'package:itenders/pages/tenders/MyTendersList.dart';
import 'package:itenders/pages/tenders/OfflineTendersList.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/utils/RouteLink.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';

final List<Map> articles = [
  {
    "title": "How to Seem Like You Always Have Your Shot Together",
    "author": "Jonhy Vino",
    "time": "4 min read",
  },
  {
    "title": "Does Dry is January Actually Improve Your Health?",
    "author": "Jonhy Vino",
    "time": "4 min read",
  },
  {
    "title": "You do hire a designer to make something. You hire them.",
    "author": "Jonhy Vino",
    "time": "4 min read",
  },
  {
    "title": "How to Seem Like You Always Have Your Shot Together",
    "author": "Jonhy Vino",
    "time": "4 min read",
  },
  {
    "title": "How to Seem Like You Always Have Your Shot Together",
    "author": "Jonhy Vino",
    "time": "4 min read",
  },
  {
    "title": "Does Dry is January Actually Improve Your Health?",
    "author": "Jonhy Vino",
    "time": "4 min read",
  },
  {
    "title": "You do hire a designer to make something. You hire them.",
    "author": "Jonhy Vino",
    "time": "4 min read",
  },
  {
    "title": "How to Seem Like You Always Have Your Shot Together",
    "author": "Jonhy Vino",
    "time": "4 min read",
  },
];


class TenderHome extends StatefulWidget {
  @override
  _TenderHomeState createState() => _TenderHomeState();
}

class _TenderHomeState extends State<TenderHome> {


  static final String path = "lib/src/pages/blog/bhome1.dart";
  static final Color primaryColor = Color(0xffFD6592);
  static final Color bgColor = Color(0xffF9E0E3);
  static final Color secondaryColor = Color(0xff324558);
  static final Color primary = Colors.white;
  static final Color active = Colors.grey.shade800;
  static final Color divider = Colors.grey.shade600;
  static String customerName = "customer";
  static String compnayName = "compnay";


  final _formKey = GlobalKey<FormState>();
  static List<String> languagesList = application.supportedLanguages;
  static List<String> languageCodesList =
      application.supportedLanguagesCodes;

  Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };
  //String label = languagesList[0];

  void _select(String language) {
    //  print("dd "+language);
    onLocaleChange(Locale(languagesMap[language]));

    setState(() {
      if(language=="Amharic"){
        SharedPreferencHelper.setLanguageId("2");
      }else{
        SharedPreferencHelper.setLanguageId("1");
      }
      Navigator.pushNamed(context, RouteLink.ROUTE_HOMME);

    });
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  int cid = 0;
  String cutomerName = "name";
  String companyName = "";
  List<String> myRegionIDList = [];
  List<String> myCategoryIDList = [];
  List<String> myRegionNameList = [];
  List<String> myCategoryNameList = [];
  AppTranslationsDelegate _newLocaleDelegate;

  void getPreferenceData() async {
    cid = await SharedPreferencHelper.getCustomerId();
    companyName = await SharedPreferencHelper.getCompanyName();
    cutomerName = await SharedPreferencHelper.getCustomerName();
    myCategoryIDList = await SharedPreferencHelper.getSelectedCategoryList();
    myRegionIDList = await SharedPreferencHelper.getSelectedRegionList();
    myRegionNameList = await SharedPreferencHelper.getSelectedRegionNamesList();
    myCategoryNameList =
    await SharedPreferencHelper.getSelectedCategoryNamesList();
  }

  @override
  void initState() {
    super.initState();

    _newLocaleDelegate = AppTranslationsDelegate(newLocale: Locale('am', "ET"));
    application.onLocaleChanged = onLocaleChange;
    // checkLogin();

  }

  @override
  Widget build(BuildContext context) {
    getPreferenceData();

    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Theme(
        data: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            textTheme: TextTheme(
              title: TextStyle(
                color: secondaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(color: secondaryColor),
            actionsIconTheme: IconThemeData(
              color: secondaryColor,
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .buttonColor,
          appBar: AppBar(
            backgroundColor: Colors.blue[400],
            //  centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTranslations.of(context).text(LangFile.ITENDER_MOTO),
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  AppTranslations.of(context).text(LangFile.ITENDER_SERVICE),
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                )
              ],
            ),
            // leading: Icon(Icons.category),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              labelColor: primaryColor,
              indicatorColor: primaryColor,
              unselectedLabelColor: secondaryColor,
              tabs: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppTranslations.of(context).text(LangFile.TENDER_MY_TENDER),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppTranslations.of(context).text(LangFile.TENDER_ALL),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppTranslations.of(context)
                      .text(LangFile.TENDER_OFFLINE)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(AppTranslations.of(context)
                      .text(LangFile.TENDER_BUSINESs_INFO)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Business"),
                ),
              ],
            ),
          ),
          drawer: _buildDrawer(context),
          body: TabBarView(
            children: <Widget>[
//              ListView.separated(
//                padding: const EdgeInsets.all(16.0),
//                itemCount: articles.length,
//                itemBuilder: (context, index) {
//                  return _buildArticleItem(index);
//                },
//                separatorBuilder: (context, index) =>
//                    const SizedBox(height: 16.0),
//              ),
              Container(
              child: MyTendersList(),
             // child: AllCatWidget(),

                // child: AllCategories(),
              ),
              Container(
                child: AllCatWidget(),
              ),
              Container(
                child: OfflineTendersListP(),
              ),
              Container(
               // child: AllCategoryWidgets(),
              ),
              Container(
                child: Text("Tab 5"),
              ),
            ],
          ),
          bottomNavigationBar: GestureDetector(
            child:
            Padding(

              padding: const EdgeInsets.all(8.0),
              child: Image(

                  image: AssetImage('assets/images/ads/ad_here.jpeg'),
                  height: 50,
                  fit: BoxFit.fill


              ),
            ),
            onTap: () {
              MyWidgets.showGreenToast("Opening Advetizing plan");
            },
          ),
        ),
      ),
    );
  }

  Widget getBottomBar() {
    return BottomNavigationBar(
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.flag),
          title: Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          title: Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          title: Text(""),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text(""),
        ),
      ],
    );
  }

  Widget _buildArticleItem(int index) {
    Map article = articles[index];
    //final String sample = images[2];
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            width: 90,
            height: 90,
            color: bgColor,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Container(
                    height: 100,
                    color: Colors.blue,
                    width: 80.0,
                    child: Text('NM')),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        article["title"],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: CircleAvatar(
                                radius: 15.0,
                                backgroundColor: primaryColor,
                              ),
                            ),
                            WidgetSpan(
                              child: const SizedBox(width: 5.0),
                            ),
                            TextSpan(
                                text: article["author"],
                                style: TextStyle(fontSize: 16.0)),
                            WidgetSpan(
                              child: const SizedBox(width: 20.0),
                            ),
                            WidgetSpan(
                              child: const SizedBox(width: 5.0),
                            ),
                            TextSpan(
                              text: article["time"],
                            ),
                          ],
                        ),
                        style: TextStyle(height: 2.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static void getnames() async {
    customerName = await SharedPreferencHelper.getCompanyName();
    compnayName = await SharedPreferencHelper.getCompanyName();
  }

  Widget _buildDrawer(BuildContext context) {
    //  final String image = images[0];ing
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);

    getnames();
    return ClipPath(
      //clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange])),
                    child: CircleAvatar(
                      radius: 40,
                      //   backgroundImage: CachedNetworkImageProvider(image),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    customerName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    compnayName,
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, "Home",
                  ),
                  _buildDivider(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: Row(children: [
                        Icon(
                          Icons.location_city,
                          color: active,

                        ),
                        SizedBox(width: 10.0),
                        Text(
                            AppTranslations.of(context).text(
                                LangFile.WORK_PLACE),
                            style: tStyle
                        ),
                        Spacer(),

                      ],),
                      onTap: () {
                        // _showLanguageChangeDailog(context);
                        // Navigator.push(context, Route RouteLink.ROUTE_FILTER_CATEGORY)
                        Navigator.pushNamed(context, RouteLink.ROUTE_FILTER_REGION);
                      },
                    ),

                  ),
                  _buildDivider(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: Row(children: [
                        Icon(
                          Icons.category,
                          color: active,

                        ),
                        SizedBox(width: 10.0),
                        Text(
                            AppTranslations.of(context).text(
                                LangFile.CATEGORY),
                            style: tStyle
                        ),
                        Spacer(),

                      ],),
                      onTap: () {
                       // _showLanguageChangeDailog(context);
                       // Navigator.push(context, Route RouteLink.ROUTE_FILTER_CATEGORY)
                        Navigator.pushNamed(context, RouteLink.ROUTE_FILTER_CATEGORY);
                      },
                    ),

                  ),
                  _buildDivider(),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: Row(children: [
                        Icon(
                          Icons.language,
                          color: active,

                        ),
                        SizedBox(width: 10.0),
                        Text(
                            AppTranslations.of(context).text(
                                LangFile.COMMON_CHANGE_LANGUAGE),
                            style: tStyle
                        ),
                        Spacer(),

                      ],),
                      onTap: () {
                        _showLanguageChangeDailog(context);
                      },
                    ),

                  ),
                  _buildDivider(),
                  _buildRow(Icons.person_pin, "My profile"),
                  _buildDivider(),
                  _buildRow(Icons.message, "Messages", showBadge: true),
                  _buildDivider(),
                  _buildRow(Icons.notifications, "Notifications",
                      showBadge: true),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings"),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "Help"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,

        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),

      ]),
    );
  }


  Future<void> _showLanguageChangeDailog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppTranslations.of(context).text(
              LangFile.COMMON_CHANGE_LANGUAGE)),
          content: SingleChildScrollView(
            child: ListBody(
                children: <Widget>[
                Text('Select language.'),



            DropdownButton<String>(

              items: [

                DropdownMenuItem<String>(

                  child: Text('Amharic'),

                  value: 'Amharic',

                ),

                DropdownMenuItem<String>(

                  child: Text('English'),

                  value: 'English',

                ),



              ],

              onChanged: (String value) {

                _select(value);

              },

              hint: Text('Select Item'),

             // value: _value,

            ),
          ],
            )

        ),
        actions: <Widget>[
        FlatButton(
        child: Text('Close'),
        onPressed: () {
        Navigator.of(context).pop();
        },
        )
        ,
        ]
        ,
        );
      },
    );
  }
}
