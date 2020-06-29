import 'package:time/time.dart';

class DateUtility{
  static String getCurrentTimeStamp(){
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String getEXPDates(){
    DateTime expdate= 5.days.fromNow;
    print(expdate.millisecondsSinceEpoch.toString());
    return expdate.millisecondsSinceEpoch.toString();
  }
}