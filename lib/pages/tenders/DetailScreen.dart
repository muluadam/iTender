import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:itenders/model/ModelTender.dart';
import 'package:itenders/model/category.dart';
import 'package:itenders/services/TenderService.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

//import 'package:html/dom.dart';
class DetailScreen extends StatefulWidget {
  // final ModelCategory category;
 final  String id,name,detail;

 DetailScreen(this.id,this.name,this.detail) ;
 // DetailScreen({Key key, @required this.category}) : super(key: key));

  @override
   _DetailScreenState createState() => new _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

Future<dynamic> getDetailTender()async{
  return  await Firestore.instance
      .collection("tender").document(widget.id).get();

}


  @override
  void initState() {
    // TODO: implement initState

    //this.getData(widget.id);
    super.initState();
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
Widget displayWidget(){
  return FutureBuilder(
      future: getDetailTender(),
      builder: (BuildContext context, AsyncSnapshot projectSnap) {
        if (projectSnap.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(
                backgroundColor: Colors.red[900]),
          );
        } else {
          return ListView.builder(
            //  itemCount: projectSnap.data.length,

              itemCount: projectSnap.data == null ? 0 : 1,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                            child: Html(data:projectSnap.data['TENDER_DETAIL'])
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      });

}
  Widget buildold(BuildContext context) {
   return new FutureBuilder(
   // future:getData(id.toString()),
    builder: (BuildContext context, AsyncSnapshot snapshot){

      while(widget.detail==null){
        return new CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 5.0,
          percent: 1.0,
          center: new Text("100%"),
          progressColor: Colors.green,
        );

      }

      return ListView.builder(
        itemCount:1,
        itemBuilder: (BuildContext context, int index) {

            return new  Card(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(widget.name.toString(),
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                    Text(widget.detail.toString(),
                      style: TextStyle(color: Colors.blue),),

                          ],

                ),

              ),
                 );
        },
      );

    },
  );
}

//
//
//  @override
//  Widget build(BuildContext context) {
//    final ModelCategory modelCategory = ModalRoute.of(context).settings.arguments;
//
//    getData(modelCategory.categoryId);
//
//    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text("Fast National Tender Service Provider"),
//
//        ),
//        body: new ListView.builder(
//            itemCount: data == null ? 0 : data.tendersList.length,
//            itemBuilder: (BuildContext context, int index) {
//              return new Card(
//                elevation: 5,
//                child: new InkWell(
//
//                    onTap: (){
//                      print("Clicked ="+data.tendersList[index].name);
////                      Navigator.push(
////                          context,
////                          MaterialPageRoute(builder: (context)=>DetailScreen(),
////                              settings: RouteSettings(
////                                  arguments: data.tendersList[index]
////                              )
////
////                          ));
//                    },
//
//                    child: new  Column(
//                      children: <Widget>[
//                        Container(
//                          child: new Row(
//                            children: <Widget>[
//                              Expanded(
//                                child: Text(data.tendersList[index].name,
//                                  style: TextStyle(
//                                      color: Colors.blue[900],
//                                      fontSize: 15,
//                                      fontWeight: FontWeight.bold
//                                  ),),
//                              ),
//
//                            ],
//                          ),
//                        ),
//                        Container(
//                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//
//                          child: Text(data.tendersList[index].org,
//                            style: TextStyle(
//
//                                color:Colors.blueGrey[900],
//                                fontSize: 10
//                            ),),
//                        ),
//
//
//ButtonBar(
//  children: <Widget>[
//    FlatButton(
//      child: const Text('BUY TICKETS'),
//      onPressed: () { /* ... */ },
//    ),
//    FlatButton(
//      child: const Text('LISTEN'),
//      onPressed: () { /* ... */ },
//    ),
//  ],
//)
//
//
//
//                      ],
//
//                    )
//
//                ),
//              );
//            })
//    );
//  }
}
