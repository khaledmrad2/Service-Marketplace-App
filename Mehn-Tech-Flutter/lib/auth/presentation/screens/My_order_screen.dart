import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/auth/presentation/screens/login_screen.dart';
import 'package:myproject/core/utils/app_constance.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/models/my_order.dart';
import 'package:myproject/shared/component.dart';

class My_Order extends StatefulWidget {
  const My_Order({Key? key}) : super(key: key);

  @override
  State<My_Order> createState() => _My_OrderState();
}

class _My_OrderState extends State<My_Order> {
  List<view_order> myorders = [];
  TextEditingController Expeected_cost = TextEditingController();

  @override
  void initState() {
    GetMyOrder();
  }

  @override
  Widget build(BuildContext context) {
    Size diSize = MediaQuery.of(context).size;
    return Scaffold(
        body: myorders.isNotEmpty
            ? ListView.builder(
                itemCount: myorders.length,
                itemBuilder: (BuildContext context, int index) {
                  view_order v = myorders[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                    child: Card(
                      elevation: 12.0,
                      child: InkWell(
                        onTap: () {
                          onpressed_card(v.status, v.id);
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "- Order ${index + 1} -",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    LoginModel.type == 0
                                        ? Text(
                                            "${v.w!.name} Workshop",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        : Text(
                                            "${v.u!.name}",
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
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        LoginModel.type == 0
                                            ? Text(
                                                v.w!.phone,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )
                                            : Text(
                                                v.u!.phone,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          v.date,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.description,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            v.description,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                    (LoginModel.type == 0 && v.status == 2)
                                        ? Column(
                                            children: [
                                              SizedBox(height: 10.0),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .monetization_on_outlined,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    "Expected Cost is :${v.Expected_Cost}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.change_history,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(child: Get_status(v.status)),
                                      ],
                                    ),
                                    SizedBox(height: 20.0),
                                    (LoginModel.type == 1 && v.status == 0)
                                        ? Container(
                                            height: 30,
                                            child: TextFormField(
                                              controller: Expeected_cost,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Enter Expected Cost ?',
                                                labelStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w300),
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blueGrey),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : Center(
                child: Text(
                  'No Order Yet!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ));
  }

  void GetMyOrder() {
    String url = MainURL + MyOrderURL;
    http
        .get(
      Uri.parse(url).replace(queryParameters: {
        'type': LoginModel.type.toString(),
        'id': LoginModel.data!.id.toString(),
      }),
      headers: SendHeaders,
    )
        .then(
      (response) {
        if (response.statusCode == 201 || response.statusCode == 200) {
          var Mapvalue = json.decode(response.body);
          List<dynamic> orders = Mapvalue[0];
          myorders.clear();
          for (var item in orders) {
            view_order v = view_order.fromJson(item);
            myorders.add(v);
          }
          Future.delayed(Duration(seconds: 2)).then((value) {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            MySnakbar(text: error_message),
          );
        }
        setState(() {});
      },
    ).catchError(
      (error) {
        print("loginDataEnter: ${error.toString()}");
      },
    );
  }

  Text Get_status(status) {
    if (status == 0) {
      if (LoginModel.type == 0) {
        return Text(
          'Pending Workshop...',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Appcolor, fontSize: 15),
        );
      } else {
        return Text(
          'Press to view Options',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Appcolor, fontSize: 15),
        );
      }
    } else if (status == 1) {
      if (LoginModel.type == 0) {
        return Text(
          'Refused Order!',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.red, fontSize: 15),
        );
      } else {
        return Text(
          'You Refused this Order',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.red, fontSize: 15),
        );
      }
    } else if (status == 2) {
      if (LoginModel.type == 0) {
        return Text(
          'Press to view Options',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Appcolor, fontSize: 15),
        );
      } else {
        return Text(
          'Pending User...',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Appcolor, fontSize: 15),
        );
      }
    } else if (status == 3) {
      if (LoginModel.type == 0) {
        return Text(
          'You Refused this Offer',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.red, fontSize: 15),
        );
      } else {
        return Text(
          'Refused Offer',
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.red, fontSize: 15),
        );
      }
    } else if (status == 4) {
      return Text(
        'Accepted!',
        style: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.green, fontSize: 15),
      );
    }
    return Text('');
  }

  void onpressed_card(status, order_id) {
    if (status == 0) {
      if (LoginModel.type == 1) {
        showDialog(
            context: context,
            builder: (context) => MyDialogDualButton(
                type: "Order",
                context: context,
                ok: () {
                  String url = MainURL + "orders/${order_id}/status";
                  String c = Expeected_cost.text.isEmpty
                      ? "When Privewing"
                      : Expeected_cost.text;
                  http.put(
                    Uri.parse(url),
                    headers: SendHeaders,
                    body: {
                      "status": '2',
                      "cost": c,
                    },
                  ).then(
                    (response) {
                      if (response.statusCode == 201 ||
                          response.statusCode == 200) {
                        Map Mapvalue = json.decode(response.body);
                        print(response.body);
                        Navigator.pop(context);
                        GetMyOrder();
                        Expeected_cost.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          MySnakbar(text: 'Order Accepted'),
                        );
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
                },
                not_ok: () {
                  String url = MainURL + "orders/${order_id}/status";
                  http.put(
                    Uri.parse(url),
                    headers: SendHeaders,
                    body: {
                      "status": '1',
                    },
                  ).then(
                    (response) {
                      if (response.statusCode == 201 ||
                          response.statusCode == 200) {
                        Map Mapvalue = json.decode(response.body);
                        print(response.body);
                        Navigator.pop(context);
                        GetMyOrder();
                        Expeected_cost.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          MySnakbar(text: 'Order Refused Successfully'),
                        );
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
                }));
      }
    }
    if (status == 2) {
      if (LoginModel.type == 0) {
        showDialog(
            context: context,
            builder: (context) => MyDialogDualButton(
                type: "Offer",
                context: context,
                ok: () {
                  String url = MainURL + "orders/${order_id}/status";
                  String c = Expeected_cost.text.isEmpty
                      ? "When Privewing"
                      : Expeected_cost.text;
                  http.put(
                    Uri.parse(url),
                    headers: SendHeaders,
                    body: {
                      "status": '4',
                    },
                  ).then(
                    (response) {
                      if (response.statusCode == 201 ||
                          response.statusCode == 200) {
                        Map Mapvalue = json.decode(response.body);
                        Navigator.pop(context);
                        GetMyOrder();
                        Expeected_cost.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          MySnakbar(text: 'Offer Accepted'),
                        );
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
                },
                not_ok: () {
                  String url = MainURL + "orders/${order_id}/status";
                  http.put(
                    Uri.parse(url),
                    headers: SendHeaders,
                    body: {
                      "status": '3',
                    },
                  ).then(
                    (response) {
                      if (response.statusCode == 201 ||
                          response.statusCode == 200) {
                        Map Mapvalue = json.decode(response.body);
                        Navigator.pop(context);
                        GetMyOrder();
                        Expeected_cost.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          MySnakbar(text: 'Offer Refused Successfully'),
                        );
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
                }));
      }
    }
  }
}
