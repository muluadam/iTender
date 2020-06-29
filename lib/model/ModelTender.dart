class ModelTender {
  String tenderId;
  String detail;
  String name,
      org,
      cpo,
      phone,
      specPlace,
      postedDateEC,
      postedDateGC,
      deadlineGC,
      deadlineEC,
      category,
      placeOfWork;
  String source;

  ModelTender(
      this.tenderId,
      this.name,
      this.org,
      this.cpo,
      this.phone,
      this.postedDateEC,
      this.postedDateGC,
      this.deadlineEC,
      this.deadlineGC,
      this.category,
      this.placeOfWork,
      this.source,
);

  factory ModelTender.fromJson(Map<String, dynamic> tenders) {
    return ModelTender(
      tenders['TENDER_ID'],
        tenders['TENDER_NAME'],
        tenders['ORGANIZATION'],
        tenders['CPO'],
        tenders['PHONE_NUMBER'],
        tenders['POSTED_DATE_EC'],
        tenders['POSTED_DATE_GC'],
        tenders['DEADLINE_EC'],
        tenders['DEADLINE_GC'],
        tenders['CATEGORY'],
        tenders['PLACE_OF_WORK'],
        tenders['SOURCE_NAME'],
     );
  }
  Map<String, dynamic> toMapForDb() {
    var tenders = Map<String, dynamic>();

    tenders['TENDER_ID']=tenderId;
    tenders['TENDER_NAME']=name;
    tenders['ORGANIZATION']=org;
    tenders['CPO']=cpo;
    tenders['PHONE_NUMBER']=phone;
    tenders['POSTED_DATE_EC']=postedDateEC;
    tenders['POSTED_DATE_GC']=postedDateGC;
    tenders['DEADLINE_EC']=deadlineEC;
    tenders['DEADLINE_GC']=deadlineGC;
    tenders['SOURCE_NAME']=source;
    tenders['CATEGORY']=category;
    tenders['PLACE_OF_WORK']=placeOfWork;

    return tenders;
  }



}

class TendersList {
  final List<ModelTender> tendersList;

  TendersList(this.tendersList);

  factory TendersList.fromJson(List<dynamic> parsedJson) {
    List<ModelTender> list = new List<ModelTender>();
    list = parsedJson.map((i) => ModelTender.fromJson(i)).toList();
    print("list=="+list.first.org);
    return new TendersList(list);
  }
}
