class TilesModel {
  int id;
  String code;
  int sr_id;
  String imgurl;

  TilesModel(this.id, this.code, this.sr_id, this.imgurl);

  TilesModel.fromJson(data){
    this.id = data['id'];
    this.code = data['code'];
    this.sr_id = data['sr_id'];
    this.imgurl = data['imgurl'];
  }
}