import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/auth/presentation/components/functions.dart';
import 'package:myproject/auth/presentation/screens/login_screen.dart';

class Setting_Screen extends StatefulWidget {
  const Setting_Screen({Key? key}) : super(key: key);

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  @override
  Widget build(BuildContext context) {
    Size disize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(Size(400, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black54),
                ),
                onPressed: () {
                 Navigator.pop(context);
                 LoginModel.token="";
                 Go(loginScreen(),context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
