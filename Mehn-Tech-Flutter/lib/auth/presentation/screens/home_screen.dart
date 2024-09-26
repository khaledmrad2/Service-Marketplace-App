import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myproject/auth/presentation/components/functions.dart';
import 'package:myproject/auth/presentation/screens/category_services_screen.dart';
import 'package:myproject/auth/presentation/screens/login_screen.dart';
import 'package:myproject/auth/presentation/screens/register_screen.dart';
import 'package:myproject/auth/presentation/screens/My_order_screen.dart';
import 'package:myproject/auth/presentation/screens/serach_screen.dart';
import 'package:myproject/auth/presentation/screens/setting_screen.dart';
import 'package:myproject/core/Caching/CacheHelper.dart';
import 'package:myproject/core/utils/app_constance.dart';
import 'package:myproject/models/category_model.dart';
import 'package:myproject/models/login_model.dart';
import 'package:myproject/shared/component.dart';
import '../../../shared/functions.dart';
import 'home_selection.dart';
import 'notification_screen.dart';
import 'order_screen.dart';
import 'package:http/http.dart' as http;

class home_screen extends StatefulWidget {
  @override
  State<home_screen> createState() => _home_screenState();

  home_screen();
}

class _home_screenState extends State<home_screen> {
  country? _selectedposition;
  List<Widget> tabItems = <Widget>[
    homeselection_screen(),
    My_Order(),
    Notification_screen(),
    Setting_Screen(),
  ];
  List<String> AppbarItems = [
    'Home',
    'My Order',
    'Call Center',
    'Setting',
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size diSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor,
        leading: _selectedIndex == 0
            ? DropdownButtonHideUnderline(
                child: DropdownButton2<country>(
                  isExpanded: true,
                  items: positionitems,
                  value: null,
                  onChanged: (country? value) {
                    setState(() {
                      _selectedposition = value;
                      CacheHelper.saveData(
                          key: 'location', value: _selectedposition!.name);
                      UpdateLocation(_selectedposition!.name);
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 70,
                    width: diSize.width * .8,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.location_on),
                    iconSize: 25,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: diSize.width * .8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 50, right: 14),
                  ),
                ),
              )
            : Container(),
        actions: [
          IconButton(
            onPressed: () {
              Go(SearchScreen(), context);
            },
            icon: Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
        title: Text(
          '${AppbarItems[_selectedIndex]}',
          style: TextStyle(color: Colors.black54),
        ),
        centerTitle: true,
      ),
      body: tabItems[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        height: 55,
        animationDuration: Duration(milliseconds: 400),
        // animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: Appcolor,
            inactiveColor: Colors.black54,
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            activeColor: Appcolor,
            inactiveColor: Colors.black54,
            icon: Icon(Icons.reorder_sharp),
            title: Text('Order'),
          ),
          FlashyTabBarItem(
            activeColor: Appcolor,
            inactiveColor: Colors.black54,
            icon: Icon(Icons.live_help_sharp),
            title: Text('Call Center'),
          ),
          FlashyTabBarItem(
            activeColor: Appcolor,
            inactiveColor: Colors.black54,
            icon: Icon(Icons.settings),
            title: Text('Setting'),
          ),
        ],
      ),
    );
  }

  void UpdateLocation(newlocation) async {
    String url = MainURL + UpdateLocationURL;
    http.put(
      Uri.parse(url),
      headers: SendHeaders,
      body: {
        "type": '${LoginModel.type}',
        "location": newlocation,
        "id": '${LoginModel.data!.id}',
      },
    ).then(
      (response) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            MySnakbar(text: 'Location Updated Successfully'),
          );
          LoginModel.data!.location=newlocation;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            MySnakbar(text: error_message),
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
