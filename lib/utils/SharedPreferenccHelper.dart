import 'dart:async';


import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencHelper{

  static final String langaugeCode="LANGUAGE_CODE";
  static final String customerId="CUSTOMER_ID";
  static final String customerName="CUSTOMER_NAME";
  static final String companyName="COMPANY_NAME";
  static final String customerEmail="CUSTOMER_EMAIL";
  static final String selectedCat="SELECTED_CATEGORY";
  static final String selectedCatNames="SELECTED_CATEGORY_NAMES";
  static final String selectedReg="SELECTED_REGION";
  static final String selectedRegNames="SELECTED_REGION_NAMES";
  static final String languageId="LANGUAGE_ID";

  static final String seenTender="SEEN_TENDERS";
  static final String savedTender="SAVED_TENDERS";

static final List<String> lists= new List<String>();


  Future<void> addToSeenList(String tenderId){

    }


 static Future<List<String>> getSavedList() async{
  SharedPreferences preferenceHelper= await SharedPreferences.getInstance();
  //lists.add("1");
 // preferenceHelper.setStringList(savedTender, lists);
  return preferenceHelper.getStringList(savedTender);

  }

  static void setSavedList(String tenderId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lists.add(tenderId);
      await prefs.setStringList(savedTender, lists);
  }
  static Future<List<String>> getSelectedCategoryNamesList() async{
    SharedPreferences preferenceHelper= await SharedPreferences.getInstance();
    List<String> empty=new List<String>();
    return await preferenceHelper.getStringList(selectedCatNames)==null?empty:preferenceHelper.getStringList(selectedCatNames);

  }

  static Future<void> setSelectedCategoryNamesList(List<String> list)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(selectedCatNames, list);
  }
  static Future<List<String>> getSelectedRegionNamesList() async{
    SharedPreferences preferenceHelper= await SharedPreferences.getInstance();
    List<String> empty=new List<String>();
    return await preferenceHelper.getStringList(selectedRegNames)==null?empty:preferenceHelper.getStringList(selectedRegNames);
  }
  static Future<void> setSelectedRegionNamesList(List<String> list)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(selectedRegNames, list);
  }
  static Future<List<String>> getSelectedCategoryList() async{
    SharedPreferences preferenceHelper= await SharedPreferences.getInstance();
    List<String> empty=new List<String>();

    return preferenceHelper.getStringList(selectedCat)==null?empty:preferenceHelper.getStringList(selectedCat);

  }

  static Future<void> setSelectedCategoryList(List<String> list)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(selectedCat, list);
  }
  static Future<List<String>> getSelectedRegionList() async{
    SharedPreferences preferenceHelper= await SharedPreferences.getInstance();
    List<String> empty=new List<String>();
    return  preferenceHelper.getStringList(selectedReg)==null?empty:preferenceHelper.getStringList(selectedReg);
  }

  static Future<void> setSelectedRegionList(List<String> list)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(selectedReg, list);
  }

  static Future<List<String>> getSeenList() async{
    SharedPreferences preferenceHelper= await SharedPreferences.getInstance();
    return await preferenceHelper.getStringList(seenTender);

  }

  static Future<void> setSeenList(List<String> list)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(seenTender, list);
  }


  static Future<bool> contains(String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.containsKey(value);

  }

  static Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(langaugeCode)==null ? 'am':prefs.getString(langaugeCode);
  }
  static Future<void> setLanguageCode(String code)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(langaugeCode, code);
  }


  static Future<int> getCustomerId()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     return (prefs.getInt(customerId)!=null ?prefs.getInt(customerId): 0 );
  }
 static Future<void> setCustomerId(int id) async{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   print('SETing ID='+id.toString());
   return prefs.setInt(customerId, id);
 }
  static Future<String> getCustomerName()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(customerName);
  }
  static Future<void> setCustomerName(String name) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(customerName,name);

  }
  static Future<String> getCompanyName()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(companyName);
  }
  static Future<void> setCompanyName(String name) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(companyName,name);

  }
  static Future<int> getLanguageId()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int lang=prefs.getInt(languageId);
    return (lang==null?2:lang);
  }
  static Future<void> setLanguageId(String id) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(languageId, int.parse(id));

  }

}