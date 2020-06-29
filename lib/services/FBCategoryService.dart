
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:itenders/model/model_sub_category.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/utils/FlutterIdGenerator.dart';
import 'package:webfeed/domain/media/category.dart';

class FBCategoryService{
  static final _firestore = Firestore.instance;
  static Future<List<ModelSubCategory>> getAllSubCategories()async{
    List<ModelSubCategory> subCatList=[];
    Map<String, dynamic> cat;
    var document= await Firestore.instance.collection("subcategory").document();
     QuerySnapshot snapshot = await Firestore.instance
        .collection("subcategory")
        .orderBy('CATEGORY_ID',descending: false)
        .getDocuments();
    Map<String,dynamic> attributeMap = new Map<String,dynamic>();
    snapshot.documents.toList().forEach((jj) => {
      attributeMap["ID"] =jj.documentID,
      attributeMap['SUB_CATEGORY_NAME_AM']=jj.data['SUB_CATEGORY_NAME_AM'].toString(),
      subCatList.add(ModelSubCategory.fromJson(attributeMap))
    });

    return subCatList;
  }


  static Future<void> saveSelectedCategories(String customerID, List<String> selectedCategories) async{


  Map<String,dynamic> maplist;

    for(int i=0;i<selectedCategories.length;i++){
    maplist={
      selectedCategories[i].toString()
    :selectedCategories[i]

    };

    }


      var doc= await _firestore
        .collection('customers')
        .document(customerID).updateData({'SELECTED_CAT':selectedCategories})

        .then((doc) {

          MyWidgets.showGreenToast('Category icuss Selected');
    })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
      print("doc save error");
      print(error);
    });

  }

  static Future<List<ModelSubCategory>>getCategoryByCustomerId()async{


    var doc= await _firestore
        .collection('customers')
        .document('customerID').get();


  }

}