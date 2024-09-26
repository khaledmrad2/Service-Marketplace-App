import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/app_constance.dart';
import '../components/auth_component.dart';

class CodeScreen extends StatelessWidget {
  TextEditingController pinController1 = TextEditingController();
  TextEditingController pinController2 = TextEditingController();
  TextEditingController pinController3 = TextEditingController();
  TextEditingController pinController4 = TextEditingController();
  TextEditingController pinController5 = TextEditingController();
  String combinedValue = "";

  CodeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    Size diSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AuthComponent().upperComponent(diSize: diSize),
              Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    title: Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                  Image.asset("assets/images/code.png"),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFfebd59),
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(75)),
                    ),
                    height: diSize.height * .7,
                    width: diSize.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: diSize.width * .7,
                          height: 80,
                          child: const Center(
                            child: Text(
                              " Please check your\nemail and put the Code",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              AuthComponent().verifyFormField(
                                  controller: pinController1, context: context),
                              AuthComponent().verifyFormField(
                                  controller: pinController2, context: context),
                              AuthComponent().verifyFormField(
                                  controller: pinController3, context: context),
                              AuthComponent().verifyFormField(
                                  controller: pinController4, context: context),
                              AuthComponent().verifyFormField(
                                  controller: pinController5, context: context),
                            ],
                          ),
                        )),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: true,
                          builder: (context) => AppConstance().defaultBottom(
                            text: 'Verify',
                            radius: 50.0,
                            background: Colors.white,
                            function: () {
                              combinedValue = pinController1.text +
                                  pinController2.text +
                                  pinController3.text +
                                  pinController4.text +
                                  pinController5.text;
                              print(combinedValue);
                            },
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
