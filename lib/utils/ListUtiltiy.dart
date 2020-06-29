class ListUtility {
  static String getSortedString(List<String> data){
    if(data !=null){
      data.sort();

    }
    return data.toString();
  }
}