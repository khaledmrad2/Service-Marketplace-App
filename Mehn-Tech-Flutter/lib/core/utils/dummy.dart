// @override
// Widget build(BuildContext context) {
//   Size diSize = MediaQuery.of(context).size;
//   return Scaffold(
//     body: SingleChildScrollView(
//       child: Stack(
//         children: [
//           Row(
//             children: [
//               Container(
//                 color: Colors.white,
//                 height: diSize.height,
//                 width: diSize.width * .3,
//               ),
//               Container(
//                 color: const Color(0xFFfebd59),
//                 height: diSize.height, width: diSize.width * .7,
//               ),
//             ],
//           ),
//           Column(
//             children: [
//           Container(
//           decoration: const BoxDecoration(
//           color: Colors.white,
//             borderRadius: BorderRadius.only(bottomRight: Radius.circular(75)),
//           ),
//             height: diSize.height * .3,
//             width: diSize.width,
//            child:  Image.asset("assets/images/ourLogo.jpg"),
//            );
//               Container(
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFfebd59),
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(75)),
//                 ),
//                 height: diSize.height * .7,
//                 width: diSize.width,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }