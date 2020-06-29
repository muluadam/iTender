class ModelRegion {
  String id, regionName;


  ModelRegion(this.id, this.regionName);


  factory ModelRegion.fromJson(Map<String, dynamic> region){

    return ModelRegion(
        region['ID'],region['REGION_NAME_AM']);
  }



}
class RegionList {
  final List<ModelRegion> regionList;

  RegionList(this.regionList);

  factory RegionList.fromJson(List<dynamic> parsedJson) {
    List<ModelRegion> list = new List<ModelRegion>();
    list=parsedJson.map((i)=>ModelRegion.fromJson(i)).toList();
  //  print("List Mtd");
  //  print(RegionList(list).regionList[0].regionName);
    return   RegionList(list);
  }
}

/**
    class ModelCategory {
    String categoryId, categoryName, amount, subCatList;

    ModelCategory({this.categoryId, this.categoryName, this.amount, this.subCatList});

    factory ModelCategory.fromJson(Map<String, dynamic> cat) {
    return ModelCategory(
    categoryId: cat["CATEGORY_ID"],
    categoryName: cat['CATEGORY_NAME'],
    amount: cat['amount'],
    subCatList: cat['SUB_CAT_LIST']);
    }
    }
    class AllCategoryList {
    final List<ModelCategory> categoryList;

    AllCategoryList(this.categoryList);

    factory AllCategoryList.fromJson(List<dynamic> parsedJson) {
    List<ModelCategory> list = new List<ModelCategory>();
    list = parsedJson.map((i) => ModelCategory.fromJson(i)).toList();
    return new AllCategoryList(list);
    }

    }**/