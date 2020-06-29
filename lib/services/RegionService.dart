import 'dart:convert';


import 'package:http/http.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';
 import 'package:itenders/utils/UrlNames.dart';

class RegionService {
 static Future<Response> getAllRegions() async {
   int  val=await SharedPreferencHelper.getLanguageId();
   print("Language =="+val.toString());


   int cid= await SharedPreferencHelper.getCustomerId();

   var requestBody = {
     "languageId": val.toString(),
   };
   String url= UrlNames.URL_PLACE_OF_WORK;
   Response response = await post(url,body: requestBody);
   return response;
 }


 static Future<Response> updateUserRegion(int userId,String list) async{
   String url=UrlNames.URL_PLACE_OF_WORK_UPDATE;
   var requestBody={
     'userId':userId.toString(),
     'userPlaceOfWork':list.toString()
   };
   Response response = await post(url,body: requestBody);
   return response;

 }
 static Future<Response> saveUserRegion(int userId,String list) async{
   String url=UrlNames.URL_PLACE_OF_WORK_SAVE;
   var requestBody={
     'userId':userId.toString(),
     'userPlaceOfWork':list.toString()
   };
   Response response = await post(url,body: requestBody);
   return response;

 }




  static Future<Response> loginWith(
      String mobile, String imei, String password) async {
    String url = UrlNames.URL_LOGIN;
    var requestBody = {'mobile': mobile, 'imei': imei, 'password': password};
    Response response = await post(url, body: requestBody);
 print("LoginBody=1="+response.body);
    return response;
  }
}
