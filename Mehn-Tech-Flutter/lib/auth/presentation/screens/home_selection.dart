import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/auth/presentation/screens/home_screen.dart';
import 'package:myproject/auth/presentation/screens/login_screen.dart';
import 'package:myproject/core/Caching/CacheHelper.dart';

import '../../../models/category_model.dart';
import '../../../shared/component.dart';
import 'category_services_screen.dart';

class homeselection_screen extends StatefulWidget {
  const homeselection_screen({Key? key}) : super(key: key);

  @override
  State<homeselection_screen> createState() => _homeselection_screenState();
}

class _homeselection_screenState extends State<homeselection_screen> {
  final List<String> imageList = [
    'assets/images/service/a.jpg',
    'assets/images/service/1.png',
    'assets/images/service/b.jpg',
    'assets/images/service/xx.jpg',
    'assets/images/service/cc.jpg',
    'assets/images/service/2.png',
    'assets/images/service/c.jpg',
    'assets/images/service/3.png',
    'assets/images/service/d.jpg',
    'assets/images/service/service_pic.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              // enable auto-scrolling
              autoPlayInterval: Duration(seconds: 3),
              // set auto-scrolling interval
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
            ),
            items: imageList.map((imageUrl) {
              return Image.asset(
                imageUrl,
                fit: BoxFit.fitWidth,
              );
            }).toList(),
          ),
        ),
        Expanded(
          flex: 2,
          child: LoginModel.type == 0
              ? ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: buildMyObjectWidget,
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 80, 30, 80),
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Card(
                          elevation: 12.0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 40, 10, 40),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LoginModel.data!.name,
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
                                          LoginModel.data!.phone,
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
                                          LoginModel.data!.location,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300),
                                        )
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
                                          LoginModel.data!.email,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ],
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
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

Widget buildMyObjectWidget(BuildContext context, int index) {
  category myObject = categories[index];
  return ListTile(
    title: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.grey),
          ),
        ),
      ),
      child: Text(
        myObject.name,
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryServicesScreen(
              cat: myObject,
            ),
          ),
        );
      },
    ),
  );
}
