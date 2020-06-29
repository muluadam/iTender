import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/model/category.dart';
import 'package:itenders/pages/tenders/DetailScreen.dart';
import 'package:itenders/pages/tenders/TendersList.dart';
import 'package:itenders/pages/tenders/TendersListPages.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/services/CategoryService.dart';
import 'package:itenders/utils/LangFile.dart';

class AllCatWidget   extends StatelessWidget {

  AllCategoryList data;

  Future<dynamic> getData() async {
    var response = await CategoryService.getAllCategories();
    print("Response LESS =" + response.body);
    // print("Response = Json =" + jsonDecode(response.body).toString());
    data = AllCategoryList.fromJson(jsonDecode(response.body));

    return data;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: projectWidget(),
    );
    //  projectWidget();

  }


  Widget projectWidget() {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot projectSnap) {
        if (projectSnap.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.red[900]),
          );
        } else {
          return ListView.builder(
            //  itemCount: projectSnap.data.length,

              itemCount: projectSnap.data == null ? 0 : projectSnap.data
                  .categoryList.length,
              itemBuilder: (context, index) {
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
                            //print("Clicked  on tap="+data.categoryList[index].categoryName);
                            MyWidgets.showGreenToast(
                                  projectSnap.data.categoryList[index]
                                    .categoryName);
                           // Navigator.of(context).pop();
                            try {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TendersListPages(
                                            projectSnap.data.categoryList[index]
                                                .categoryId
                                                .toString(),
                                            projectSnap.data.categoryList[index]
                                                .categoryName.toString()),
//                            settings: RouteSettings(
//                                arguments: data.categoryList[index]
                                    // )
                                  ));
                            } catch (e) {
                              print("error" + e.toString());
                            }
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        projectSnap.data.categoryList[index]
                                            .categoryName,
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          projectSnap.data.categoryList[index]
                                              .amount +
                                              ": " +
                                              AppTranslations.of(context).text(
                                                  LangFile.TENDER_ACTIVE),
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
                                        projectSnap.data.categoryList[index]
                                            .subCatList,
                                        style: TextStyle(
                                            color: Colors.blueGrey[900],
                                            fontSize: 14),
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
              });
        }

//        if (projectSnap.hasData) {
//          MyWidgets.showGreenToast('has data');
//          children = <Widget>[
//            Icon(
//              Icons.check_circle_outline,
//              color: Colors.green,
//              size: 60,
//            ),
//            Padding(
//              padding: const EdgeInsets.only(top: 16),
//              child: Text('Result: ${projectSnap.data}'),
//            )
//          ];
//        } else if (projectSnap.hasError) {
//          MyWidgets.showGreenToast('has Erorr');
//
//          children = <Widget>[
//            Icon(
//              Icons.error_outline,
//              color: Colors.red,
//              size: 60,
//            ),
//            Padding(
//              padding: const EdgeInsets.only(top: 16),
//              child: Text('Error: ${projectSnap.error}'),
//            )
//          ];
//        } else {
//          MyWidgets.showGreenToast('has progess ');
//
//          children = <Widget>[
//            SizedBox(
//              child: CircularProgressIndicator(),
//              width: 60,
//              height: 60,
//            ),
//            const Padding(
//              padding: EdgeInsets.only(top: 16),
//              child: Text('Awaiting result...'),
//            )
//          ];
//        }


      },
    );
  }


}




