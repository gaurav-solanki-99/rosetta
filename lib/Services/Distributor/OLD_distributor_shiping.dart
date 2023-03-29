// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:rosetta_fluter_app/main/utils/AppColors.dart';
// import 'package:rosetta_fluter_app/rosetta/models/AllStates.dart';
// import 'package:rosetta_fluter_app/rosetta/models/DealerAllInformations.dart';
// import 'package:rosetta_fluter_app/rosetta/models/DistributorAllTransporter.dart';
// import 'package:rosetta_fluter_app/rosetta/models/NewBlockedItems.dart';
// import 'package:rosetta_fluter_app/rosetta/models/NewCartItems.dart';
// import 'package:rosetta_fluter_app/rosetta/models/NewDistributorShippingAdress.dart';
// import 'package:rosetta_fluter_app/rosetta/models/OrderPlacedFailed.dart';
// import 'package:rosetta_fluter_app/rosetta/models/PurchaseLineProducts.dart';
// import 'package:rosetta_fluter_app/rosetta/models/ResponsePlaceOrder.dart';
// import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';
// import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShFunction.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';
//
// import 'package:rosetta_fluter_app/rosetta/models/SpinnerDealersList.dart';
//
// import '../SplashScreen.dart';
// import '../shimmer_list.dart';
// import 'DisHomeScreen.dart';
// import 'DisOrderHistory.dart';
// import 'NewDistributorDashBoard.dart';
//
// class DistributorShipingDetails extends StatefulWidget {
//   static String tag = '/ShProfileFragment';
//   SharedPreferences prefs = null;
//
//   SpinnerSpinnerDealerList spinnerDealerSelectes=null;
//   List<NewCartItesm> newCartListSelected2=[];
//   List<NewBlockedItems> newBlockListSelected2=[];
//   String RemarkValue;
//   String SelectedValueForSearch="";
//
//   // ignore: non_constant_identifier_names
//   DistributorShipingDetails({this.spinnerDealerSelectes, this.newCartListSelected2,this.RemarkValue,this.SelectedValueForSearch,this.newBlockListSelected2});
//
//   @override
//   ShWishlistFragmentState createState() => ShWishlistFragmentState();
// }
//
// class ShWishlistFragmentState extends State<DistributorShipingDetails> {
//
//
//
//
//   Image img;
// // example: Image.asset('images/camera.png',)
//   Image imgUp =  Image.asset(ic_check,height: 22,width: 22,color: sh_colorPrimary,);
//   Image imgDown =  Image.asset(ic_uncheck,height: 22,width: 22,color: sh_colorPrimary,);
//   var tapcount=0;
//   var selectedindex;
//   var listlength=0;
//   var list1 = [];
//
//
//
//
//   bool BlockedListVisible=true;
//
//   String dropdownValue = 'Select Dealer Location';
//
//   List<String> spinnerItems = [
//     'Select Dealer Location',
//     'One',
//     'Two',
//     'Three',
//     'Four',
//     'Five'
//   ];
//
//
//
//
//
//
//   // Select Tranporter
//   String dropdownValue2 = 'Select Transporter';
//
//   List<String> spinnerItems2 = [
//     'Select Transporter',
//     'One',
//     'Two',
//     'Three',
//     'Four',
//     'Five'
//   ];
//   List<ShProduct> list = [];
//
//
//
//
//   var checkNetconnection=null;
//   String MyToken;
//   String MyUserName="";
//   String MyCompanyId;
//   String MyMemberId;
//   String MyMemberType;
//   String  Myparent_distributor_id;
//   String  Myparent_distributor_nav_id;
//   List<SpinnerSpinnerDealerList> spinnerDelerList = null;
//
//
//
//
//
//
//   // Dealer Information
//   //varable here
//   List<User> users=null;
//
//   String memerName="";
//   String DealerName="",DealerContact="",DealerAdd1="",DealerAdd2="",DealerCity="",DealerPinCode="" ,DealerState=""  ,
//       DealerPhone_no="",DealerCode="",DealerPostCode="",DealerCountryRegionCode="";
//
//
//
//
//   // All Transporter List
//   List<DistribuorAllTranporter> distributorAllTransporterDetails=null;
//   List<String> spinnerSelectTransporterDetails = [];
//
//
//
//   String selectedTranspor="Select Address";
//   // String selectedTranspor="Select Address";
//   String selectedStates="Select State";
//   String stateCode;
//
//   bool isDisPlaceOrderSelf=false;
//   String memberType = "";
//
//
//   String  address_send="",
//       address_2_send="",
//       post_code_send="",
//       city_send="",
//       state_send="",
//       country_region_code_send="",
//       phone_no_send="",
//       name_send="",
//       contact_send="";
//
//
//
//   //New Cart Items
//   List<NewCartItesm> newCartListSelected=[];
//
//   int lenghtOfCommingBlockList;
//   int lenghtOfCommingList;
//   String OrderForm="";
//
//
//
//
//
//   //
//   //~~~~~~~~~~~~~~~~~~~~~~~~~Spinner State Api
//   List<AllSates> AllStatesList = [];
//   List<String> spinnerAllStatesList = [];
//
//   Future<List<SpinnerSpinnerDealerList>> getAllList() async {
//     print("Get All States Api  List Methode Call >>>>>>>>>>>>>>>>>>");
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/states'),//?sort=&page=1&per_page=20
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form ALL States  List Methode   Data Api : $responcebody");
//     print("Response code Form ALL States  List Methode  Data Api : $responseCode");
//
//
//     setState(() {
//
//
//       if(responseCode==200)
//       {
//         AllStatesList= allSatesFromJson((response.body));
//         getSpinnerAllSates();
//       }
//
//
//
//     });
//
//
//     int newinventoryLength =  AllStatesList.length;
//     print("All States is  Length >>>>>>>>>>>>>>> $newinventoryLength");
//   }
//
//   getSpinnerAllSates () async {
//
//
//     print("Get Spinner All States   List Methode Call");
//
//     var length = AllStatesList.length;
//     print(" Spinner Sates List   lsi length is $length");
//
//     for(int i=0;i<AllStatesList.length;i++)
//     {
//       var displayname;
//       print(" Spinner Sates List  Loop is Called ");
//       setState(() {
//         if(i==0)
//         {
//           spinnerAllStatesList.add("Select State");
//
//           spinnerAllStatesList.add(AllStatesList[i].name);
//           displayname = spinnerAllStatesList[i];
//         }
//         else
//         {
//           spinnerAllStatesList.add(AllStatesList[i].name);
//           displayname = spinnerAllStatesList[i];
//         }
//
//         ///SelectedDealer2=spinnerSelectDealer2[0];
//       });
//
//
//       print(" Spinner Dealer List   Name $displayname");
//     }
//
//
//     print("Length of Spinner All States length is "+spinnerAllStatesList.length.toString());
//   }
//
//
//
//
//
//   //unFocus
//   var currentFocus;
//
//   unfocus() {
//     currentFocus = FocusScope.of(context);
//
//     if (!currentFocus.hasPrimaryFocus) {
//       currentFocus.unfocus();
//     }
//   }
//
//   int dealerId=0;
//
//   @override
//   void initState() {
//     super.initState();
//     isInternatAvailable2(context);
//     fetchData();
//     getSessionData();
//
//
//
//     newCartListSelected=widget.newCartListSelected2;
//     lenghtOfCommingList=widget.newCartListSelected2.length;
//     print("Length of Widget CartItems List $lenghtOfCommingList");
//
//     lenghtOfCommingBlockList=widget.newBlockListSelected2.length;
//     print("Length of Widget Block List "+lenghtOfCommingBlockList.toString());
//
//     if(lenghtOfCommingList==0)
//     {
//       OrderForm="blocked";
//     }
//     else
//     {
//       OrderForm="cart";
//     }
//
//     ConverPurchaseLines();
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
//     //  print("Data From Cart Page Dealer Information "+widget.spinnerDealerSelectes.name + " & Items selected "+widget.newCartListSelected.length.toString()+widget.RemarkValue);
//   }
//   List<PurchaseLineProducts> ListPurchaseLineProducts= [];
//
//   ConverPurchaseLines()
//   {
//
//     if( OrderForm=="cart") {
//
//       print("Convert Purchase line for Cart");
//       //For Cart Item is >>>>>>>>>>>>>>>>>>>>>>>
//       int totalItems = newCartListSelected.length;
//       print("Total Selected Item is $totalItems");
//       for (int i = 0; i < totalItems; i++) {
//         NewCartItesm cartItems = newCartListSelected[i];
//
//         //  //(unitprice*discount)/100
//         double totalvalue=0;
//
//         if(cartItems.discount.toString().isEmptyOrNull)
//         {
//
//           totalvalue =  cartItems.unitPrice*cartItems.orderQuantity;
//           print("Amount without Discount $totalvalue");
//         }
//         else
//         {
//
//           double dis = (cartItems.unitPrice*cartItems.discount)/100;
//           double disPrice = cartItems.unitPrice-dis;
//           totalvalue =  disPrice*cartItems.orderQuantity;
//           print("Amount with  Discount $dis  $totalvalue");
//         }
//
//
//         PurchaseLineProducts purchaseLineProducts = new PurchaseLineProducts(
//             itemId: cartItems.id,
//             productId: cartItems.productId,
//             rateType: (cartItems.rateType=="RL"||cartItems.rateType=="CL")?cartItems.rateType:"RL",
//             quantity: cartItems.orderQuantity,
//             batchNo: cartItems.batchNo,
//             unitPrice: cartItems.unitPrice,
//             discount: cartItems.discount,
//             //
//             onlineDiscount: cartItems.onlineDiscount,
//             stockPointId: cartItems.stockPointId,
//             amount: "" +totalvalue.toString());
//
//         print("Purchase line items is " + purchaseLineProducts.itemId.toString());
//
//         ListPurchaseLineProducts.add(purchaseLineProducts);
//       }
//     }
//     else {
//       print("Convert Purchase line for Block");
//
//       int totalItems = widget.newBlockListSelected2.length;
//       print("Total Selected Item is $totalItems");
//       for (int i = 0; i < totalItems; i++) {
//         NewBlockedItems blockcartItems =  widget.newBlockListSelected2[i];
//
//         //(unitprice*discount)/100
//
//
//
//         double totalvalue =  0;
//         if(blockcartItems.discount.toString().isEmptyOrNull)
//         {
//
//           totalvalue =  blockcartItems.unitPrice*blockcartItems.orderQuantity;
//           print("Amount without Discount $totalvalue");
//         }
//         else
//         {
//
//
//           double dis = (blockcartItems.unitPrice*blockcartItems.discount)/100;
//           double disPrice = blockcartItems.unitPrice-dis;
//           totalvalue =  disPrice*blockcartItems.orderQuantity;
//           print("Amount with  Discount $dis  $totalvalue");
//         }
//
//
//
//         PurchaseLineProducts purchaseLineProducts = new PurchaseLineProducts(
//             itemId: blockcartItems.id,
//             productId: blockcartItems.productId,
//             rateType: (blockcartItems.rateType=="RL"||blockcartItems.rateType=="CL")?blockcartItems.rateType:"RL",
//             quantity: blockcartItems.orderQuantity,
//             batchNo: blockcartItems.batchNo,
//             unitPrice: blockcartItems.unitPrice,
//             discount: blockcartItems.discount,
//             //
//             onlineDiscount: blockcartItems.onlineDiscount,
//             stockPointId: blockcartItems.stockPointId,
//             amount: "" + totalvalue.toString());
//
//         print("Purchase line items is Block " + purchaseLineProducts.itemId.toString());
//
//         ListPurchaseLineProducts.add(purchaseLineProducts);
//       }
//     }
//
//     print("Length of ListPurchaseLineProducts "+ListPurchaseLineProducts.length.toString());
//
//     print("Json ListPurchaseLineProducts "+jsonEncode(ListPurchaseLineProducts));
//
//   }
//
//   DealeerAllInformation(SpinnerSpinnerDealerList selectedDealerObject) async
//   {
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
//     print("Get Dealer ALl Informations  Methode Call ");
//
//     int id = selectedDealerObject.id;
//     // print("Id of Distributor id");
//
//     //http://ros.rosettaproducts.com/api/companies/3/dealers/2971/addresses
//     // http://rosdev.rosettaproducts.com/api/dealers/$id/users?sort=&page=1&per_page=20
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$id/addresses'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of FormDealer ALl Informations Data Api : $responcebody");
//     print("Response code Form Dealer ALl Informations   Data Api : $responseCode");
//     if(responseCode==200)
//     {
//       setState(() {
//
//         distributorAllTransporterDetails  =  distribuorAllTranporterFromJson(responcebody);
//
//         print("Response From Dealer All Information 200");
//         print("Response From Dealer All Information 200 $distributorAllTransporterDetails");
//
//         // users  = DealerAllAllInformations.fromJson(json.decode(responcebody)).users;
//
//         int UserLength= distributorAllTransporterDetails.length;
//         print("List Of User Length is $UserLength");
//         //memerName=distributorAllTransporterDetails[0].name==null?"":distributorAllTransporterDetails[0].name;
//         DealerName=distributorAllTransporterDetails[0].name==null?"":distributorAllTransporterDetails[0].name;
//         DealerContact=distributorAllTransporterDetails[0].phoneNo==null?"":distributorAllTransporterDetails[0].phoneNo;
//         DealerAdd1=distributorAllTransporterDetails[0].address==null?"":distributorAllTransporterDetails[0].address;
//         DealerAdd2=distributorAllTransporterDetails[0].address2==null?"":distributorAllTransporterDetails[0].address2;
//         DealerCity=distributorAllTransporterDetails[0].city==null?"":distributorAllTransporterDetails[0].city;
//         DealerPinCode=distributorAllTransporterDetails[0].countryRegionCode==null?"":distributorAllTransporterDetails[0].countryRegionCode;
//
//         DealerCode="";
//         // DealerCode=distributorAllTransporterDetails[0].code==null?"":distributorAllTransporterDetails[0].code;
//         DealerPostCode=distributorAllTransporterDetails[0].postCode==null?"":distributorAllTransporterDetails[0].postCode;
//         DealerCountryRegionCode=distributorAllTransporterDetails[0].countryRegionCode==null?"":distributorAllTransporterDetails[0].countryRegionCode;
//         DealerPhone_no=distributorAllTransporterDetails[0].phoneNo==null?"":distributorAllTransporterDetails[0].phoneNo;
//
//
//
//
//
//
//       });
//
//       // int UserLength= users.length;
//       // print("List Of User Length is $UserLength");
//     }
//
//   }
//
//
//
//   fetchData() async {
//     var products = await loadProducts();
//     setState(() {
//       list.clear();
//       list.addAll(products);
//     });
//   }
//
//   Future<List<ShProduct>> loadProducts() async {
//     String jsonString =
//     await loadContentAsset('assets/shophop_data/wishlist_products.json');
//     final jsonResponse = json.decode(jsonString);
//     return (jsonResponse as List).map((i) => ShProduct.fromJson(i)).toList();
//   }
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
//   getTransporterList() async {
//     print("Distributor Get Transporter List Methode Call >>>>>>>>>>>>>>>>>>");
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/addresses'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form Transporter List Methode   Data Api : $responcebody");
//     print("Response code Form Transporter List Methode  Data Api : $responseCode");
//     // int inventoryLength =  newCartItesmFromJson(json.decode(response.body)).length;
//     //
//     // print("New Cart List Length >>>>>>>>>>>>>>> $inventoryLength");
//
//     if(responseCode==200)
//     {
//       setState(() {
//
//         distributorAllTransporterDetails  =  distribuorAllTranporterFromJson(responcebody);
//         if(distributorAllTransporterDetails.length==0)
//         {
//           showToastDialog(context, "Shipping Address not Available ");
//
//         }
//         if( addressApicall!=true)
//         {
//           DealerName=distributorAllTransporterDetails[0].name==null?"":distributorAllTransporterDetails[0].name;
//           DealerContact=distributorAllTransporterDetails[0].phoneNo==null?"":distributorAllTransporterDetails[0].phoneNo;
//           DealerAdd1=distributorAllTransporterDetails[0].address==null?"":distributorAllTransporterDetails[0].address;
//           DealerAdd2=distributorAllTransporterDetails[0].address2==null?"":distributorAllTransporterDetails[0].address2;
//           DealerCity=distributorAllTransporterDetails[0].city==null?"":distributorAllTransporterDetails[0].city;
//           DealerPinCode=distributorAllTransporterDetails[0].countryRegionCode==null?"":distributorAllTransporterDetails[0].countryRegionCode;
//           DealerPostCode=distributorAllTransporterDetails[0].postCode==null?"":distributorAllTransporterDetails[0].postCode;
//
//         }
//
//       });
//
//
//       int TransporterDetailsLength =  distributorAllTransporterDetails.length;
//       print("New TransporterDetailsLength  List   Length 1111111>>>>>>>>>>>>>>> $TransporterDetailsLength ");
//       for(int i=0;i<distributorAllTransporterDetails.length;i++)
//       {
//         String displayname;
//         print(" Spinner selectedTranspor List  Loop is Called ");
//         setState(() {
//           if(i==0)
//           {
//             //selectedTranspor="Select Address";
//             // selectedTranspor=DealerName;
//             // selectedTranspor=""+distributorAllTransporterDetails[0].name+"*";
//             spinnerSelectTransporterDetails.add("Select Address");
//             spinnerSelectTransporterDetails.add(distributorAllTransporterDetails[0].name);
//           }
//           else
//           {
//
//             if(spinnerSelectTransporterDetails.contains(distributorAllTransporterDetails[i].name))
//             {
//               //spinnerSelectTransporterDetails.add(distributorAllTransporterDetails[i].name+"*");
//             }
//             else
//             {
//               spinnerSelectTransporterDetails.add(distributorAllTransporterDetails[i].name);
//             }
//
//             displayname = spinnerSelectTransporterDetails[i];
//           }
//
//         });
//
//
//         print(" Spinner selectedTranspor List   Name $displayname");
//       }
//     }
//
//
//
//
//
//
//   }
//   getTransporterListDealer() async {
//     print("Dealer Get Transporter List Methode Call >>>>>>>>>>>>>>>>>> $dealerId");
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$dealerId/addresses'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Dealer Response Body of Form Transporter List Methode   Data Api : $responcebody");
//     print("Dealer Response code Form Transporter List Methode  Data Api : $responseCode");
//     // int inventoryLength =  newCartItesmFromJson(json.decode(response.body)).length;
//     //
//     // print("New Cart List Length >>>>>>>>>>>>>>> $inventoryLength");
//
//     if(responseCode==200)
//     {
//       setState(() {
//         distributorAllTransporterDetails  =  distribuorAllTranporterFromJson(responcebody);
//
//         if(distributorAllTransporterDetails.length==0)
//         {
//           showToastDialog(context, "Shipping Address not Available ");
//
//         }
//         if( addressApicall!=true)
//         {
//           DealerName=distributorAllTransporterDetails[0].name==null?"":distributorAllTransporterDetails[0].name;
//           DealerContact=distributorAllTransporterDetails[0].phoneNo==null?"":distributorAllTransporterDetails[0].phoneNo;
//           DealerAdd1=distributorAllTransporterDetails[0].address==null?"":distributorAllTransporterDetails[0].address;
//           DealerAdd2=distributorAllTransporterDetails[0].address2==null?"":distributorAllTransporterDetails[0].address2;
//           DealerCity=distributorAllTransporterDetails[0].city==null?"":distributorAllTransporterDetails[0].city;
//           DealerPinCode=distributorAllTransporterDetails[0].countryRegionCode==null?"":distributorAllTransporterDetails[0].countryRegionCode;
//           DealerPostCode=distributorAllTransporterDetails[0].postCode==null?"":distributorAllTransporterDetails[0].postCode;
//         }
//
//
//
//         // selectedTranspor= distributorAllTransporterDetails[0].name;
//       });
//
//
//       int TransporterDetailsLength =  distributorAllTransporterDetails.length;
//       print("New TransporterDetailsLength  List   Length22222 >>>>>>>>>>>>>>> $TransporterDetailsLength ");
//       for(int i=0;i<distributorAllTransporterDetails.length;i++)
//       {
//         String displayname;
//         print(" Spinner selectedTranspor List  Loop is Called ");
//         setState(() {
//           if(i==0)
//           {
//             selectedTranspor=DealerName;
//             //spinnerSelectTransporterDetails.add("Select Address");
//           }
//           else
//           {
//             spinnerSelectTransporterDetails.add(distributorAllTransporterDetails[i].name);
//             displayname = spinnerSelectTransporterDetails[i];
//           }
//
//         });
//
//
//         print(" Spinner selectedTranspor List   Name $displayname");
//       }
//     }
//
//
//
//
//
//
//   }
//   getTransporterListDUDDUC() async {
//     print("$MyMemberType  Get Transporter List Methode Call >>>>>>>>>>>>>>>>>> ");
//
//
//
//
//     http.Response response;
//     if(MyMemberType=="DUC")
//     {
//       //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/addresses
//       response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/addresses'),
//         headers: {
//           HttpHeaders.authorizationHeader: 'bearer $MyToken',
//         },
//       );
//     }
//     else if(MyMemberType=="DUD")
//     {
//       //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1687/addresses
//       response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/addresses'),
//         headers: {
//           HttpHeaders.authorizationHeader: 'bearer $MyToken',
//         },
//       );
//     }
//
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("$MyMemberType  Response Body of Form Transporter List Methode   Data Api : $responcebody");
//     print("$MyMemberType Response code Form Transporter List Methode  Data Api : $responseCode");
//     // int inventoryLength =  newCartItesmFromJson(json.decode(response.body)).length;
//     //
//     // print("New Cart List Length >>>>>>>>>>>>>>> $inventoryLength");
//
//     if(responseCode==200)
//     {
//       setState(() {
//         distributorAllTransporterDetails  =  distribuorAllTranporterFromJson(responcebody);
//         if(distributorAllTransporterDetails.length==0)
//         {
//           showToastDialog(context, "Shipping Address not Available ");
//
//         }
//         if( addressApicall!=true)
//         {
//           DealerName=distributorAllTransporterDetails[0].name==null?"":distributorAllTransporterDetails[0].name;
//           DealerContact=distributorAllTransporterDetails[0].phoneNo==null?"":distributorAllTransporterDetails[0].phoneNo;
//           DealerAdd1=distributorAllTransporterDetails[0].address==null?"":distributorAllTransporterDetails[0].address;
//           DealerAdd2=distributorAllTransporterDetails[0].address2==null?"":distributorAllTransporterDetails[0].address2;
//           DealerCity=distributorAllTransporterDetails[0].city==null?"":distributorAllTransporterDetails[0].city;
//           DealerPinCode=distributorAllTransporterDetails[0].countryRegionCode==null?"":distributorAllTransporterDetails[0].countryRegionCode;
//
//
//
//
//           DealerCode=distributorAllTransporterDetails[0].code==null?"":distributorAllTransporterDetails[0].code;
//           DealerPostCode=distributorAllTransporterDetails[0].postCode==null?"":distributorAllTransporterDetails[0].postCode;
//         }
//
//
//
//         // selectedTranspor= distributorAllTransporterDetails[0].name;
//       });
//
//
//       int TransporterDetailsLength =  distributorAllTransporterDetails.length;
//       print("New TransporterDetailsLength  List   Length 3333333>>>>>>>>>>>>>>> $TransporterDetailsLength ");
//       for(int i=0;i<distributorAllTransporterDetails.length;i++)
//       {
//         String displayname;
//         print(" Spinner selectedTranspor List  Loop is Called ");
//         setState(() {
//
//
//
//           if(i==0)
//           {
//             spinnerSelectTransporterDetails.add("Select Address");
//           }
//           spinnerSelectTransporterDetails.add(
//               distributorAllTransporterDetails[i].name);
//           displayname = spinnerSelectTransporterDetails[i];
//         });
//
//
//         print(" Spinner selectedTranspor List   Name $displayname");
//       }
//     }
//
//
//
//
//
//
//   }
//
//
//
//
//
//   getSessionData() async
//   {
//     print("Get Session Methode Call");
//     prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token');
//     String  userName = prefs.getString('UserName');
//     String  mycompanyId = prefs.getString('companyId');
//     String  mymemberId = prefs.getString('memberId');
//     String  mymemberType = prefs.getString('memberType');
//     API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');
//
//     String  parent_distributor_id ="0";
//     String  parent_distributor_nav_id = "0";
//     if(mymemberType!="Distributor")
//     {
//
//       parent_distributor_id = prefs.getString('parent_distributor_id');
//       parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');
//
//     }
//
//     print(">>>>>>>>>>>Session Token $token  $userName $mycompanyId $mymemberId");
//     print(">>>>>>>>>>>Session Token $token");
//     setState(() {
//       MyToken=token;
//       MyUserName=userName;
//       MyCompanyId=mycompanyId;
//       MyMemberId=mymemberId;
//       MyMemberType=mymemberType;
//       if(MyMemberType!="Distributor")
//       {
//         Myparent_distributor_id=parent_distributor_id;
//         Myparent_distributor_nav_id=parent_distributor_nav_id;
//         print("DisSelected Inventory  Page Session Data Myparent_distributor_id  $parent_distributor_id , Myparent_distributor_nav_id $parent_distributor_nav_id");
//       }
//
//
//     });
//
//     if(token.isNotEmpty)
//     {
//       print(">>>>>>>>>>>>>>>>>>Token is Not Empty>>>>>>>>>>>>>>>>>>>");
//
//
//
//
//       checkNetconnection = isInternatAvailable();
//       print("Response od internet Menthode $checkNetconnection");
//       print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$checkNetconnection.");
//       if(checkNetconnection!=null)
//       {
//         getAllList();
//
//         DealeerAllInformation(widget.spinnerDealerSelectes);
//
//
//
//         print("Selected Memeber For Search "+widget.SelectedValueForSearch);
//
//
//         if (MyMemberType == "Distributor")
//         {
//           if(widget.SelectedValueForSearch=="Self Stock")
//           {
//             getTransporterList();
//
//             print("Self Stock is Selected ");
//             setState(() {
//               isDisPlaceOrderSelf=true;
//               memberType="Distributor";
//               memerName=MyUserName;
//
//             });
//
//           }
//           else  if(widget.SelectedValueForSearch=="Dealer")
//           {
//             dealerId=  widget.spinnerDealerSelectes.id;
//             getTransporterListDealer();
//             print("Dealer  is Selected ");
//
//             setState(() {
//               isDisPlaceOrderSelf=false;
//               memberType="Dealer";
//               memerName=widget.spinnerDealerSelectes.name;
//             });
//
//           }
//         }
//         else
//         {
//           getTransporterListDUDDUC();
//         }
//
//
//
//       }
//       if(checkNetconnection!=null)
//       {
//         print("Please check your Internet Connection ");
//         // showAlertStockDialog(context);
//         //interNetPopup();
//       }
//     }
//   }
//
//
//
//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }
//   var newJsonData;
//   bool isPlaced=false;
//   bool isCloseButtonVisible=false;
//
//
//   bool flagOrderPlace=true;
//   String LoadMessage;
//   bool addressApicall=false;
//   String responceStringOrderPlace="";
//   int orderPalcedResponse=0;
//   Future<int> orderPlacedMethode(StateSetter updateState)
//   async {
//     updateState((){
//       isCloseButtonVisible=false;
//     });
//
//     print("Order Placed Methode Call Address Api Call $addressApicall");
//     print("Order Placed Methode Call Dealer Post Code  $DealerPostCode");
//     print("Order Placed Methode Call Code Value "+widget.SelectedValueForSearch=="Self Stock"?(addressApicall?DealerCode:null):null);
//     print("orderPlacedMethode Json ListPurchaseLineProducts "+jsonEncode(ListPurchaseLineProducts));
//
//     String codeSent="";
//     String OnBehalf="Dealer";
//
//
//
//
//     if(MyMemberType == "Distributor")
//     {
//       codeSent=widget.SelectedValueForSearch=="Self Stock"?(addressApicall?DealerCode:null):null;
//       if(widget.SelectedValueForSearch=="Self Stock")
//       {
//         OnBehalf=null;
//       }
//
//     }
//     else
//     {
//       if(MyMemberType=="DUC")
//       {
//         OnBehalf=null;
//         //Dealer under Company
//         // 1. My Address - Add Address API -> response will get Address Code + Place Order (code to be sent)
//         // 2. My Customer Address - store address locally + Place Order (code = null)
//         codeSent=addressApicall?DealerCode:null;
//
//       }
//       else if(MyMemberType=="DUD")
//       {
//         OnBehalf=null;
//         //Dealer Under Distributor
//         // 1. My Address - Add Address API -> response will get Address Code + Place Order (code = null)
//         //  2. My Customer Address - store address locally + Place Order (code = null)
//         codeSent=null;
//
//       }
//     }
//
//
//     print("Code to be Sent $codeSent");
//
//     newJsonData = {
//       "shipping_method": "AS AGREED",
//       "special_request": ""+widget.RemarkValue,
//       "purchase_lines":ListPurchaseLineProducts,
//       "shipping_address": {
//         "code": codeSent,//widget.SelectedValueForSearch=="Self Stock"?(addressApicall?DealerCode:null):null,//DealerCode,
//         "address": DealerAdd1,
//         "address_2": DealerAdd2,
//         "post_code": DealerPostCode,
//         "city": DealerCity,
//         "country_region_code": "IN",
//         "phone_no": DealerPhone_no,
//         "name": DealerName,
//         "contact": DealerContact,
//         "state": "MAH"
//       },
//       "order_from": "$OrderForm",
//       "online": false,
//       "source":"APP",
//       "OnBehalf":OnBehalf==null?null:"$OnBehalf"
//     };
//
//     print("orderPlacedMethode json Data >>>>>>>>>>>>>>>> "+jsonEncode(newJsonData));
//
//     var headers = {
//       'Authorization': 'bearer $MyToken',
//       'Content-Type': 'application/json'
//     };
//     var request;
//     String order_Api_Responce_Body;
//     int order_Api_Responce_Status_Code;
//     List<dynamic> invalid=[];
//     dynamic po;
//
//
//
//
//     if (MyMemberType == "Distributor") {
//       if (widget.SelectedValueForSearch == "Self Stock")
//       {
//         print("Get Cart List Methode Call >>>>>>>>>>>>>>>>>> " +
//             widget.SelectedValueForSearch);
//         //  request = http.Request('POST', Uri.parse('http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/distributors/$MyMemberId/purchase_orders'));
//         // request.body = jsonEncode(newJsonData);
//         // //   request.body = '''{\n    "shipping_method": "AS AGREED",\n    "special_request": "",\n    "purchase_lines": [\n        {\n            "item_id": 114,\n            "product_id": 596,\n            "rate_type": "CL",\n            "quantity": 10,\n            "batch_no": "33-15 I/PT056",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0,\n            "stock_point_id": 1,\n            "amount": " 94.6"\n        }\n    ],\n    "shipping_address": {\n        "code": "0002-80985",\n        "address": "B,703 Jhelum bldg evershine estate 100ft road",\n        "address_2": "Vasai West. Opp green house hotel.",\n        "post_code": "401202",\n        "city": "MUMBAI",\n        "country_region_code": "IN",\n        "phone_no": "9049224168",\n        "name": "Yusuf indorewala",\n        "contact": "Yusuf indorewala",\n        "state": "MAH"\n    },\n    "order_from": "cart",\n    "online": false\n}''';
//         // request.headers.addAll(headers);
//
//
//         var res = await http.post(Uri.parse(API_ROS_PROD__BASE_URL +
//             '/api/companies/$MyCompanyId/distributors/$MyMemberId/purchase_orders'),
//             body: jsonEncode(newJsonData),
//             headers: {
//               'Authorization': 'bearer $MyToken',
//               'Content-Type': 'application/json'
//             }
//         );
//         order_Api_Responce_Body = res.body;
//         order_Api_Responce_Status_Code = res.statusCode;
//         print("Distributor Place Order Api Status Code " + res.body);
//         setState(() {
//           responceStringOrderPlace=res.body;
//
//         });
//         print("Distributor Place Order Api Response " + res.statusCode.toString());
//         print(">>>>>>>>>>>>>>>>>>>>>..");
//
//         if (res.statusCode == 200) {
//           invalid = ResponsePlaceOrder
//               .fromJson(json.decode(res.body))
//               .invalid;
//           po = ResponsePlaceOrder
//               .fromJson(json.decode(res.body))
//               .po;
//
//           print("Distributor Invalid >>>>>>>>>>>>>>> Response Po  " +
//               po.toString());
//           print("Distributor Po >>>>>>>>>>>>>>> Response length Invalid  " +
//               invalid.length.toString());
//         }
//         else {
//           print("Slef Place Order  Api status not 200>>>>>>>>>>>>>>>>>>>>>..");
//
//           return res.statusCode;
//         }
//       }
//       else if (widget.SelectedValueForSearch == "Dealer")
//       {
//         widget.spinnerDealerSelectes;
//         int dealerID = widget.spinnerDealerSelectes.id;
//         print("Dealer Pace Order Methode Call >>>>>>>>>>>>>>>>>> " +
//             widget.SelectedValueForSearch + dealerID.toString());
//
//         //  request = http.Request('POST', Uri.parse('http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/dealers/$dealerID/purchase_orders'));
//         //request
//
//         var res = await http.post(Uri.parse(API_ROS_PROD__BASE_URL +
//             '/api/companies/$MyCompanyId/dealers/$dealerID/purchase_orders'),
//             body: jsonEncode(newJsonData),
//             headers: {
//               'Authorization': 'bearer $MyToken',
//               'Content-Type': 'application/json'
//             }
//         );
//         order_Api_Responce_Body = res.body;
//         order_Api_Responce_Status_Code = res.statusCode;
//         print("Dealer Place Order Api Status Code " + res.body);
//         setState(() {
//           responceStringOrderPlace=res.body;
//
//         });
//         print("Dealer Place Order Api Response " + res.statusCode.toString());
//         if (res.statusCode == 200) {
//           invalid = ResponsePlaceOrder
//               .fromJson(json.decode(res.body))
//               .invalid;
//           po = ResponsePlaceOrder
//               .fromJson(json.decode(res.body))
//               .po;
//
//           print("Invalid >>>>>>>>>>>>>>> Response Po  " + po.toString());
//           print("Po >>>>>>>>>>>>>>> Response length Invalid  " +
//               invalid.length.toString());
//         }
//         else {
//           print("Dealer Api status not 200>>>>>>>>>>>>>>>>>>>>>..");
//           print("Dealer Api status not 200>>>>>>>>>>>>>>>>>>>>>..");
//
//           res.statusCode;
//         }
//
//         print(">>>>>>>>>>>>>>>>>>>>>..");
//
//
//         // var jsonValue = json.decode(decodedJson['invalid']);
//         //ResponsePlaceOrder.fromJson(decodedJson).invalid;
//
//         //  var data = jsonDecode(res.body);
//
//
//         // jsonResponse["po"];
//
//
//         //request = http.Request('POST', Uri.parse('http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/dealers/$dealerID/purchase_orders'));
//         // request.body = jsonEncode(newJsonData);
//
//
//         // New Changes
//
//         //  var res = await http.post(Uri.parse('http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/dealers/$dealerID/purchase_orders'),body: jsonEncode({"email":"$username","password":"$password",}),
//         //    headers: {"Content-Type":"application/json"});
//
//
//         //   request.body = '''{\n    "shipping_method": "AS AGREED",\n    "special_request": "",\n    "purchase_lines": [\n        {\n            "item_id": 114,\n            "product_id": 596,\n            "rate_type": "CL",\n            "quantity": 10,\n            "batch_no": "33-15 I/PT056",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0,\n            "stock_point_id": 1,\n            "amount": " 94.6"\n        }\n    ],\n    "shipping_address": {\n        "code": "0002-80985",\n        "address": "B,703 Jhelum bldg evershine estate 100ft road",\n        "address_2": "Vasai West. Opp green house hotel.",\n        "post_code": "401202",\n        "city": "MUMBAI",\n        "country_region_code": "IN",\n        "phone_no": "9049224168",\n        "name": "Yusuf indorewala",\n        "contact": "Yusuf indorewala",\n        "state": "MAH"\n    },\n    "order_from": "cart",\n    "online": false\n}''';
//
//
//         //  request.headers.addAll(headers);
//
//
//       }
//     }
//     else
//     {
//       if(MyMemberType=="DUC")
//       {
//         print("$MyMemberType Placed  Methode Call >>>>>>>>>>>>>>>>>> ");
//         //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/purchase_orders
//
//         var res = await http.post(Uri.parse(API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/dealers/$MyMemberId/purchase_orders'),
//             body: jsonEncode(newJsonData),
//             headers: {
//               'Authorization': 'bearer $MyToken',
//               'Content-Type': 'application/json'
//             }
//         );
//         order_Api_Responce_Body = res.body;
//         order_Api_Responce_Status_Code = res.statusCode;
//         print("$MyMemberType Place Order Api Status Code " + res.body);
//         setState(() {
//           responceStringOrderPlace=res.body;
//
//         });
//         print("$MyMemberType Place Order Api Response " +
//             res.statusCode.toString());
//         print(">>>>>>>>>>>>>>>>>>>>>..");
//
//         if (res.statusCode == 200) {
//           invalid = ResponsePlaceOrder
//               .fromJson(json.decode(res.body))
//               .invalid;
//           po = ResponsePlaceOrder
//               .fromJson(json.decode(res.body))
//               .po;
//
//           print("$MyMemberType Invalid >>>>>>>>>>>>>>> Response Po  " +
//               po.toString());
//           print("$MyMemberType Po >>>>>>>>>>>>>>> Response length Invalid  " +
//               invalid.length.toString());
//         }
//         else {
//           print("Slef Place Order  Api status not 200>>>>>>>>>>>>>>>>>>>>>..");
//
//           return res.statusCode;
//         }
//       }
//       else if(MyMemberType=="DUD")
//       {
//         print("$MyMemberType Placed  Methode Call >>>>>>>>>>>>>>>>>> ");
//
//
//         //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1687/purchase_orders
//         var res = await http.post(Uri.parse(API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/dealers/$MyMemberId/purchase_orders'),
//             body: jsonEncode(newJsonData),
//             headers: {
//               'Authorization': 'bearer $MyToken',
//               'Content-Type': 'application/json'
//             }
//         );
//         order_Api_Responce_Body = res.body;
//         order_Api_Responce_Status_Code = res.statusCode;
//
//         setState(() {
//           responceStringOrderPlace=res.body;
//
//         });
//         print("$MyMemberType Place Order Api Status Code " + res.body);
//         print("$MyMemberType Place Order Api Response " +
//             res.statusCode.toString());
//         print(">>>>>>>>>>>>>>>>>>>>>..");
//
//         if (res.statusCode == 200) {
//           invalid = ResponsePlaceOrder
//               .fromJson(json.decode(res.body))
//               .invalid;
//           po = ResponsePlaceOrder
//               .fromJson(json.decode(res.body))
//               .po;
//
//           print("$MyMemberType Invalid >>>>>>>>>>>>>>> Response Po  " +
//               po.toString());
//           print("$MyMemberType Po >>>>>>>>>>>>>>> Response length Invalid  " +
//               invalid.length.toString());
//         }
//         else {
//           print("Slef Place Order  Api status not 200>>>>>>>>>>>>>>>>>>>>>..");
//
//           return res.statusCode;
//         }
//       }
//     }
//
//
//
//
//
//
//
//
//
//     //   http.StreamedResponse response = await request.send();
//     //   int valueRespone = response.statusCode;
//
//
//     //  print("Response From Place Order $valueRespone");
//
//     //if (response.statusCode == 200)
//
//     setState(() {
//       orderPalcedResponse=order_Api_Responce_Status_Code;
//     });
//
//
//     if (order_Api_Responce_Status_Code == 200) {
//       print("Oder Placed For Api SUccess "+order_Api_Responce_Status_Code.toString());
//
//       //responsePlaceOrderFromJson(response.stream.bytesToString().toString());
//       //print(order_Api_Responce_Body);
//
//       print("Response body "+order_Api_Responce_Body);
//
//       //String responseS =  jsonDecode(response);
//
//       //print("Response by s $responseS");
//
//
//       //  ResponsePlaceOrder.fromJson(json.decode(await response.stream.bytesToString()));
//
//       // var newResponse;
//       // await response.stream.bytesToString().then((value){
//       //   newResponse=value;
//       //
//       //   print("New Response of Order Placed Api is "+value);
//       //
//       // });
//
//
//
//
//       print("Value of Po is  "+po.toString());
//       print("Length of invalid of array "+invalid.length.toString());
//
//
//       if(po!=null&&invalid.length==0)
//       {
//         print("Po is not  null  Invalid array length is   Zero");
//
//         updateState((){
//           isPlaced=true;
//           isCloseButtonVisible=true;
//
//           LoadMessage="Order Placed Success fully ";
//         });
//       }
//       else if(po!=null&&invalid.length!=0)
//       {
//         //We are unable to Place Order of 1 items order for remaining items has been placed
//         print("Po is null  Invalid array length is  not Zero");
//         updateState((){
//           int length =invalid.length;
//           isCloseButtonVisible=true;
//           LoadMessage="We were unable to place order for $length. items. Order for remaining items has been placed";
//         });
//
//       }
//       else if(po==null&&invalid.length==0||po==null&&invalid.length!=0)
//       {
//         updateState((){
//           LoadMessage="Please Review your Cart items  ";
//           isCloseButtonVisible=true;
//         });
//         print("Po is null  Invalid array length is Zero");
//       }
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
//     }
//     else {
//       // print("Error >>>>>>>>>>>>>"+response.reasonPhrase+""+response.statusCode.toString()  );
//
//       return    order_Api_Responce_Status_Code;
//     }
//     //return    response.statusCode;
//
//     return    order_Api_Responce_Status_Code;
//   }
//
//
//   Future<int> AddDistributorShippingAdress(String address_test,
//       String address_2__test,
//       String post_code__test,
//       String city__test,
//       String country_region_code_test,
//       String phone_no_test,
//       String name_test,
//       String contact_test) async {
//     String url="";
//
//     print("Add Shipping Address Methode Call");
//     print("Data In Add Transposter Methode String address_test $address_2__test $post_code__test $city__test,  $country_region_code_test, $phone_no_test, $name_test, $contact_test");
//
//
//
//     if (MyMemberType == "Distributor") {
//       if (widget.SelectedValueForSearch == "Self Stock")
//       {
//         print(
//             ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Adding Shipping address For Distributor");
//
//         url = API_ROS_PROD__BASE_URL +
//             "/api/companies/$MyCompanyId/distributors/$MyMemberId/addresses";
//       }
//       else
//       {
//         print(
//             ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Adding Shipping address For Dealer$dealerId");
//         url = API_ROS_PROD__BASE_URL +
//             "/api/companies/$MyCompanyId/dealers/$dealerId/addresses";
//       }
//     }
//     else
//     {
//       if(MyMemberType=="DUC")
//       {
//         //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/addresses
//         print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Adding Shipping address For $MyMemberType");
//         url = API_ROS_PROD__BASE_URL + "/api/companies/$MyCompanyId/dealers/$MyMemberId/addresses";
//       }
//       else if(MyMemberType=="DUD")
//       {
//         //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1687/addresses
//         print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Adding Shipping address For $MyMemberType");
//         url = API_ROS_PROD__BASE_URL + "/api/companies/$MyCompanyId/dealers/$MyMemberId/addresses";
//
//       }
//     }
//
//
//     var res = await http.post(Uri.parse(url),body: jsonEncode({"address": "$address_test",
//       "address_2": "$address_2__test",
//       "post_code": "$post_code__test",
//       "city": "$city__test",
//       "state": "$stateCode",
//       "country_region_code": "$country_region_code_test",
//       "phone_no": "$phone_no_test",
//       "name": "$name_test",
//       "contact": "$contact_test"}),
//         headers: {
//           'Authorization': 'bearer $MyToken',
//           'Content-Type': 'application/json'
//         });
//     print(res.statusCode);
//     print(res.body);
//     var status = res.statusCode;
//     print("<<<<<<<<<<<<<<<<<<<<< $status");
//
//     if(status==200)
//     {
//       print("<<<<<<<<<<<<<<<<<<<<< 200");
//
//       NewDistributorShippingAdress onjNewAdd =  NewDistributorShippingAdress.fromJson(json.decode(res.body));
//
//       print("Details of Apii "+onjNewAdd.city);
//
//       setState(() {
//
//
//         DealerName=onjNewAdd.name==null?"":onjNewAdd.name;
//         DealerContact=onjNewAdd.phoneNo==null?"":onjNewAdd.phoneNo;
//         DealerAdd1=onjNewAdd.address==null?"":onjNewAdd.address;
//         DealerAdd2=onjNewAdd.address2==null?"":onjNewAdd.address2;
//         DealerCity=onjNewAdd.city==null?"":onjNewAdd.city;
//         DealerPinCode=onjNewAdd.countryRegionCode==null?"":onjNewAdd.countryRegionCode;
//
//
//         DealerCode=onjNewAdd.code==null?"":onjNewAdd.code;
//         DealerPostCode=onjNewAdd.postCode==null?"":onjNewAdd.postCode;
//         DealerCountryRegionCode=onjNewAdd.countryRegionCode==null?"":onjNewAdd.countryRegionCode;
//         DealerPhone_no=onjNewAdd.phoneNo==null?"":onjNewAdd.phoneNo;
//
//       });
//
//
//
//
//     }
//
//
//
//
//     // var headers = {
//     //   'Authorization': 'bearer $MyToken',
//     //   'Content-Type': 'application/json'
//     // };
//     // var request = http.Request('POST', Uri.parse('http://rosdev.rosettaproducts.com/api/companies/3/distributors/5/addresses'));
//     // request.body = '''{\n    "address": "Test App 1",\n    "address_2": "Test App 1",\n    "post_code": "411001",\n    "city": "Pune",\n    "state": "MAH",\n    "country_region_code": "IN",\n    "phone_no": "Test App",\n    "name": "Test App 1",\n    "contact": "Test App 1"\n}''';
//     // request.headers.addAll(headers);
//     //
//     // http.StreamedResponse response = await request.send();
//     //
//     // if (response.statusCode == 200) {
//     //   print(await response.stream.bytesToString());
//     //
//     //   NewDistributorShippingAdress onjNewAdd =  NewDistributorShippingAdress.fromJson(json.decode(response.stream.bytesToString().toString()));
//     //
//     //
//     //   print("Add Shiiping Adress Success Flutlly "+onjNewAdd.countryRegionCode);
//     // }
//     // else {
//     //   print(response.reasonPhrase);
//     // }
//     return res.statusCode;
//   }
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.width;
//     return
//       MediaQuery(
//         data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//         child:
//
//         Scaffold(
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(50),
//             child:MyAppBar(false,"",MyUserName,false),
//           ),
//
//
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Container(
//                       margin: EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
//
//                       child: Column(
//
//
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child:
//                             Text("Add Customer & Shipping Details", style: TextStyle(fontSize:textSizeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.bold  ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//
//                     //~~~~~~~~~~~~~~~~~~~~~~~List Blocked ~~~~~~~~~~~~~~~~~~~~
//                     Visibility(
//                       child:Container(
//                         child: widget.newBlockListSelected2.length == 0 ? Container(): ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             itemCount: widget.newBlockListSelected2.length,
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               //newBlockedList[index].product.collection.displayName.toString().replaceAll("Code.","");
//                               var collectionName = widget.newBlockListSelected2[index].product.collection.displayName;
//
//                               String colorCode = widget.newBlockListSelected2[index].product.colour==null?"":widget.newBlockListSelected2[index].product.colour.displayName==null?"":widget.newBlockListSelected2[index].product.colour.displayName;
//                               double  price = widget.newBlockListSelected2[index].rateType.toString()=="RL"||widget.newBlockListSelected2[index].rateType.toString()=="CL"?widget.newBlockListSelected2[index].unitPrice:double.parse(((widget.newBlockListSelected2[index].unitPrice-((widget.newBlockListSelected2[index].unitPrice *widget.newBlockListSelected2[index].discount)/100))).toStringAsFixed(2));
//
//                               double   quantity  = double.parse(widget.newBlockListSelected2[index].orderQuantity.toString());
//                               double ammount = price * quantity;
//                               String blockedTimeStamp = widget.newBlockListSelected2[index].expires;
//                               //countdowntime = int.parse(newBlockedList[index].expires);
//                               String batchNo = widget.newBlockListSelected2[index].batchNo;
//
//                               String ImageUrl = widget.newBlockListSelected2[index].product.imageUrl;
//
//
//                               //  var batchNo = newBlockedList[index].batchNo.name==null?"":newBlockedList[index].batchNo.name;
//
//                               print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$batchNo");
//
//
//
//                               DateTime date = DateTime.parse(blockedTimeStamp);
//                               print(DateFormat('dd-MM-yyyy').format(date));
//                               print("Time Stamp Result $date");
//
//                               // var d12 = DateFormat('MM/dd/yyyy, HH:mm:ss a').format(date);
//                               var d12 = DateFormat('HH:mm:ss').format(date);
//                               print("Time In Secods with Date  $d12");
//
//                               //Time Stamp Convert
//                               //var newTime = new DateTime.fromMicrosecondsSinceEpoch(int.parse(blockedTimeStamp));
//                               var newTime = new DateTime.fromMicrosecondsSinceEpoch(1639117198);
//                               // DateTime.fromMicrosecondsSinceEpoch(int.parse(blockedTimeStamp).microsecondsSinceEpoch)
//                               print("New Time Stamp >>>>>>  $newTime");
//
//                               //
//                               var t = readTimestamp(int.parse(blockedTimeStamp));
//                               //countdowntime=startTimer(countdowntime);
//                               //print ("Time From readTimeStamp $countdowntime");
//
//
//
//                               return  Container(
//                                 margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
//                                 padding: EdgeInsets.only(right: 10,top: 10,bottom: 10, left: 10),
//                                 width: double.infinity,
//                                 child:
//                                 Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: <Widget>[
//
//                                         //~~~~~~~~~~~~~~~~CUstom Check Box Code
//                                         // Theme(data: ThemeData(
//                                         //   // checked color
//                                         //     primarySwatch: kPrimaryColor,
//                                         //     // border color
//                                         //     unselectedWidgetColor:kPrimaryColor
//                                         // ),
//                                         //     child:  Checkbox(
//                                         //
//                                         //         value:  list1.contains(index) ? true :false,
//                                         //         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                         //
//                                         //         onChanged: (value)
//                                         //         {
//                                         //           setState(() {
//                                         //             if(list1.contains(index))
//                                         //             {
//                                         //               list1.remove(index);
//                                         //             }
//                                         //             else
//                                         //             {
//                                         //               list1.add(index);
//                                         //
//                                         //             }
//                                         //
//                                         //           });
//                                         //         })),
//
//                                         SizedBox(width: 10,),
//                                         Container(
//                                           width:50,//width * 0.3,
//                                           height: 50,
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.circular(5.0),
//                                             child:ImageUrl!=null?Image.network(ImageUrl, fit: BoxFit.fill):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.fill),
//
//                                           ),
//
//
//                                         ),
//                                         SizedBox(width: 10,),
//
//                                         Container(
//                                           width: (width/2)-66,
//                                           // alignment: Alignment.centerLeft,
//                                           child: Column(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               //collectionName
//                                               Text("$collectionName",style: TextStyle(fontWeight: FontWeight.bold,fontSize: textSizeMedium,color: sh_textColorSecondarylight),),
//                                               SizedBox(height: 10,),
//                                               Text(colorCode,style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),
//                                               SizedBox(height: 10,),
//                                               Text("$batchNo",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),
//                                               SizedBox(height: 10,),
//                                               Text(widget.newBlockListSelected2[index].orderQuantity.toStringAsFixed(2)+" SFT",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),
//
//                                               // Container(
//                                               //   width: 100,
//                                               //   height: 35,
//                                               //   margin: EdgeInsets.only(left: 0),
//                                               //   child: TextFormField(
//                                               //     readOnly: true,
//                                               //     keyboardType: TextInputType.emailAddress,
//                                               //     autofocus: false,
//                                               //     initialValue: widget.newBlockListSelected2[index].orderQuantity.toStringAsFixed(2)+" SFT",
//                                               //     textCapitalization: TextCapitalization.words,
//                                               //     style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeSMedium),
//                                               //     decoration: InputDecoration(
//                                               //
//                                               //         filled: true,
//                                               //         fillColor: backgroundSearchProductFormInput,
//                                               //         focusColor: sh_editText_background_active,
//                                               //         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSMedium),
//                                               //         contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
//                                               //         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_textColorSecondary, width: 0.5)),
//                                               //         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                               //   ),
//                                               //   //
//                                               //   // decoration: BoxDecoration(
//                                               //   //
//                                               //   //   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                               //   //   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                               //   // ),
//                                               // ),
//
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           width: (width/2)-66,
//                                           alignment: Alignment.centerRight,
//                                           child: Column(
//
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//
//                                             children: [
//                                               // InkWell(
//                                               //
//                                               //   child: Container(
//                                               //       alignment: Alignment.centerRight,
//                                               //       child: Image.asset(ic_unlockcart_item,height: 20,width: 20,fit: BoxFit.fill,color: sh_colorPrimary,)),
//                                               //   onTap: (){
//                                               //
//                                               //
//                                               //    // FlagUnblockItems=true;
//                                               //     //  showAlertDialogUnblockToBlockSearchResult(context,newBlockedList[index],setState,index);
//                                               //     //showAlertDialogConfirmUnBlock(context,newBlockedList[index],setState,index);
//                                               //
//                                               //
//                                               //
//                                               //   },
//                                               // ),
//
//                                               SizedBox(height: 10,),
//                                               Container(
//                                                 alignment: Alignment.centerRight,
//                                                 child: Text(""+price.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),
//
//                                               ),
//                                               SizedBox(height: 5,),
//                                               Container(
//                                                 alignment: Alignment.centerRight,
//
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Container(),
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.start,
//
//                                                       children: [
//                                                         Text("Total ",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),
//
//                                                         Text(""+ammount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),
//                                                       ],
//                                                     ),
//
//
//                                                   ],
//                                                 ),
//
//                                               ),
//                                               SizedBox(height: 5,),
//                                               Container(
//                                                 alignment: Alignment.centerRight,
//
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Container(),
//                                                     (widget.newBlockListSelected2[index].rateType=="RL"||widget.newBlockListSelected2[index].rateType=="CL")? Row(
//                                                       mainAxisAlignment: MainAxisAlignment.start,
//
//                                                       children: [
//                                                         Text("Rate Type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
//                                                         SizedBox(width: 5,),
//                                                         Text(""+(widget.newBlockListSelected2[index].rateType),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
//                                                         //Text(""+cartammount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
//
//                                                       ],
//                                                     ):Container(),
//                                                   ],
//                                                 ),
//
//                                               ),
//
//
//                                             ],
//
//
//                                           ),
//                                         ),
//
//
//
//
//                                       ],
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(top: 10),
//                                       padding: EdgeInsets.all(5),
//                                       child:
//                                       Container(
//                                         alignment: Alignment.center,
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Container(),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               children: [
//                                                 Container(
//                                                     alignment: Alignment.centerRight,
//                                                     child: Image.asset(ic_blockround,height: 20,width: 20,fit: BoxFit.fill,color: sh_colorPrimary,)),
//                                                 SizedBox(width: 5,),
//                                                 Container(
//                                                   child: Text("Blocked",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
//                                                 ),
//                                                 SizedBox(width: 5,),
//                                                 Container(
//
//
//                                                   //child: Text("$t",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
//                                                     child:  CountdownTimer(
//                                                       textStyle: TextStyle(
//                                                           fontSize: 14, color: sh_colorPrimary, fontWeight: FontWeight.bold),
//                                                       onEnd: null,
//
//
//                                                       endTime:
//                                                       DateTime.now().millisecondsSinceEpoch +
//                                                           Duration(seconds: DateTime.fromMillisecondsSinceEpoch(int.parse(widget.newBlockListSelected2[index].expires)*1000).difference(DateTime.now()).inSeconds,
//                                                           ).inMilliseconds,
//                                                       //DateTime.parse(newBlockedList[index].expires).difference(DateTime.now()).inSeconds,
//                                                       //countRemainsTime2(DateTime.now().millisecondsSinceEpoch.toString(), ""+newBlockedList[index].expires),
//                                                       endWidget: Text(
//                                                         "Deal has ended",
//                                                         style: TextStyle(
//                                                             fontSize: 14,
//                                                             color: sh_colorPrimary,
//                                                             fontWeight: FontWeight.bold),
//                                                       ),
//                                                     )
//
//                                                 ),
//
//                                               ],
//                                             ),
//                                             Container(),
//                                           ],
//                                         ),
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color:sh_blockedBackGround,
//
//                                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                                       ),
//
//                                     ),
//
//                                   ],
//                                 ),
//
//
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//                               );
//
//                             }),
//                       ),
//                       visible: BlockedListVisible,
//                     ),
//
//
//                     Container(
//
//                       child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           itemCount: newCartListSelected.length,
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           padding: EdgeInsets.only(bottom: 5),
//                           itemBuilder: (context, index) {
//
//                             String cartcollectionName = newCartListSelected[index].product.collection.displayName.toString();
//                             String cartcolorCode = newCartListSelected[index].product.colour.displayName.toString();
//                             double  cartprice = newCartListSelected[index].rateType.toString()=="RL"||newCartListSelected[index].rateType.toString()=="CL"?newCartListSelected[index].unitPrice:double.parse(((newCartListSelected[index].unitPrice-((newCartListSelected[index].unitPrice *newCartListSelected[index].discount)/100))).toStringAsFixed(2));
//
//                             double   cartquantity  = double.parse(newCartListSelected[index].orderQuantity.toString());
//                             double cartammount = cartprice * cartquantity;
//                             String ImageUrl=newCartListSelected[index].product.imageUrl;
//                             return     Container(
//                               margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
//                               padding: EdgeInsets.all(10),
//                               width: double.infinity,
//                               child:  Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   // Container(
//                                   //   child:GestureDetector(
//                                   //
//                                   //     child: list1.contains(index) ? imgUp:imgDown,
//                                   //     onTap: (){
//                                   //       setState(() {
//                                   //         selectedindex=index;
//                                   //         if(list1.contains(index))
//                                   //         {
//                                   //           list1.remove(index);
//                                   //         }
//                                   //         else
//                                   //         {
//                                   //           list1.add(index);
//                                   //
//                                   //         }
//                                   //
//                                   //         //  print(img.toString()+"Show1");
//                                   //       });
//                                   //
//                                   //     },
//                                   //   ),
//                                   //   padding: EdgeInsets.all(2),
//                                   //
//                                   //
//                                   // ),
//                                   // SizedBox(width: 10,),
//                                   Container(
//                                     width:50,//width * 0.3,
//                                     height: 50,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(5.0),
//                                       child:ImageUrl!=null?Image.network(ImageUrl, fit: BoxFit.fill):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.fill),
//
//                                     ),
//                                   ),
//                                   SizedBox(width: 10,),
//
//                                   Container(
//                                     width: (width/2)-56,
//                                     // alignment: Alignment.centerLeft,
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text("$cartcollectionName",style: TextStyle(fontWeight: FontWeight.bold,fontSize: textSizeMedium),),
//                                         SizedBox(height: 10,),
//                                         Text("$cartcolorCode",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
//                                         SizedBox(height: 10,),
//                                         Text("Quantity "+cartquantity.toStringAsFixed(2)+" SFT",
//                                           style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
//
//                                         // Container(
//                                         //   width: 100,
//                                         //
//                                         //
//                                         //   child:  TextFormField(
//                                         //     readOnly: true,
//                                         //     keyboardType: TextInputType.emailAddress,
//                                         //     autofocus: false,
//                                         //     initialValue: "Quantity "+cartquantity.toStringAsFixed(2)+" SFT",
//                                         //
//                                         //
//                                         //     textCapitalization: TextCapitalization.words,
//                                         //     style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeSMedium),
//                                         //     decoration: InputDecoration(
//                                         //
//                                         //         filled: true,
//                                         //         fillColor: backgroundSearchProductFormInput,
//                                         //         focusColor: sh_editText_background_active,
//                                         //
//                                         //         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSMedium),
//                                         //
//                                         //         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_textColorSecondary, width: 0.5)),
//                                         //         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                         //   ),
//                                         //
//                                         //   // decoration: BoxDecoration(
//                                         //   //
//                                         //   //   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                         //   //   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         //   // ),
//                                         // ),
//
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     width: (width/2)-56,
//                                     alignment: Alignment.centerRight,
//                                     child: Column(
//                                       children: [
//                                         // InkWell(
//                                         //   child:  Container(
//                                         //       alignment: Alignment.centerRight,
//                                         //       child: Image.asset(ic_delete_item,height: 20,width: 20,fit: BoxFit.fill,color: sh_colorPrimary,)),
//                                         //     onTap: ()
//                                         //   {
//                                         //       setState(() {
//                                         //          list.remove(index);
//                                         //
//                                         //       });
//                                         //   },
//                                         // ),
//
//
//                                         SizedBox(height: 10,),
//                                         Container(
//                                           alignment: Alignment.centerRight,
//                                           child: Text("$cartprice".toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
//
//                                         ),
//                                         SizedBox(height: 5,),
//                                         Container(
//                                           alignment: Alignment.centerRight,
//
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//
//                                                 children: [
//                                                   Text("Total",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
//                                                   SizedBox(width: 5,),
//                                                   Text(""+cartammount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
//                                                 ],
//                                               ),
//
//
//                                             ],
//                                           ),
//
//                                         ),
//                                         SizedBox(height: 10,),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(),
//                                             (widget.newCartListSelected2[index].rateType=="RL"||widget.newCartListSelected2[index].rateType=="CL")? Row(
//                                               mainAxisAlignment: MainAxisAlignment.start,
//
//                                               children: [
//                                                 Text("Rate Type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
//                                                 SizedBox(width: 5,),
//                                                 Text(""+(widget.newCartListSelected2[index].rateType),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
//                                                 //Text(""+cartammount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
//
//                                               ],
//                                             ):Container(),
//
//                                           ],
//                                         )
//
//
//
//                                       ],
//                                     ),
//                                   ),
//
//
//
//
//                                 ],
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//
//                                 border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                 borderRadius: BorderRadius.all(Radius.circular(5)),
//                               ),
//                             );
//                             // return Chats(mListings[index], index);
//                           }),
//                     ),
//
//
//
//                     Container(
//                       margin: EdgeInsets.only(left: 15,right: 15,top: 10),
//
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//
//
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child:
//                             MyMemberType=="Distributor"?  Text("$memberType Name : "+memerName, style: TextStyle(fontSize:textSizeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.bold  ),)
//                                 : Text("Dealer Name : "+MyUserName, style: TextStyle(fontSize:textSizeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.bold  ),),
//                           ),
//
//                           // Image.asset(ic_info_icon,height: 20,width: 20,),
//
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//
//                     // For Dealer Drop Down
//
//
//
//
//
//
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 15),
//
//                       child: Column(
//
//
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.center,
//                             child:
//                             MyMemberType=="Distributor"?
//                             Text("$memberType Shipping Information", style: TextStyle(fontSize:textSizeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.bold  ),):
//                             Text("Dealer Shipping Information", style: TextStyle(fontSize:textSizeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.bold ), ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//
//
//                     Visibility(
//                       visible: true,
//                       // visible: isDisPlaceOrderSelf,
//                       child: Container(
//                         margin : EdgeInsets.symmetric(horizontal: 15),
//
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             spinnerSelectTransporterDetails.length==0?Container(
//                               child: Container(
//                                 padding: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
//                                 width: width-78,
//
//
//                                 child: text("Loading  Shipping  Adresses..",
//                                     fontSize: textSizeSmall,
//                                     fontFamily: fontRegular,
//                                     textColor: sh_textColorSecondary),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                 ),
//                               ),
//                             ):
//                             Container(
//                               width: width-78,
//                               height: 40,
//                               padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
//                               child: new DropdownButton<String>(
//
//                                 value: selectedTranspor.replaceAll("*", ""),
//
//
//                                 isExpanded: true,
//                                 icon: Icon(
//                                   Icons.arrow_drop_down,
//                                   color:
//                                   sh_textColorSecondary,
//                                   size: 25,
//                                 ),
//                                 iconSize: 15,
//                                 elevation: 16,
//                                 style: TextStyle(
//                                   color: sh_textColorSecondary,
//                                   fontSize: 18,
//                                 ),
//                                 underline: Container(
//                                   height: 1,
//                                 ),
//                                 onChanged: (String value) {
//                                   setState(() {
//                                     selectedTranspor = value;
//
//
//
//                                     final index = distributorAllTransporterDetails.indexWhere((element) =>
//                                     element.name == selectedTranspor);
//
//                                     print(">>>>>>Selected SelectedShippingInformations  List Index $index");
//                                     String SelectedShippingInformations  = distributorAllTransporterDetails[index].name;
//                                     print("Selected Shipping Dealer Informations Name  Informations  $SelectedShippingInformations");
//
//
//
//                                     DealerName=distributorAllTransporterDetails[index].name==null?"":distributorAllTransporterDetails[index].name;
//                                     DealerContact=distributorAllTransporterDetails[index].phoneNo==null?"":distributorAllTransporterDetails[index].phoneNo;
//                                     DealerAdd1=distributorAllTransporterDetails[index].address==null?"":distributorAllTransporterDetails[index].address;
//                                     DealerAdd2=distributorAllTransporterDetails[index].address2==null?"":distributorAllTransporterDetails[index].address2;
//                                     DealerCity=distributorAllTransporterDetails[index].city==null?"":distributorAllTransporterDetails[index].city;
//                                     DealerPinCode=distributorAllTransporterDetails[index].countryRegionCode==null?"":distributorAllTransporterDetails[index].countryRegionCode;
//
//
//
//                                     DealerCode=distributorAllTransporterDetails[index].code==null?"":distributorAllTransporterDetails[index].code;
//                                     DealerPostCode=distributorAllTransporterDetails[index].postCode==null?"":distributorAllTransporterDetails[index].postCode;
//                                     DealerCountryRegionCode=distributorAllTransporterDetails[index].countryRegionCode==null?"":distributorAllTransporterDetails[index].countryRegionCode;
//                                     DealerPhone_no=distributorAllTransporterDetails[index].phoneNo==null?"":distributorAllTransporterDetails[index].phoneNo;
//
//
//
//
//
//                                   });
//                                 },
//                                 items: spinnerSelectTransporterDetails
//                                     .map<DropdownMenuItem<String>>(
//                                         (String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value.replaceAll("*"," "),style: TextStyle(fontSize: 14.0)
//                                         ),
//                                       );
//                                     }).toList(),
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//
//                                 border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                 borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                               ),
//                             ),
//                             SizedBox(width: 10,),
//                             Container(
//
//
//                               child: InkWell(
//                                 child: Image.asset(ic_plus,height: 35,width: 35, fit: BoxFit.fill,color: sh_colorPrimary,),
//                                 onTap: (){
//                                   showAlertAddDialog(context,setState);
//                                 },
//                               ),
//
//
//
//
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       height: 10,
//                     ),
//
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//
//
//                           Container(
//                             width: (width)-20,
//                             padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
//                             child:  Text("Name : $DealerName",style: TextStyle(color: sh_textColorSecondary),),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//
//                               border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                               borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           Container(
//                             width:  (width)-20,
//                             padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
//
//                             child:
//                             Text("Contact : $DealerContact",style: TextStyle(color: sh_textColorSecondary)),
//
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//
//                               border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                               borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           Container(
//                             width:  (width)-20,
//                             padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
//                             child:  Text("Address1 : $DealerAdd1",style: TextStyle(color:sh_textColorSecondary ),),
//
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//
//                               border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                               borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           Container(
//                             width:  (width)-20,
//                             padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
//                             child: Text("Address2 : $DealerAdd2",style: TextStyle(color:sh_textColorSecondary ),),
//
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//
//                               border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                               borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           Container(
//                             width:  (width)-20,
//                             padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
//                             child: Text("City : $DealerCity",style: TextStyle(color:sh_textColorSecondary ),),
//
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//
//                               border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                               borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           Container(
//                             width:  (width)-20,
//                             padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
//
//                             child: Text("PinCode : $DealerPostCode",style: TextStyle(color:sh_textColorSecondary ),),
//
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//
//                               border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                               borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//
//
//
//
//
//                     Container(
//                       margin: EdgeInsets.only(left: 15,right: 15),
//
//
//
//                       child:Container(
//
//
//                         child: MaterialButton(
//
//
//
//                           child: Container(
//                               padding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
//                               alignment: Alignment.center,
//                               child: text("Place Order", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white)),
//                           textColor: sh_white,
//                           shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                           color: sh_colorPrimary,
//                           onPressed: () => {
//
//
//                             //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Place Order Api Integrations
//                             // orderPlacedMethode(),
//
//
//                             //   DealerName=distributorAllTransporterDetails[0].name==null?"":distributorAllTransporterDetails[0].name;
//                             //     DealerContact=distributorAllTransporterDetails[0].phoneNo==null?"":distributorAllTransporterDetails[0].phoneNo;
//                             //     DealerAdd1=distributorAllTransporterDetails[0].address==null?"":distributorAllTransporterDetails[0].address;
//                             //     DealerAdd2=distributorAllTransporterDetails[0].address2==null?"":distributorAllTransporterDetails[0].address2;
//                             //     DealerCity=distributorAllTransporterDetails[0].city==null?"":distributorAllTransporterDetails[0].city;
//                             //     DealerPinCode=distributorAllTransporterDetails[0].countryRegionCode==null?"":distributorAllTransporterDetails[0].countryRegionCode;
//                             // DealerPostCode=distributorAllTransporterDetails[0].postCode==null?"":distributorAllTransporterDetails[0].postCode;
//
//                             if(DealerName==""||DealerContact==""||DealerAdd1==""||DealerCity==""||DealerPostCode=="")
//                               {
//                                 print("All Fields Are Not Field "),
//                                 showToastDialog(context, "Please use valid Address"),
//
//                               }
//                             else
//                               {
//                                 flagOrderPlace=true,
//
//                                 showAlertDialog(context),
//
//                                 //  Navigator.of(context)
//                                 //     .push(new MaterialPageRoute(builder: (context) => DisOrderHistory(backArrowVisible: true,
//                                 //               SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",))),
//                                 // setState((){
//                                 // }),
//
//
//
//                               }
//
//
//
//                           },
//                           elevation: 0,
//                         ),
//
//                       ),
//                     ),
//
//
//
//                     SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           endDrawer:MyDrwaer(),
//         ),
//       );
//   }
//
//
//   showAlertDialog(BuildContext context) {
//     // Create button
//     LoadMessage="Please wait";
//
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//
//               builder: (BuildContext context, setState)
//               {
//                 isInternatAvailable2(context);
//
//                 //Order Placed Api Methode Call
//                 if(flagOrderPlace) {
//                   orderPlacedMethode(setState).then((value) {
//
//                     print(">>>>>>>>>>>>>>>>>>>>>>>>>>> Status code From Place Order Api Call is "+value.toString());
//                     setState(() {
//                       flagOrderPlace = false;
//                     });
//                     if (value == 412) {
//
//                       orderPlacedFailedFromJson(responceStringOrderPlace).errorText;
//
//                       print(
//                           "Your order cannot be processed at this time due to overdue payments."+responceStringOrderPlace);
//                       setState(() {
//                         isCloseButtonVisible=true;
//                         LoadMessage = ""+orderPlacedFailedFromJson(responceStringOrderPlace).errorText;
//                         // LoadMessage = "Your order cannot be processed at this time due to overdue payments.";
//                       });
//                     }
//
//                     if(value==500)
//                     {
//                       print(
//                           "Please Contact to Rosetta Admin");
//                       setState(() {
//                         isCloseButtonVisible=true;
//                         LoadMessage = ""+orderPlacedFailedFromJson(responceStringOrderPlace).errorText;
//                         //LoadMessage = "Please Contact Rosetta Admin";
//                       });
//                     }
//                   });
//                 }
//
//
//                 return  MediaQuery(
//                   data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//                   child:
//
//                   WillPopScope(
//                     onWillPop: () async {
//                       return false;
//                     },
//                     child:  AlertDialog(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0)), //this right here
//                       content: Container(
//                           height: 200,
//
//                           color: Colors.white,
//                           width: MediaQuery.of(context).size.width,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//
//                               Container(
//                                 child:isPlaced?Image.asset(ic_greencheck,height: 50,width: 50, fit: BoxFit.fill,):
//                                 Image.asset(ic_form_preloader_gif,height: 50,width: 50, fit: BoxFit.fill,),
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.of(context).size.width,
//
//
//                                 child:isPlaced?Text("Order Placed Successfully",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),):
//
//                                 Text("$LoadMessage",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                               ),
//                               isCloseButtonVisible?Container(
//                                 alignment: Alignment.center,
//
//                                 child: MaterialButton(
//
//                                   padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
//                                   child: text("Close", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                                   textColor: Colors.white,
//                                   shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                   color: sh_colorPrimary,
//                                   onPressed: () async => {
//
//
//
//                                     Navigator.pop(context),
//                                     //   await Navigator.of(context)
//                                     //   .push(new MaterialPageRoute(builder: (context) => NewDistributorDashboard())),
//                                     // setState((){}),
//
//                                     //
//                                     // Navigator.of(context, rootNavigator:
//                                     // true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
//                                     //     NewDistributorDashboard()), (route) => false),
//
//
//                                     //DisOrderHistory(backArrowVisible: true,
//                                     //SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",).launch(context),
//
//
//                                     //G MAy 25
//                                     // await Navigator.of(context)
//                                     // .push(new MaterialPageRoute(builder: (context) => DisOrderHistory(
//                                     //   backArrowVisible: true,
//                                     //   SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",
//                                     // ))),
//
//
//
//
//
//
//
//                                   },
//                                   elevation: 0,
//                                 ),
//                               ):Container(),
//
//                             ],
//                           )),
//                     ),
//                   ),);
//
//
//               }
//           );
//
//
//         }).then((value){
//
//
//
//       if(orderPalcedResponse==200)
//       {
//         // Navigator.pushAndRemoveUntil(
//         //     context,
//         //     MaterialPageRoute(
//         //         builder: (context) =>
//         //             NewDistributorDashboard(1)),
//         //         (Route)=>false);
//
//         DisHomeScreen().launch(context);
//
//       }
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
//     });
//   }
//
//
//
//
//   showAlertAddDialog(BuildContext context,StateSetter updateState_Dialog) {
//
//
//
//
//     showDialog(
//         context: context,
//
//         builder: (BuildContext context) {
//           final formKey = GlobalKey<FormState>();
//           selectedStates="Select State";
//           bool isEditNo=true;
//
//           return StatefulBuilder(
//               builder: (BuildContext context, setState)
//               {
//                 return
//                   MediaQuery(
//                     data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//                     child:
//                     AlertDialog(
//
//                       insetPadding: EdgeInsets.zero,
//
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0)), //this right here
//                       content: Container(
//                         // height: 360,
//                           color: Colors.white,
//                           //backgroundSearchProductForm
//                           width: MediaQuery.of(context).size.width,
//                           child: SingleChildScrollView(
//                               child: Form(
//                                 key: formKey,
//                                 child: Column(
//
//
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(child: Text("Add Shipping Address",style: TextStyle(color: sh_black,fontSize: 20,fontWeight: FontWeight.bold),),),
//                                           InkWell(
//                                             child: Image.asset(ic_cross_dialog,height: 25,width: 25,
//                                               color: sh_colorPrimary,),
//                                             onTap: (){
//                                               Navigator.pop(context, false);
//                                             },
//                                           ),
//
//                                         ]
//
//                                     ),
//
//
//
//
//
//
//                                     SizedBox(height: 2,),
//
//                                     //Name
//                                     TextFormField(
//                                       keyboardType: TextInputType.emailAddress,
//                                       autofocus: false,
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         //errorText: isemailvalidate?"*Required":null,
//
//
//                                         fillColor: sh_editText_background,
//                                         focusColor: sh_editText_background_active,
//                                         hintText: "Name",
//                                         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
//
//
//                                       ),
//
//                                       onChanged: (value){
//                                         setState(() {
//                                           name_send=value;
//
//                                         });
//
//                                         print("New  Add 1 is $value");
//
//                                       },
//                                     ),
//
//                                     SizedBox(height: 2,),
//
//                                     TextFormField(
//                                       keyboardType: TextInputType.emailAddress,
//                                       autofocus: false,
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         //errorText: isemailvalidate?"*Required":null,
//
//
//                                         fillColor: sh_editText_background,
//                                         focusColor: sh_editText_background_active,
//                                         hintText: "Address 1",
//                                         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
//
//
//                                       ),
//
//                                       onChanged: (value){
//
//                                         setState(() {
//                                           address_send=value;
//
//                                         });
//                                         print("New  Add 1 is $value");
//
//                                       },
//                                     ),
//                                     SizedBox(height: 2,),
//
//                                     TextFormField(
//                                       keyboardType: TextInputType.emailAddress,
//                                       autofocus: false,
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         //errorText: isemailvalidate?"*Required":null,
//
//
//                                         fillColor: sh_editText_background,
//                                         focusColor: sh_editText_background_active,
//                                         hintText: "Address 2",
//                                         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
//
//
//                                       ),
//
//                                       onChanged: (value){
//                                         setState(() {
//                                           address_2_send=value;
//
//
//                                         });
//                                         print("New  Add 1 is $value");
//
//                                       },
//                                     ),
//                                     SizedBox(height: 2,),
//
//                                     Container(
//                                       child: TextFormField(
//                                         inputFormatters: [
//                                           new LengthLimitingTextInputFormatter(6),
//                                         ],
//                                         keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                         autofocus: false,
//                                         validator: (String value) {
//                                           if (value.length>6||value.length<6) {
//
//                                             print("Required 6 Digit");
//                                             return 'Required 6 Didits ';
//                                           }
//
//
//
//                                         },
//
//                                         textCapitalization: TextCapitalization.words,
//                                         style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                         decoration: InputDecoration(
//                                           filled: true,
//
//
//
//                                           //errorText: isemailvalidate?"*Required":null,
//
//
//
//                                           fillColor: sh_editText_background,
//                                           focusColor: sh_editText_background_active,
//                                           hintText: "Post Code",
//                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
//
//
//                                         ),
//
//                                         onChanged: (value){
//                                           setState(() {
//                                             post_code_send=value;
//
//
//                                           });
//
//                                           print("New  Add 1 is $value");
//
//                                         },
//                                       ),
//
//
//                                     ),
//                                     SizedBox(height: 2,),
//
//
//
//                                     // Container(
//                                     //
//                                     //   height: 40,
//                                     //   padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
//                                     //   child: new DropdownButton<String>(
//                                     //
//                                     //     value: selectedStates,
//                                     //     isExpanded: true,
//                                     //     icon: Icon(
//                                     //       Icons.arrow_drop_down,
//                                     //       color:
//                                     //       sh_textColorSecondary,
//                                     //       size: 25,
//                                     //     ),
//                                     //     iconSize: 15,
//                                     //     elevation: 16,
//                                     //     style: TextStyle(
//                                     //       color: sh_textColorSecondary,
//                                     //       fontSize: 18,
//                                     //     ),
//                                     //     underline: Container(
//                                     //       height: 1,
//                                     //     ),
//                                     //     onChanged: (String value) {
//                                     //       setState(() {
//                                     //         selectedStates = value;
//                                     //
//                                     //
//                                     //         print("Selected State Value is "+selectedStates.toString());
//                                     //
//                                     //
//                                     //
//                                     //         final index = AllStatesList.indexWhere((element) =>
//                                     //         element.name == selectedStates);
//                                     //         stateCode = AllStatesList[index].code;
//                                     //         country_region_code_send=AllStatesList[index].country.name;
//                                     //
//                                     //
//                                     //         print("Selected State code is "+stateCode.toString());
//                                     //
//                                     //
//                                     //
//                                     //
//                                     //
//                                     //
//                                     //
//                                     //       });
//                                     //     },
//                                     //     items: spinnerAllStatesList
//                                     //         .map<DropdownMenuItem<String>>(
//                                     //             (String value) {
//                                     //           return DropdownMenuItem<String>(
//                                     //             value: value,
//                                     //             child: Text(value,style: TextStyle(fontSize: 14.0)
//                                     //             ),
//                                     //           );
//                                     //         }).toList(),
//                                     //   ),
//                                     //   decoration: BoxDecoration(
//                                     //     color: Colors.white,
//                                     //
//                                     //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                     //     borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                     //   ),
//                                     // ),
//
//
//
//                                     Container(
//                                       child:Autocomplete(
//
//                                         optionsBuilder: (TextEditingValue value) {
//                                           // When the field is empty
//                                           if (value.text.isEmpty) {
//                                             return [];
//                                           }
//
//                                           // The logic to find out which ones should appear
//                                           return spinnerAllStatesList.where((suggestion) => suggestion.toString()
//                                               .toLowerCase()
//                                               .contains(value.text.toLowerCase()));
//                                         },
//
//                                         fieldViewBuilder: (BuildContext context,
//                                             TextEditingController textEditingController,
//
//                                             FocusNode focusNode, VoidCallback onFieldSubmitted) {
//
//
//                                           return TextFormField(
//                                             controller: textEditingController,
//                                             //  decoration: myTextFieldDecoration(topLabel: "Another Input", hintText: "Type or select from list"),
//                                             decoration: InputDecoration(
//                                               filled: true,
//                                               prefixIcon: Icon(Icons.search,color:sh_colorPrimary,size: 20,),
//                                               fillColor: backgroundSearchProductFormInput,
//                                               focusColor: sh_editText_background_active,
//
//                                               hintText: "Search States",
//                                               hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                               contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                                               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0)
//
//                                               ),),
//                                             focusNode: focusNode,
//                                             onFieldSubmitted: (String value) {
//                                               onFieldSubmitted();
//                                               print('You just typed a new entry  $value');
//
//                                             },
//                                           );
//                                         },
//
//                                         onSelected: (value) {
//                                           setState(() {
//                                             selectedStates = value;
//
//
//                                             print("Selected State Value is "+selectedStates.toString());
//
//
//
//                                             final index = AllStatesList.indexWhere((element) =>
//                                             element.name == selectedStates);
//                                             stateCode = AllStatesList[index].code;
//                                             country_region_code_send=AllStatesList[index].country.name;
//
//
//                                             print("Selected State code is "+stateCode.toString());
//
//
//
//
//
//
//
//                                           });
//                                         },
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//
//                                         border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                         borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                       ),
//
//                                     ),
//
//                                     TextFormField(
//                                       keyboardType: TextInputType.emailAddress,
//                                       autofocus: false,
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         //errorText: isemailvalidate?"*Required":null,
//
//
//                                         fillColor: sh_editText_background,
//                                         focusColor: sh_editText_background_active,
//                                         hintText: "City",
//                                         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
//
//
//                                       ),
//
//                                       onChanged: (value){
//                                         setState(() {
//                                           city_send=value;
//
//                                         });
//                                         print("New  Add 1 is $value");
//
//                                       },
//                                     ),
//                                     SizedBox(height: 2,),
//
//
//
//                                     // TextFormField(
//                                     //   keyboardType: TextInputType.emailAddress,
//                                     //   autofocus: false,
//                                     //
//                                     //   textCapitalization: TextCapitalization.words,
//                                     //   style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                     //   decoration: InputDecoration(
//                                     //     filled: true,
//                                     //     //errorText: isemailvalidate?"*Required":null,
//                                     //
//                                     //
//                                     //     fillColor: sh_editText_background,
//                                     //     focusColor: sh_editText_background_active,
//                                     //     hintText: "Region Code",
//                                     //     hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                     //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                     //     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                     //     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
//                                     //
//                                     //
//                                     //   ),
//                                     //
//                                     //   onChanged: (value){
//                                     //     setState(() {
//                                     //       country_region_code_send=value;
//                                     //
//                                     //     });
//                                     //     print("New  Add 1 is $value");
//                                     //
//                                     //   },
//                                     // ),
//                                     // SizedBox(height: 2,),
//
//                                     TextFormField(
//                                       keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                       inputFormatters: [
//                                         new LengthLimitingTextInputFormatter(10),
//                                       ],
//                                       autofocus: false,
//                                       validator: (String value) {
//                                         if (value.length!=10) {
//
//                                           print("Mob no should be 10 Digits");
//                                           return 'Mob no should be 10 Digits ';
//                                         }
//
//
//
//                                       },
//
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         prefixIcon:Padding(padding: EdgeInsets.only(left: 15,right: 0,top: 15,bottom: 15), child: Text('+91')),
//
//
//                                         //errorText: isemailvalidate?"*Required":null,
//
//
//                                         fillColor: sh_editText_background,
//                                         focusColor: sh_editText_background_active,
//                                         hintText: "Phone No",
//
//                                         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
//
//
//                                       ),
//
//                                       onChanged: (value){
//                                         print("New  Add 1 is $value");
//                                         setState(() {
//                                           phone_no_send=value;
//
//                                           if(value.length==3)
//                                           {
//                                             setState((){
//                                               isEditNo=false;
//                                             });
//                                           }
//                                           else
//                                           {
//                                             isEditNo=true;
//                                           }
//
//                                         });
//
//                                       },
//                                     ),
//                                     SizedBox(height: 2,),
//
//
//
//
//
//                                     TextFormField(
//                                       // keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                       // inputFormatters: [
//                                       //   new LengthLimitingTextInputFormatter(10),
//                                       // ],
//                                       autofocus: false,
//                                       // validator: (String value) {
//                                       //   if (value.length!=10) {
//                                       //
//                                       //     print("Mob no should be 10 Digits");
//                                       //     return 'Mob no should be 10 Digits ';
//                                       //   }
//                                       //
//                                       //
//                                       //
//                                       // },
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         //errorText: isemailvalidate?"*Required":null,
//
//
//                                         fillColor: sh_editText_background,
//                                         focusColor: sh_editText_background_active,
//                                         hintText: "Contact Name",
//                                         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
//
//
//                                       ),
//
//                                       onChanged: (value){
//                                         setState(() {
//                                           contact_send=value;
//
//                                         });
//
//                                         print("New  Add 1 is $value");
//
//                                       },
//                                     ),
//
//
//                                     Container(
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                                         children: [
//                                           Container(
//                                             // margin:  EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
//
//                                             child: MaterialButton(
//
//                                               padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
//                                               child: text("My Address", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                                               textColor: Colors.white,
//                                               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                               color: sh_colorPrimary,
//                                               onPressed: () => {
//                                                 if (!formKey.currentState.validate()) {
//
//                                                   print("Not Validate Form On Submitions ")
//
//                                                 }
//
//                                                 else if(address_send==""&&address_2_send==""&&post_code_send==""&&city_send==""&&country_region_code_send==""&&phone_no_send==""&&name_send==""&&contact_send=="")
//                                                   {
//                                                     print("All Fields Are Not Field "),
//                                                     showToastDialog(context, "All fields are mandatory"),
//
//                                                   }
//                                                 else
//                                                   {
//
//                                                     print("All Fields Are Field $stateCode"),
//                                                     if(stateCode==null)
//                                                       {
//                                                         showToastDialog(context, "All fields are mandatory"),
//                                                       }
//                                                     else
//                                                       {
//                                                         setState(() {
//                                                           addressApicall=true;
//                                                         }),
//                                                         AddDistributorShippingAdress(
//                                                             address_send,
//                                                             address_2_send,
//                                                             post_code_send,
//                                                             city_send,
//                                                             country_region_code_send,
//                                                             phone_no_send,
//                                                             name_send,
//                                                             contact_send).then((value){
//
//                                                           print("After Add Shipping Address in Api "+value.toString());
//
//                                                           if(value==200)
//                                                           {
//
//
//                                                             // if (MyMemberType == "Distributor")
//                                                             //   {
//                                                             //
//                                                             //   }
//                                                             if (MyMemberType == "Distributor")
//                                                             {
//                                                               if(widget.SelectedValueForSearch=="Self Stock")
//                                                               {
//                                                                 print("Address Saved on Self Stock ");
//                                                                 setState((){
//                                                                   distributorAllTransporterDetails=null;
//                                                                   spinnerSelectTransporterDetails = [];
//
//                                                                   // selectedTranspor=DealerName;
//                                                                 });
//                                                                 getTransporterList();
//
//                                                               }
//                                                               else
//                                                               {
//                                                                 setState((){
//                                                                   distributorAllTransporterDetails=null;
//                                                                   spinnerSelectTransporterDetails = [];
//
//                                                                   //selectedTranspor=DealerName;
//
//                                                                 });
//                                                                 getTransporterListDealer();
//                                                                 print("Address Saved on Self Stock ");
//
//                                                               }
//                                                             }
//                                                             else
//                                                             {
//                                                               setState((){
//                                                                 distributorAllTransporterDetails=null;
//                                                                 spinnerSelectTransporterDetails = [];
//
//                                                                 //selectedTranspor=DealerName;
//
//                                                               });
//                                                               getTransporterListDUDDUC();
//                                                               print("Address Saved on DUDDUC ");
//                                                             }
//
//
//
//                                                             Navigator.pop(context, false);
//
//                                                           }
//                                                         })
//                                                       }
//
//                                                   },
//
//
//
//
//
//                                               },
//                                               elevation: 0,
//                                             ),
//
//                                           ),
//                                           Container(
//                                             // margin:  EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
//
//                                             child: MaterialButton(
//
//                                               padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
//                                               child: text("My Customer Address", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                                               textColor: Colors.white,
//                                               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                               color: sh_colorPrimary,
//                                               onPressed: () => {
//                                                 if (!formKey.currentState.validate()) {
//
//                                                   print("Not Validate Form On Submitions ")
//
//                                                 }
//
//                                                 else   if(address_send==""&&address_2_send==""&&post_code_send==""&&city_send==""&&country_region_code_send==""&&phone_no_send==""&&name_send==""&&contact_send=="")
//                                                   {
//                                                     print("All Fields Are Not Field "),
//                                                     showToastDialog(context, "All fields are mandatory"),
//
//                                                   }
//                                                 else
//                                                   {
//                                                     setState(() {
//                                                       addressApicall=false;
//
//                                                     }),
//
//                                                     print("All Fields Are Field $stateCode"),
//                                                     if(stateCode==null)
//                                                       {
//                                                         showToastDialog(context, "All fields are mandatory"),
//                                                       }
//                                                     else
//                                                       {
//                                                         updateState_Dialog((){
//                                                           DealerName=name_send;
//                                                           DealerContact=contact_send;
//                                                           DealerAdd1=address_send;
//                                                           DealerAdd2=address_2_send;
//                                                           DealerCity=city_send;
//                                                           DealerPostCode=post_code_send;
//                                                           DealerPhone_no=phone_no_send;
//                                                         }),
//                                                         Navigator.pop(context, false),
//
//
//
//                                                         // AddDistributorShippingAdress(
//                                                         //     address_send,
//                                                         //     address_2_send,
//                                                         //     post_code_send,
//                                                         //     city_send,
//                                                         //     country_region_code_send,
//                                                         //     phone_no_send,
//                                                         //     name_send,
//                                                         //     contact_send).then((value){
//                                                         //       print("After Add Shipping Address in Api "+value.toString());
//                                                         //       if(value==200)
//                                                         //   {
//                                                         //     Navigator.pop(context, false);
//                                                         //
//                                                         //   }
//                                                         // })
//                                                       }
//
//                                                   },
//
//
//
//
//
//                                               },
//                                               elevation: 0,
//                                             ),
//
//                                           ),
//
//                                         ],
//                                       ),
//                                     ),
//
//                                   ],
//                                 ) ,
//                               )
//
//                           )
//
//
//                       ),
//                     ),);
//               }
//           );
//
//
//         });
//   }
//   showToastDialog(BuildContext context,String Message)
//   {
//
//
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//
//               child: StatefulBuilder(
//
//                 builder: (BuildContext context, setState){
//
//                   return  Container(
//                     height: 110,
//
//                     width:MediaQuery.of(context).size.width,
//                     color: sh_white,
//                     padding: EdgeInsets.only(top: 20,bottom: 20),
//
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(child:Text("$Message",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
//
//                         Container(
//                           margin: EdgeInsets.only(top: 5),
//
//
//
//                           color: sh_white,
//                           child:   Container(
//                             color: Colors.white,
//
//                             child: MaterialButton(
//                               padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
//
//
//                               child: Text("Retry", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
//                               textColor: sh_white,
//                               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                               color: sh_colorPrimary,
//                               onPressed: () => {
//
//                                 //DisApproveOrder().launch(context),
//                                 Navigator.pop(context, false),
//
//
//                               },
//                             ),
//                           ),
//
//
//                         ),
//
//
//                       ],
//                     ),
//
//
//
//                   );
//                 },
//               )
//
//
//
//           );
//         });
//
//   }
//
// }