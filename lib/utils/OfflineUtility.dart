import 'dart:io';

import 'package:intl/intl.dart';
import 'package:itenders/db/SavedTender.dart';
import 'package:itenders/db/TenderDatbase.dart';
import 'package:itenders/model/ModelTender.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';

class OfflineUtility {
  static int saveTender(ModelTender savedTender) {
    TenderDatabase database = new TenderDatabase();
    database.addTender(savedTender);
    return 1;
  }
static Future<List<ModelTender>> getAllSaved() async{
  TenderDatabase database = new TenderDatabase();
List<ModelTender> tenders=  await database.fetchAll();
//  var it = obj.iterator;
//  while (it.moveNext()) {
//    use(it.current);
//  }

//  var t=tenders.iterator;
//  while(t.moveNext()){
//    print(t.current.org);
//  }
return await tenders;
}
  static Future<TendersList> getAllTendersList() async{
    TenderDatabase database = new TenderDatabase();
    List<ModelTender> tenders=  await database.fetchAll();
    TendersList data=TendersList(tenders);

    return   data;
  }

  static void saveToSean(String tenderId) async {
    //  print("adding="+tenderId);
    var sp = SharedPreferencHelper.setSavedList(tenderId);

    List<String> list = await SharedPreferencHelper.getSavedList();

    if (list == null) {
    //  print("print added" + tenderId);
      list.add(tenderId.toString());
    } else {
      if (!list.contains(tenderId.toString())) {
      //  print("Print Seen=" + tenderId.toString());
        list.add(tenderId.toString());
      }
    }
  }
}
