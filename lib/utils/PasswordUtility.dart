import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class PasswordUtility{

  static String toSHA1(String plain){
    var bytes = utf8.encode(plain); // data being hashed

  return sha1.convert(bytes).toString();
  }
}
