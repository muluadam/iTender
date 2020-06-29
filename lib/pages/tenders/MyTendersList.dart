import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itenders/localization/app_translations.dart';
import 'package:itenders/model/ModelTender.dart';
import 'package:itenders/model/category.dart';
import 'package:itenders/pages/tenders/DetailScreen.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/services/FBTenderService.dart';
import 'package:itenders/services/TenderService.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/utils/ListUtiltiy.dart';
import 'package:itenders/utils/OfflineUtility.dart';
import 'package:itenders/utils/RouteLink.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';

class MyTendersList extends StatefulWidget {
  // final String id, name;

  //OfflineTendersListP(this.id, this.name);

  @override
  _TendersListState createState() => _TendersListState();
}

class _TendersListState extends State<MyTendersList> {
  ModelCategory category;

  int cid = 0;
  String cutomerName = "name";
  String companyName = "";
  List<String> myRegionIDList = [];
  List<String> myCategoryIDList = [];
  List<String> myRegionNameList = [];
  List<String> myCategoryNameList = [];

  void getPreferenceData() async {
    cid = await SharedPreferencHelper.getCustomerId();
    companyName = await SharedPreferencHelper.getCompanyName();
    cutomerName = await SharedPreferencHelper.getCustomerName();
    myCategoryIDList = await SharedPreferencHelper.getSelectedCategoryList();
    myRegionIDList = await SharedPreferencHelper.getSelectedRegionList();
    myRegionNameList = await SharedPreferencHelper.getSelectedRegionNamesList();
    myCategoryNameList =
        await SharedPreferencHelper.getSelectedCategoryNamesList();
    if (this.mounted) {
      setState(() {

      });
    }
  }

  TendersList data;

  Future<dynamic> getData() async {
data= await FBTenderService.getTenders();
    print('Tenders List=='+data.tendersList.length.toString());


 return data;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
  //    getData();
    });
     // getData();
    ///super.initState();
  }
//  Future getdata() async{
//    data= await FBTenderService.getAllTenders();
//    var data=Firestore.instance.collection("tenders");
//    return data.document();
//  }


  Widget getWidgets(){
    return FutureBuilder(
       future: getData(),
      builder: (BuildContext context,AsyncSnapshot projectSnap){
         if(projectSnap.connectionState!=ConnectionState.done){
           return Center(
             child: CircularProgressIndicator(
               backgroundColor: Colors.red[600],

             ),
           );
         }else {

           return ListView.builder(
               itemCount: projectSnap.data==null?0:projectSnap.data.tendersList.length,
               itemBuilder: (context,index){
                 return GestureDetector(
                   child: Slidable(
                     actionPane: SlidableDrawerActionPane(),
                     actionExtentRatio: 0.25,
                   child: new Card(
                     shape: RoundedRectangleBorder(
                       borderRadius: const BorderRadius.all(
                         Radius.circular(8.0),
                       ),
                     ),
                     elevation: 5,
                     child: new InkWell(
                       onTap: () {

                         MyWidgets.showGreenToast(projectSnap.data.tendersList[index].tenderId.toString());
                                 try {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) =>
                                     DetailScreen(
                                         projectSnap.data.tendersList[index]
                                             .tenderId
                                             .toString(),
                                         projectSnap.data.tendersList[index]
                                             .name.toString(),
                                       projectSnap.data.tendersList[index]
                                           .name.toString(),
                                     ),
//                            settings: RouteSettings(
//                                arguments: data.categoryList[index]
                                 // )
                               ));
                         } catch (e) {
                           print("error" + e.toString());
                         }
                       },
                       child: Container(
                         padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                         child: Column(
                           children: <Widget>[
                             Column(
                               children:<Widget>[
                                 Column(
                                   children:<Widget>[ Text(
                                   projectSnap.data.tendersList[index].name.toString(),
                                   style: TextStyle(
                                       color: Colors.blue,
                                       fontSize: 15,
                                       fontWeight: FontWeight.bold),
                               )],
                                 )],
                             ),
                             SizedBox(height: 3),
                             Row(
                               children:<Widget>[ Text(
                                 projectSnap.data.tendersList[index].org.toString(),
                                 style: TextStyle(color: Colors.black),
                               )],
                             ),
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: <Widget>[
                                 Text(
                                     AppTranslations.of(context)
                                         .text(LangFile.TENDER_POSTED_DATE),
                                     style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold)),
                                 Text(projectSnap.data.tendersList[index].postedDateEC.toString() + ":",
                                     style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold)),
                                 Text(
                                     AppTranslations.of(context)
                                         .text(LangFile.TENDER_DEADLINE),
                                     style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold)),

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
                                 Text(projectSnap.data.tendersList[index].cpo.toString() + ":",
                                     style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold)),
                                 Text(
                                     AppTranslations.of(context)
                                         .text(LangFile.TENDER_SOURCE),
                                     style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold)),

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
                                 Text(projectSnap.data.tendersList[index].phone.toString() + "",
                                     style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold)),
                                 Text(projectSnap.data.tendersList[index].phone.toString() + "",
                                     style: TextStyle(
                                         color: Colors.black,
                                         fontWeight: FontWeight.bold)),

                               ],
                             ),
                           ],
                         ),
                       ),
                     ),

                   ),
                     actions: <Widget>[
                       IconSlideAction(
                         caption: 'Archive',
                         color: Colors.blue,
                         icon: Icons.archive,
                         onTap: () => MyWidgets.showGreenToast('Archive'),
                       ),
                       IconSlideAction(
                         caption: 'Share',
                         color: Colors.indigo,
                         icon: Icons.share,
                         onTap: () => MyWidgets.showGreenToast('Share'),
                       ),
                     ],
                     secondaryActions: <Widget>[
                       IconSlideAction(
                         caption: 'More',
                         color: Colors.black45,
                         icon: Icons.more_horiz,
                         onTap: () => MyWidgets.showGreenToast('More'),
                       ),
                       IconSlideAction(
                         caption: 'Delete',
                         color: Colors.red,
                         icon: Icons.delete,
                         onTap: () => MyWidgets.showGreenToast('Delete'),
                       ),
                     ],
                 )
                 );
               });
         }

      },
    )
    ;
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: getWidgets(),
  );
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
