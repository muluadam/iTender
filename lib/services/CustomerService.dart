import 'dart:convert';

import 'package:http/http.dart';
import 'package:itenders/pages/widgests/MyWidgets.dart';
import 'package:itenders/utils/LangFile.dart';
import 'package:itenders/utils/UrlNames.dart';

class CustomerService {


  static Future<Response> checkLogin(String name, String org, String mobile,
      String imei, String ssn, String email, String password) async {
    String url = UrlNames.URL_REGISTER_CUSTOMER;
    print('URL=='+url);
    var requestBody = {
      "name": name,
      "organization": org,
      "mobile": mobile,
      "imei": imei,
      "ssn": ssn,
      "email": email,
      "password": password
    };
    Response response = await post(url, body: requestBody);
//    Map data= jsonDecode(response.body);

    String statusCode = response.statusCode.toString();
    print("Status Code="+statusCode);
    return response;
  }


  static Future<Response> loginWith(
      String mobile, String imei, String password) async {
    String url = UrlNames.URL_LOGIN;
    var requestBody = {'mobile': mobile, 'imei': imei, 'password': password};
    Response response = await post(url, body: requestBody);
  //  print("LoginBody=1="+response.body);
    return response;
  }
static Future<Response> isPhoneRegistered(String imei) async{
  String url = UrlNames.URl_IS_COSTOMER_REGISTERED;
  var requestBody = {'imei': imei};
  Response response = await post(url, body: requestBody);

  return response;
}
  static Future<Response> requestPasswordChange(String mobile,String imei) async{
    String url = UrlNames.URL_CUSTOMER_PASS_CHANGE_REQ;
    var requestBody = {'imei': imei,'mobile':mobile};
    Response response = await post(url, body: requestBody);

    return response;
  }
  static Future<Response> changeMyPassword(String customerId,String password) async{
    String url = UrlNames.URL_CUSTOMER_PASS_CHANGE;
    var requestBody = {'customerId': customerId,'password':password};
    Response response = await post(url, body: requestBody);

    return response;
  }

}
