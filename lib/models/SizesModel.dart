class SizesModel {
  int id;
  int width;
  int heigth;
  String unit;

  SizesModel(this.id, this.width, this.heigth, this.unit);

  SizesModel.fromJson(data){
    this.id = data['id'];
    this.width = data['width'];
    this.heigth = data['height'];
    this.unit = data['unit'];
  }
}