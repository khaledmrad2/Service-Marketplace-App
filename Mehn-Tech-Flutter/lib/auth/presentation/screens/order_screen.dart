import 'dart:convert';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/auth/presentation/components/auth_component.dart';
import 'package:myproject/auth/presentation/components/functions.dart';
import 'package:myproject/auth/presentation/screens/home_screen.dart';
import 'package:myproject/auth/presentation/screens/login_screen.dart';
import 'package:myproject/core/utils/app_constance.dart';
import 'package:myproject/models/workshop_model.dart';
import 'package:myproject/shared/component.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:http/http.dart' as http;

class Order_Screen extends StatefulWidget {
  workshop w;
  bool isloading = false;

  Order_Screen({super.key, required this.w});

  @override
  State<Order_Screen> createState() => _Order_ScreenState();
}

class _Order_ScreenState extends State<Order_Screen> {
  TextEditingController problem_description = TextEditingController();
  TextEditingController location_description = TextEditingController();
  final formKey = GlobalKey<FormState>();
  double probelm_container_height = 100;
  double location_container_height = 100;
  DateTime Date = DateTime.now();
  String formattedDate = "";

  void initState() {
    super.initState();
    Date = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(Date);
  }

  @override
  Widget build(BuildContext context) {
    Date = DateTime.now();
    Size diSize = MediaQuery.of(context).size;
    workshop w = widget.w;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor,
        automaticallyImplyLeading: false,
        title: Text(
          'Order Info',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Card(
                      elevation: 12.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 40, 10, 40),
                        child: Row(
                          children: [
                            Column(
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
                                      categories[w.category_id-1].name.toString(),
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
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: Text(
                            'Describe Your Probelm',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 22),
                          ),
                        ),
                        Container(
                          height: probelm_container_height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Appcolor),
                          ),
                          child: TextFormField(
                            controller: problem_description,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'put Your description';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Like I need to Clean My House ....',
                              hintStyle: TextStyle(fontWeight: FontWeight.w300),
                              contentPadding: EdgeInsets.all(16.0),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                probelm_container_height = diSize.height * .1 +
                                    3 *
                                        problem_description.text.length
                                            .toDouble();
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: Text(
                            'Your Location in Detail',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 22),
                          ),
                        ),
                        Container(
                          height: location_container_height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Appcolor),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'put Your Loaction';
                              }
                              return null;
                            },
                            controller: location_description,
                            decoration: InputDecoration(
                              hintText: 'Damascus - Airport Street ...etc',
                              hintStyle: TextStyle(fontWeight: FontWeight.w300),
                              contentPadding: EdgeInsets.all(16.0),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                location_container_height = diSize.height * .1 +
                                    3 *
                                        location_description.text.length
                                            .toDouble();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            //minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _openDatePicker(context);
                          },
                          child: Text(
                            'Select Date',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${formattedDate.toString()}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(3.0),
                              backgroundColor:
                                  MaterialStateProperty.all(Appcolor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            onPressed: () => confirm_order(context),
                            child: Center(
                              child: widget.isloading
                                  ? Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(2.0),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : Text(
                                      'Confirm Order',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirm_order(context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        widget.isloading = true;
      });
      String url = MainURL + CreateOrderURL;
      String description =
          "The Problem is :${problem_description.text} ,and The Location is :${location_description.text}";
      http.post(
        Uri.parse(url),
        headers: SendHeaders,
        body: {
          "workshop_id": widget.w.id.toString(),
          "user_id": LoginModel.data!.id.toString(),
          "description": description.toString(),
          "date": formattedDate,
          "status": 0.toString(),
        },
      ).then(
        (response) {
          if (response.statusCode == 201 || response.statusCode == 200) {
            var Mapvalue = json.decode(response.body);
            ScaffoldMessenger.of(context).showSnackBar(
              MySnakbar(text: 'Order Add Successfully'),
            );
            Future.delayed(Duration(seconds: 2)).then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Go(home_screen(), context);
            });
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

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      title: 'Set Your Suitable Time ',
      dateOrder: DatePickerDateOrder.dmy,
      pickerTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 18,
      ),
      titleStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Appcolor,
      ),
      onChange: (index) {
        print(index);
      },
      onSubmit: (index) {
        setState(() {
          Date = index;
          formattedDate = DateFormat('yyyy-MM-dd').format(Date);
        });
      },
      bottomPickerTheme: BottomPickerTheme.orange,
    ).show(context);
  }
}
