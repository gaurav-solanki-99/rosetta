// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:rosetta_fluter_app/ApiHelper/ApiService.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/DisOrderHistory.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/viewallproductcategory.dart';
// import 'package:rosetta_fluter_app/Services/Distributor/viewallsubcategoty.dart';
// import 'package:rosetta_fluter_app/main/model/MainCategory.dart';
// import 'package:rosetta_fluter_app/main/model/MainCollection.dart';
// import 'package:rosetta_fluter_app/main/model/MainColors.dart';
//
//
// import 'package:rosetta_fluter_app/main/utils/AppColors.dart';
// import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
// import 'package:rosetta_fluter_app/rosetta/models/ALLCollectionsROSS.dart';
// import 'package:rosetta_fluter_app/rosetta/models/Category.dart';
// import 'package:rosetta_fluter_app/rosetta/models/Collection.dart';
// import 'package:rosetta_fluter_app/rosetta/models/NewProductsSearch.dart';
// import 'package:rosetta_fluter_app/rosetta/models/PDFResponse.dart';
// import 'package:rosetta_fluter_app/rosetta/models/SearchProductsList.dart';
//
// import 'package:rosetta_fluter_app/rosetta/models/ShCategory.dart';
// import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';
// import 'package:rosetta_fluter_app/rosetta/models/SpinnerDealerRefined.dart';
// import 'package:rosetta_fluter_app/rosetta/models/SpinnerDealersList.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShFunction.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';
//
// import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
//
// import '../../rosetta/models/SettingMessages.dart';
// import '../../rosetta/models/SkipButtonApi.dart';
// import '../shimmer_list.dart';
// import 'DisAprroveOrder.dart';
// import 'SelectProductPlaceOrder.dart';
// import 'SerchResultProduct.dart';
//
// import 'package:multi_select_flutter/multi_select_flutter.dart';
//
//
// import 'package:flutter_chips_input/flutter_chips_input.dart';
// import 'package:device_info_plus/device_info_plus.dart';
//
// import 'package:text_scroll/text_scroll.dart';
//
//
//
//
//
// class DisHomeScreen extends StatefulWidget {
//   DisHomeScreen({this.navigatorKey, this.child});
//
//   final Widget child;
//   final GlobalKey navigatorKey;
//   var id =47;
//
//
//   static String tag = '/ShHomeFragment';
//
//   @override
//   ShHomeFragmentState createState() => ShHomeFragmentState();
// }
//
// class ShHomeFragmentState extends State<DisHomeScreen> {
//   final _chipKey = GlobalKey<ChipsInputState>();
//
//   BuildContext dialogContext;
//   String SingleSelectedCategory = "CARPET";
//   String SelectedValue;
//   bool _isInAsyncCall = true;
//   List<Datum> category=null;
//   List<Product> collection = null;
//   List<MainCategory> mainCategory = null;
//
//   List<SelectAutoSuggestDealer> spinnerSelectCollectionDealer = new  List();
//   List<SelectAutoSuggest> spinnerSelectCollection = new  List();
//   String SelectedCollection=null;
//   String onChangedSelectedValue="";
//
//
//
//
//   List<String> spinnerSelectColors = new  List();
//   String SelectedColors=null;
//
//   List<MainCollection> mainCollection=null;
//   List<MainColors> mainColors=null;
//   List<String> spinnerSelectCollection2 = new  List();
//   String SelectedCollection2=null;
//   List<AppProfile> mockResults = new List();
//   String SelectedAutoSuggestStirng,SelectedmaxPrice="999999",SelectedMinPrice="1",SelectedQuantity="1",SelectedDesign;
//   bool isDecimalValue=false;
//
//   bool isRemoveSelfStock = true;
//
//
//
//
//   List<Inventory> inventoryList;
//
//
//   ///~~~~~~~~~~~~~~~~~~~~~~~Spineeer Dealer Variables
//   ///For Select Dealerrs
//   List<SpinnerSpinnerDealerList> spinnerDelerList = [];
//   List<String> spinnerSelectDealer2 = [];
//   String SelectedDealer2="";
//   SpinnerSpinnerDealerList spinnerDealerSelectes=null;
//
//
//
//   //~~~~~~~~~~~~~~~~~~~~~~~~~~`Spinner Dealer List Refined
//   List<SpinnerDealerRefined> spinnerDelerListRefined = [];
//   List<String> spinnerSelectDealerRefined  = [];
//
//
//   //~~~~~~~~~~~~~~~~~~~~~~~~~Spinner Dealer Api
//   Future<List<SpinnerSpinnerDealerList>> getDealerList() async {
//     print("Get SpinnerDealer List Methode Call >>>>>>>>>>>>>>>>>> Home Screen");
//
//     //?sort=&page=1&per_page=20
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form SpinnerDealer List Methode   Data Api : $responcebody");
//     print("Response code Form SpinnerDealer List Methode  Data Api : $responseCode");
//
//     // int inventoryLength =  newCartItesmFromJson(json.decode(response.body)).length;
//     //
//     // print("New Cart List Length >>>>>>>>>>>>>>> $inventoryLength");
//     setState(() {
//       //NewDealerList.fromJson(json.decode(str));
//       // newCartItesmFromJson(response.body);
//       spinnerDelerList = spinnerSpinnerDealerListFromJson((response.body));
//       if(responseCode==200)
//       {
//
//         for(int i=0;i<spinnerDelerList.length;i++)
//         {
//           spinnerSelectCollectionDealer.add(SelectAutoSuggestDealer(spinnerDelerList[i].id, spinnerDelerList[i].name));
//           //loop
//         }
//
//         getDelaerSpinnerList();
//       }
//
//
//
//     });
//
//
//     int newinventoryLength =  spinnerDelerList.length;
//     print("New SpinnerDealer List   Length >>>>>>>>>>>>>>> $newinventoryLength");
//     SpinnerSpinnerDealerList.fromJson(json.decode(response.body));
//   }
//   getDelaerSpinnerList() async {
//
//
//     print("Get Spinner Dealer List Methode Call");
//
//     var length = spinnerDelerList.length;
//     print(" Spinner Dealer List   lsi length is $length");
//
//     for(int i=0;i<spinnerDelerList.length;i++)
//     {
//       var displayname;
//       print(" Spinner Dealer List  Loop is Called ");
//       setState(() {
//         if(i==0)
//         {
//           //spinnerSelectDealer2.add("Select Dealer");
//           spinnerSelectDealer2.add("Self Stock");
//           spinnerSelectDealer2.add(spinnerDelerList[i].name);
//           displayname = spinnerSelectDealer2[i];
//         }
//         else
//         {
//           spinnerSelectDealer2.add(spinnerDelerList[i].name);
//           displayname = spinnerSelectDealer2[i];
//         }
//
//         SelectedDealer2=spinnerSelectDealer2[0];
//       });
//
//       int lengthOFSpinnerLsit = spinnerSelectDealer2.length;
//       print("List of Spinner List Lenght After $lengthOFSpinnerLsit");
//       print(" Spinner Dealer List   Name $displayname");
//     }
//   }
//
//
// //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Get Dealer List Refined
//   getDealerListRefinrd() async {
//     print("Get SpinnerDealer List Refined Methode Call >>>>>>>>>>>>>>>>>>");
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/searchDealers'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form SpinnerDealer Refined List Methode   Data Api : $responcebody");
//     print("Response code Form SpinnerDealer Refined List Methode  Data Api : $responseCode");
//
//
//     setState(() {
//
//       spinnerDelerListRefined = spinnerDealerRefinedFromJson(json.decode(response.body));
//       if(responseCode==200)
//       {
//         print("Refined Methode Call Success Fully their response is $responcebody");
//
//
//         //getDelaerSpinnerListRefined();
//       }
//
//
//
//     });
//
//
//     // int newinventoryLength =  spinnerDelerList.length;
//     //  print("New SpinnerDealer Refined  List   Length >>>>>>>>>>>>>>> $newinventoryLength");
//     //  SpinnerSpinnerDealerList.fromJson(json.decode(response.body)).dealers;
//   }
//
//   getDelaerSpinnerListRefined() async {
//
//
//     print("Get Spinner Dealer List Refined Methode Call");
//
//     var length = spinnerDelerListRefined.length;
//     print(" Spinner Dealer List  Refined  lsi length is $length");
//
//     for(int i=0;i<spinnerDelerList.length;i++)
//     {
//       var displayname;
//       print(" Spinner Dealer List Refined   Loop is Called ");
//       setState(() {
//         spinnerSelectDealerRefined.add(spinnerDelerListRefined[i].name);
//
//         print("Spinner Dealer Refined  Name "+spinnerDelerListRefined[i].name.toString());
//
//
//       });
//
//       int refinedSpinnerLength = spinnerSelectDealerRefined.length;
//       print(" Spinner Dealer List  Refined  Length  $refinedSpinnerLength");
//     }
//   }
//
//
//
//
//
//
//
//
//   getList() async {
//
//
//     print("Api Methode Calll For CMS Collections ");
//
//
//
//
//     String url = API_CMS_BASE_URL+"/api/webservices/categories";
//     try {
//       final response = await http.get(Uri.parse(url));
//       var reult = response.statusCode;
//       print("Rsponse Code Of Category Api $reult");
//       print(json.decode(response.body));
//
//
//       if (200 == response.statusCode) {
//
//         setState(() {
//           category = CategoryCMS
//               .fromJson(json.decode(response.body))
//               .data;
//         });
//
//
//
//         // return CategoryCMS
//         //     .fromJson(json.decode(response.body))
//         //     .data;
//       } else {
//         // return <Datum>[];
//       }
//     } catch (e) {
//
//       print("Expetion Category is >>>>>>>>>>>>>>>>>. $e");
//       // return <Datum>[];
//     }
//   }
//
//
//
//   getListData() async{
//
//
//     print("PDF Api Methode call");
//
//     var  uri = "https://laravel.cppatidar.com/rosetta/api/webservices/getProductPdfById";
//
//     var map = new Map<String, dynamic>();
//     // map['grant_type'] = 'password';
//     // map['client_id'] = '3MVG9dZJodJWITSviqdj3EnW.LrZ81MbuGBqgIxxxdD6u7Mru2NOEs8bHFoFyNw_nVKPhlF2EzDbNYI0rphQL';
//     // map['client_secret'] = '42E131F37E4E05313646E1ED1D3788D76192EBECA7486D15BDDB8408B9726B42';
//     map['id'] = "118";
//
//
//
//
//     http.Response response = await http.post(Uri.parse(uri), body: map,);
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//
//
//
//
//     print("Response Body of Form Data PDF  Api : $responcebody");
//     print("Response code Form Data  PDF Api : $responseCode");
//
//     if (200 == response.statusCode) {
//
//       setState(() {
//
//
//       });
//
//
//
//     } else {
//       return <Product>[];
//     }
//
//   }
//
//
//   getMainCollection() async{
//     print(" Get Main Collection  Api Mehtode Call ");
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/categories/$SingleSelectedCategory/collections?sort=&page=2&per_page=10'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form Main Collection  Data Api : $responcebody");
//     print("Response code Form Main Collection  Data Api : $responseCode");
//
//     setState(()
//     {
//       print(" Get Main Collection  Api Mehtode Call >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $mainCollection");
//       final parsed = jsonDecode(responcebody).cast<Map<String, dynamic>>();
//
//       mainCollection = parsed.map<MainCollection>((json) => MainCollection.fromJson(json)).toList();
//
//       var displayName=mainCollection[0].displayName;
//       print(" Get Main Collection  Api Mehtode Call @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $displayName");
//
//       if(responseCode==200)
//       {
//
//         setState(() {
//           getCollectionSpinnerList();
//           _isInAsyncCall=false;
//         });
//
//       }
//
//     });
//
//
//
//   }
//
//   getMainCololrs() async{
//     print(" Get Main Colors  Api Mehtode Call $MyToken");
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/categories/$SingleSelectedCategory/collections/IBADA/colours?sort=&page=1&per_page=10'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form Main Colors  Data Api : $responcebody");
//     print("Response code Form Main Colors  Data Api : $responseCode");
//
//     setState(() {
//
//       print(" Get Main  Colors   Api Mehtode Call >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $mainColors");
//       final parsed = jsonDecode(responcebody).cast<Map<String, dynamic>>();
//       mainColors = parsed.map<MainColors>((json) => MainColors.fromJson(json)).toList();
//
//       var displayName=mainColors[0].displayName;
//       print(" Get Main Colors  Api Mehtode Call @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $displayName");
//
//
//       if(responseCode==200)
//       {
//
//         setState(() {
//           getColorsSpinnerList();
//           _isInAsyncCall=false;
//         });
//
//       }
//
//
//
//
//     });
//
//
//
//   }
//   String StringNoticeMessage="";
//   getSettingMessage() async{
//     print(" Get Main getSettingMessage  Api Mehtode Call $MyToken");
//     var map = new Map<String, dynamic>();
//     if(isRGallery)
//     {
//       map['is_rgallery'] = "1";
//     }
//     else
//     {
//       map['is_rgallery'] = "0";
//     }
//
//
//
//     //API_CMS_BASE_URL
//     http.Response response;
//     try{
//       response = await http.post(Uri.parse(API_CMS_BASE_URL+'/api/webservices/getSettingMessage'), body: map,);
//
//     }catch(e)
//     {
//       print("Error Message >>>>>>>>>>>>>>>>>>> "+e.toString());
//     }
//
//
//     // http.Response response = await http.get(Uri.parse('https://cmsdev.rosettaproducts.com/api/webservices/getSettingMessage'),
//     //   body: map,
//     // );
//
//     // http.Response response = await http.get(Uri.parse('https://cmsdev.rosettaproducts.com/api/webservices/getSettingMessage'),
//     //   headers: {
//     //     HttpHeaders.authorizationHeader: 'bearer $MyToken',
//     //   },
//     // );
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form getSettingMessage Data Api : $responcebody");
//     print("Response code Form Main getSettingMessage  Data Api : $responseCode");
//
//     setState(() {
//
//       if(responseCode==200)
//       {
//
//
//         settingMessagesFromJson(responcebody).status;
//         if(settingMessagesFromJson(responcebody).status);
//         {
//           if(settingMessagesFromJson(responcebody).message.isNotEmpty)
//           {
//             setState(() {
//               StringNoticeMessage=settingMessagesFromJson(responcebody).message;
//             });
//           }
//         }
//
//
//
//       }
//
//
//
//
//     });
//
//
//
//   }
//   getColorsSpinnerList() async {
//
//     print("Get Colors  List Methode Call");
//     var length = mainColors.length;
//     print("MainColors lsi length is $length");
//
//     setState(() {
//       for(int i=0;i<mainColors.length;i++)
//       {
//         print("Colors Loop is Called ");
//         spinnerSelectColors.add(mainColors[i].displayName);
//
//         var displayname = spinnerSelectColors[i];
//         SelectedColors=spinnerSelectColors[0];
//         mockResults.add(AppProfile(mainColors[i].displayName, mainColors[i].code, mainColors[i].code));
//
//         print("SpinnerSelectedList Name $displayname");
//
//
//
//       }
//       var length2 = mockResults.length;
//       print("mockResults  length is $length2");
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
//
//   }
//
//   getCollectionSpinnerList() async {
//
//
//     print("Get Category List Methode Call");
//
//     var length = mainCollection.length;
//     print("MainCategory lsi length is $length");
//
//     for(int i=0;i<mainCollection.length;i++)
//     {
//       var displayname;
//       print("Loop is Called ");
//       setState(() {
//         spinnerSelectCollection2.add(mainCollection[i].displayName);
//         displayname = spinnerSelectCollection2[i];
//         SelectedCollection2=spinnerSelectCollection2[0];
//       });
//
//
//       print("SpinnerSelectedList2 Name $displayname");
//     }
//   }
//   //~~~~~~~~~~~~~~~~~~For Closing Keyboard
//   var currentFocus;
//
//   unfocus() {
//     currentFocus = FocusScope.of(context);
//
//     if (!currentFocus.hasPrimaryFocus) {
//       currentFocus.unfocus();
//     }
//   }
//   // Future<List<Inventory>> SearchProduct(String SuggestValue,var dealerId)
//   String SelectedValueForSearch="Self Stock";
//   bool isLoadAll= true;
//
//   bool isDialogView = true;
//   Future<List<Inventory>> SearchProduct(String SuggestValue) async {
//
//     print("is Load >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$isLoadAll");
//     setState(() {
//       isLoadAll= true;
//     });
//
//
//
//
//
//     print("1 >>>>>>Search Result App is call $SuggestValue  $MyMemberType");
//     String apiUrl="";
//
//     if(MyMemberType=="Distributor")
//     {
//       if(SelectedValueForSearch=="Self Stock")
//       {
//         SelectedValueForSearch="Self Stock";
//
//         print(">>>>>>>>>>>>....Form Data  $SelectedAutoSuggestStirng $SelectedDesign $SelectedQuantity $SelectedMinPrice $SelectedmaxPrice   $SelectedDealer2");
//
//         print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>. Api For Self stock ");
//
//         //category=CARPET
//         // collection=IBADA
//         //http://rosdev.rosettaproducts.com/api/companies/3/inventory?sort=&page=1&per_page=10&category=CARPET&collection=IBADA&quantity=%253E1&distributor=103&cust_type=DISTRIBUTO&min_price=70&max_price=87
//         apiUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&distributor=$MyMemberId&cust_type=DISTRIBUTO&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice';
//         // apiUrl= 'http://rosdev.rosettaproducts.com/api/companies/3/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E1&cust_type=DISTRIBUTO&distributor=5';
//       }
//       else{
//         SelectedValueForSearch="Dealer";
//         var dealerIdSelected = spinnerDealerSelectes.id;
//         print(">>>>>>>>>>>>....Form Data  $SelectedAutoSuggestStirng $SelectedDesign $SelectedQuantity $SelectedMinPrice $SelectedmaxPrice $dealerIdSelected  $SelectedDealer2");
//
//         print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>. Api For Dealer stock  $dealerIdSelected $SelectedMinPrice $SelectedmaxPrice $SelectedQuantity");
//
//         //   var nee= 'http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/distributors/$MyMemberId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice&dealer=$dealerIdSelected&cust_type=DEALER';
//         //  apiUrl =  'http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&dealer=$dealerIdSelected&cust_type=DEALER&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice';
//
//         //3 :45
//         http://rosdev.rosettaproducts.com/api/companies/3/distributors/4/inventory?sort=&page=1&per_page=10&category=CARPET&collection=LUSH&colour=2731%2520GREEN&quantity=%253E1&min_price=1&max_price=500&dealer=1687&cust_type=DEALER
//         apiUrl =  API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice&dealer=$dealerIdSelected&cust_type=DEALER';
//         //  apiUrl =  'http://rosdev.rosettaproducts.com/api/companies/3/distributors/4/inventory?sort=&page=1&per_page=10&category=CARPET&collection=LUSH&colour=2731%2520GREEN&quantity=%253E1&min_price=1&max_price=500&dealer=1687&cust_type=DEALER';
//       }
//     }
//     else
//     {
//       if(MyMemberType=="DUC")
//       {
//         print("Search Result App is call >>>>>>>>>>>>>>>>>>>>>>>>>>>>. DUC ");
//         apiUrl=API_ROS_PROD__BASE_URL+"/api/companies/$MyCompanyId/inventory?$SuggestValue&quantity=%253E$SelectedQuantity&dealer=$MyMemberId&cust_type=DEALER&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice";
//         //apiUrl=API_ROS_PROD__BASE_URL+"/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&dealer=$MyMemberId&cust_type=DEALER&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice";
//         //apiUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&distributor=$MyMemberId&cust_type=DISTRIBUTO&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice';
//         // SelectedValue="CARPET";
//       }
//       else if(MyMemberType=="DUD")
//       {
//         print("Search Result App is call >>>>>>>>>>>>>>>>>>>>>>>>>>>>. DUD ");
//         String MyNavDistrributorId=Myparent_distributor_id;
//         print("DUD my member Id $MyMemberId");
//         print("DUD my MyNavDistrributorId is $MyNavDistrributorId");
//         //SearchProductsList length is
//         apiUrl = API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyNavDistrributorId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice&dealer=$MyMemberId&cust_type=DEALER';
//         // apiUrl = API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyNavDistrributorId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice&dealer=$MyMemberId&cust_type=DEALER';
//
//
//
//         // apiUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&distributor=$MyMemberId&cust_type=DISTRIBUTO&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice';
//
//
//         // For testing
//         // SelectedValue="LAMINATE";
//
//       }
//     }
//
//
//
//
//
//     final response = await http.get(
//
//       //Uri.parse('http://rosdev.rosettaproducts.com/api/companies/3/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E1&dealer=$dealerId&cust_type=DEALER'),
//       Uri.parse(apiUrl),
//       // Send authorization headers to the backend.
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     // final responseJson = jsonDecode(response.body);
//
//
//     var result = response.statusCode;
//
//     print("Response Code Of Search Product  is  $result");
//
//     // var total =   SearchProductsList.fromJson(json.decode(response.body)).total;
//     // print("Total Search $total");
//
//     if(result!=200)
//     {
//
//       print("Dialog View on 1 Navigator "+isDialogView.toString());
//
//
//       //   Navigator.pop(context, false);
//       showToastDialog(context, "Please Try Again ");
//
//     }
//     else {
//       inventoryList = SearchProductsList
//           .fromJson(json.decode(response.body))
//           .inventory;
//       var inventoryLength = inventoryList.length;
//
//       print("SearchProductsList length is $inventoryLength");
//       if (inventoryLength == 0)
//       {
//
//         print("Dialog View on 2 Navigator "+isDialogView.toString());
//         if (isLoadAll) {
//           print("NAvigator 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>> Inventory not found");
//           //Navigator.pop(context);
//         }
//         else {
//           print(
//               "NAvigator 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>> Inventory not found1");
//         }
//
//         print("Inventory not found ");
//       }
//       else {
//         print("Dialog View on 3 Navigator "+isDialogView.toString());
//         if (isLoadAll) {
//           print("NAvigator 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>> Inventory  found");
//           //  Navigator.pop(context, false);
//         }
//         else {
//           print("NAvigator 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>> Inventory  found1");
//         }
//       }
//     }
//     return inventoryList;
//
//   }
//
//
//
//
//   //New Api(Category, Collectiuon & Color Code)
//   getNewProducts() async{
//     print("Get New Prioduct Api  Mehtode Call");
//
//
//     http.Response response = await http.get(Uri.parse(API_CMS_BASE_URL+"/api/webservices/collections"));
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form New Prioduct Api  : $responcebody");
//     print("Response code Form New Prioduct Api  : $responseCode");
//
//
//
//
//
//     List<ProdectObject> ProdectObjectlist =  NewProductsSearch.fromJson(json.decode(responcebody)).data;
//     int length = ProdectObjectlist.length;
//     print("Length of ProdectObjectlist is $length");
//
//
//     for(int i=0;i<ProdectObjectlist.length;i++)
//     {
//       String category=ProdectObjectlist[i].categoryTitle;
//       print("New Product Category $category");
//       // Add Main Category
//       spinnerSelectCollection.add(SelectAutoSuggest("category", category));
//
//
//
//
//       List<CategoryProduct> categoryProductList  = ProdectObjectlist[i].categoryProducts;
//       int length2 = categoryProductList.length;
//       print("Length of categoryProductList is $length2");
//       for(int j=0;j<length2;j++)
//       {
//         String Newcollection =categoryProductList[j].name;
//
//         print("New Product Collection $Newcollection");
//         // Add Main Collections
//         spinnerSelectCollection.add(SelectAutoSuggest("collection", Newcollection));
//
//         List<ProductColor> ProductColorList =categoryProductList[j].productColors;
//         int length3=ProductColorList.length;
//         print("Length of ProductColorList is $length3");
//         for(int k=0;k<ProductColorList.length;k++)
//         {
//           String NewColors = ProductColorList[k].name;
//           print("New Product Colors $NewColors");
//
//           String objectvalue = SelectAutoSuggest("color", NewColors).toString();
//           print("New Product Object Value  $objectvalue");
//           // Add Main Colors
//           spinnerSelectCollection.add(SelectAutoSuggest("color", NewColors));
//
//         }
//
//
//
//
//
//
//
//
//       }
//       //
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
//   get_All_Collection_Categoty_ColorCde(String User) async {
//     http.Response response;
//
//     print(">>>>>>>>>>>>>>>>>>>>.All_Collection_Categoty_ColorCde $API_ROS_PROD__BASE_URL");
//
//
//     if(MyMemberType=="Distributor")
//     {
//       if(User=="Self Stock")
//       {
//
//         setState(() {
//           spinnerSelectCollection.clear();
//
//         });
//         print("get_All_Collection_Categoty_ColorCde Self Stock companies Id " +MyCompanyId+"  Memeber ID $MyMemberId");
//
//         response = await http.get(
//           Uri.parse(API_ROS_PROD__BASE_URL+"/api/companies/$MyCompanyId/distributors/$MyMemberId/customer_product_attributes"),
//           headers: {
//             HttpHeaders.authorizationHeader: 'bearer $MyToken',
//           },
//         );
//
//       }
//       else
//       {
//         setState(() {
//           spinnerSelectCollection.clear();
//
//         });
//         int id = spinnerDealerSelectes.id;
//         String name = spinnerDealerSelectes.name;
//         print("get_All_Collection_Categoty_ColorCde Self Stock Dealer $id");
//
//
//         response = await http.get(
//           Uri.parse(API_ROS_PROD__BASE_URL+"/api/companies/$MyCompanyId/dealers/$id/customer_product_attributes"),
//           headers: {
//             HttpHeaders.authorizationHeader: 'bearer $MyToken',
//           },
//         );
//
//       }
//     }
//     else
//     {
//       if(MyMemberType=="DUC")
//       {
//         print("DUC get_All_Collection_Categoty_ColorCde Self Stock Dealer ");
//         setState(() {
//           spinnerSelectCollection.clear();
//
//         });
//
//
//
//         //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/customer_product_attributes
//         print("DUC Company ID $MyCompanyId");
//         print("DUC Member ID $MyMemberId");
//         response = await http.get(
//           Uri.parse(API_ROS_PROD__BASE_URL+"/api/companies/$MyCompanyId/dealers/$MyMemberId/customer_product_attributes"),
//           headers: {
//             HttpHeaders.authorizationHeader: 'bearer $MyToken',
//           },
//         );
//
//       }
//       else if(MyMemberType=="DUD")
//       {
//         setState(() {
//           spinnerSelectCollection.clear();
//
//         });
//
//         print("DUD get_All_Collection_Categoty_ColorCde Self Stock Dealer ");
//
//         //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1997/customer_product_attributes
//
//         print("DUD Company ID $MyCompanyId");
//         print("DUD Member ID $MyMemberId");
//         response = await http.get(
//           Uri.parse(API_ROS_PROD__BASE_URL+"/api/companies/$MyCompanyId/dealers/$MyMemberId/customer_product_attributes"),
//           headers: {
//             HttpHeaders.authorizationHeader: 'bearer $MyToken',
//           },
//         );
//       }
//     }
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form get_All_Collection_Categoty_ColorCde Api  : $responcebody");
//     print("Response code Form get_All_Collection_Categoty_ColorCde Api  : $responseCode");
//
//     List<AllRossCollectionsRoss> listAllCollectonsRoss =  allRossCollectionsRossFromJson(response.body);
//     int length = listAllCollectonsRoss.length;
//     print("Length of get_All_Collection_Categoty_ColorCde List is $length");
//
//     String categoryValue="";
//     String collectionValue="";
//
//
//
//     for(int i=0;i<listAllCollectonsRoss.length;i++)
//     {
//       String category=listAllCollectonsRoss[i].code;
//
//       categoryValue=category;
//       print("get_All_Collection_Categoty_ColorCde New Product Category $category");
//       // Add Main Category
//       spinnerSelectCollection.add(SelectAutoSuggest("category", category));
//
//
//
//
//       List<RossCollections> collectionsProductList  = listAllCollectonsRoss[i].collections;
//       int length2 = collectionsProductList.length;
//       print("Length of categoryProductList is $length2");
//       for(int j=0;j<length2;j++)
//       {
//         String Newcollection =collectionsProductList[j].code;
//         collectionValue=Newcollection;
//         print("get_All_Collection_Categoty_ColorCde New Product Collection $Newcollection");
//         // Add Main Collections
//         spinnerSelectCollection.add(SelectAutoSuggest("category=$categoryValue&collection", Newcollection));
//
//         List<RossColours> ProductColorList =collectionsProductList[j].colours;
//         int length3=ProductColorList.length;
//         print("Length of ProductColorList is $length3");
//         for(int k=0;k<ProductColorList.length;k++)
//         {
//
//           //Change for 351 RED(CARPET)
//           String NewColors = ProductColorList[k].code;
//
//
//           print("get_All_Collection_Categoty_ColorCde New Product Colors $NewColors");
//
//           String objectvalue = SelectAutoSuggest("color", NewColors).toString();
//           print("New Product Object Value  $objectvalue");
//           // Add Main Colors
//           spinnerSelectCollection.add(SelectAutoSuggest("category=$categoryValue&collection=$collectionValue&colour", NewColors));
//
//         }
//
//
//
//
//
//
//
//
//       }
//       //
//     }
//   }
//
//
//
//
//
//
//   getSpecificIamge() async{
//     print("Get Image Api Methode Call ");
//
//     var  uri = API_CMS_BASE_URL+'/api/webservices/getProductColorImage';
//
//     var map = new Map<String, dynamic>();
//
//     map['product_color_code'] = '1811 BLUE';
//
//
//
//     try
//     {
//       http.Response response = await http.post(Uri.parse(uri), body: map,);
//       var responcebody = response.body;
//       var responseCode = response.statusCode;
//       print("Response Body Get Image  of Form Data Api : $responcebody");
//       print("Response code Get Image Form Data Api : $responseCode");
//     }
//     catch(e)
//     {
//       print("Image Api Methode Error $e");
//     }
//
//
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
//   List<String> listOFSelectedColors = [];
//
//   String dropdownValue1 = 'Design';
//   List<String> spinnerItems1 = [
//     'Design',
//     'One',
//     'Two',
//     'Three',
//     'Four',
//     'Five'
//   ];
//
//   String dropdownValue2 = 'Colors';
//
//   List<String> spinnerItems2 = [
//     'Colors',
//     'One',
//     'Two',
//     'Three',
//     'Four',
//     'Five'
//   ];
//
//
//   TextEditingController _textEditingController;
//
//   int _currentRoute = 0;
//
//
//
//
//
//
//
//
//   //~~~~~~~~~~~~~~~~~~~~~~~~~~
//   String dropdownValue = 'Select1  ';
//
//   List <String> spinnerItems = [
//     'Select1  ',
//     'One',
//     'Two',
//     'Three',
//     'Four',
//     'Five'
//   ] ;
//
//
//
//
//   List<ShCategory> list = [];
//   List<String> banners = [];
//   List<ShProduct> newestProducts = [];
//
//
//   List<ShProduct> featuredProducts = [];
//   var position = 0;
//   var colors = [sh_cat_1, sh_cat_2, sh_cat_3, sh_cat_4, sh_cat_5];
//
//   bool selectedColor = false;
//
//   String MyToken;
//   String MyUserName="";
//   String MyCompanyId;
//   String MyMemberId;
//   String MyMemberType;
//   String  Myparent_distributor_id;
//   String  Myparent_distributor_nav_id;
//
//   var checkNetconnection=null;
//   bool isMethodecall = true;
//
//
//
//
//   List<String> allSelectedColorCode =["2711 BLUE","2722 BROWN","2731 GREEN"];
//
//   Future<int> getCollectivePdfLink(String itemCode) async{
//
//
//
//
//     print("Collective PDF Api Methode call");
//
//     var  uri = "https://laravel.cppatidar.com/rosetta/api/webservices/getProductPdfForColorCode";
//
//     var map = new Map<String, dynamic>();
//
//
//
//     map['product_color_code[]'] =allSelectedColorCode;
//
//     var res = await http.post(Uri.parse(uri),body: jsonEncode({"product_color_code":["531502","531503"]}));
//     print("Response From Json Array "+res.body);
//
//
//
//
//
//     http.Response response = await http.post(Uri.parse(uri), body: map,);
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//
//
//
//
//     print("Collective PDf Response Body of Form Data PDF  Api : $responcebody");
//     print("Collective PDf Response code Form Data  PDF Api : $responseCode");
//
//     if (200 == response.statusCode) {
//
//       setState(() {
//
//         String pdfUrl =PdfResponse.fromJson(json.decode(responcebody)).data;
//
//         print("Collective Pdf Url is $pdfUrl");
//       });
//
//
//
//     } else {
//
//     }
//     return response.statusCode;
//   }
//
//   int autospaceid;
//
//   SelectAutoSuggest obj2;
//   String SelectedCode2;
//   String onTypeString="";
//
//
//   bool isVisibleSkip=false;
//
//   isVisibleSkipApi() async {
//     String url = "https://laravel.cppatidar.com/rosetta/api/webservices/skip_button";
//     try {
//       final response = await http.get(Uri.parse(url));
//       var reult = response.statusCode;
//       print("Rsponse Code Of Category Api $reult");
//       print(json.decode(response.body));
//
//
//
//       print("Response of isVisible Api is >>>>>>>>>>>>>   "+response.body);
//
//       setState(() {
//         isVisibleSkip= SkipButtonApi.fromJson(json.decode(response.body)).status;
//
//         print("Result of Skip  isVisible layout >>>>>>>>>>>>   "+isVisibleSkip.toString());
//
//       });
//
//
//     }
//     catch(e)
//     {
//
//     }
//
//
//
//   }
//   bool isRGallery = false ;
//
//   @override
//   void initState() {
//     super.initState();
//     if(API_ROS_PROD__BASE_URL=="http://ros.rosettaproducts.com")
//     {
//       print("App >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Rosetta ");
//       setState(() {
//         isRGallery = false ;
//       });
//     }
//     if(API_ROS_PROD__BASE_URL=="http://ros.r-gallery.in")
//     {
//       //  saveBaseUrl(API_ROS_PROD__BASE_URL);
//       print("App >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> R Gallery  ");
//       setState(() {
//         isRGallery = true ;
//       });
//     }
//
//
//
//
//
//     print(">>>>>>>>>>>>>>>>>>>>>>>..Home Screen Back ");
//     print(">>>>>>>>>>>>....Form Data Home Screen Back $SelectedAutoSuggestStirng $SelectedDesign $SelectedQuantity $SelectedMinPrice $SelectedmaxPrice   $SelectedDealer2");
//
//     HttpOverrides.global = MyHttpOverrides();
//
//     isVisibleSkipApi();
//     getPermission();
//     checkNetconnection = isInternatAvailable();
//     print("Init Methode call");
//     getSessionData();
//     isMethodecall=false;
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
//   }
//
//   void search_on_Type(String value)
//   {
//
//     //spinnerSelectCollection
//
//     print("search_on_Type >>>>>>>>>>>>>>>>>>>>>   $value "+spinnerSelectCollection.length.toString());
//
//     int  length  = spinnerSelectCollection.length;
//
//     for(int i =0; i < spinnerSelectCollection.length; i++)
//     {
//
//
//       //print("search_on_Type  >>>>>>>>>>>>>>>>>>>>>>>  Value match "+   spinnerSelectCollection[i].Code.toString()   +   spinnerSelectCollection[i].value.toString() );
//       if(spinnerSelectCollection[i].value == value.toUpperCase())
//       {
//         print("search_on_Type  >>>>>>>>>>>>>>>>>>>>>>>  Value match "+spinnerSelectCollection[i].Code);
//
//         SelectedValue =   spinnerSelectCollection[i].value;
//
//         String SelectedCode  =  spinnerSelectCollection[i].Code;
//
//
//
//
//         //category=CARPET
//         SelectedAutoSuggestStirng="$SelectedCode=$SelectedValue";
//       }
//
//     }
//
//   }
//
//   void getPermission() async {
//     print(">>>>>>>>Get Permission");
//
//
//
//     if(Platform.isAndroid) {
//
//       var androidInfo = await DeviceInfoPlugin().androidInfo;
//       var release = androidInfo.version.release;
//
//       List<String> names = release.split(".");
//       print("Android Device Version >>>>>>>>>>>>>>>>>>>>>>>  "+names[0]);
//
//       if (double.parse(names[0])==10) {
//         print("1 Android Device Version >>>>>>>>>>>>>>>>>>>>>>>  "+names[0]);
//
//         //          Permission.manageExternalStorage,
//         Map<Permission, PermissionStatus> statuses = await [
//           Permission.storage,
//           Permission.accessMediaLocation,
//         ].request();
//
//         print(" 10  Status >>>>>>"+statuses[Permission.storage].toString());
//         print("10 Permission Status >>>>>>>"+statuses[Permission.accessMediaLocation].toString());
//
//
//       }
//       else
//       {
//         print("2 Android Device Version >>>>>>>>>>>>>>>>>>>>>>>  "+names[0]);
//
//         Map<Permission, PermissionStatus> statuses = await [
//           Permission.storage,
//         ].request();
//
//       }
//     }
//
//
//
//
// // You can request multiple permissions at once.
// //     Map<Permission, PermissionStatus> statuses = await [
// //       Permission.storage,
// //       Permission.manageExternalStorage,
// //     ].request();
//
//
//
//     // print("Permission Status "+statuses[Permission.storage].toString());
//     // print("Permission Status "+statuses[Permission.manageExternalStorage].toString());
//
//
//   }
//
//   // void getPermission() async {
//   //   print(">>>>>>>>Get Permission");
//   //
//   //   if(Platform.isAndroid){
//   //     Permission permission;
//   //     var androidInfo = int.parse(Platform.operatingSystemVersion);
//   //     if (androidInfo < 11) {
//   //       permission = Permission.storage;
//   //     } else {
//   //       permission = Permission.manageExternalStorage;
//   //     }
//   //     if (await permission.isGranted) {
//   //       print("permission accept");
//   //     } else {
//   //       var result = await permission.request();
//   //       if (result == PermissionStatus.granted) {
//   //         print("permission accept1");
//   //       } else {
//   //         print("permission not accept");
//   //       }
//   //     }
//   //   }
//   //
//   //
//   //
//   //   /*  if (await Permission.manageExternalStorage.request().isGranted) {
//   //     setState(() {
//   //       //permissionGranted = true;
//   //       print("Storage permissions is granted ");
//   //     });
//   //   } else if (await Permission.manageExternalStorage.request().isPermanentlyDenied) {
//   //     print("Storage permissions is  isPermanentlyDenied");
//   //
//   //     await openAppSettings();
//   //   } else if (await Permission.manageExternalStorage.request().isDenied) {
//   //     print("Storage permissions is  isPermanentlyDenied");
//   //
//   //     setState(() {
//   //       //permissionGranted = false;
//   //     });
//   //   }
//   //   // print("Permission Status "+statuses[Permission.storage].toString());
//   //   // print("Permission Status "+statuses[Permission.manageExternalStorage].toString());*/
//   //
//   //
//   // }
//
//
//   getSessionData() async
//   {
//
//     //SelectedTenantBaseURl
//     print("Get Session Methode Call");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString("gst","");
//     prefs.setString("status_pan","");
//     prefs.setString("reference_number_pan","");
//     prefs.setString("number_pan","");
//     prefs.setString("customer_type","");
//     prefs.setString('error_message',"");
//     prefs.setString("paymentTerms","");
//     prefs.setString("paymentMethod","");
//     prefs.setString("credit_limit","2000");
//     prefs.setString("overdueBalance","0");
//     String token = prefs.getString('token');
//     String  userName = prefs.getString('UserName');
//     String  mycompanyId = prefs.getString('companyId');
//     String  mymemberId = prefs.getString('memberId');
//     String  mymemberType = prefs.getString('memberType');
//     API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');
//     String  parent_distributor_id ="0";
//     String  parent_distributor_nav_id = "0";
//
//
//
//
//
//     if(mymemberType!="Distributor")
//     {
//
//       parent_distributor_id = prefs.getString('parent_distributor_id');
//       parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');
//
//     }
//
//
//     print("Home Page >>>>>>>>>>>Session Token $token  $userName $mycompanyId $mycompanyId $mymemberType");
//     setState(() {
//       MyToken=token;
//       MyUserName=userName==null?"":userName;
//       MyCompanyId=mycompanyId;
//       MyMemberId=mymemberId;
//       MyMemberType=mymemberType;
//       if(MyMemberType!="Distributor")
//       {
//
//         //~~~~~~~~~~~~~~~~Spinear Dealer
//
//         Myparent_distributor_id=parent_distributor_id;
//         Myparent_distributor_nav_id=parent_distributor_nav_id;
//         print("Home Page Session Data Myparent_distributor_id  $parent_distributor_id , Myparent_distributor_nav_id $parent_distributor_nav_id");
//       }
//       else
//       {
//         getDealerList(); //1
//       }
//
//     });
//
//     if(token.isNotEmpty)
//     {
//       print(">>>>>>>>>>>>>>>>>>Token is Not Empty>>>>>>>>>>>>>>>>>>>");
//
//       setState(() {
//         if(checkNetconnection==null)
//         {
//           //showAlertStockDialog(context);
//
//         }
//       });
//
//
//       checkNetconnection = isInternatAvailable();
//       print("Response od internet Menthode $checkNetconnection");
//       print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$checkNetconnection.");
//       if(checkNetconnection!=null)
//       {
//
//
//         getList();
//         // getListData();
//         fetchData();
//
//         //getNewProducts();
//         get_All_Collection_Categoty_ColorCde("Self Stock");
//
//
//
//
//         //~~~~~~~~~~~~~~~~~~Spinner Refined Dealer Call
//         // getDealerListRefinrd();
//
//
//
//         getMainCololrs();
//         getSettingMessage();
//
//
//
//
//         //getCollectivePdfLink("");
//       }
//       if(checkNetconnection!=null)
//       {
//         print("Please check your Internet Connection ");
//         // showAlertStockDialog(context);
//         //interNetPopup();
//       }
//     }
//
//     // String cuurentTimeStamp =  DateTime.now().millisecondsSinceEpoch.toString();
//     var now = new DateTime.now();
//     var formatter = new DateFormat('yyyy-MM-dd');
//     String cuurentTimeStamp  = formatter.format(now).toString();//2016-01-25
//     print("myTimeStamp >>>>>>>>>>>>>>>>>>> "+prefs.getString("myTimeStamp").toString());
//     print("cuurentTimeStamp >>>>>>>>>>>>>>>>>>> "+cuurentTimeStamp);
//     bool isShowDialog = false;
//     if(cuurentTimeStamp!=prefs.getString("myTimeStamp")||prefs.getString("myTimeStamp").isEmptyOrNull)
//     {
//       print("Home Dialog Show ");
//       prefs.setString("myTimeStamp", cuurentTimeStamp);
//
//       myTimeStamp=cuurentTimeStamp;
//
//       if(isRGallery)
//       {
//         print("Home Dialog 1 ");
//         showToastDialogNoticeRGallery(context);
//       }
//       if(!isRGallery)
//       {
//         print("Home Dialog 2 ");
//         showToastDialogNotice(context);
//       }
//
//     }
//     else
//     {
//       print("Home Dialog Dismiss ");
//     }
//
//
//
//   }
//
//
//
//   fetchData() async {
//
//
//
//     loadCategory().then((categories) {
//       setState(() {
//         list.clear();
//         list.addAll(categories);
//
//
//       });
//     }).catchError((error) {
//       toasty(context, error);
//     });
//     List<ShProduct> products = await loadProducts();
//     List<ShProduct> featured = [];
//     products.forEach((product) {
//       if (product.featured) {
//         featured.add(product);
//       }
//     });
//     List<String> banner = [];
//     for (var i = 1; i < 7; i++) {
//       banner.add("images/shophop/img/products/banners/b" + i.toString() + ".jpg");
//     }
//
//
//
//
//     setState(() {
//       newestProducts.clear();
//       featuredProducts.clear();
//       banners.clear();
//       banners.addAll(banner);
//       newestProducts.addAll(products);
//       featuredProducts.addAll(featured);
//     });
//   }
//
//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.width;
//     return Navigator(
//         key: widget.navigatorKey,
//         onGenerateRoute: (RouteSettings settings)
//         {
//           return MaterialPageRoute(
//               settings: settings,
//
//               builder: (BuildContext context)
//               {
//                 return
//
//
//
//
//                   MediaQuery(
//                     data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//                     child:
//                     Scaffold(
//                       key: _scaffoldKey,
//                       appBar: PreferredSize(
//                         preferredSize: const Size.fromHeight(50),
//                         child:MyAppBar(true,"Home",MyUserName+" @",isVisibleSkip),
//                         // child:MyAppBar(true,"Home",MyUserName,isVisibleSkip),
//                       ),
//                       resizeToAvoidBottomInset: false,
//
//                       body: newestProducts.isNotEmpty
//                           ? ScrollConfiguration(
//                           behavior: MyBehavior(),
//                           child:SingleChildScrollView(
//
//                               child: ConstrainedBox(
//                                 constraints: BoxConstraints(maxHeight:double.infinity,
//                                     maxWidth:  MediaQuery.of(context).size.width
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     StringNoticeMessage.isEmpty?Container():  Container(
//                                       padding: EdgeInsets.all(10.0),
//                                       color: sh_colorPrimary,
//                                       child: TextScroll(
//                                         '$StringNoticeMessage',
//                                         mode: TextScrollMode.endless,
//                                         velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
//                                         delayBefore: Duration(milliseconds: 500),
//                                         //numberOfReps: 5,
//                                         // pauseBetween: Duration(milliseconds: 50),
//                                         style: TextStyle(color: Colors.white,fontSize: 15),
//                                         textAlign: TextAlign.right,
//                                         selectable: true,
//                                       ),
//                                     ),
//
//                                     //Search Product to Place Order
//                                     Container(
//                                       alignment: Alignment.centerLeft,
//                                       margin: EdgeInsets.only(left: 0),
//                                       padding: EdgeInsets.only(top:10,left: 15,bottom: 10),
//                                       color: sh_ColorPrimary2,
//                                       child:  Text("Manage Orders",style: TextStyle(fontSize: textSizeLargeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),
//                                     ),
//
//                                     Container(
//
//                                       padding: EdgeInsets.all(15.0),
//                                       color: sh_ColorPrimary2,
//                                       child: SizedBox(
//                                         width: double.infinity,
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           children: [
//
//
//                                             Container(
//                                                 width: MyMemberType=="Distributor"?(width-40)/2:width-40,
//                                                 padding: EdgeInsets.symmetric(horizontal: 10),
//
//                                                 child:
//                                                 MaterialButton(
//
//                                                   padding: EdgeInsets.all(0.0),
//
//                                                   child:   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.start,
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//
//                                                       Image.asset(ic_approve,height: 15,width: 15,color: isrosetta?sh_colorPrimary:sh_colorPrimary2,),
//                                                       Container(
//                                                         margin: EdgeInsets.only(left: 5),
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                                           children: [
//                                                             Container(),
//                                                             Text("MY PO's", style:TextStyle(fontSize: textSizeSmall,fontWeight: FontWeight.w500,color:
//                                                             sh_textColorSecondary),),
//                                                             Container(),
//
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   textColor: backgroundSearchProductFormButtons,
//                                                   // shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                                   color: sh_white,
//
//                                                   onPressed: () => {
//                                                     DisOrderHistory(backArrowVisible: false,SelectedValueForSearch:"Self Stock").launch(context),
//                                                   },
//                                                   elevation: 0,
//                                                 ),
//
//                                                 decoration: BoxDecoration(
//                                                   color: sh_white,
//                                                   borderRadius: BorderRadius.all(
//                                                     Radius.circular(10),
//
//                                                   ),
//
//                                                 )
//                                             ),
//                                             SizedBox(width: 10,),
//                                             MyMemberType=="Distributor"?   Container(
//                                                 width: (width-40)/2,
//
//                                                 padding: EdgeInsets.symmetric(horizontal: 10),
//
//                                                 child:
//                                                 MaterialButton(
//
//                                                   padding: EdgeInsets.all(0.0),
//
//                                                   child:   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.start,
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//
//                                                       Image.asset(ic_approve,height: 15,width: 15,color: isrosetta?sh_colorPrimary:sh_colorPrimary2,),
//                                                       Container(
//                                                         margin: EdgeInsets.only(left: 5),
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                                           children: [
//                                                             Container(),
//                                                             Text("Dealer Order", style:TextStyle(fontSize: textSizeSmall,fontWeight: FontWeight.w500,color:
//                                                             sh_textColorSecondary),),
//                                                             Container(),
//
//                                                           ],
//                                                         ),
//                                                       ),
//
//
//                                                     ],
//                                                   ),
//                                                   textColor: backgroundSearchProductFormButtons,
//                                                   // shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                                   color: sh_white,
//
//                                                   onPressed: () => {
//                                                     DisOrderHistory(backArrowVisible: false,SelectedValueForSearch:"Dealer").launch(context),
//                                                   },
//                                                   elevation: 0,
//                                                 ),
//
//                                                 decoration: BoxDecoration(
//                                                   color: sh_white,
//                                                   borderRadius: BorderRadius.all(
//                                                     Radius.circular(10),
//
//                                                   ),
//
//                                                 )
//                                             ):Container(),
//
//                                           ],
//                                         ),
//                                       ),
//
//                                     ),
//                                     Container(
//
//                                       width: width,
//                                       padding: EdgeInsets.all(15.0),
//
//
//                                       color:sh_white,
//                                       child: Column(
//                                         children: [
//
//
//                                           //~~~~~~~~~~~~~Search Heading
//                                           Container(
//                                             alignment: Alignment.centerLeft,
//                                             child: Text(sh_form_searchProductOrder,style: TextStyle(
//                                                 fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black
//                                             ),),
//                                           ),
//                                           SizedBox(height: 10,),
//
//
//                                           //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Selecte Deale Start
//                                           // spinnerSelectDealer2.length==0?Container(
//                                           //
//                                           //   child: Container(
//                                           //     padding: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
//                                           //     width: double.infinity,
//                                           //     child:Row(
//                                           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           //       children: [
//                                           //         text("Loading Dealers..",
//                                           //             fontSize: textSizeSmall,
//                                           //             fontFamily: fontRegular,
//                                           //             textColor: sh_textColorSecondary),
//                                           //         Image.asset(ic_form_preloader_gif,height: 20,width: 20,)
//                                           //
//                                           //
//                                           //
//                                           //       ],
//                                           //     ),
//                                           //
//                                           //
//                                           //
//                                           //
//                                           //
//                                           //     decoration: BoxDecoration(
//                                           //       color: Colors.white,
//                                           //
//                                           //       border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                           //       borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                           //     ),
//                                           //   ),
//                                           // ) :
//                                           // Container(
//                                           //   width: width,
//                                           //
//                                           //    padding: EdgeInsets.symmetric(horizontal: 20),
//                                           //   child: new DropdownButton<String>(
//                                           //     value: SelectedDealer2,
//                                           //     hint: new Text("Select Here"),
//                                           //     isExpanded: true,
//                                           //     icon: Icon(
//                                           //       Icons.arrow_drop_down,
//                                           //       color:
//                                           //       sh_textColorSecondary,
//                                           //       size: 25,
//                                           //     ),
//                                           //     iconSize: 24,
//                                           //     elevation: 16,
//                                           //     style: TextStyle(
//                                           //       color: Colors.black,
//                                           //       fontSize: 18,
//                                           //     ),
//                                           //     underline: Container(
//                                           //       height: 2,
//                                           //     ),
//                                           //     onChanged: (String value) {
//                                           //       setState(() {
//                                           //         SelectedDealer2 = value;
//                                           //
//                                           //         if(SelectedDealer2=="Self Stock")
//                                           //         {
//                                           //           SelectedValueForSearch="Self Stock";
//                                           //           print("Self Stock is Selected ");
//                                           //           get_All_Collection_Categoty_ColorCde(SelectedDealer2);
//                                           //
//                                           //         }
//                                           //         else
//                                           //         {
//                                           //           SelectedValueForSearch="Dealer";
//                                           //           final index = spinnerDelerList.indexWhere((element) =>
//                                           //           element.name == SelectedDealer2);
//                                           //
//                                           //           print(">>>>>>Selected Dealer List Index $index");
//                                           //           spinnerDealerSelectes=spinnerDelerList[index];
//                                           //           get_All_Collection_Categoty_ColorCde(SelectedDealer2);
//                                           //         }
//                                           //
//                                           //
//                                           //
//                                           //
//                                           //
//                                           //
//                                           //       });
//                                           //     },
//                                           //     items: spinnerSelectDealer2
//                                           //         .map<DropdownMenuItem<String>>(
//                                           //             (String value) {
//                                           //           return DropdownMenuItem<String>(
//                                           //             value: value,
//                                           //             child: text(value,
//                                           //                 fontSize: textSizeSmall,
//                                           //                 textColor: sh_textColorSecondary,
//                                           //                 fontFamily: fontRegular),
//                                           //           );
//                                           //         }).toList(),
//                                           //   ),
//                                           //   decoration: BoxDecoration(
//                                           //     color: Colors.white,
//                                           //
//                                           //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                           //     borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                           //   ),
//                                           //
//                                           // ),
//                                           //
//                                           //
//                                           //
//                                           // SizedBox(height: 10,),
//
//                                           // Select Auto Suggest For Dealer
//                                           MyMemberType=="Distributor"?   Container(
//                                             child:Autocomplete(
//
//                                               optionsBuilder: (TextEditingValue value) {
//                                                 // When the field is empty
//                                                 if (value.text.isEmpty) {
//                                                   return [];
//                                                 }
//
//                                                 // The logic to find out which ones should appear
//                                                 return spinnerSelectDealer2.where((suggestion) => suggestion.toString()
//                                                     .toLowerCase()
//                                                     .contains(value.text.toLowerCase()));
//                                               },
//
//                                               fieldViewBuilder: (BuildContext context,
//                                                   TextEditingController textEditingController,
//
//                                                   FocusNode focusNode, VoidCallback onFieldSubmitted) {
//
//
//                                                 return TextFormField(
//                                                   controller: textEditingController,
//                                                   //  decoration: myTextFieldDecoration(topLabel: "Another Input", hintText: "Type or select from list"),
//                                                   decoration: InputDecoration(
//                                                     filled: true,
//                                                     //backgroundSearchProductFormButtons
//                                                     prefixIcon: Icon(Icons.search,color:sh_colorPrimary,size: 20,),
//                                                     fillColor: backgroundSearchProductFormInput,
//                                                     focusColor: sh_editText_background_active,
//
//                                                     hintText: "Search Dealers",
//                                                     hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                                     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                                     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                                     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0)
//
//                                                     ),),
//                                                   focusNode: focusNode,
//                                                   onFieldSubmitted: (String value) {
//                                                     onFieldSubmitted();
//                                                     print('You just typed a new entry  $value');
//
//                                                   },
//                                                 );
//                                               },
//
//                                               onSelected: (value) {
//                                                 setState(() {
//
//                                                   print("Selected Dealer From Auto Suggest is "+value);
//
//
//                                                   SelectedDealer2 = value;
//
//                                                   if(SelectedDealer2=="Self Stock")
//                                                   {
//                                                     SelectedValueForSearch="Self Stock";
//                                                     print("Self Stock is Selected ");
//                                                     get_All_Collection_Categoty_ColorCde(SelectedDealer2);
//
//                                                   }
//                                                   else
//                                                   {
//                                                     SelectedValueForSearch="Dealer";
//                                                     final index = spinnerDelerList.indexWhere((element) =>
//                                                     element.name == SelectedDealer2);
//
//                                                     print(">>>>>>Selected Dealer List Index $index");
//                                                     spinnerDealerSelectes=spinnerDelerList[index];
//                                                     get_All_Collection_Categoty_ColorCde(SelectedDealer2);
//                                                   }
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
//                                                 });
//
//                                               },
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//
//                                               border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                               borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                             ),
//
//                                           ):Container(),
//
//                                           SizedBox(height: 10,),
//                                           //Select Auto Suggest
//                                           Container(
//                                             child:
//
//
//
//                                             Autocomplete(
//
//                                               optionsBuilder: (TextEditingValue value) {
//                                                 // When the field is empty
//
//                                                 print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>.."+value.text);
//                                                 onChangedSelectedValue=value.text;
//                                                 onTypeString=value.text;
//
//
//
//                                                 if (value.text.isEmpty) {
//                                                   return [];
//                                                 }
//
//                                                 // The logic to find out which ones should appear
//                                                 return
//
//                                                   spinnerSelectCollection.where((suggestion) => suggestion.toString()
//                                                       .toLowerCase()
//                                                       .contains(value.text.toLowerCase()));
//                                               },
//
//                                               fieldViewBuilder: (BuildContext context,
//                                                   TextEditingController textEditingController,
//                                                   FocusNode focusNode, VoidCallback onFieldSubmitted) {
//                                                 return
//
//                                                   MediaQuery(
//                                                       data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//                                                       child:
//                                                       TextFormField(
//                                                         controller: textEditingController,
//
//                                                         //  decoration: myTextFieldDecoration(topLabel: "Another Input", hintText: "Type or select from list"),
//                                                         decoration: InputDecoration(
//                                                           filled: true,
//                                                           //backgroundSearchProductFormButtons
//                                                           prefixIcon: Icon(Icons.search,color:sh_colorPrimary,size: 20,),
//                                                           fillColor: backgroundSearchProductFormInput,
//                                                           focusColor: sh_editText_background_active,
//
//                                                           hintText: sh_hint_SearchCollection2,
//                                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                                           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0)
//
//                                                           ),),
//                                                         focusNode: focusNode,
//                                                         onFieldSubmitted: (String value) {
//                                                           onFieldSubmitted();
//                                                           print('You just typed a new entry  $value');
//
//                                                         },
//                                                       )
//                                                   );
//                                               },
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
//                                               onSelected: (value) {
//                                                 setState(() {
//                                                   onTypeString="";
//                                                   SelectAutoSuggest obj = value as SelectAutoSuggest;
//                                                   SelectedValue =   obj.value;
//
//                                                   String SelectedCode  =  obj.Code;
//
//
//                                                   print("Selected Category >>>>>>>>>>>>>>>>> $onTypeString $value   $SelectedValue   $SelectedCode ");
//
//                                                   //category=CARPET
//                                                   SelectedAutoSuggestStirng="$SelectedCode=$SelectedValue";
//                                                   // SingleSelectedCategory=value;
//                                                   spinnerSelectCollection2.clear();
//                                                   getMainCollection();
//                                                   mockResults.clear();
//                                                   getMainCololrs();
//
//
//
//
//
//
//                                                 });
//
//                                               },
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//
//                                               border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                               borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                             ),
//
//                                           ),
//
//
//
//                                         ],
//                                       ),
//
//
//
//
//                                     ),
//
//
//
//
//
//
//                                     //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Select Dealer End
//
//                                     //Loading Colors
//                                     // Container(
//                                     //   margin: EdgeInsets.only(left: 15,right: 15),
//                                     //   width: width,
//                                     //   child: Column(
//                                     //     children: <Widget>[
//                                     //       //mockResults.isEmpty
//                                     //       Container(
//                                     //         padding: EdgeInsets.only(left: 15,right: 10),
//                                     //         child: ChipsInput(
//                                     //           key: _chipKey,
//                                     //           keyboardAppearance: Brightness.dark,
//                                     //           textCapitalization: TextCapitalization.words,
//                                     //           textStyle: const TextStyle(height: 1.5, fontFamily: 'Roboto', fontSize: 16),
//                                     //           decoration: const InputDecoration(
//                                     //             border: InputBorder.none,
//                                     //             focusedBorder: InputBorder.none,
//                                     //             enabledBorder: InputBorder.none,
//                                     //             errorBorder: InputBorder.none,
//                                     //             disabledBorder: InputBorder.none,
//                                     //             hintText: 'Search Colors',
//                                     //             hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                     //           ),
//                                     //           findSuggestions: (String query) {
//                                     //
//                                     //             if (query.isNotEmpty) {
//                                     //               var lowercaseQuery = query.toLowerCase();
//                                     //               return mockResults.where((profile) {
//                                     //                 return profile.name
//                                     //                     .toLowerCase()
//                                     //                     .contains(query.toLowerCase()) ||
//                                     //                     profile.email
//                                     //                         .toLowerCase()
//                                     //                         .contains(query.toLowerCase());
//                                     //               }).toList(growable: false)
//                                     //                 ..sort((a, b) => a.name
//                                     //                     .toLowerCase()
//                                     //                     .indexOf(lowercaseQuery)
//                                     //                     .compareTo(
//                                     //                     b.name.toLowerCase().indexOf(lowercaseQuery)));
//                                     //             }
//                                     //
//                                     //             return mockResults;
//                                     //           },
//                                     //           onChanged: (data) {
//                                     //             // print(data);
//                                     //           },
//                                     //           chipBuilder: (context, state, dynamic profile) {
//                                     //             return InputChip(
//                                     //               key: ObjectKey(profile),
//                                     //               label: Text(profile.name),
//                                     //               avatar: CircleAvatar(
//                                     //                 backgroundImage: NetworkImage(profile.imageUrl),
//                                     //               ),
//                                     //               onDeleted: () => state.deleteChip(profile),
//                                     //               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                                     //             );
//                                     //           },
//                                     //           suggestionBuilder: (context, state, dynamic profile) {
//                                     //             return ListTile(
//                                     //               key: ObjectKey(profile),
//                                     //               leading: CircleAvatar(
//                                     //                 backgroundImage: NetworkImage(profile.imageUrl),
//                                     //               ),
//                                     //               title: Text(profile.name),
//                                     //               subtitle: Text(profile.email),
//                                     //               onTap: () => state.selectSuggestion(profile),
//                                     //             );
//                                     //           },
//                                     //         ),
//                                     //         decoration: BoxDecoration(
//                                     //           color: Colors.white,
//                                     //
//                                     //           border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                     //           borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                     //         ),
//                                     //       ),
//                                     //
//                                     //     ],
//                                     //   ),
//                                     // ),
//                                     // SizedBox(height: 10,),
//
//                                     //Design & Quantity
//                                     Container(
//                                       margin: EdgeInsets.only(left: 15,right: 15),
//                                       child: SizedBox(
//
//                                         child: Row(
//                                           children: <Widget>[
//
//                                             //~~~~~~~~~~`Select Design
//                                             // Expanded(
//                                             //   flex: 1,
//                                             //   child: Container(
//                                             //     // width: 100,
//                                             //     width:width*0.25,
//                                             //     padding: EdgeInsets.only(left: 15,right: 10),
//                                             //
//                                             //     child:  new DropdownButton<String>(
//                                             //       value: dropdownValue1,
//                                             //       hint: new Text("Select Here"),
//                                             //       isExpanded: true,
//                                             //       icon: Icon(
//                                             //         Icons.arrow_drop_down,
//                                             //         color:
//                                             //         sh_textColorSecondary,
//                                             //         size: 25,
//                                             //       ),
//                                             //       iconSize: 24,
//                                             //       elevation: 16,
//                                             //       style: TextStyle(
//                                             //         color: Colors.black,
//                                             //         fontSize: 18,
//                                             //       ),
//                                             //       underline: Container(
//                                             //         height: 2,
//                                             //       ),
//                                             //       onChanged: (String value) {
//                                             //         setState(() {
//                                             //           dropdownValue1 = value;
//                                             //           SelectedDesign=value;
//                                             //         });
//                                             //       },
//                                             //       items: spinnerItems1
//                                             //           .map<DropdownMenuItem<String>>(
//                                             //               (String value) {
//                                             //             return DropdownMenuItem<String>(
//                                             //               value: value,
//                                             //               child: text(value,
//                                             //                   fontSize: textSizeSmall,
//                                             //                   fontFamily: fontRegular,
//                                             //                   textColor: sh_textColorSecondary),
//                                             //             );
//                                             //           }).toList(),
//                                             //     ),
//                                             //     decoration: BoxDecoration(
//                                             //       color: Colors.white,
//                                             //
//                                             //       border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                             //       borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                             //     ),
//                                             //
//                                             //   ),),
//
//
//
//                                             //Select Quantitiy
//                                             Expanded(
//
//                                               child: Container(
//
//                                                 //   width: 100,
//                                                 child: TextFormField(
//                                                   keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                                   autofocus: false,
//                                                   onChanged: (value){
//
//                                                     SelectedQuantity=value;
//
//
//
//                                                     if(int.tryParse(value)!=null)
//                                                     {
//                                                       isDecimalValue=false;
//                                                     }
//                                                     else
//                                                     {
//                                                       isDecimalValue=true;
//                                                       showToastDialog(context, "Please do not enter decimal values");
//                                                     }
//
//                                                   },
//
//                                                   textCapitalization: TextCapitalization.words,
//                                                   style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                                   decoration: InputDecoration(
//
//                                                       filled: true,
//                                                       fillColor: backgroundSearchProductFormInput,
//                                                       focusColor: sh_editText_background_active,
//                                                       hintText: sh_hint_EnterQty,
//                                                       hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                                       contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                                       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                                       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                                 ),
//                                                 decoration: BoxDecoration(
//
//                                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                                   borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                                 ),
//
//                                               ),)
//
//
//
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 10,),
//
//
//                                     //~~~~~~~~~~~~Min , MAx & Search
//                                     Container(
//                                       margin: EdgeInsets.only(left: 15,right: 15),
//                                       child: SizedBox(
//                                         width: double.infinity,
//                                         child: Row(
//                                           children: [
//                                             //~~~~~~~~~~~~~~Select Min Price
//                                             Expanded(
//                                               flex: 1,
//                                               child:   Container(
//                                                 width:width*0.25,
//                                                 child:TextFormField(
//                                                   keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                                   autofocus: false,
//                                                   onChanged: (value){
//                                                     SelectedMinPrice=value;
//                                                   },
//
//                                                   textCapitalization: TextCapitalization.words,
//                                                   style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                                   decoration: InputDecoration(
//
//                                                       filled: true,
//                                                       fillColor: backgroundSearchProductFormInput,
//                                                       focusColor: sh_editText_background_active,
//                                                       hintText: sh_hint_Min,
//                                                       hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                                       contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                                       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                                       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                                 ),
//                                                 decoration: BoxDecoration(
//
//                                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                                   borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                                 ),
//                                               ),),
//                                             SizedBox(width: 10,),
//
//                                             //~~~~~~~~~~~Select Max Price
//                                             Expanded(
//                                               flex: 1,
//                                               child:   Container(
//                                                 width:width*0.25,
//                                                 child:TextFormField(
//                                                   keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                                   autofocus: false,
//                                                   onChanged: (value){
//                                                     SelectedmaxPrice=value;
//                                                   },
//
//                                                   textCapitalization: TextCapitalization.words,
//                                                   style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                                   decoration: InputDecoration(
//
//                                                       filled: true,
//                                                       fillColor: backgroundSearchProductFormInput,
//                                                       focusColor: sh_editText_background_active,
//                                                       hintText: sh_hint_Max,
//                                                       hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                                       contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                                       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_textColorSecondary, width: 0.5)),
//                                                       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                                 ),
//
//                                                 decoration: BoxDecoration(
//
//                                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                                   borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                                 ),
//                                               ),),
//                                             SizedBox(width: 10,),
//
//                                             //~~~~~~~~~~~Search Button
//                                             Expanded(
//                                               flex: 1,
//                                               child:   Container(
//                                                 width:width*0.25,
//
//                                                 child: MaterialButton(
//
//
//
//                                                   child: Container(
//                                                     padding: EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
//                                                     alignment: Alignment.center,
//
//                                                     child: Text(sh_lbl_search,style: TextStyle(fontSize: textSizeSMedium),),
//                                                     //text(sh_lbl_search, fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                                                   ),
//
//                                                   textColor: sh_white,
//                                                   shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                                   color: sh_colorPrimary,
//                                                   onPressed: () =>
//                                                   {
//
//                                                     //  SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context),
//
//
//
//
//
//
//
//                                                     isInternatAvailable2(context),
//
//                                                     search_on_Type(onTypeString),
//
//                                                     if(SelectedAutoSuggestStirng!=null && SelectedQuantity!=null  && isDecimalValue==false )
//                                                       {
//
//
//
//
//                                                         //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//
//
//                                                         //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//
//
//                                                         FocusScope.of(context).unfocus(),
//                                                         isDialogView=true,
//                                                         showProgressDialog(context),
//                                                         //SearchProduct(SelectedAutoSuggestStirng,spinnerDealerSelectes.id)
//                                                         SearchProduct(SelectedAutoSuggestStirng).then((value) async {
//
//                                                           List<Inventory> inventoryFilterdList=[];
//
//
//
//                                                           int responseLength =  value.length;
//
//                                                           if(responseLength==0) {
//                                                             print("Data Not Found");
//                                                             Navigator.pop(dialogContext);
//                                                             showToastDialog(context,
//                                                                 "Data Not Found");
//                                                           }
//                                                           else
//                                                           {
//                                                             if(isLoadAll)
//                                                             {
//                                                               String SelectedValueTemp;
//                                                               String SelectedDealer2Temp;
//
//                                                               setState(() {
//                                                                 SelectedValueTemp=SelectedValue;
//                                                                 SelectedDealer2Temp=SelectedDealer2;
//                                                                 // SelectedValue="";
//                                                                 // SelectedDealer2="";
//
//                                                                 print("Goint to Search Page >>>>>>>>>>>>>>>>>>>>>>> SelectedDealer2 $SelectedDealer2");
//                                                                 print("Goint to Search Page >>>>>>>>>>>>>>>>>>>>>>>  SelectedValueForSearch  $SelectedValueForSearch" );
//
//                                                                 print("Goint to Search Page >>>>>>>>>>>>>>>>>>>>>>>$SelectedValue  $SelectedAutoSuggestStirng  $SelectedDealer2  $SelectedValueForSearch $value $SingleSelectedCategory");
//
//                                                               });
//                                                               print("Dialog View on 4 Navigator "+isDialogView.toString());
//                                                               print("NAvigator 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>> SearchProductResult1");
//                                                               Navigator.of(context);
//                                                               // Navigator.pop(context, false);
//                                                               //  SearchProductResult(value,SelectedAutoSuggestStirng,spinnerDealerSelectes,SelectedQuantity,this.SingleSelectedCategory,SelectedDealer2,SelectedMinPrice,SelectedmaxPrice,SelectedValueTemp,spinnerDelerList,spinnerSelectDealer2,SelectedValueForSearch).launch(context);
//
//                                                               Navigator.pop(dialogContext);
//                                                               await Navigator.of(context)
//                                                                   .push(new MaterialPageRoute(builder: (context) => SearchProductResult(value,SelectedAutoSuggestStirng,spinnerDealerSelectes,SelectedQuantity,this.SingleSelectedCategory,SelectedDealer2,SelectedMinPrice,SelectedmaxPrice,SelectedValueTemp,spinnerDelerList,spinnerSelectDealer2,SelectedValueForSearch)));
//                                                               setState((){
//                                                               });
//                                                             }
//                                                           }
//
//
//
//
//
//
//
//
//                                                           int quntyList=0;
//                                                           int priceList=0;
//
//
//
//
//
//                                                         }),
//
//                                                       }
//                                                     else
//                                                       {
//
//                                                         if(isDecimalValue==true)
//                                                           {
//                                                             showToastDialog(context, "Please do not enter decimal values")
//                                                           }
//                                                         else
//                                                           {
//                                                             showToastDialog(context,"Please Fill All Field "),
//                                                             print("Please Fill All Field "),
//                                                           }
//
//
//
//                                                       }
//
//
//
//
//                                                   },
//                                                   elevation: 0,
//                                                 ),
//
//                                               ),),
//
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//
//
//
//
//                                     // Horizantal Heading & View All
//                                     SizedBox(height: 10,),
//
//                                     // horizontalHeading("Category", callback: () {
//                                     //   // ShViewAllProductScreen().launch(context);
//                                     //   // Navigator.push(context, MaterialPageRoute(builder: (context) => ShViewAllProductScreen(prodcuts: newestProducts, title: sh_lbl_newest_product)));
//                                     //   Navigator.push(context, MaterialPageRoute(builder: (context) => ShViewAllProductScreen()));
//                                     // }),
//
//                                     Container(
//                                         margin: EdgeInsets.only(left: 10),
//                                         child: Text("Category",style: TextStyle(fontSize: textSizeLargeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),)),
//
//                                     SizedBox(height: 10,),
//                                     Container(
//                                       child:    category == null ? ShimmerList() :
//                                       GridView.builder(
//                                           itemCount: category.length,
//                                           physics: NeverScrollableScrollPhysics(),
//                                           shrinkWrap: true,
//
//
//                                           padding: EdgeInsets.all(spacing_middle),
//                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 11, crossAxisSpacing: spacing_middle, mainAxisSpacing: spacing_middle),
//                                           itemBuilder: (_, index) {
//                                             return InkWell(
//                                               onTap: () {
//                                                 Navigator.push(context, MaterialPageRoute(builder: (context) => ShSubProductSctreen(prodcuts: newestProducts, title: sh_lbl_newest_product,id:  category[index].id)));
//
//                                                 //  Navigator.push(context, MaterialPageRoute(builder: (context) => ShProductDetail(product: mProductModel[index])));
//                                               },
//                                               child: Container(
//                                                 child: Wrap(
//                                                   crossAxisAlignment: WrapCrossAlignment.start,
//                                                   children: <Widget>[
//                                                     AspectRatio(
//                                                       aspectRatio: 9 / 11,
//                                                       child: Stack(
//                                                         alignment: Alignment.center,
//                                                         children: <Widget>[
//                                                           Container(
//                                                             padding: EdgeInsets.all(1),
//                                                             decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 0.5)),
//                                                             child:
//                                                             Image.network(
//                                                               category[index].sliderImage,
//                                                               fit: BoxFit.cover,
//                                                               width: double.infinity,
//                                                               height: double.infinity,
//                                                             ),
//                                                             // Image.asset(
//                                                             //   "images/shophop/img/products" + newestProducts[index].images[0].src,
//                                                             //   fit: BoxFit.cover,
//                                                             //   width: double.infinity,
//                                                             //   height: double.infinity,
//                                                             // ),
//                                                           ),
//                                                           Container(
//
//                                                             padding: EdgeInsets.all(10),
//                                                             child: Text(category[index].title,style: TextStyle(fontSize:15,color: Colors.white,fontWeight: FontWeight.bold),
//                                                             ),
//                                                             decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
//
//                                                           ),
//
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 2),
//
//                                                   ],
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                     ),
//
//
//
//
//
//
//
//                                   ],
//                                 ),
//                               )
//                           )
//                       )
//
//                           : Container(
//
//                       ),
//
//                       endDrawer:MyDrwaer(),
//                     ),
//                   );
//               }
//
//
//           );
//         }
//
//     );
//   }
//
//   showProgressDialog(BuildContext context)
//   {
//
//
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//
//         builder: (BuildContext context) {
//           dialogContext = context;
//           return
//             MediaQuery(
//               data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//               child:
//               WillPopScope(
//                 onWillPop: () async {
//                   return false;
//                 },
//                 child: Dialog(
//
//                     child: StatefulBuilder(
//
//                       builder: (BuildContext context, setState){
//
//                         return  Container(
//                           height: 233,
//
//
//                           width:MediaQuery.of(context).size.width,
//                           color: sh_white,
//                           padding: EdgeInsets.only(top: 20,bottom: 20),
//
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(right: 15),
//                                 child: InkWell(
//                                   child: Image.asset(ic_cross_dialog,height: 25,width: 25,
//                                     color: sh_colorPrimary,),
//                                   onTap: (){
//                                     Navigator.pop(context, false);
//                                   },
//                                 ),
//                                 alignment: Alignment.topRight,
//
//                               ),
//                               Stack(
//                                 children: [
//
//
//                                   Container(
//                                     child:
//
//
//                                     Image.asset(ic_form_preloader_gif,height: 100,width: 100, fit: BoxFit.fill,),
//
//                                     alignment: Alignment.topCenter,
//                                   ),
//
//                                 ],
//                               ),
//
//
//                               Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.of(context).size.width,
//
//                                 height: 40,
//                                 child: Text("Loading...",style: TextStyle(color: sh_black,fontSize: 18,fontWeight: FontWeight.bold),),
//                               ),
//
//                               Container(
//                                   alignment: Alignment.center,
//                                   margin: EdgeInsets.symmetric(horizontal: 15),
//
//
//                                   child:Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(),
//                                       Text("Please wait while we load your search",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
//                                       Container(),
//                                     ],
//
//                                   )
//
//                               ),
//
//                               Container(
//                                 alignment: Alignment.center,
//                                 margin: EdgeInsets.symmetric(horizontal: 15),
//
//
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(),
//                                     Text("results",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
//                                     Container(),
//                                   ],
//
//                                 ),
//                               ),
//
//
//                               // Container(
//                               //   margin: EdgeInsets.only(top: 5),
//                               //
//                               //
//                               //
//                               //   color: sh_white,
//                               //   child:   Container(
//                               //
//                               //     child: MaterialButton(
//                               //       padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
//                               //
//                               //
//                               //       child: Text("close", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
//                               //       textColor: sh_white,
//                               //       shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                               //       color: sh_colorPrimary,
//                               //       onPressed: () => {
//                               //             setState(() {
//                               //             isLoadAll=false;
//                               //             }),
//                               //
//                               //         //DisApproveOrder().launch(context),
//                               //         Navigator.pop(context, false),
//                               //
//                               //
//                               //       },
//                               //     ),
//                               //   ),
//                               //
//                               //
//                               // ),
//
//
//                             ],
//                           ),
//
//
//
//                         );
//                       },
//                     )
//
//
//
//                 ),
//               ),
//             );
//         }).then((value) {
//
//       print("Search Dialog Close >>>>>>>>>>>>>>>>>>>>>>>>>>>.");
//       isDialogView=false;
//       if(value)
//       {
//
//
//         print("Search Dialog Close >>>>>>>>>>>>>>>>>>>>>>>>>>>.");
//         FocusScope.of(context).unfocus();
//       }
//     });
//
//   }
//
//
//
//   showToastDialog(BuildContext context,String Message)
//   {
//
//
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return   MediaQuery(
//             data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//             child:
//
//             Dialog(
//
//                 child: StatefulBuilder(
//
//                   builder: (BuildContext context, setState){
//
//                     return  Container(
//                       height: 110,
//
//                       width:MediaQuery.of(context).size.width,
//                       color: sh_white,
//                       padding: EdgeInsets.only(top: 20,bottom: 20),
//
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(child:Text("$Message",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
//
//                           Container(
//                             margin: EdgeInsets.only(top: 5),
//
//
//
//                             color: sh_white,
//                             child:   Container(
//                               color: Colors.white,
//
//                               child: MaterialButton(
//                                 padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
//
//
//                                 child: Text("Retry", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
//                                 textColor: sh_white,
//                                 shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                                 color: sh_colorPrimary,
//                                 onPressed: () => {
//
//                                   //DisApproveOrder().launch(context),
//                                   Navigator.pop(context, false),
//
//
//                                 },
//                               ),
//                             ),
//
//
//                           ),
//
//
//                         ],
//                       ),
//
//
//
//                     );
//                   },
//                 )
//
//
//
//             ),
//           );
//         });
//
//   }
//   showToastDialogNotice(BuildContext context)
//   {
//
//
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return   MediaQuery(
//             data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//             child:
//
//             Dialog(
//
//                 child: StatefulBuilder(
//
//                   builder: (BuildContext context, setState){
//
//                     return  Container(
//                       height: 270,
//
//
//                       width:MediaQuery.of(context).size.width,
//                       color: sh_white,
//                       padding: EdgeInsets.all(20),
//
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(),
//                                   //MOHARRAM
//                                   //MOHARRAM HOLIDAY
//                                   Container(child:Text("NOTICE !",style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: sh_colorPrimary,),)),
//                                   Container(),
//                                 ],
//                               ),
//                               SizedBox(height: 15.0,),
//                               Container(child:Text("Dear Rosetta Associates,",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
//                               Container(child:Text("On account of Moharram, the Corporate Office & all Company Warehouses across INDIA would remain shut between 29th July to 7th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
//                               SizedBox(height: 15.0,),
//                               Container(child:Text("All orders given during this time on the Rosetta App will be shipped after 8th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
//
//
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(),
//                               Container(
//                                 margin: EdgeInsets.only(top: 5),
//
//
//
//                                 color: sh_white,
//                                 child:   Container(
//                                   color: Colors.white,
//
//                                   child: MaterialButton(
//                                     padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
//
//
//                                     child: Text("OK", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
//                                     textColor: sh_white,
//                                     shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                                     color: sh_colorPrimary,
//                                     onPressed: () => {
//
//                                       //DisApproveOrder().launch(context),
//                                       Navigator.pop(context, false),
//
//
//                                     },
//                                   ),
//                                 ),
//
//
//                               ),
//                               Container(),
//                             ],
//                           ),
//
//
//
//
//                         ],
//                       ),
//
//
//
//                     );
//                   },
//                 )
//
//
//
//             ),
//           );
//         });
//
//   }
//   showToastDialogNoticeRGallery(BuildContext context)
//   {
//
//
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (BuildContext context) {
//           return   MediaQuery(
//             data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//             child:
//
//             Dialog(
//
//                 child: StatefulBuilder(
//
//                   builder: (BuildContext context, setState){
//
//                     return  Container(
//                       height: 270,
//
//
//                       width:MediaQuery.of(context).size.width,
//                       color: sh_white,
//                       padding: EdgeInsets.all(20),
//
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(),
//                                   //MOHARRAM
//                                   //MOHARRAM HOLIDAY
//                                   Container(child:Text("NOTICE !",style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: sh_colorPrimary,),)),
//                                   Container(),
//                                 ],
//                               ),
//                               SizedBox(height: 15.0,),
//                               Container(child:Text("Dear R Gallery Associates,",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
//                               Container(child:Text("On account of Moharram, the Corporate Office & all Company Warehouses across INDIA would remain shut between 29th July to 7th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
//                               SizedBox(height: 15.0,),
//                               Container(child:Text("All orders given during this time on the R Gallery App will be shipped after 8th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
//
//
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(),
//                               Container(
//                                 margin: EdgeInsets.only(top: 5),
//
//
//
//                                 color: sh_white,
//                                 child:   Container(
//                                   color: Colors.white,
//
//                                   child: MaterialButton(
//                                     padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
//
//
//                                     child: Text("OK", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
//                                     textColor: sh_white,
//                                     shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                                     color: sh_colorPrimary,
//                                     onPressed: () => {
//
//                                       //DisApproveOrder().launch(context),
//                                       Navigator.pop(context, false),
//
//
//                                     },
//                                   ),
//                                 ),
//
//
//                               ),
//                               Container(),
//                             ],
//                           ),
//
//
//
//
//                         ],
//                       ),
//
//
//
//                     );
//                   },
//                 )
//
//
//
//             ),
//           );
//         });
//
//   }
//
//
//
// }
//
//
//
// //Chips Input Model
// class AppProfile {
//   final String name;
//   final String email;
//   final String imageUrl;
//
//   const AppProfile(this.name, this.email, this.imageUrl);
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is AppProfile &&
//               runtimeType == other.runtimeType &&
//               name == other.name;
//
//   @override
//   int get hashCode => name.hashCode;
//
//   @override
//   String toString() {
//     return name;
//   }
// }
//
//
// class SelectAutoSuggest
// {
//   final String Code;
//   final String value;
//
//   SelectAutoSuggest(this.Code, this.value);
//
//   @override
//   String toString() {
//     return value;
//   }
//
//
//
//
// }
//
//
// class SelectAutoSuggestDealer
// {
//   final int id;
//   final String  name;
//
//   SelectAutoSuggestDealer(this.id, this.name);
//
//   @override
//   String toString() {
//     return name;
//   }
//
//
//
//
// }
//
//
// // For Https Request Codes in Api
//
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
//
//
// // To Avoid Scroll Shadow
// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildOverscrollIndicator(
//       BuildContext context, Widget child, ScrollableDetails details) {
//     return child;
//   }
//
//
//
//
//
// }
//
//
