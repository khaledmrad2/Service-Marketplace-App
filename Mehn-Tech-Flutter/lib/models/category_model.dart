class category {
  int? id = 0;
  String name = "";
  String? pic_id = "";

  category({required this.id, required this.name, required this.pic_id});

  category.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pic_id = json['pic_id'];
  }

  @override
  String toString() {
    return 'category{id: $id, name: $name, pic_id: $pic_id}';
  }
}
