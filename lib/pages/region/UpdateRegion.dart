import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itenders/localization/application.dart';
import 'package:itenders/model/model_region.dart';
import 'package:itenders/services/RegionService.dart';
import 'package:itenders/utils/RouteLink.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/localization/app_translations.dart';

// Create a Form widget.
class UpdateRegion extends StatefulWidget {
  @override
  RegisterCustomerState createState() {
    return RegisterCustomerState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegisterCustomerState extends State<UpdateRegion> {

String companyName="Company Name";
  RegionList data;
  List<String> selectedRegions =
      []; // SharedPreferencHelper.getSelectedCategoryList();
  List<String> selectedRegionNames =
      []; // SharedPreferencHelper.getSelectedCategoryList();


  final _formKey = GlobalKey<FormState>();
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };
  String label = languagesList[0];





  void _onSelectCategory(bool selected, category, names) {
  //  print("REG IT== s=" + selectedRegions.length.toString());

    if (selected) {
      selectedRegions.add(category.toString());
      selectedRegionNames.add(names);
      SharedPreferencHelper.setSelectedRegionList(selectedRegions);
      SharedPreferencHelper.setSelectedRegionNamesList(selectedRegionNames);
      setState(() {});
    } else {
      selectedRegionNames.remove(names);
      selectedRegions.remove(category.toString());
      SharedPreferencHelper.setSelectedRegionList(selectedRegions);
      SharedPreferencHelper.setSelectedRegionNamesList(selectedRegionNames);
      setState(() {});
    }
  }

  Future<dynamic> getData() async {
    var response = await RegionService.getAllRegions();
    print(response.body);
     selectedRegions = await SharedPreferencHelper.getSelectedRegionList();
     selectedRegionNames =
         await SharedPreferencHelper.getSelectedRegionNamesList();

      data = RegionList.fromJson(jsonDecode(response.body));

   // print("data==");
    print(data.regionList.length);setState(() {});
    companyName= await SharedPreferencHelper.getCompanyName();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  void initState()  {
    // TODO: implement initState
print("Region on in it ");
    getData();
  //  super.initState();
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }

  Widget catTemplate(cate) {
    return Card(
      margin: EdgeInsets.fromLTRB(12, 0, 16, 0),
      child: Column(
        children: <Widget>[
          Text(
            cate.getCategoryName(),
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
getData();

    return Scaffold(
        appBar: new AppBar(
          title:   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTranslations.of(context).text(LangFile.TENDER_UPDATE_REGION),
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              Text(
                AppTranslations.of(context).text(LangFile.ITENDER_SERVICE),

                style: TextStyle(color: Colors.white, fontSize: 12.0),
              )
            ],
          ),
          leading: FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.home,
                  color: Colors.deepOrange,
                ),

              ],
            ),
            onPressed: ()=>
                Navigator.pushNamed(context, RouteLink.ROUTE_HOMME)

            ,
          ),

          actions: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 5),
                child: RaisedButton(

                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.grey,
                  onPressed: () async {
                    print(await SharedPreferencHelper
                        .getSelectedRegionNamesList());
                    SharedPreferencHelper.setSelectedRegionList(
                        selectedRegions);
                    Navigator.pushNamed(
                        context, RouteLink.ROUTE_HOMME);
                  },
                  child: Text(
                    AppTranslations.of(context).text(LangFile.BUTTON_UPDATE) +
                        " >",
                  ),
                ),
              ),
            ),
          ],
        ),
        body: new ListView.builder(
            itemCount: data == null ? 0 : data.regionList.length,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                child: new Container(
                  padding: EdgeInsets.fromLTRB(12, 0, 16, 0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: new CheckboxListTile(
                          value: selectedRegions.contains(data.regionList[index].id.toString()),
                          onChanged: (bool s) {
                            setState(() {
                              _onSelectCategory(
                                  s,
                                  data.regionList[index].id.toString(),
                                  data.regionList[index].regionName.toString());
                            });
                          },
                          checkColor: Colors.yellowAccent,
                          // color of tick Mark
                          activeColor: Colors.blue[600],
                          title: Text(
                            data.regionList[index].regionName.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
