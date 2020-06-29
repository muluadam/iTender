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

}