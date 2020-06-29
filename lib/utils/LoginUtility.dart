import 'package:itenders/utils/SharedPreferenccHelper.dart';

class LoginUtility{

  static void setLoginInfo(int customerId, String customerName, String compnayName)async{
    SharedPreferencHelper.setCustomerId(customerId);
    SharedPreferencHelper.setCustomerName(customerName);
    SharedPreferencHelper.setCompanyName(customerName);
    int cid=await SharedPreferencHelper.getCustomerId();
    print("Registred CID=="+cid.toString());


  }
}