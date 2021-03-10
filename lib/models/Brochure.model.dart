class brochureModel {
  String title;
  String pdfurl;

  brochureModel(this.title, this.pdfurl);

  brochureModel.fromJson(data){
    this.title = data['title'];
    this.pdfurl = data['pdfurl'];
  }
}
