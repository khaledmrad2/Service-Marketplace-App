import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notification_screen extends StatefulWidget {
  const Notification_screen({Key? key}) : super(key: key);

  @override
  State<Notification_screen> createState() => _Notification_screenState();
}

class _Notification_screenState extends State<Notification_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Help Center", style: TextStyle(fontSize: 30,fontWeight: FontWeight.w300),)),
    );
  }
}
