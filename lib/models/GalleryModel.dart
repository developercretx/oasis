class GalleryModel {
  int id;
  String title;
  String imgurl;

  GalleryModel(this.id, this.title, this.imgurl);

  GalleryModel.fromJson(data){
    this.id = data['id'];
    this.title = data['title'];
    this.imgurl = data['imgurl'];
  }
}
