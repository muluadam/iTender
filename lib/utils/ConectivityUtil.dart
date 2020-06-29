import 'package:connectivity/connectivity.dart';


class ConnectivityUtil{

  static Future<bool> isConnected() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }else if(connectivityResult==ConnectivityResult.none){
      return false;
    }
    return false;
  }
}