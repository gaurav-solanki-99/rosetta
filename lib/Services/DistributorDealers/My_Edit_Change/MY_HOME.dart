//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../rosetta/models/DealersDetails.dart';
// import 'my_personaldeail_edit.dart';
//
// class MYHOME extends StatefulWidget {
//
//
//   @override
//   State<MYHOME> createState() => _MYHOMEState();
// }
//
// class _MYHOMEState extends State<MYHOME> {
//
//   DealersDetsils dealersDetsils=null;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("MY HOME"),
//          leading: IconButton(onPressed: () {
//             Navigator.pop(context);
//          },
//              icon: Icon(Icons.arrow_back,
//             color: Colors.red,
//       size: 30,
//     ),
//       ),
//     ) ,
//
//      body: Column(
//         children: [
//           Center(
//             child: TextButton(onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => MyPersonalDeatilsForm("1",true,null,dealersDetsils)));
//
//
//             }, child: Text("PAYMENT EDIT PAGE")),
//           )
//         ],
//     ),
//
//     ) ;
//   }
// }
