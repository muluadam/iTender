import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/model/category.dart';
import 'package:itenders/pages/tenders/DetailScreen.dart';
import 'package:itenders/pages/tenders/TendersList.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/services/CategoryService.dart';
import 'package:itenders/utils/LangFile.dart';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  AllCategoryList data;

  Future<dynamic> getData() async {
    var response = await CategoryService.getAllCategories();
    // print("Response ="+response.body);
    print("Response = Json =" + jsonDecode(response.body).toString());
    data =  await AllCategoryList.fromJson(jsonDecode(response.body));
//    this.setState(() {
//      data = AllCategoryList.fromJson(jsonDecode(response.body));
//    });
  }

  @override
  void initState() {
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Fast National Tender Service Provider"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new ListView.builder(
              itemCount: data == null ? 0 : data.categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
                  child: GestureDetector(
                    child: new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      elevation: 5,
                      child: new InkWell(
                          onTap: () {
                             
                          },
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        data.categoryList[index].categoryName,
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          data.categoryList[index].amount+": "+AppTranslations.of(context).text(LangFile.TENDER_ACTIVE),
                                          style: TextStyle(
                                              color: Colors.red[600],
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 5, 2),

                                child: new Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        data.categoryList[index].subCatList,
                                        style: TextStyle(
                                            color: Colors.blueGrey[900], fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.blue[600],
                                      size: 16),

                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                );
              }),
        ));
  }
}
