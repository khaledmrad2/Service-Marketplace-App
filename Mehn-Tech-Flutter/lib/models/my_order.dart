import 'package:myproject/auth/presentation/screens/login_screen.dart';
import 'package:myproject/models/login_model.dart';
import 'package:myproject/models/my_order.dart';
import 'package:myproject/models/workshop_model.dart';

class view_order {
  int id = 0;
  int workshop_id = 0;
  int user_id = 0;
  String description = "";
  String date = "";
  String Expected_Cost="";
  int status = 0;
  workshop? w;
  UserData? u;


  view_order(this.id, this.workshop_id, this.user_id, this.description,
      this.date, this.Expected_Cost, this.status, this.w, this.u);

  view_order.fromJson(Map json) {
    id = json['id'];
    workshop_id = json['workshop_id'];
    user_id = json['user_id'];
    date = json['date'];
    status = json['status'];
    description = json['description'];
    Expected_Cost = json['cost'];
    if(LoginModel.type==0)
    w = workshop.fromJson(json['workshop']);
    else
    u=UserData.fromJson(json['user']);
  }

  @override
  String toString() {
    return 'view_order{id: $id, workshop_id: $workshop_id, user_id: $user_id, description: $description, date: $date, status: $status, w: $w}';
  }
}
