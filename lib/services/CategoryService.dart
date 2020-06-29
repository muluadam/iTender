import 'dart:convert';


import 'package:http/http.dart';
import 'package:itenders/utils/SharedPreferenccHelper.dart';
 import 'package:itenders/utils/UrlNames.dart';

class CategoryService {
  static Future<Response> getAllSubCategories() async{
   int  val=await SharedPreferencHelper.getLanguageId();

   var requestBody = {
     "languageId": val.toString(),
   };
   String url= UrlNames.URL_TENDER_SUB_CATEGORY_LIST;
   Response response = await post(url,body: requestBody);
   return response;
 }
 static Future<Response> getAllCategories()async{
    String url= UrlNames.URL_TENDER_CATEGORY;
    int  val=await SharedPreferencHelper.getLanguageId();
    var requestBody = {
      "languageId": val.toString(),
    };
       Response response = await post(url,body: requestBody);
    return response;
 }

 static Future<Response> updateUserCategory(int userId,String list) async{
    String url=UrlNames.URL_TENDER_CATEGORY_UPDATE;
    var requestBody={
      'userId':userId.toString(),
      'userCategory':list.toString()
    };
    Response response = await post(url,body: requestBody);
    return response;

 }
  static Future<Response> saveUserCategory(int userId,String list) async{
    String url=UrlNames.URL_TENDER_CATEGORY_SAVE;
    var requestBody={
      'userId':userId.toString(),
      'userCategory':list.toString()
    };
    Response response = await post(url,body: requestBody);
    return response;

  }
  static Future<Response> loginWith(
      String mobile, String imei, String password) async {
    String url = UrlNames.URL_LOGIN;
    var requestBody = {'mobile': mobile, 'imei': imei, 'password': password};
    Response response = await post(url, body: requestBody);
 //print("LoginBody=1="+response.body);
    return response;
  }



}
