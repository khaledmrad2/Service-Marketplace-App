import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myproject/core/utils/app_constance.dart';
import 'package:myproject/models/login_model.dart';
import 'package:myproject/models/workshop_model.dart';

import '../building_widgets.dart';
import '../models/category_model.dart';
import '../models/service_model.dart';

Widget MyText({
  ///Text Content
  required String text,

  ///Font Size
  double fsize = 35,

  ///Font Color
  Color fcolor = Colors.white,
}) =>
    Text(
      text.toString(),
      maxLines: 4,
      style: TextStyle(
          color: fcolor,
          fontSize: fsize,
          fontFamily: 'SourceSansPro',
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none),
    );

class country {
  int id;
  String name;

  country({required this.id, required this.name});
}

MySnakbar({
  required String text,
}) =>
    SnackBar(
      content: Text(
        text,
      ),
      duration: Duration(seconds: 1),
    );

List<country> positions = [
  country(id: 1, name: 'Damascus'),
  country(id: 2, name: 'Aleppo'),
  country(id: 3, name: 'Daraa'),
  country(id: 4, name: 'Deir ez-Zor'),
  country(id: 5, name: 'Hama'),
  country(id: 6, name: 'Al-Hasakah'),
  country(id: 7, name: 'Homs'),
  country(id: 8, name: 'Latakia'),
  country(id: 9, name: 'Quneitra'),
  country(id: 10, name: 'Ar-Raqqah'),
  country(id: 11, name: 'As-Suwayda'),
  country(id: 12, name: 'Tartus'),
  country(id: 13, name: 'Al-Nabek'),
];

List<String> items = [''];
List<category> categories = [];
List<workshop> workshops = [];

Widget mydefaultformfield({
  required TextEditingController controller,
  required TextInputType type,
  required String labeltext,
  required String? Function(String?)? validate,
  IconData? prefix,
  VoidCallback? OnTap,
  IconData? suffix,
  Function? functionvalidate,
  Function? function2,
  bool isclicked = true,
  bool ispassword = false,
  Color c = Colors.white,
  Function? function3,
  String? Function(String?)? Onchanged,
  VoidCallback? SuffixPressed,
}) =>
    TextFormField(
      validator: validate,
      controller: controller,
      keyboardType: type,
      onTap: OnTap,
      onChanged: Onchanged,
      enabled: isclicked,
      decoration: InputDecoration(
        labelText: '$labeltext',
        labelStyle: TextStyle(
          color: c,
        ),
        prefixIcon: Icon(
          prefix,
          color: Appcolor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Appcolor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Appcolor),
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                  color: Appcolor,
                ),
                onPressed: SuffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget MyDialogDualButton({
  required context,
  //Order Or Offer
  required var type,
  required ok,
  required not_ok,
}) =>
    AlertDialog(
      title: Center(
          child: Text(
        "Message",
        style: TextStyle(fontWeight: FontWeight.w300),
      )),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      content: Container(
          child: Text(
        "Accept this ${type.toString()} ?",
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
      )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                child: MyText(
                  text: "Accept",
                  fsize: 20,
                  fcolor: Colors.green,
                ),
                onPressed: ok),
            TextButton(
              child: MyText(
                text: "Refuse",
                fsize: 20,
                fcolor: Colors.red,
              ),
              onPressed: not_ok,
            ),
          ],
        ),
      ],
    );
