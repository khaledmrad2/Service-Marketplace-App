import 'package:flutter/material.dart';

import '../../../core/utils/app_constance.dart';
import '../components/auth_component.dart';
import '../components/functions.dart';

class resetPasswordScreen extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  resetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size diSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AuthComponent().upperComponent(diSize: diSize),
            Column(
              children: [
                AuthComponent().logoStyleComponent(diSize: diSize),
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
                      const SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        width: diSize.width * .7,
                        height: 70,
                        child: const Center(
                          child: Text(
                            "   Your New Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 68,
                                  width: diSize.width * .8,
                                  child: AuthComponent().defaultFormField(
                                      controller: passwordController,
                                      prefix: Icons.lock,
                                      suffix: Icons.remove_red_eye_outlined,
                                      labelText: "Password",
                                      suffixPressed: () {},
                                      validate: (value) =>
                                          validatePassword(value),
                                      type: TextInputType.visiblePassword),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 68,
                                  width: diSize.width * .8,
                                  child: AuthComponent().defaultFormField(
                                      controller: confirmController,
                                      prefix: Icons.lock,
                                      suffix: Icons.remove_red_eye_outlined,
                                      labelText: "Confirm Password",
                                      suffixPressed: () {},
                                      validate: (value) => validateConfirm(
                                          value, passwordController.text),
                                      type: TextInputType.visiblePassword),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      AppConstance().defaultBottom(
                        radius: 50,
                        text: 'reset',
                        function: () {
                          final currentState = formKey.currentState;
                          if (currentState != null &&
                              currentState.validate()) {}
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
