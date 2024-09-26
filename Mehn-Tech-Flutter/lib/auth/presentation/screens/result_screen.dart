import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/auth/presentation/components/functions.dart';
import 'package:myproject/auth/presentation/screens/order_screen.dart';
import 'package:myproject/core/utils/app_constance.dart';
import 'package:myproject/models/workshop_model.dart';
import 'package:myproject/shared/component.dart';

class result_screen extends StatefulWidget {
  const result_screen({Key? key}) : super(key: key);

  @override
  State<result_screen> createState() => _result_screenState();
}

class _result_screenState extends State<result_screen> {
  List<workshop> res_workpshops = [];
  @override
  void initState() {
    res_workpshops= workshops;
  }

  @override
  Widget build(BuildContext context) {
    Size diSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor,
        automaticallyImplyLeading: false,
        title: Text(
          'Result  Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount:  res_workpshops.length,
        itemBuilder: (BuildContext context, int index) {
          workshop w =   res_workpshops[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
            child: SizedBox(
              width: diSize.width,
              height: diSize.height * .3,
              child: Card(
                elevation: 12.0,
                child: InkWell(
                  onTap: () {
                     Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return Order_Screen(
                            w: w,
                          );
                        },
                      ),
                    );
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
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
            ),
          );
        },
      ),
    );
  }
}
