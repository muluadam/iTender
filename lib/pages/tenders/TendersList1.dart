import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itenders/model/ModelTender.dart';
import 'package:itenders/model/category.dart';
import 'package:itenders/services/TenderService.dart';
import 'package:itenders/utils/ConectivityUtil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
class TendersListP1 extends StatefulWidget {

  final  String id,name;
  TendersListP1(this.id,this.name);

  @override
  _TendersListState createState() => _TendersListState();
}

class _TendersListState extends State<TendersListP1> {

  ModelCategory category;
  // _DetailScreenState(this.category);

  TendersList data;



  Future<dynamic> getData(String id) async {
    var response = await TenderService.getTendersByCategory(id);
    // print("Response ="+response.body);
    print("Response = Json =" + jsonDecode(response.body).toString());
    this.setState(() {
data=TendersList.fromJson(jsonDecode(response.body));    });
  }

  // In the constructor, require a Todo.
//  Future getData(String id)async{  //  var response = await CategoryService.getAllCategories();
//      print("Response ="+id);
//   var response= await TenderService.getTendersByCategory(id);
//    print("id inside="+id);
//    print("Response = Json =" + jsonDecode(response.body).toString());
//    this.setState(() {
//      // data = AllCategoryList.fromJson(jsonDecode(response.body));
//      data=TendersList.fromJson(jsonDecode(response.body));
//
//    });
//  }

//  Future<dynamic> getData(String id)async{
//
//    print("id inside="+id);
//    try{
//      Response response= await TenderService.getTendersByCategory(id);
//      print("Data is============"+response.body);
//
//      data=TendersList.fromJson(jsonDecode(response.body));
//    }catch(e){print("Error="+e);}
//
//
//  }

  @override
  void initState() {
    // TODO: implement initState

    print("ID="+widget.id);
    this.getData(widget.id);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Fast National Tender Service Provider"),
      ),


      body: Container(


        child: FutureBuilder(
          future: getData(widget.id),
          builder: (BuildContext context, AsyncSnapshot sh){
            while(sh.data==null){
              new CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: 1.0,
                center: new Text("100%"),
                progressColor: Colors.green,
              );

            }
            ListView.builder(
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

            // ignore: missing_return
            );
            return null;
          },


        )
      )


    );
  }
}
