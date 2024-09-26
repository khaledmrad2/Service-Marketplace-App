import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/auth/presentation/components/auth_component.dart';
import 'package:myproject/auth/presentation/screens/login_screen.dart';
import 'package:myproject/auth/presentation/screens/order_screen.dart';
import 'package:myproject/core/utils/app_constance.dart';
import 'package:myproject/models/workshop_model.dart';

import '../../../shared/component.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool issearch = false;
  List<workshop> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor,
        title: Container(
          height: 40,
          child: mydefaultformfield(
            controller: searchController,
            type: TextInputType.text,
            labeltext: 'Search',
            validate: (value) {},
            suffix: Icons.search,
            Onchanged: (value) {
              value.toString().length != 0 ? Get_Result(context) : result.clear();

            },
          ),
        ),
      ),
      body:  ListView.builder(
          itemCount: result.length,
          itemBuilder: (BuildContext context, int index) {
            workshop w = result[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Card(
                elevation: 12.0,
                child: InkWell(
                  onTap: () {
                    LoginModel.type == 0
                        ? Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return Order_Screen(
                            w: w,
                          );
                        },
                      ),
                    )
                        : null;
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 40, 10, 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                w.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.call,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    w.phone,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    w.location,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    w.email,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.work,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    categories[w.category_id - 1]
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Image.asset('assets/images/white.jpg'),
                              Image.asset('assets/images/login.png'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void Get_Result(context) {
    String url = MainURL + SearchURL;
    http
        .get(Uri.parse(url).replace(queryParameters: {
      'name': searchController.text,
    }))
        .then((response) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        var Mapvalue = json.decode(response.body);
        List<dynamic> k=Mapvalue[0];
        result.clear();
        for (var item in k) {
          workshop w = workshop.fromJson(item);
          result.add(w);
        }
        setState(() {
        });

      }
    });
  }
}
