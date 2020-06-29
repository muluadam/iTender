

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itenders/model/model_region.dart';

class FBRegionService {
  static final _firestore = Firestore.instance;
  static Future<List<ModelRegion>> getAllRegions()async{
    List<ModelRegion> subCatList=[];
    Map<String, dynamic> cat;
    var document= await Firestore.instance.collection("regions").document();
    QuerySnapshot snapshot = await Firestore.instance
        .collection("regions")
        .getDocuments();
    print('Here I am ');
    Map<String,dynamic> attributeMap = new Map<String,dynamic>();
    snapshot.documents.toList().forEach((jj) => {

      attributeMap["ID"] =jj.documentID,
      attributeMap['REGION_NAME_AM']=jj.data['REGION_NAME_AM'].toString(),

      subCatList.add(ModelRegion.fromJson(attributeMap))

    });
 //   print('Size='+subCatList.length.toString());

    return subCatList;
  }



  static Future<void> saveSelectedRegions(String customerID, List<String> selectedRegions) async{


    Map<String,dynamic> maplist;

    for(int i=0;i<selectedRegions.length;i++){
      maplist={
        selectedRegions[i].toString()
            :selectedRegions[i]

      };

    }


    var doc= await _firestore
        .collection('customers')
        .document(customerID).updateData({'SELECTED_REGION':selectedRegions})

        .then((doc) {

     })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
      print("doc save error");
      print(error);
    });

  }


}