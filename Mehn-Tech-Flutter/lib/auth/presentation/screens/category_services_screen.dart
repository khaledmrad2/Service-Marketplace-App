import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myproject/auth/presentation/components/functions.dart';
import 'package:myproject/auth/presentation/screens/login_screen.dart';
import 'package:myproject/auth/presentation/screens/result_screen.dart';
import 'package:myproject/auth/presentation/screens/reset_password_scrren.dart';
import 'package:myproject/core/utils/app_constance.dart';
import 'package:myproject/models/category_model.dart';
import 'package:myproject/models/category_model.dart';
import 'package:myproject/models/service_model.dart';
import 'package:myproject/models/workshop_model.dart';
import 'package:myproject/shared/component.dart';
import 'package:myproject/shared/functions.dart';
import 'package:http/http.dart' as http;

class CategoryServicesScreen extends StatefulWidget {
  final category cat;

  const CategoryServicesScreen({super.key, required this.cat});

  @override
  State<CategoryServicesScreen> createState() => _CategoryServicesScreenState();
}

class _CategoryServicesScreenState extends State<CategoryServicesScreen> {
  List<service> l = [];
  late final GlobalKey<ScaffoldState> _scaffoldKey;

  void initState() {
    super.initState();
    l = getCatService(widget.cat);
    _scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('${widget.cat.name} ')),
      body: ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          final service = l[index];
          return ListTile(
            title: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  //  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                        'assets/images/service/${service.cat_id}-${service.id}.png'),
                    Center(
                        child: Text(
                      service.name,
                      style: TextStyle(fontSize: 25, color: Colors.black54),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      service.description,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                onPressed: () {
                  var snackBar = SnackBar(
                    content: Text(
                      'Loading ....',
                      style: TextStyle(color: Appcolor),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 12,
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnakbar(text: 'Working on it...'),
                  );
                  Getresult();
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    Go(result_screen(), context);
                  });
                  //_onLoading(context);
                }),
          );
        },
      ),
    );
  }

  Future<void> Getresult() async {
    String url = MainURL + ResultURL;
    http
        .get(
      Uri.parse(url).replace(
          queryParameters: {
        'category_id': widget.cat.id,
        'location': '${LoginModel.data!.location}',
      }.map((key, value) => MapEntry(key, value.toString()))),
      headers: SendHeaders,
    )
        .then(
      (response) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          var Mapvalue = json.decode(response.body);
          workshops.clear();
          for (var item in Mapvalue) {
            workshop w = workshop.fromJson(item);
            workshops.add(w);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            MySnakbar(text: 'Wrong Email or Password'),
          );
        }
      },
    ).catchError(
      (error) {
        print("loginDataEnter: ${error.toString()}");
      },
    );
  }
}
