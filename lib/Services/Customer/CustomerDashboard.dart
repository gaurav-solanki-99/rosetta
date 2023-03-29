// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/DisHomeScreen.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/SerchResultProduct.dart';
// import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
// import 'package:rosetta_fluter_app/rosetta/models/ShCategory.dart';
//
//
//
//
// import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
//
// import 'CustomerAccount.dart';
// import 'CustomerHome.dart';
//
//
// // import 'ShSubCategory.dart';
//
// class CustomerDashboard extends StatefulWidget {
//   static String tag = '/ShHomeScreen';
//
//   @override
//   ShHomeScreenState createState() => ShHomeScreenState();
// }
//
// class ShHomeScreenState extends State<CustomerDashboard> {
//
//   int _pageIndex = 0;
//
//   Map<int, GlobalKey> navigatorKeys =
//   {
//     0: GlobalKey(),
//     1: GlobalKey(),
//     2: GlobalKey(),
//
//   };
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var title = "Home";
//
//     return Scaffold(
//
//       body: SafeArea(
//         child: WillPopScope(
//           onWillPop: () async {
//             return !await Navigator.maybePop(
//                 navigatorKeys[_pageIndex].currentState.context);
//           },
//           child: IndexedStack(
//             index: _pageIndex,
//             children: <Widget>[
//               CustomerHome(
//                 child: Text('Home'),
//                 navigatorKey: navigatorKeys[0],
//               ),
//               CustomerHome(
//                 child: Text('Business'),
//                 navigatorKey: navigatorKeys[1],
//               ),
//               CustomerAccount(
//                 child: Text('Technology'),
//                 navigatorKey: navigatorKeys[2],
//               ),
//               CustomerHome(
//                 child: Text('Technology'),
//                 navigatorKey: navigatorKeys[3],
//               )
//
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//
//         decoration: BoxDecoration(
//
//
//           borderRadius: BorderRadius.only(topLeft: Radius.elliptical(90, 20),topRight: Radius.elliptical(90, 20)),
//
//
//           image: DecorationImage(image: AssetImage('images/shophop/bg_bottom_bar.png'), fit: BoxFit.fill),
//
//
//         ),
//         child:BottomNavigationBar(
//           backgroundColor: Colors.transparent,
//           type: BottomNavigationBarType.fixed,
//           elevation: 0,
//           selectedItemColor: sh_colorPrimary,
//
//
//
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage(ic_home_item)),
//               title: Text('Home',),
//             ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage(ic_order)),
//               title: Text('Order',),
//             ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(AssetImage(ic_contactus)),
//               title: Text('Contact',),
//             ),
//
//
//           ],
//           currentIndex: _pageIndex,
//           onTap: (int index) {
//             setState(
//                   () {
//                 _pageIndex = index;
//               },
//             );
//           },
//         ),
//
//
//       ),
//
//
//     );
//   }
//
//   Widget getDrawerItem(String icon, String name, {VoidCallback callback}) {
//     return InkWell(
//       onTap: callback,
//       child: Container(
//         color: sh_white,
//         padding: EdgeInsets.fromLTRB(20, 14, 20, 14),
//         child: Row(
//           children: <Widget>[
//             icon != null ? Image.asset(icon, width: 20, height: 20) : Container(width: 20),
//             SizedBox(width: 20),
//             text(name, textColor: sh_textColorPrimary, fontSize: textSizeMedium, fontFamily: fontMedium)
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }
//
//
