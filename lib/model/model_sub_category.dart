class ModelSubCategory {
  String categoryId, categoryName;

  ModelSubCategory(
      {this.categoryId, this.categoryName});

  factory ModelSubCategory.fromJson(Map<String, dynamic> cat) {
    //print('CATOD='+cat['ID']);
    return ModelSubCategory(
        categoryId: cat["ID"],
        categoryName: cat['SUB_CATEGORY_NAME_AM']);
  }
}

class CategoryList {
  final List<ModelSubCategory> catlists;

  CategoryList(this.catlists);

  factory CategoryList.fromJson(List<dynamic> parsedJson) {
    List<ModelSubCategory> list = new List<ModelSubCategory>();
    list=parsedJson.map((i)=>ModelSubCategory.fromJson(i)).toList();
   return new CategoryList(list);
  }
}
