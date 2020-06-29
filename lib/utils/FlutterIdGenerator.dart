
class FlutterIdGenerator {

    static String getID(){
      DateTime  dateTime= new DateTime.utc(2030);
     var dif=dateTime.millisecondsSinceEpoch-DateTime.now().millisecondsSinceEpoch;
 return dif.toString().substring(4);
  }

}