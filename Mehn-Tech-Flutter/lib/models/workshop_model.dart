class workshop {
  int id=0;
  String name="";
  String email="";
  String location="";
  String phone="";
  int  category_id=0;


  workshop(this.id, this.name, this.email, this.location, this.phone,
      this.category_id);

  workshop.fromJson(Map<dynamic, dynamic> json){
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    category_id = json['category_id'];
    location = json['location'];
  }

  @override
  String toString() {
    return 'workshop{id: $id, name: $name, email: $email, location: $location, phone: $phone, category_id: $category_id}';
  }
}