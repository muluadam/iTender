class Customer {
  String  fullName, companyName,mobile;

  int customerId,status;
  DateTime registrationDate,expDate,lastLogin;

  Customer({this.customerId,
    this.fullName,
    this.companyName,
    this.mobile,
     });

   factory Customer.from(Map<String, dynamic> ca) {
    Map<String, dynamic> cat=ca["customer"][0];
    print(cat);
   return   Customer.fromJsonToObj(cat);

  }
  factory Customer.fromJsonToObj(Map<String, dynamic> cat) {
    //Map<String, dynamic> cat=ca["customer"];
    return Customer(
        customerId: int.parse(cat["CUSTOMER_ID"]),
        companyName: cat['ORGANIZATION_NAME'],
        mobile: cat['MOBILE'],
        fullName: cat['USER_FULL_NAME']);
  }
  factory Customer.fromJson(Map<String, dynamic> cat) {
 // Map<String, dynamic> cat=ca["customer"];
    return Customer(
        customerId: cat["CUSTOMER_ID"],
        companyName: cat['ORGANIZATION_NAME'],
        mobile: cat['MOBILE'],
        fullName: cat['USER_FULL_NAME']);
  }
}
