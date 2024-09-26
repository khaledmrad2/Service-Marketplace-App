// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:progress_state_button/iconed_button.dart';
// import 'package:progress_state_button/progress_button.dart';
//
// //////////////////////////////////////////////////
// ///Button for loading
// Widget buildTextWithIconWithMinState() {
//   return ProgressButton.icon(
//     iconedButtons: {
//       ButtonState.idle: IconedButton(
//           text: "Send",
//           icon: Icon(Icons.send, color: Colors.white),
//           color: Colors.deepPurple.shade500),
//       ButtonState.loading:
//       IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
//       ButtonState.fail: IconedButton(
//           text: "Failed",
//           icon: Icon(Icons.cancel, color: Colors.white),
//           color: Colors.red.shade300),
//       ButtonState.success: IconedButton(
//           icon: Icon(
//             Icons.check_circle,
//             color: Colors.white,
//           ),
//           color: Colors.green.shade400)
//     },
//     onPressed: onPressedIconWithMinWidthStateText,
//     state: stateTextWithIconMinWidthState,
//     minWidthStates: [ButtonState.loading, ButtonState.success],
//   );
// }
// Widget buildCustomButton() {
//   var progressTextButton = ProgressButton(
//     stateWidgets: {
//       ButtonState.idle: Text(
//         "Idle",
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//       ),
//       ButtonState.loading: Text(
//         "Loading",
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//       ),
//       ButtonState.fail: Text(
//         "Fail",
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//       ),
//       ButtonState.success: Text(
//         "Success",
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//       )
//     },
//     stateColors: {
//       ButtonState.idle: Colors.grey.shade400,
//       ButtonState.loading: Colors.blue.shade300,
//       ButtonState.fail: Colors.red.shade300,
//       ButtonState.success: Colors.green.shade400,
//     },
//     onPressed: onPressedCustomButton,
//     state: stateOnlyText,
//     padding: EdgeInsets.all(8.0),
//   );
//   return progressTextButton;
// }
// Widget buildCustomProgressIndicatorButton() {
//   var progressTextButton = ProgressButton(
//     stateWidgets: {
//       ButtonState.idle: Text(
//         "Idle",
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//       ),
//       ButtonState.loading: Text(
//         "Loading",
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//       ),
//       ButtonState.fail: Text(
//         "Fail",
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//       ),
//       ButtonState.success: Text(
//         "Success",
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//       )
//     },
//     progressIndicator:  CircularProgressIndicator( backgroundColor: Colors.white, valueColor: AlwaysStoppedAnimation(Colors.red), strokeWidth: 1, ),
//     stateColors: {
//       ButtonState.idle: Colors.grey.shade400,
//       ButtonState.loading: Colors.blue.shade300,
//       ButtonState.fail: Colors.red.shade300,
//       ButtonState.success: Colors.green.shade400,
//     },
//     onPressed: onPressedCustomIndicatorButton,
//     state: stateOnlyCustomIndicatorText,
//     padding: EdgeInsets.all(8.0),
//   );
//   return progressTextButton;
// }
//
// void onPressedCustomButton() {
//   setState(() {
//     switch (stateOnlyText) {
//       case ButtonState.idle:
//         stateOnlyText = ButtonState.loading;
//         break;
//       case ButtonState.loading:
//         stateOnlyText = ButtonState.fail;
//         break;
//       case ButtonState.success:
//         stateOnlyText = ButtonState.idle;
//         break;
//       case ButtonState.fail:
//         stateOnlyText = ButtonState.success;
//         break;
//     }
//   });
// }
// void onPressedIconWithMinWidthStateText() {
//   switch (stateTextWithIconMinWidthState) {
//     case ButtonState.idle:
//       stateTextWithIconMinWidthState = ButtonState.loading;
//       Future.delayed(Duration(seconds: 1), () {
//         setState(() {
//           stateTextWithIconMinWidthState = Random.secure().nextBool()
//               ? ButtonState.success
//               : ButtonState.fail;
//         });
//       });
//
//       break;
//     case ButtonState.loading:
//       break;
//     case ButtonState.success:
//       stateTextWithIconMinWidthState = ButtonState.idle;
//       break;
//     case ButtonState.fail:
//       stateTextWithIconMinWidthState = ButtonState.idle;
//       break;
//   }
//   setState(() {
//     stateTextWithIconMinWidthState = stateTextWithIconMinWidthState;
//   });
// }
//
// void onPressedCustomIndicatorButton() {
//   setState(() {
//     switch (stateOnlyCustomIndicatorText) {
//       case ButtonState.idle:
//         stateOnlyCustomIndicatorText = ButtonState.loading;
//         break;
//       case ButtonState.loading:
//         stateOnlyCustomIndicatorText = ButtonState.fail;
//         break;
//       case ButtonState.success:
//         stateOnlyCustomIndicatorText = ButtonState.idle;
//         break;
//       case ButtonState.fail:
//         stateOnlyCustomIndicatorText = ButtonState.success;
//         break;
//     }
//   });
// }