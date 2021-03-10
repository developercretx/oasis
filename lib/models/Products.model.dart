class Products_model {
  int id;
  String title;
  String description;
  String imageurl;
  String type;
  String size;

  Products_model(this.id, this.title, this.description, this.imageurl,
      this.type, this.size);

  Products_model.fromJson(data) {
    this.id = data['id'];
    this.title = data['title'];
    this.description = data['description'];
    this.imageurl = data['imageurl'];
    this.type = data['typename'];
    this.size = data['size_numbers'];
  }
}
