import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  State<TestingScreen> createState() => _TestingState();
}

class _TestingState extends State<TestingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: const Icon(
        HumanitarianIcons.laptop,
        size: 40,
        color: Colors.black,
      )),
    );
  }
}
