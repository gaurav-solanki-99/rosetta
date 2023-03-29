// import 'dart:convert';
// import 'dart:io';
//
// import 'package:external_path/external_path.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter/material.dart';
//
// import 'package:nb_utils/nb_utils.dart';
// import 'package:open_file/open_file.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/DisHomeScreen.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/SelectProductPlaceOrder.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/SerchResultProduct.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/viewallproductcategory.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/viewallsubcategoty.dart';
// import 'package:rosetta_fluter_app/Services/DistributorDealers/My_Edit_Change/MY_HOME.dart';
// import 'package:rosetta_fluter_app/Services/loginScreen.dart';
// import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
// import 'package:rosetta_fluter_app/main/utils/dots_indicator/dots_indicator.dart';
// import 'package:rosetta_fluter_app/rosetta/models/DealersDetails.dart';
// import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';
// // import 'package:shop_hop/shopHop/screens/ShCartScreen.dart';
// // import 'package:shop_hop/shopHop/screens/ShProductDetail.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
// import 'package:http/http.dart' as http;
//
//
// import '../../../rosetta/utils/ShConstant.dart';
// import '../../../rosetta/utils/ShFunction.dart';
// import '../PersonalDeatilsForm.dart';
// import '../ViewDealers.dart';
// import 'my_personaldeail_edit.dart';
//
//
//
//
// var textFiledBorderStyle = OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(width: 0, color: sh_editText_background));
// SharedPreferences prefs;
//
// InputDecoration formFieldDecoration(String hintText) {
//   return InputDecoration(
//     labelText: hintText,
//     focusColor: sh_colorPrimary,
//     counterText: "",
//     labelStyle: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
//     contentPadding: new EdgeInsets.only(bottom: 2.0),
//   );
// }
//
// // ignore: must_be_immutable
//
// class MyEditAppBar extends StatefulWidget
// {
//   bool homeback;
//   String title;
//   String userName;
//   bool isGuestUser;
//   bool isEditButton;
//   String dealersId;
//   DealersDetsils dealersDetsils;
//   MyEditAppBar(this.homeback,this.title,this.userName,this.isGuestUser,this.isEditButton );
//
//   @override
//   State<MyEditAppBar> createState() => _MyEditAppBarState();
// }
//
// class _MyEditAppBarState extends State<MyEditAppBar> {
//   DealersDetsils dealersDetsils;
//
//   var checkNetconnection = null;
//
//   String MyToken;
//
//   String MyUserName = "";
//
//   String MyCompanyId;
//
//   String MyMemberId;
//
//   String MyMemberType;
//
//   String Myparent_distributor_id;
//
//   String Myparent_distributor_nav_id;
//
//   String name="";
//
//   String personal_Name="";
//
//   String email="";
//
//   String passwoard="";
//
//   String phone="";
//
//   String fax="";
//
//   String address="";
//
//   String paymentTerms="";
//
//   String paymentMethods="";
//
//   String creditLimits="";
//
//   String overdueBalance="";
//
//   String gstCusType="";
//
//   String gstNumber="";
//
//   String panNo="";
//
//   String panRefernce="";
//
//   // NEW CHANGE
//   String state_code = "";
//
//   String state = "" ;
//
//   String city = "" ;
//
//   String Post_code = "" ;
//
//   bool isDetailsLoad=false;
//
//   getDealerDetails(String dealerId) async {
//     print("Dealers Details >>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
//
//     //?sort=&page=1&per_page=20
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers/$dealerId'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//
//     print("Response Code >>>>>>>>>>>>>>>>>>>>> $responseCode");
//     print("Response Body >>>>>>>>>>>>>>>>>>>>> $responcebody");
//     print("LLLLLLLLLLLLLLLLLLLLLLNEWNEWNEW");
//     print(responcebody.length);
//      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa");
//     print("Response Code >>>>>>>>>>>>>>>>>>>>> $responseCode");
//
//     if(responseCode==200)
//     {
//       dealersDetsils =DealersDetsils.fromJson(json.decode(responcebody));
//
//
//       setState(() {
//         name=dealersDetsils.name;
//         personal_Name=dealersDetsils.contact;
//         email=dealersDetsils.email;
//         passwoard="";
//         phone=dealersDetsils.phone;
//         fax=dealersDetsils.fax.toString();
//         address=dealersDetsils.address;
//
//         paymentTerms=dealersDetsils.paymentTerms.key;
//         paymentMethods=dealersDetsils.paymentMethod.key;
//         creditLimits=dealersDetsils.creditLimit.toString();
//         overdueBalance=dealersDetsils.overdueBalance.toString();
//         gstCusType=dealersDetsils.taxInformation.gst.customerType.key;
//         gstNumber=dealersDetsils.taxInformation.gst.number.toString();
//         panNo=dealersDetsils.taxInformation.pan.number.toString();
//         panRefernce=dealersDetsils.taxInformation.pan.referenceNumber.toString();
//         state = dealersDetsils.state.name.toString();
//         Post_code = dealersDetsils.zipcode.toString();
//         print("State Details "+dealersDetsils.name);
//         print("State Details 2"+state);
//         print("PPPPPPPPPPPPPPPPPPPPPPPPPNEWNEWNEW");
//         print(panNo);
//         print(Post_code);
//
//
//         // NEW CHANGES
//         // state_code =  dealersDetsils.state_code.toString();
//         city =  dealersDetsils.city;
//
//         print("NEW STATE TEST +++++++++++++++++++"+state);
//         print(dealersDetsils.state.toString());
//         // if(dealersDetsils.taxInformation.pan.number!=null)
//         //  {
//         //    print("Dealer Pan Details >>>>>>>>>>>>>>>>>>>>> Number "+dealersDetsils.taxInformation.pan.number.toString());
//         //  }
//         // if(dealersDetsils.taxInformation.pan.status.value!=null)
//         //  {
//         //    print("Dealer Pan Details >>>>>>>>>>>>>>>>>>>>> Status  "+dealersDetsils.taxInformation.pan.status.value.toString());
//         //  }
//         // if(dealersDetsils.taxInformation.pan.referenceNumber!=null)
//         //  {
//         //    print("Dealer Pan Details >>>>>>>>>>>>>>>>>>>>>  Refrence "+dealersDetsils.taxInformation.pan.referenceNumber.toString());
//         //  }
//
//       });
//     }
//
//     setState(() {
//       isDetailsLoad=false;
//
//     });
//   }
//
//   getSessionData() async
//   {
//     print("Get Session Methode Call");
//     prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token');
//     String userName = prefs.getString('UserName');
//     String mycompanyId = prefs.getString('companyId');
//     String mymemberId = prefs.getString('memberId');
//     String mymemberType = prefs.getString('memberType');
//     API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');
//
//     String parent_distributor_id = "0";
//     String parent_distributor_nav_id = "0";
//     if (mymemberType != "Distributor") {
//       parent_distributor_id = prefs.getString('parent_distributor_id');
//       parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');
//     }
//
//     print(
//         ">>>>>>>>>>>Session Token $token  $userName $mycompanyId $mymemberId");
//     print(">>>>>>>>>>>Session Token $token");
//     setState(() {
//       MyToken = token;
//       MyUserName = userName;
//       MyCompanyId = mycompanyId;
//       MyMemberId = mymemberId;
//       MyMemberType = mymemberType;
//       if (MyMemberType != "Distributor") {
//         Myparent_distributor_id = parent_distributor_id;
//         Myparent_distributor_nav_id = parent_distributor_nav_id;
//         print(
//             "DisSelected Inventory  Page Session Data Myparent_distributor_id  $parent_distributor_id , Myparent_distributor_nav_id $parent_distributor_nav_id");
//       }
//     });
//
//     if (token.isNotEmpty) {
//       print(">>>>>>>>>>>>>>>>>>Token is Not Empty>>>>>>>>>>>>>>>>>>>");
//
//
//       checkNetconnection = isInternatAvailable();
//       print("Response od internet Menthode $checkNetconnection");
//       print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$checkNetconnection.");
//       if (checkNetconnection != null) {
//         setState(() {
//           isDetailsLoad=true;
//         });
//         getDealerDetails(widget.dealersId);
//       }
//       if (checkNetconnection != null) {
//         print("Please check your Internet Connection ");
//         // showAlertStockDialog(context);
//         //interNetPopup();
//       }
//     }
//   }
//   @override
//   void initState() {
//
//
//     getSessionData();
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp);
//
//     print("Username >>>>>>>>>>>>>>>>>>>>>>>. @@@@@@@2 PPPPPPP "+widget.userName);
//     return AppBar(
//       backgroundColor: sh_white,
//       automaticallyImplyLeading: false,
//       titleSpacing: 0,
//
//       iconTheme: IconThemeData(color: sh_textColorPrimary),
//       actions: <Widget>[
//
//         widget.userName==""?Container():  Padding(
//             padding: EdgeInsets.only(right: 10.0,top: 0.0),
//             child: Container(
//               width: 150,
//               child: GestureDetector(
//                   onTap: () {},
//                   // child: Text("$userName",overflow: TextOverflow.ellipsis,fontSize: textSizeSMedium,textColor: Colors.black)
//                   child:Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(),
//                       Text(widget.userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)
//                       //Text(userName.length==1?userName:userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)
//
//                     ],
//                   )
//               ),
//             )
//         ),
//
//         //// EDIT BUTTON
//
//
//         widget.isEditButton?Container(): Padding(
//             padding: EdgeInsets.only(right: 10.0),
//             child: GestureDetector(
//               onTap: ()  {
//                // SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);
//               //  MYHOME();
//
//
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyPersonalDeatilsForm("1",true,null,widget.dealersDetsils)));
//               // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MYHOME()));
//               },
//               child: Icon(
//                 Icons.edit,
//                 color: secondColor,
//                 size: 26.0,
//               ),
//             )
//         ),
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//         widget.isGuestUser?Container(): Padding(
//             padding: EdgeInsets.only(right: 10.0),
//             child: GestureDetector(
//               onTap: ()  {
//                 SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);
//                 // _pageIndex = 3;
//
//                 // Navigator.pop(context, false);
//                 // Navigator.pop(context);
//                 // await Navigator.of(context)
//                 //     .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart")));
//
//                 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart"),));
//                 //  Navigator.pushAndRemoveUntil(
//                 //      context,
//                 //      MaterialPageRoute( builder: (context) =>
//                 //          SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart")),
//                 //          (Route)=>false);
//
//               },
//               child: Icon(
//                 Icons.shopping_cart_outlined,
//                 color: secondColor,//isrosetta?sh_colorPrimary:sh_colorPrimary2,
//                 size: 26.0,
//               ),
//             )
//         ),
//         Padding(
//             padding: EdgeInsets.only(right: 10.0),
//             child: GestureDetector(
//               onTap: () {
//                 Scaffold.of(context).openEndDrawer();
//                 //_scaffoldKey.currentState.openEndDrawer();
//
//                 // _pageIndex = 3;
//
//
//               },
//               child: Icon(
//                 Icons.menu,
//                 color: Colors.black,
//                 size: 26.0,
//               ),
//             )
//         ),
//       ],
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             margin: EdgeInsets.only(left: 5),
//             child:  GestureDetector(
//               onTap: () {
//
//                 // Navigator.pop(context);
//                 if(this.widget.homeback)
//                 {
//
//
//                 }
//                 else
//                 {
//                   Navigator.of(context).pop();
//
//                 }
//
//               },
//               child:new Offstage(
//                 offstage: widget.homeback,
//                 child: Icon(
//                   Icons.arrow_back,
//                   color: Colors.black,
//                   size: 26.0,
//                 ),
//               ) ,
//               // child:Visibility(
//               //
//               // child :Icon(
//               //   Icons.arrow_back,
//               //   color: Colors.black,
//               //   size: 26.0,
//               // ),
//               //   maintainSize: true,
//               //   maintainAnimation: true,
//               //   maintainState: true,
//               //   visible: homeback,
//               //
//               // ),
//
//             ),),
//           SizedBox(width: 5,),
//           Container(
//
//               child: Text(widget.title,style: TextStyle(color: sh_textColorPrimary,fontWeight: FontWeight.bold,fontSize: textSizeMedium),))
//
//
//
//
//
//
//         ],
//       ),
//       elevation: 1,
//     );
//   }
// }
// // class MyAppBar2 extends StatelessWidget
// // {
// //   bool homeback;
// //   String title;
// //   String userName;
// //   bool isGuestUser;
// //
// //
// //
// //   MyAppBar2(this.homeback,this.title,this.userName,this.isGuestUser);
// //
// //
// //
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //
// //     print("Username >>>>>>>>>>>>>>>>>>>>>>>. @@@@@@@2 "+userName);
// //     return AppBar(
// //       backgroundColor: sh_white,
// //       automaticallyImplyLeading: false,
// //       titleSpacing: 0,
// //
// //       iconTheme: IconThemeData(color: sh_textColorPrimary),
// //       actions: <Widget>[
// //
// //         userName==""?Container():  Padding(
// //             padding: EdgeInsets.only(right: 10.0,top: 0.0),
// //             child: Container(
// //               width: 150,
// //               child: GestureDetector(
// //                   onTap: () {},
// //                   // child: Text("$userName",overflow: TextOverflow.ellipsis,fontSize: textSizeSMedium,textColor: Colors.black)
// //                   child:Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Container(),
// //                       Text(userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)
// //                       //Text(userName.length==1?userName:userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)
// //
// //                     ],
// //                   )
// //               ),
// //             )
// //         ),
// //
// //         isGuestUser?Container(): Padding(
// //             padding: EdgeInsets.only(right: 10.0),
// //             child: GestureDetector(
// //               onTap: () {
// //                 SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);
// //                 // _pageIndex = 3;
// //
// //
// //               },
// //               child: Icon(
// //                 Icons.shopping_cart_outlined,
// //                 color: sh_colorPrimary,
// //                 size: 26.0,
// //               ),
// //             )
// //         ),
// //         Padding(
// //             padding: EdgeInsets.only(right: 10.0),
// //             child: GestureDetector(
// //               onTap: () {
// //                 Scaffold.of(context).openEndDrawer();
// //                 //_scaffoldKey.currentState.openEndDrawer();
// //
// //                 // _pageIndex = 3;
// //
// //
// //               },
// //               child: Icon(
// //                 Icons.menu,
// //                 color: Colors.black,
// //                 size: 26.0,
// //               ),
// //             )
// //         ),
// //       ],
// //       title: Row(
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Container(
// //             margin: EdgeInsets.only(left: 5),
// //             child:  GestureDetector(
// //               onTap: () {
// //
// //                 // Navigator.pop(context);
// //                 if(this.homeback)
// //                 {
// //
// //
// //                 }
// //                 else
// //                 {
// //                   // Navigator.of(context).pop();
// //                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(true)));
// //
// //                 }
// //
// //               },
// //               child:new Offstage(
// //                 offstage: homeback,
// //                 child: Icon(
// //                   Icons.cancel_outlined,
// //                   color: Colors.black,
// //                   size: 26.0,
// //                 ),
// //               ) ,
// //               // child:Visibility(
// //               //
// //               // child :Icon(
// //               //   Icons.arrow_back,
// //               //   color: Colors.black,
// //               //   size: 26.0,
// //               // ),
// //               //   maintainSize: true,
// //               //   maintainAnimation: true,
// //               //   maintainState: true,
// //               //   visible: homeback,
// //               //
// //               // ),
// //
// //             ),),
// //           SizedBox(width: 5,),
// //           Container(
// //
// //               child: Text(title,style: TextStyle(color: sh_textColorPrimary,fontWeight: FontWeight.bold,fontSize: textSizeMedium),))
// //
// //
// //
// //
// //
// //
// //         ],
// //       ),
// //       elevation: 1,
// //     );
// //   }
// // }
// // class MyAppBar3 extends StatelessWidget
// // {
// //   bool homeback;
// //   String title;
// //   String userName;
// //   bool isGuestUser;
// //   bool isComeBack;
// //
// //
// //
// //   MyAppBar3(this.homeback,this.title,this.userName,this.isGuestUser,this.isComeBack);
// //
// //
// //
// //   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //
// //     print("Username >>>>>>>>>>>>>>>>>>>>>>>. @@@@@@@2 "+userName);
// //     return AppBar(
// //       backgroundColor: sh_white,
// //       automaticallyImplyLeading: false,
// //       titleSpacing: 0,
// //
// //       iconTheme: IconThemeData(color: sh_textColorPrimary),
// //       actions: <Widget>[
// //
// //         userName==""?Container():  Padding(
// //             padding: EdgeInsets.only(right: 10.0,top: 0.0),
// //             child: Container(
// //               width: 150,
// //               child: GestureDetector(
// //                   onTap: () {},
// //                   // child: Text("$userName",overflow: TextOverflow.ellipsis,fontSize: textSizeSMedium,textColor: Colors.black)
// //                   child:Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Container(),
// //                       Text(userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)
// //                       //Text(userName.length==1?userName:userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)
// //
// //                     ],
// //                   )
// //               ),
// //             )
// //         ),
// //
// //         isGuestUser?Container(): Padding(
// //             padding: EdgeInsets.only(right: 10.0),
// //             child: GestureDetector(
// //               onTap: () {
// //                 SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);
// //                 // _pageIndex = 3;
// //
// //
// //               },
// //               child: Icon(
// //                 Icons.shopping_cart_outlined,
// //                 color: sh_colorPrimary,
// //                 size: 26.0,
// //               ),
// //             )
// //         ),
// //         Padding(
// //             padding: EdgeInsets.only(right: 10.0),
// //             child: GestureDetector(
// //               onTap: () {
// //                 Scaffold.of(context).openEndDrawer();
// //                 //_scaffoldKey.currentState.openEndDrawer();
// //
// //                 // _pageIndex = 3;
// //
// //
// //               },
// //               child: Icon(
// //                 Icons.menu,
// //                 color: Colors.black,
// //                 size: 26.0,
// //               ),
// //             )
// //         ),
// //       ],
// //       title: Row(
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Container(
// //             margin: EdgeInsets.only(left: 5),
// //             child:  GestureDetector(
// //               onTap: () {
// //
// //                 // Navigator.pop(context);
// //                 if(this.homeback)
// //                 {
// //
// //
// //                 }
// //                 else
// //                 {
// //                   // Navigator.of(context).pop();
// //
// //                   if(isComeBack)
// //                   {
// //                     DisHomeScreen(
// //                       child: Text('Home'),
// //                       navigatorKey: GlobalKey(),
// //                     ).launch(context);
// //                     //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewDistributorDashboard(0)));
// //                   }
// //                   else
// //                   {
// //                     Navigator.of(context).pop();
// //                   }
// //
// //
// //
// //                   // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers()));
// //
// //                 }
// //
// //               },
// //               child:new Offstage(
// //                 offstage: homeback,
// //                 child: Icon(
// //                   Icons.arrow_back,
// //                   color: Colors.black,
// //                   size: 26.0,
// //                 ),
// //               ) ,
// //               // child:Visibility(
// //               //
// //               // child :Icon(
// //               //   Icons.arrow_back,
// //               //   color: Colors.black,
// //               //   size: 26.0,
// //               // ),
// //               //   maintainSize: true,
// //               //   maintainAnimation: true,
// //               //   maintainState: true,
// //               //   visible: homeback,
// //               //
// //               // ),
// //
// //             ),),
// //           SizedBox(width: 5,),
// //           Container(
// //
// //               child: Text(title,style: TextStyle(color: sh_textColorPrimary,fontWeight: FontWeight.bold,fontSize: textSizeMedium),))
// //
// //
// //
// //
// //
// //
// //         ],
// //       ),
// //       elevation: 1,
// //     );
// //   }
// // }
// //
//
//
//
//
//
