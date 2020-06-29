import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itenders/model/model_sub_category.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/utils/RouteLink.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';
import 'package:itenders/services/CategoryService.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/localization/application.dart';

// Create a Form widget.
class UpdateCategory extends StatefulWidget {
  @override
  RegisterCustomerState createState() {
    return RegisterCustomerState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegisterCustomerState extends State<UpdateCategory> {


  CategoryList categoryData;
  List<String> selectedCategories =List<String>(); // SharedPreferencHelper.getSelectedCategoryList();
  List<String> selectedCategoryNames=List<String>(); // SharedPreferencHelper.getSelectedCategoryList();



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

  Future<dynamic> getData() async {

     var response = await CategoryService.getAllSubCategories();
    categoryData = CategoryList.fromJson(jsonDecode(response.body));

    selectedCategories = await SharedPreferencHelper.getSelectedCategoryList();
    selectedCategoryNames= await SharedPreferencHelper.getSelectedCategoryNamesList();
setState(() {

});
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  void initState()  {
    selectedCategories = List<String>();
    selectedCategoryNames = List<String>();

    getData();
   super.initState();
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
                AppTranslations.of(context).text(LangFile.TENDER_UPDATE_CATEGOY),
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              Text(
                AppTranslations.of(context).text(LangFile.ITENDER_SERVICE),

                style: TextStyle(color: Colors.white, fontSize: 12.0),
              )
            ],
          ),
          leading: FlatButton(
            child: Column(
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
                        .getSelectedCategoryNamesList());
                    SharedPreferencHelper.setSelectedCategoryList(
                        selectedCategories);
                    int cid=await SharedPreferencHelper.getCustomerId();
                    CategoryService.updateUserCategory(cid, selectedCategories.toString());
                    setState(() {
                      Navigator.pushNamed(
                          context, RouteLink.ROUTE_HOMME);
                    });

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
            itemCount: categoryData == null ? 0 : categoryData.catlists.length,
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
              );
            }));
  }
}
