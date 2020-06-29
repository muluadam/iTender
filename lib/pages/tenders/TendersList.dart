import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/model/ModelTender.dart';
import 'package:itenders/model/category.dart';
import 'package:itenders/services/TenderService.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/utils/OfflineUtility.dart';
import 'package:itenders/utils/RouteLink.dart';

class TendersListP extends StatefulWidget {
  final String id, name;

  TendersListP(this.id, this.name);

  @override
  _TendersListState createState() => _TendersListState();
}

class _TendersListState extends State<TendersListP> {
  ModelCategory category;

  // _DetailScreenState(this.category);

  TendersList data;

  Future<dynamic> getData(String id) async {
    var response = await TenderService.getTendersByCategory(id);
    // print("Response ="+response.body);
   // print("Response = Json =" + jsonDecode(response.body).toString());

      data = TendersList.fromJson(jsonDecode(response.body));
    if (mounted) { // Avoid calling `setState` if the widget is no longer in the widget tree.
      setState(() {
        data = TendersList.fromJson(jsonDecode(response.body));
        //;getData(id)
      });
    }
    return data;
  }


  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    getData(widget.id);
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
        title: new Text(widget.name),
    ),
    body:displayWidget(),
    );
  }
  Widget displayWidget() {

    return FutureBuilder(
      future: getData(widget.id),
      builder: (BuildContext context, AsyncSnapshot projectSnap) {
        if (projectSnap.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.red[900]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.green[900]),
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
