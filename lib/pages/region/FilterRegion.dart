import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itenders/localization/application.dart';
import 'package:itenders/model/model_region.dart';
import 'package:itenders/services/FBRegionService.dart';
import 'package:itenders/services/RegionService.dart';
import 'package:itenders/utils/RouteLink.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/localization/app_translations.dart';

// Create a Form widget.
class FilterRegion extends StatefulWidget {
  @override
  RegisterCustomerState createState() {
    return RegisterCustomerState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegisterCustomerState extends State<FilterRegion> {

String companyName="Company Name";
  RegionList regionList;
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


regionList= new RegionList(await FBRegionService.getAllRegions());

      setState(() {
//       print(response[0].categoryName);

      });
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  void initState()  {
    // TODO: implement initState

    this.getData();
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

        return Scaffold(
        appBar: new AppBar(
          title: Text(
            AppTranslations.of(context).text(LangFile.CATEGORY+ "->"),
            style: TextStyle(fontSize: 14),
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
                    var cid=await SharedPreferencHelper.getCustomerId();
                //    print('"CID= '+cid.toString());
                    FBRegionService.saveSelectedRegions(cid.toString(), selectedRegions);
                    print(await SharedPreferencHelper
                        .getSelectedRegionNamesList());
                    SharedPreferencHelper.setSelectedRegionList(
                        selectedRegions);
                    Navigator.pushNamed(
                        context, RouteLink.ROUTE_HOMME);
                  },
                  child: Text(
                    AppTranslations.of(context).text(LangFile.BUTTON_SAVE) +
                        " >",
                  ),
                ),
              ),
            ),
          ],
        ),
        body: new ListView.builder(

            itemCount: regionList == null ? 0 : regionList.regionList.length,
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
                          value: selectedRegions.contains(regionList.regionList[index].id.toString()),
                          onChanged: (bool s) {
                            setState(() {
                              _onSelectCategory(
                                  s,
                                  regionList.regionList[index].id.toString(),
                                  regionList.regionList[index].regionName.toString());
                            });
                          },
                          checkColor: Colors.yellowAccent,
                          // color of tick Mark
                          activeColor: Colors.blue[600],
                          title: Text(
                            regionList.regionList[index].regionName.toString(),
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
