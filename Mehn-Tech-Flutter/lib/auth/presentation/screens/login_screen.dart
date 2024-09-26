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

import '../../../core/utils/app_constance.dart';
import '../../../models/login_model.dart';
import '../../../shared/component.dart';
import '../components/auth_component.dart';
import '../components/functions.dart';
import 'code_screen.dart';
import 'home_screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool is_seen = true;
  bool islogin = false;
  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    Size diSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AuthComponent().upperComponent(diSize: diSize),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AuthComponent().logoStyleComponent(diSize: diSize),
                  Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Appcolor,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(75)),
                    ),
                    height: diSize.height * .7,
                    width: diSize.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          width: diSize.width * .7,
                          height: 70,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 68,
                                width: diSize.width * .8,
                                child: AuthComponent().defaultFormField(
                                    controller: email,
                                    prefix: Icons.email_outlined,
                                    labelText: "Email",
                                    validate: (value) => validate_Email(value),
                                    type: TextInputType.visiblePassword),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 68,
                                width: diSize.width * .8,
                                child: AuthComponent().defaultFormField(
                                    ispassword: is_seen,
                                    controller: password,
                                    prefix: Icons.lock,
                                    suffix: is_seen
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off,
                                    labelText: "Password",
                                    suffixPressed: () {
                                      setState(() {
                                        is_seen = !is_seen;
                                      });
                                    },
                                    validate: (value) =>
                                        validatePassword(value),
                                    type: TextInputType.visiblePassword),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            TextButton(
                                child: MyText(
                                  text: 'Forget Password ?',
                                  fcolor: Colors.white,
                                  fsize: 15,
                                ),
                                onPressed: () {
                                  Go(CodeScreen(), context);
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                    text: "Not Have an Account ?", fsize: 15),
                                TextButton(
                                  child: MyText(
                                      text: 'Create Now!',
                                      fsize: 15,
                                      fcolor: Colors.black54),
                                  onPressed: () {
                                    Go(RegisterScreen(), context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        buildTextWithIcon(),
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

  void login_fun() async {
    String url = MainURL + LoginURL;
    http.post(
      Uri.parse(url),
      headers: SendHeaders,
      body: {
        "email": email.text,
        "password": password.text,
      },
    ).then(
      (response) {
        if (response.statusCode == 201||response.statusCode == 200) {
          Map Mapvalue = json.decode(response.body);
          loginmodel.fromJson(Mapvalue);
          islogin = true;
          LoginModel = loginmodel.fromJson(Mapvalue);
          Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.pop(context);
            Go(home_screen(), context);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            MySnakbar(text: 'Wrong Email or Password'),
          );
        }
      },
    ).catchError(
      (error) {
        print("loginDataEnter: ${error.toString()}");
      },
    );
  }

  ///////////////////////////////////////////

  Widget buildTextWithIcon() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Login",
          icon: Icon(Icons.login, color: Colors.white),
          color: Appcolor),
      ButtonState.loading: IconedButton(text: "Loading", color: Appcolor),
      ButtonState.fail: IconedButton(
          text: "Failed",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: onPressedIconWithText, state: stateTextWithIcon);
  }

  void onPressedIconWithText() async {
    if (formKey.currentState!.validate()) {
      login_fun();
      switch (stateTextWithIcon) {
        case ButtonState.idle:
          stateTextWithIcon = ButtonState.loading;
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              stateTextWithIcon =
                  islogin ? ButtonState.success : ButtonState.fail;
            });
          }).then((value) => {
                if (!islogin)
                  Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      stateTextWithIcon = ButtonState.idle;
                    });
                  })
              });
          break;
        case ButtonState.loading:
          break;
        case ButtonState.success:
          stateTextWithIcon = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateTextWithIcon = ButtonState.idle;
          break;
      }
      setState(() {
        stateTextWithIcon = stateTextWithIcon;
      });
    }
  }
}

late loginmodel LoginModel;
