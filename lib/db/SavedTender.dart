class SavedTender {
  int id;
  int tenderId;
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

  SavedTender(
      this.id,
      this.tenderId,
      this.name,
      this.org,
      this.cpo,
      this.phone,
      this.postedDateEC,
      this.postedDateGC,
      this.deadlineEC,
      this.deadlineGC,

      this.source);


  SavedTender.fromDb(Map<String, dynamic> tenders)
      : id = tenders['id'],

        tenderId=int.parse(tenders['TENDER_ID']),
        name=tenders['TENDER_NAME'],
        org=tenders['ORGANIZATION'],
        cpo=tenders['CPO'],
        phone=tenders['PHONE_NUMBER'],
        postedDateEC=tenders['POSTED_DATE_EC'],
        postedDateGC=tenders['POSTED_DATE_GC'],
        deadlineEC= tenders['DEADLINE_EC'],
        deadlineGC=tenders['DEADLINE_GC'],
        source = tenders['SOURCE_NAME'];

  Map<String, dynamic> toMapForDb() {
    var tenders = Map<String, dynamic>();
 //   tenders['id'] = id;
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

   return tenders;
  }

}

