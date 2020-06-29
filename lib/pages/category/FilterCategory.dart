import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itenders/model/model_sub_category.dart';
import 'package:itenders/services/FBCategoryService.dart';
import 'package:itenders/services/FBCustomerService.dart';
import 'package:itenders/utils/RouteLink.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';
import 'package:itenders/services/CategoryService.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/localization/application.dart';

// Create a Form widget.
class FilterCategory extends StatefulWidget {
  @override
  RegisterCustomerState createState() {
    return RegisterCustomerState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegisterCustomerState extends State<FilterCategory> {
String customerID="123";
  List<String> selectedCategoryIDs=[] ;
  CategoryList categoryData;
  List<String> selectedCategories=[] ; // SharedPreferencHelper.getSelectedCategoryList();
  List<String> selectedCategoryNames=[]; // SharedPreferencHelper.getSelectedCategoryList();
  void _onSelectCategory(bool selected, category, names) {

    if (selected) {
      selectedCategories?.add(category.toString());
      selectedCategoryNames?.add(names);
      SharedPreferencHelper.setSelectedCategoryList(selectedCategories);
      SharedPreferencHelper.setSelectedCategoryNamesList(selectedCategoryNames);
     setState(() {});
    } else {
      selectedCategoryNames.remove(names);
      selectedCategories.remove(category.toString());
      SharedPreferencHelper.setSelectedCategoryList(selectedCategories);
      SharedPreferencHelper.setSelectedCategoryNamesList(selectedCategoryNames);

  setState(() {});
    }
    print("Cat IT== s=" + selectedCategories.length.toString());
  }

  Future<String> getCiD() async{
    String customerID="1010";
    SharedPreferencHelper.getCustomerId().then((val)=>{
       customerID=val.toString(),
     // print("VALUE==="+val.toString())
    });
    return customerID;
  }
  Future<dynamic> getData() async {
    categoryData= new CategoryList(await FBCategoryService.getAllSubCategories());
 return categoryData;
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  void initState()  {

    // TODO: implement initState
    this.getData();
   // super.initState();
  }

  Widget getCategoryList(){

      return FutureBuilder(
          future: getData(),
          initialData: categoryData,
          builder: (BuildContext context, AsyncSnapshot projectSnap) {
            if (projectSnap.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(strokeWidth: 6,

                    backgroundColor: Colors.red[900]),
              );
            } else {
              return ListView.builder(
                  itemCount: projectSnap.data == null ? 0 : projectSnap.data.catlists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10,0, 10, 0),
                      child: new Card(
                        child: new Container(
                          padding: EdgeInsets.fromLTRB(12, 0, 16, 0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: new CheckboxListTile(
                                  value:selectedCategories.contains(projectSnap.data.catlists[index].categoryId.toString()),
                                  onChanged: (bool s) {
                                    setState(() {
                                      _onSelectCategory(
                                          s,
                                          projectSnap.data.catlists[index].categoryId.toString(),
                                          projectSnap.data.catlists[index].categoryName.toString());
                                    });
                                  },
                                  checkColor: Colors.yellowAccent,
                                  // color of tick Mark
                                  activeColor: Colors.blue[600],
                                  title: Text(
                                    projectSnap.data.catlists[index].categoryName.toString(),
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
                      ),
                    );
                  }
            );
            }
          });


  }



  @override
  Widget build(BuildContext context) {
    String id="noId";
    var doc=  getCiD().then((onValue){

      });


    return Scaffold(
      appBar: new AppBar(
        title: Text(          AppTranslations.of(context).text(LangFile.CATEGORY)+id ,
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
                  print(await SharedPreferencHelper
                      .getSelectedCategoryNamesList());
                  SharedPreferencHelper.setSelectedCategoryList(
                      selectedCategories);
                  print(selectedCategories);
                  var cid=await SharedPreferencHelper.getCustomerId();
                  print('"CID= '+cid.toString());
                  FBCategoryService.saveSelectedCategories(cid.toString()  , selectedCategories);

                  Navigator.pushNamed(
                      context, RouteLink.ROUTE_FILTER_REGION);
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
      body:getCategoryList(),
    );
  }

  Widget buildOld(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          AppTranslations.of(context).text(LangFile.CATEGORY),
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
                  print(await SharedPreferencHelper
                      .getSelectedCategoryNamesList());
                  SharedPreferencHelper.setSelectedCategoryList(
                      selectedCategories);
                  print(selectedCategories);
                  var cid=await SharedPreferencHelper.getCustomerId();
                  print('"CID= '+cid.toString());
              FBCategoryService.saveSelectedCategories(cid.toString()  , selectedCategories);

                   Navigator.pushNamed(
                       context, RouteLink.ROUTE_FILTER_REGION);
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
      body:getGidget(),
    );


  }
  Widget displayWidget(){
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot projectSnap) {
        if (projectSnap.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.red[900]),
          );
        } else {
          return Center(
            child: getGidget(),
          );

        }

      },
    );
  }
  Widget getGidget(){
    return Scaffold(

        body: new ListView.builder(
            itemCount: categoryData == null ? 0 : categoryData.catlists.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10,0, 10, 0),
                child: new Card(
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 16, 0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: new CheckboxListTile(
                            value:selectedCategories.contains(categoryData.catlists[index].categoryId.toString()),
                            onChanged: (bool s) {
                              setState(() {
                                _onSelectCategory(
                                    s,
                                    categoryData.catlists[index].categoryId.toString(),
                                    categoryData.catlists[index].categoryName.toString());
                              });
                            },
                            checkColor: Colors.yellowAccent,
                            // color of tick Mark
                            activeColor: Colors.blue[600],
                            title: Text(
                              categoryData.catlists[index].categoryName.toString(),
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
                ),
              );
            })


    );
  }
}
