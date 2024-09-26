import 'package:flutter/material.dart';
import 'package:myproject/auth/presentation/screens/home_screen.dart';
import 'package:myproject/core/utils/app_constance.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/models/category_model.dart';
import 'package:myproject/shared/component.dart';
import 'auth/presentation/screens/login_screen.dart';
import 'auth/presentation/screens/register_screen.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:myproject/auth/presentation/screens/register_screen.dart';
import 'package:myproject/core/Caching/CacheHelper.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // final servicesLocator = ServicesLocator();
  // servicesLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => GetData(context));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void GetData(context) {
  String url = MainURL + GetCategoryiesURL;
  http.get(
    Uri.parse(url),
    headers: SendHeaders,
  )
      .then((response) {
    if (response.statusCode == 201 || response.statusCode == 200) {
      var Mapvalue = json.decode(response.body);
      categories.clear();
      for (var item in Mapvalue) {
        category categoryObject = category.fromJson(item);
        categories.add(categoryObject);
      }
    }
  });
}
