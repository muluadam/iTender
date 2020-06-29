import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/model/ModelTender.dart';
import 'package:itenders/model/category.dart';
import 'package:itenders/services/TenderService.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/utils/OfflineUtility.dart';

class OfflineTendersListP extends StatefulWidget {
 // final String id, name;

  //OfflineTendersListP(this.id, this.name);

  @override
  _TendersListState createState() => _TendersListState();
}

class _TendersListState extends State<OfflineTendersListP> {
  ModelCategory category;

  // _DetailScreenState(this.category);

  TendersList data;

  Future<dynamic> getData() async {

    data=  await OfflineUtility.getAllTendersList();
return data;

  }



  @override
  void initState()  {
super.initState();
     // getData();
  }

  @override
  Widget build(BuildContext context)   {
    getData();
    return Scaffold(

        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          child: ListView.builder  (
            itemCount:   data.tendersList.length,
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

                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

//  Widget loadData() {
//    return FutureBuilder(
//      builder: (context, projectSnap) {
//        if (projectSnap.connectionState == ConnectionState.none &&
//            projectSnap.data == null) {
//          //print('project snapshot data is: ${projectSnap.data}');
//          return Container();
//        }
//        return ListView.builder(
//          itemCount: data.tendersList.length,
//          itemBuilder: (context, index) {
//            return new  Card(
//              child: Container(
//                child: Column(
//
//                  children: <Widget>[
//                    Text(data.tendersList[index].name,
//                      style: TextStyle(
//                          color: Colors.blue[900],
//                          fontSize: 15,
//                          fontWeight: FontWeight.bold
//                      ),),
//                    Text(data.tendersList[index].org,
//                      style: TextStyle(color: Colors.blue),),
//
//                    Text(("Posted Date :${data.tendersList[index].postedDateEC})"),
//                      style: TextStyle(color: Colors.black),),
//
//
//
//                  ],
//
//                ),
//
//              ),
//
//
//            );
//
//
//
//          },
//        );
//      },
//      future: getData(widget.id),
//    );
//  }

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Fast National Tender Service Provider"),
      ),



      body: new ListView.builder(
      itemCount: data == null ? 0 : data.tendersList.length,
      itemBuilder: (BuildContext context, int index) {

                return new  Card(
                  child: Container(
                    child: Column(

                      children: <Widget>[
                        Text(data.tendersList[index].name,
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),),
                        Text(data.tendersList[index].org,
                          style: TextStyle(color: Colors.blue),),

                        Text(("Posted Date :${data.tendersList[index].postedDateEC})"),
                          style: TextStyle(color: Colors.black),),



                      ],

                    ),

                  ),


                );
              },

)


    );
  }
  */

}
