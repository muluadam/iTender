import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/model/ModelTender.dart';
import 'package:itenders/model/category.dart';
import 'package:itenders/services/TenderService.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/utils/OfflineUtility.dart';
import 'package:itenders/utils/RouteLink.dart';


class TendersListPages extends StatelessWidget {

  final String id, name;

  TendersListPages(this.id, this.name);
  ModelCategory category;

  // _DetailScreenState(this.category);

  TendersList data;

  Future<dynamic> getData(String id) async {
    var response = await TenderService.getTendersByCategory(id);
    data = TendersList.fromJson(jsonDecode(response.body));
   return data;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(name),
      ),
      body:displayWidget(),
    );
  }





  Widget displayWidget() {

    return FutureBuilder(

      future: getData(id),
      builder: (BuildContext context, AsyncSnapshot projectSnap) {
        if (projectSnap.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.red[900]),
          );
        } else {
          return  new ListView.builder(
                  itemCount: data.tendersList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: new Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                          child: Column(
                            children: <Widget>[
                              Text(
                                data.tendersList[index].name,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3),
                              Text(
                                data.tendersList[index].org,
                                style: TextStyle(color: Colors.black),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                      AppTranslations.of(context)
                                          .text(LangFile.TENDER_POSTED_DATE),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(data.tendersList[index].postedDateEC + ":",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      AppTranslations.of(context)
                                          .text(LangFile.TENDER_DEADLINE),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(data.tendersList[index].postedDateEC),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                      AppTranslations.of(context)
                                          .text(LangFile.TENDER_CPO),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(data.tendersList[index].cpo + ":",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      AppTranslations.of(context)
                                          .text(LangFile.TENDER_SOURCE),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(data.tendersList[index].source),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                      AppTranslations.of(context)
                                          .text(LangFile.TENDER_PHONE),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(data.tendersList[index].phone + "",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      AppTranslations.of(context)
                                          .text(LangFile.TENDER_SEEN),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  Icon(
                                    Icons.check,
                                    size: 15,
                                    color: Colors.blue[900],
                                  )
                                ],
                              ),
                              ButtonTheme.bar(
                                child: new ButtonBar(

                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      ),
                                      color: Color.fromRGBO(68, 153, 213, 1.0),
                                      shape: CircleBorder(),
                                      onPressed: () {
                                    //    URLLauncher.launch("tel:"+data.tendersList[index].phone);
                                        //  MyWidgets.showGreenToast("Calling to "+data.tendersList[index].org);
                                        //  _initCall(data.tendersList[index].phone);

                                      },
                                    ),
                                    FlatButton(
                                      child: Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      ),
                                      color: Color.fromRGBO(68, 153, 213, 1.0),
                                      shape: CircleBorder(),
                                      onPressed: () {
                                        OfflineUtility.saveTender(
                                            data.tendersList[index]);
                                        //  print("Tender ID="+data.tendersList[index].tenderId.toString());
                                      },
                                    ),
                                    FlatButton(
                                      color: Color.fromRGBO(161, 108, 164, 1.0),
                                      child: const Text('Read '),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(30.0)),
                                      textColor: Colors.white,
                                      onPressed: () async{
                                        // await OfflineUtility.saveToSean(data.tendersList[index].tenderId.toString());
                                        //  OfflineUtility.getAllSaved();
                                        TenderService.getTenderDetailById(data.tendersList[index].tenderId);
                                        // Navigator.pushNamed(context, RouteLink.ROUTE_TENDER_DETAIL);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );


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
