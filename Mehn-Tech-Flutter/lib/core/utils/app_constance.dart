import 'package:flutter/material.dart';

class AppConstance{
  static const  baseURL = "";

  static const  homePostsURL = "";

  static const  promotePostsURL = "";

  static const  categoriesURL = "";

  static const  Color appColor = Color(0xFFfebd59);


  Widget defaultbutton({
    double width =200,
    Color background = Colors.white,
    double fontsize = 20,

    ///On Pressed Function
    required VoidCallback function,
    required String text,

    ///if text is underline
    bool underline = false,

    ///radius of the borders
    double radius = 24.0,
  }) =>
      Container(
        width: width,
        height: 40.0,
        child: MaterialButton(
          onPressed: function,
          child: Text(
            ///to right the text in Uppercase
            text.toUpperCase(),
            style: TextStyle(
              fontSize: fontsize,
              fontWeight: FontWeight.bold,

              ///validate if text is underline or not
              decoration: underline == true ? TextDecoration.underline : null,
              color:  Color(0xFFfebd59),
            ),
          ),
        ),
        decoration: BoxDecoration(
          /// to make the border of the bottom as circular as We need
          borderRadius: BorderRadius.circular(radius),

          /// background mean the the bottom will take the color of the background
          color: background,
        ),
      );

  Widget defaultBottom({
    double width=200,
    Color background=Colors.white,
    required Function function,
    required String text,
    double radius = 1.0,
  })=> Container(
    width: width,
    height: 40.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: background,
    ),
    child: MaterialButton(
      onPressed: function(),
      child: Text(
        text.toUpperCase(),
        style:const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFFfebd59),
        ),
      ),

    ),
  );

}
const Color Appcolor=Color(0xFFfebd59);

///Color(0xFFfebd59)
///Color(0xFF97C9E3)
///

String error_message ='Something is Error!';
String MainURL ='http://10.0.2.2:8000/api/';
String LoginURL ='login';
String GetCategoryiesURL ='categories';
String UpdateLocationURL ='location';
String SignupURL ='register';
String ResultURL ='result';
String  CreateOrderURL ='create_orders';
String  SearchURL ='workshops/search';
String  MyOrderURL ='my_order';
Map<String, String> SendHeaders = {"Accept": "application/json"};
Map<String, String> TokenHeaders = {
  //"Authorization": "Bearer ${CacheHelper.GetData(key: 'token')}",
};