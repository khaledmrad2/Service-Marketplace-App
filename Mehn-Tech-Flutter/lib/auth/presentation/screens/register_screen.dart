import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_multi_select.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../../core/utils/app_constance.dart';
import '../../../models/category_model.dart';
import '../../../models/service_model.dart';
import '../../../shared/component.dart';
import '../../../shared/functions.dart';
import '../components/auth_component.dart';
import '../components/functions.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isUser = true;
  bool isregistered = false;
  country? _selectedposition;
  category? _selectedcategory;
  List<service> _selectedservices = [];
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ButtonState stateTextWithIcon = ButtonState.idle;
  List<MultiSelectItem<service>> service_items = [];

  @override
  Widget build(BuildContext context) {
    Size diSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              AuthComponent().upperComponent2(diSize: diSize),
              Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    isUser ? Appcolor : Colors.grey,
                                  ),
                                  elevation: MaterialStateProperty.all(10),
                                ),
                                onPressed: () {
                                  if (!isUser) {
                                    setState(() {
                                      isUser = true;
                                    });
                                  }
                                },
                                child: Image.asset('assets/images/usery.png')),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    isUser ? Colors.grey : Appcolor,
                                  ),
                                  elevation: MaterialStateProperty.all(10),
                                ),
                                onPressed: () {
                                  if (isUser) {
                                    setState(() {
                                      isUser = false;
                                    });
                                  }
                                },
                                child: Image.asset('assets/images/worky.png')),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyText(
                            text: '  User',
                            fcolor: isUser ? Appcolor : Colors.grey,
                            fsize: 30,
                          ),
                          MyText(
                            text: 'WorkShop',
                            fcolor: isUser ? Colors.grey : Appcolor,
                            fsize: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        !isUser
                            ? Column(
                                children: [
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<category>(
                                      isExpanded: true,
                                      hint: const Row(
                                        children: [
                                          Icon(
                                            Icons.help,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Select Your Category',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      items: categoryitems,
                                      value: _selectedcategory,
                                      onChanged: (category? value) {
                                        setState(() {
                                          _selectedservices =
                                              getCatService(value!);
                                          service_items = _selectedservices!
                                              .map((s) =>
                                                  MultiSelectItem<service>(
                                                      s, s.name))
                                              .toList();
                                          _selectedcategory = value!;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 70,
                                        width: diSize.width * .8,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Appcolor,
                                        ),
                                        elevation: 2,
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 18,
                                        iconEnabledColor: Colors.white,
                                        iconDisabledColor: Colors.grey,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 400,
                                        width: diSize.width * .8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[500],
                                        ),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _selectedcategory != null
                                      ? Container(
                                          width: diSize.width * .8,

                                          //height: 250,
                                          child: MultiSelectDialogField(
                                            separateSelectedItems: true,
                                            items: service_items,
                                            title: Text("Servies "),
                                            selectedColor: Appcolor,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: Colors.black26,
                                              ),
                                              color: Appcolor,
                                            ),
                                            buttonIcon: Icon(
                                              Icons.home_repair_service,
                                              color: Colors.white,
                                            ),
                                            buttonText: Text(
                                              "  Your Services",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                            onConfirm: (results) {
                                              _selectedservices = results;
                                            },
                                          ),
                                        )
                                      : Container(),
                                ],
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<country>(
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    'Select Your Location',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: positionitems,
                            value: _selectedposition,
                            onChanged: (country? value) {
                              setState(() {
                                _selectedposition = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 70,
                              width: diSize.width * .8,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Appcolor,
                              ),
                              elevation: 2,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 18,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.grey,
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
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 50, right: 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 68,
                          width: diSize.width * .8,
                          child: AuthComponent().defaultFormField(
                              controller: name,
                              prefix: Icons.perm_identity,
                              labelText: "Name",
                              validate: (value) => validate_Name(value),
                              type: TextInputType.text),
                        ),
                        SizedBox(
                          height: 68,
                          width: diSize.width * .8,
                          child: AuthComponent().defaultFormField(
                              controller: phone,
                              prefix: Icons.phone,
                              labelText: "Phone",
                              validate: (value) => validate_Phone(value),
                              type: TextInputType.number),
                        ),
                        SizedBox(
                          height: 68,
                          width: diSize.width * .8,
                          child: AuthComponent().defaultFormField(
                              controller: email,
                              prefix: Icons.email_outlined,
                              labelText: "Email",
                              validate: (value) => validate_Email(value),
                              type: TextInputType.text),
                        ),
                        SizedBox(
                          height: 68,
                          width: diSize.width * .8,
                          child: AuthComponent().defaultFormField(
                              controller: password,
                              prefix: Icons.lock_outline,
                              labelText: "Password",
                              validate: (value) => validatePassword(value),
                              type: TextInputType.text),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  buildTextWithIcon(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextWithIcon() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Register",
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
    if (formKey.currentState!.validate() &&
        ((isUser && _selectedposition != null) ||
            (!isUser &&
                _selectedposition != null &&
                _selectedcategory != null))) {
      register_fun();
      switch (stateTextWithIcon) {
        case ButtonState.idle:
          stateTextWithIcon = ButtonState.loading;
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              stateTextWithIcon =
                  isregistered ? ButtonState.success : ButtonState.fail;
            });
          }).then((value) => {
                if (!isregistered)
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

  void register_fun() async {
    ///todo make api for register and then go to login
    String url = MainURL + SignupURL;
    int type = isUser ? 0 : 1;
    if (isUser) {
      await http.post(
        Uri.parse(url),
        headers: SendHeaders,
        body: {
          "name": name.text,
          "email": email.text,
          "password": password.text,
          "phone": phone.text,
          "type": '$type',
          "location": _selectedposition!.name,
        },
      ).then(
        (response) {
          print(response.body);

          ///Decode The Response
          Map Mapvalue = json.decode(response.body);
          print(response.statusCode);

          ///Email  or UserName or Both are already Used
          if (response.statusCode == 409) {
            ScaffoldMessenger.of(context).showSnackBar(
              MySnakbar(text: 'Email Has Been used'),
            );
          }

          ///Success to Register
          else if (response.statusCode == 200 || response.statusCode == 201) {
            isregistered = true;
            ScaffoldMessenger.of(context).showSnackBar(
              MySnakbar(text: 'Registered Successfully'),
            );
            Future.delayed(Duration(seconds:4)).then((value) {
              Navigator.pop(context);
            });
          }
        },
      ).catchError(
        (error) {
          print("loginDataEnter: ${error.toString()}");
        },
      );
    } else {
      await http.post(Uri.parse(url), headers: SendHeaders, body: {
        "name": name.text,
        "email": email.text,
        "password": password.text,
        "phone": phone.text,
        "type": '$type',
        "location": _selectedposition!.name,
        "category_id": _selectedcategory!.id.toString(),
      }).then(
        (response) {
          print(response.body);

          ///Decode The Response
          Map Mapvalue = json.decode(response.body);
          print(response.statusCode);

          ///Email  or UserName or Both are already Used
          if (response.statusCode == 409) {
            ScaffoldMessenger.of(context).showSnackBar(
              MySnakbar(text: 'Email Has Been used'),
            );
          }

          ///Success to Register
          else if (response.statusCode == 200 || response.statusCode == 201) {
            isregistered = true;
            ScaffoldMessenger.of(context).showSnackBar(
              MySnakbar(text: 'Registered Successfully'),
            );
            Future.delayed(Duration(seconds: 2)).then((value) {
              Navigator.pop(context);
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              MySnakbar(text: 'Something is Error'),
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
}

//7.3.1
List<DropdownMenuItem<country>> positionitems = positions.map((country item) {
  return DropdownMenuItem<country>(
    value: item,
    child: Row(
      children: [
        Icon(Icons.location_on),
        SizedBox(
          width: 30,
        ),
        Text(
          item.name,
          style: const TextStyle(
            fontSize: 18,
            // fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}).toList();

List<DropdownMenuItem<category>> categoryitems =
    categories.map((category item) {
  return DropdownMenuItem<category>(
    value: item,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: Image.asset('assets/images/service/${item.pic_id}.png')),
        // Expanded(child: Icon(Icons.add)),
        Text(
          item.name,
          style: const TextStyle(
            fontSize: 18,
            // fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}).toList();

List<service> services = [
  service(
    id: 1,
    name: 'Electricity Repair',
    pic_id: 1,
    cat_id: 1,
    description:
        'the process of fixing or restoring electrical systems and devices that are not functioning properly. Electrical repair can be performed on a wide variety of electrical systems, including residential, commercial, and industrial systems.',
  ),
  service(
    id: 2,
    name: 'Electricity Connect',
    pic_id: 2,
    cat_id: 1,
    description:
        'the process of connecting a building or structure to an electrical power supply. ',
  ),
  service(
      id: 3,
      name: 'Electricity FullDevice',
      pic_id: 3,
      cat_id: 1,
      description: 'Full Support with Electricity'),
  service(
    id: 5,
    name: 'Clean Kitchen',
    pic_id: 4,
    cat_id: 2,
    description: 'maintain a hygienic and healthy environment. ',
  ),
  service(
    id: 6,
    name: 'Car Washing',
    pic_id: 4,
    cat_id: 2,
    description: ' keep it looking clean and well-maintained. ',
  ),
  service(
    id: 7,
    name: 'Clothes Washing',
    pic_id: 4,
    cat_id: 2,
    description: 'Clothes Washing  keep it looking clean and well-maintained. ',
  ),
  service(
    id: 8,
    name: 'Full Clean',
    pic_id: 4,
    cat_id: 2,
    description: '',
  ),
  service(
    id: 9,
    name: 'Repair Mobile',
    pic_id: 4,
    cat_id: 4,
    description: '',
  ),
  service(
    id: 10,
    name: 'Mobile Marketing',
    pic_id: 4,
    cat_id: 4,
    description: '',
  ),
  service(
    id: 11,
    name: 'Plumber Service',
    pic_id: 4,
    cat_id: 3,
    description: '',
  ),
];
