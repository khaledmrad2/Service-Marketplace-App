import 'package:flutter/material.dart';
import '../../../models/service_model.dart';
import '../../../shared/component.dart';

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Password is required';
  } else if (value.length < 8) {
    return 'Password Must be more than 8 characters';
  }
  return null;
}

String? validateConfirm(String value, String value2) {
  if (value != value2) {
    return "not Equal";
  }
  return null;
}

String? validate_Email(String value) {
  if (value.isEmpty)
    return 'Email is required!';
  else if (!value.endsWith('@gmail.com')) {
    return 'Email must end with @gmail.com';
  }
  return null;
}

String? validate_Name(String value) {
  if (value.isEmpty)
    return 'Name is required!';
  else if (value.length < 2) {
    return 'Name must be more than 2 Chars!';
  }
  return null;
}

String? validate_Phone(String value) {
  if (value.isEmpty)
    return 'Phone is required!';
  else if (value.length < 10) {
    return 'Phone must be Equal to 10';
  }
  return null;
}

Future<bool> checkImage(context, int cat, int service) async {
  try {
    final bundle = DefaultAssetBundle.of(context);
    if (cat != -1 && service != -1)
      await bundle.load('assets/images/${cat}-${service}.png');
    else
      await bundle.load('assets/images/${cat}.png');
    AssetImage('assets/images/');
    return true;
  } catch (e) {
    return false; //Not Exist
  }
}


void Go(var nextScreen,context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => nextScreen,
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (_, a, __, c) =>
          FadeTransition(opacity: a, child: c),
    ),
  );
}
