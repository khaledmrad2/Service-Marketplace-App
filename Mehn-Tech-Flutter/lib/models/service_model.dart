class service {
  int id = 0;
  int cat_id = 0;
  String name = "";
  String description="";
  int pic_id = 0;

  service({
    required this.id,
    required this.cat_id,
    required this.name,
     required this.description,
    required this.pic_id,
  });

  service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cat_id = json['cat_id'];
    description = json['description'];
    name = json['name'];
    pic_id = json['pic_id'];
  }
}
