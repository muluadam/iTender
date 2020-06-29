import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' ;
import 'package:itenders/utils/SharedPreferenccHelper.dart';
import 'package:itenders/utils/UrlNames.dart';

class TenderService{
  static Future<Response> getTendersByCategory(String categoryId)async{
   // String url= UrlNames.URL_TENDER_CATEGORY;


    String lang="2";
    String cid="130";
    var requestBody = {
      "languageId": lang.toString(),
      'categoryId':categoryId.toString(),
      'customerId':cid.toString()
    };
    String url= UrlNames.URL_GET_TENDERS_LIST;
    Response response = await post(url,body: requestBody);
    return response;
  }
  static Future<Response> getTenderDetailById(String tenderId)async{
    // String url= UrlNames.URL_TENDER_CATEGORY;


    String lang="2";
    String cid="130";
    var requestBody = {
      "tenderId":tenderId.toString(),
    };
    String url= UrlNames.URL_GET_TENDERS_DETAIL;
    Response response = await post(url,body: requestBody);
    print(response.body);
    return response;
  }


//  static Future<http.Response> getTendersByCategory(String categoryId) async {
//  //  int  lang=await SharedPreferencHelper.getLanguageId();
//    //int cid= await SharedPreferencHelper.getCustomerId();
//
//    String lang="2";
//    String cid="130";
//    var requestBody = {
//      "languageId": lang.toString(),
//      'categoryId':categoryId.toString(),
//      'customerId':cid.toString()
//    };
//    print(requestBody);
//    var babe = json.encode(requestBody);
//
//    String url= UrlNames.URL_GET_TENDERS_LIST;
//    print(url);
//    try {
//      var data = await http.post(url, body:  babe, headers: {
//      "Accept": "application/json"});
//
//      print("Res=)"+json.decode(data.body));
//
//      return data;
//    }catch(e){print(e);
//
//    }
//
//  }

  }