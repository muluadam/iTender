
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itenders/model/ModelTender.dart';

class FBTenderService{

static Future<TendersList> getTenders() async{
  List<ModelTender> tenderList=[];
  ModelTender model=null;
  Map<String,dynamic> tenderMap = new Map<String,dynamic>();
  QuerySnapshot snapshot = await Firestore.instance
      .collection("tender")
      .getDocuments();
  snapshot.documents.toList().forEach((t)=>{
//print("NAMe=="+t.data['TENDER_NAME']),
  tenderMap['TENDER_ID']=t.documentID,
  tenderMap['TENDER_NAME']=t.data['TENDER_NAME'],
      tenderMap['ORGANIZATION']=t.data['ORGANIZATION'],
      tenderMap['CPO']=t.data['CPO'],
  tenderMap['PHONE_NUMBER']=t.data['PHONE_NUMBER'],
  tenderMap['POSTED_DATE_EC']=t.data['POSTED_DATE_EC'],
  tenderMap['POSTED_DATE_GC']=t.data['POSTED_DATE_GC'],
  tenderMap['DEADLINE_EC']=t.data['DEADLINE_EC'],
  tenderMap['DEADLINE_GC']=t.data['DEADLINE_GC'],
  tenderMap['SOURCE_NAME']=t.data['SOURCE_NAME'],
  tenderMap['CATEGORY']='t.data[],',
  tenderMap['PLACE_OF_WORK']=t.data['PLACE_OF_WORK'],

    model=  ModelTender.fromJson(tenderMap),
    print('ORG='+model.org),
    tenderList.add(model)
  });
  return  await TendersList(tenderList);

}


}