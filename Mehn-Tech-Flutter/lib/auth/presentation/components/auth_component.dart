import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/app_constance.dart';

class AuthComponent {
  Widget defaultFormField({
    required TextEditingController controller,
    required IconData prefix,
    required String labelText,
    required Function validate,
    required TextInputType type,
    Function? suffixPressed,
    IconData? suffix,
    GlobalKey? key,
    bool ispassword = false,
  }) =>
      TextFormField(
        // no matter what you set, it simply shows white keyboard
        obscureText: ispassword,
        keyboardType: type,
        key: key,
        style: TextStyle(color: Colors.black54),
        decoration: InputDecoration(
          errorMaxLines: 4,

          //labelText: labelText,
          hintText: labelText,

          errorStyle: TextStyle(
            color: Colors.red[900],
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSansPro',
            // fontSize: 18,
          ),
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            prefix,
            color: Colors.white,
          ),

          ///UnderlineInputBorder is line under the field
          enabledBorder: const UnderlineInputBorder(
            ///color of line
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),

          ///Error Border of the field
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(
                    suffix,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    return suffixPressed!();
                  },
                )
              : null,
        ),
        validator: (value) {
          return validate(value);
        },
        controller: controller,
      );

  Widget verifyFormField({
    required TextEditingController controller,
    required BuildContext context,
  }) =>
      SizedBox(
        height: 68,
        width: 64,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            // Optional: Adjust the content padding
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white), // Set the border color to white
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white), // Set the border color to white
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white), // Set the border color to white
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          onSaved: (pin1) {},
        ),
      );

  Widget upperComponent({required Size diSize}) => Row(
        children: [
          Container(
            color: Colors.white,
            height: diSize.height,
            width: diSize.width * .25,
          ),
          Container(
            color: AppConstance.appColor,
            height: diSize.height,
            width: diSize.width * .75,
          ),
        ],
      );

  Widget upperComponent2({required Size diSize}) => Column(
        children: [
          Container(
            color: Colors.white,
            height: diSize.height * .35,
            width: diSize.width,
          ),
          Container(
            color: Appcolor,
            height: diSize.height ,
            width: diSize.width,
          ),
        ],
      );

  Widget logoStyleComponent({required Size diSize}) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(75)),
        ),
        height: diSize.height * .35,
        width: diSize.width,
        child: Image.asset("assets/images/login.png"),
      );
}
