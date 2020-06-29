 

  class UrlNames {
    static String URL = "http://www.instant-systems.net/new1/ services/";
    static String HOST = "192.168.1.10";

   static String USER_NAME = "user_name";
   static String PASSWORD = "password";
   static String FULL_NAME = "full_name";
   static String PREFERENCE_NAME = "instanttenders";
   static String LANGUAGE = "am";

  // Server user login url
   static String URL_LOGIN = "http://www.instant-systems.net/new1/CustomerService/login";
   static String KEY_IS_LOGGEDIN = "isLoggedIn";

   static String URL_REGISTER_CUSTOMER = "http://www.instant-systems.net/new1/Customer/serviceRegister";
    static String URL_CUSTOMER_STATUS = "http://www.instant-systems.net/new1/CustomerService/status";
   static String URL_CUSTOMER_REMAINING_DATE = "http://www.instant-systems.net/new1/CustomerService/expdate";
   static String URL_CUSTOMER_PASS_CHANGE_REQ = "http://www.instant-systems.net/new1/CustomerService/changePasswordRequest";
   static String URL_CUSTOMER_PASS_CHANGE = "http://www.instant-systems.net/new1/CustomerService/changePassword";
   static String URl_IS_COSTOMER_REGISTERED = "http://www.instant-systems.net/new1/CustomerService/isPhoneRegistered";

   static String URL_CUSTOMER_EXT_DATE = "http://www.instant-systems.net/new1/CustomerService/expdate";

   static String URL_TENDER_CATEGORY = "http://www.instant-systems.net/new1/CategoryService/getCategoryList";
   static String URL_TENDER_SUB_CATEGORY_LIST = "http://www.instant-systems.net/new1/CategoryService/getSubCategoryList";
   static String URL_TENDER_CATEGORY_UPDATE = "http://www.instant-systems.net/new1/CategoryService/updateUserCategory";
   static String URL_TENDER_CATEGORY_SAVE = "http://www.instant-systems.net/new1/CategoryService/saveUserCategory";
   static String URL_TENDER_CATEGORY_BY_CUSTIMER_ID = "http://www.instant-systems.net/new1/CategoryService/getAllTenderCategoriesByCustomerId";
  //md5(byCustomerId)=50817d55809f438df5b48c8d1faeebfa
  //   3ac340832f29c11538fbe2d6f75e8bcc
//md3(save)==43781db5c40ecc39fd718685594f0956
   static String URL_EMAIL_SEND_WELCOME = "http://www.instant-systems.net/new1/mail/SendWelcomeEmail.php";
  ////cb0967062105f6e5f108a11bb956dcbd ==
   static String URL_GET_MY_TENDERS_ID_LIST = "http://www.instant-systems.net/new1/TenderService/getMyNewTenderIDs";
   static String URL_GET_MY_TENDERS_LIST = "http://www.instant-systems.net/new1/TenderService/getMyTendersList";
   static String URL_GET_TENDERS_LIST = "http://www.instant-systems.net/new1/TenderService/getTendersByCategory";
   static String URL_GET_TENDERS_LIST_WITH_P_AND_C = "http://www.instant-systems.net/new1/TenderService/getTendersByPlaceOfWorkAndCategory";
   static String URL_SAVE_TENDER_LOG = "http://www.instant-systems.net/new1/Log/save";


   static String URL_GET_TENDERS_DETAIL = "http://www.instant-systems.net/new1/TenderService/getDetailByID";
   static String URL_GET_DETAIL = "http://www.instant-systems.net/new1/services/ServiceTender.php?key=onlydetail";


   static String URL_GET_NEW_TENDERS_COUNT = "http://www.instant-systems.net/new1/services/ServiceTender.php?key=count";

   static String URL_GET_NEW_TENDERS_NOTIFICATION = "http://www.instant-systems.net/new1/TenderService/getTID4Notify";


   static String URL_PLACE_OF_WORK = "http://www.instant-systems.net/new1/RegionService/getRegionList";
  //md5(getId)
   static String URL_GET_PLACE_OF_WORK_ID = "http://www.instant-systems.net/new1/RegionService/getIdByName";

  // md5("update")=3ac340832f29c11538fbe2d6f75e8bcc
   static String URL_PLACE_OF_WORK_UPDATE = "http://www.instant-systems.net/new1/RegionService/updateUserWorkPlace";
   static String URL_PLACE_OF_WORK_SAVE = "http://www.instant-systems.net/new1/RegionService/saveUserWorkPlace";

   static String URL_BUSINESS_INFO_TITLES = "http://192.168.0.103/services/ServiceBusinessInfo.php?key=titles";
   static String URL_BUSINESS_INFO_DETAIL = "http://www.instant-systems.net/new1/code/services/ServiceBusinessInfo.php?key=detail";
  //GetByPlaceOFWork.php
  //GetByCategories.php?categoryId
  //{"error":false,"message":"Login Successfull!",
// "customer":[{"CUSTOMER_ID":"107","USER_FULL_NAME":"adam","ORGANIZATION_NAME":"adam",
// "MOBILE":"0913971996","EMAIL":"mtmuluadamt@gmail.com"}]}
   static String CUSTOMER_ID = "CUSTOMER_ID";
   static String USER_FULL_NAME = "USER_FULL_NAME";
   static String ORGANIZATION_NAME = "ORGANIZATION_NAME";
   static String MOBILE = "MOBILE";
   static String EMAIL = "EMAIL";
   static String EXP_DATE = "EXP_DATE";
   static String LAST_LOGIN = "LAST_LOGIN";
   static String LAST_SEEN = "LAST_SEEN";
   static String LAST_SEEN_TENDER_ID = "LAST_SEEN_TENDER_ID";
   static String IS_CATEGORY_SELECTED = "";
   static String IS_PLACE_OF_WORK_SELECTED = "";
   static String PAYMENT_STATUS = "0";

}
//md5('category)==c4ef352f74e502ef5e7bc98e6f4e493d