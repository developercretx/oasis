class sliderModel {
  int id;
  int sid;
  String name;
  String imageurl;

  sliderModel(this.id,this.sid,this.name, this.imageurl);

  sliderModel.fromJson(data){
    this.id = data['id'];
    this.sid = data['sid'];
    this.name = data['name'];
    this.imageurl = data['imagurl'];
  }
}
