// import 'dart:convert';
// import 'dart:io';
// import 'dart:math' as math;
//
//
// import 'package:dio/dio.dart';
// import 'package:external_path/external_path.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_chips_input/flutter_chips_input.dart';
// import 'package:flutter_share/flutter_share.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:nb_utils/src/extensions/widget_extensions.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:rosetta_fluter_app/main/model/MainCategory.dart';
// import 'package:rosetta_fluter_app/main/model/MainCollection.dart';
// import 'package:rosetta_fluter_app/main/model/MainColors.dart';
// import 'package:rosetta_fluter_app/main/utils/AppColors.dart';
// import 'package:rosetta_fluter_app/rosetta/models/ALLCollectionsROSS.dart';
// import 'package:rosetta_fluter_app/rosetta/models/AddToCartItems.dart';
// import 'package:rosetta_fluter_app/rosetta/models/Category.dart';
// import 'package:rosetta_fluter_app/rosetta/models/Collection.dart';
// import 'package:rosetta_fluter_app/rosetta/models/GetSingleImag.dart';
// import 'package:rosetta_fluter_app/rosetta/models/LortInventory.dart';
// import 'package:rosetta_fluter_app/rosetta/models/PDFResponse.dart';
// import 'package:rosetta_fluter_app/rosetta/models/SearchProductsList.dart';
//
// import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';
//
// import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
// import 'package:rosetta_fluter_app/rosetta/models/SpinnerDealersList.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShFunction.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
//
// import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
// import 'DisHomeScreen.dart';
// import 'DisSelectedInventory.dart';
// import 'NewProductDetails.dart';
// import 'SearchResultProductDetails.dart';
// import 'SelectProductPlaceOrder.dart';
//
//
//
//
//
//
//
//
// class SearchProductResult extends StatefulWidget {
//
//
//
//   // for check box
//   bool _value = false;
//
//   static String tag = '/ShProfileFragment';
//   var id =47;
//
//
//
//   List<Inventory> listsearchProducts=[];
//
//   //For Form Fill in Search Page
//   String SelectedAutoSuggestStirng,SelectedmaxPrice,SelectedMinPrice,SelectedQuantity="0",SelectedDesign;
//   SpinnerSpinnerDealerList spinnerDealerSelectes;
//   String SingleSelectedCategory;
//   String SelectedDealer2="Select Dealer";
//
//   String SelectedValue;
//
//   //Select Dealer
//   ///For Select Dealerrs
//   List<SpinnerSpinnerDealerList> spinnerDelerList = [];
//   List<String> spinnerSelectDealer2 = [];
//   String SelectedValueForSearch;
//
//
//   SearchProductResult(this.listsearchProducts,this.SelectedAutoSuggestStirng,this.spinnerDealerSelectes,this.SelectedQuantity,this.SingleSelectedCategory,this.SelectedDealer2,this.SelectedMinPrice,this.SelectedmaxPrice,this.SelectedValue,this.spinnerDelerList,this.spinnerSelectDealer2,this.SelectedValueForSearch);
//
//
//   @override
//   ShWishlistFragmentState createState() => ShWishlistFragmentState();
// }
//
// class ShWishlistFragmentState extends State<SearchProductResult> {
//
//
//   String sharedString="";
//   String sharedPDFurl="";
//   String sharedImageUrl="";
//   Future<void> share() async {
//     await FlutterShare.share(
//         title: 'Example share',
//         text: ' $sharedString',
//         linkUrl: '$sharedImageUrl',
//         chooserTitle: 'Example Chooser Title');
//   }
//
//   final _chipKey = GlobalKey<ChipsInputState>();
//
//   String buttonStringDownload = "Generate Catalog";
//
//
//   // //Select Dealer
//   // ///For Select Dealerrs
//   // List<SpinnerSpinnerDealerList> spinnerDelerList = [];
//   // List<String> spinnerSelectDealer2 = [];
//
//   //SpinnerDealer spinnerDealerSelectes=null;
//
//
//
//
//
//   // Future<void> share() async {
//   //   await FlutterShare.share(
//   //       title: 'Example share',
//   //       text: 'Example share text',
//   //       linkUrl: 'https://flutter.dev/',
//   //       chooserTitle: 'Example Chooser Title');
//   // }
//
//
//
//
//   List<bool> _isChecked;
//
//   var isListViewSelected = false;
//
//   String dropdownValue = 'Category';
//
//   List<String> spinnerItems = [
//     'Category',
//     'One',
//     'Two',
//     'Three',
//     'Four',
//     'Five'
//   ];
//
//
//   // for Collection
//   String dropdownValue2 = 'Collection';
//
//   List<String> spinnerItems2 = [
//     'Collection',
//     'One',
//     'Two',
//     'Three',
//     'Four',
//     'Five'
//   ];
//
//   String dropdownValue4 = 'Select Dealer(Optional)';
//
//   List<String> spinnerItems4 = ['Select Dealer(Optional)', 'Self Stock', 'One', 'Two', 'Three', 'Four', 'Five'];
//
//   // for Sort
//
//
//   String dropdownValue3 = 'Sort By Price';
//
//   List<String> spinnerItems3 = ['Sort By Price', 'High to Low', 'Low to High',];
//
//   String dropdownValue5 = 'Select Design';
//
//   List<String> spinnerItems5 = ['Select Design', 'One', 'Two', 'Three', 'Four', 'Five'];
//
//   String dropdownValue6 = 'Colors';
//
//   List<String> spinnerItems6 = ['Colors', 'One', 'Two', 'Three', 'Four', 'Five'];
//
//   String dropdownValue7 = 'Select Cities';
//
//   List<String> spinnerItems7 = ['Select Cities', 'Mumbai', 'Pune', 'Three', 'Four', 'Five'];
//
//
//
//   List<ShProduct> list = [];
//
//
//   Image img;
// // example: Image.asset('images/camera.png',)
//   Image imgUp =  Image.asset(ic_check,height: 22,width: 22,);
//   Image imgDown =  Image.asset(ic_uncheck,height: 22,width: 22,);
//   var tapcount=0;
//   var selectedindex;
//   var listlength=0;
//   var list1 = [];
//
//
//
//   bool isVisibleCheckbox=false;
//   bool isVisibleMessage=false;
//
//   bool is_allow_cl=true;
//
//
//   bool  value = false;
//
//   String etsearch;
//   String etcategory;
//   String etcollection;
//   String etcolors;
//   String etdesign;
//
//
//
//   //For Search Product Form
//
//   bool _isInAsyncCall = true;
//   List<Datum> category=null;
//   List<Product> collection=null;
//   String collectionName="";
//   List<MainCategory> mainCategory=null;
//
//   List<SelectAutoSuggestDealer> spinnerSelectDealer = new  List();
//
//   List<SelectAutoSuggest> spinnerSelectCollection = new  List();
//   String SelectedCollection=null;
//
//
//   List<String> spinnerSelectColors = new  List();
//   String SelectedColors=null;
//
//   List<MainCollection> mainCollection=null;
//   List<MainColors> mainColors=null;
//   List<String> spinnerSelectCollection2 = new  List();
//   String SelectedCollection2=null;
//   List<LotInventory> lotInventory=null;
//   List<String> imageListOfProduct= [];
//   List<DatumIamge> listofImageCode=[];
//
//
//   // For  Stock Dialog
//   int selectedStcokindex;
//   String selectedStockSource;
//   var Stocklist1 = [];
//   Image imgstock;
//
//   Image imgUpstock =  Image.asset(ic_check,height: 20,width: 20,);
//   Image imgDownstock =  Image.asset(ic_uncheck,height: 20,width: 20,);
//   bool ischeckstock=false;
//
//
//
//   String displayImageUrl="";
//   List<String> displayImageUrlList=[];
//
//
//
//
//
//
//   // ignore: deprecated_member_use
//   List<AppProfile> mockResults = new List();
//
//   getCollection() async{
//
//     print(">>>>>>>>>>>>>>>>Get Collection Methode >>>>>>>");
//
//     var  uri = API_CMS_BASE_URL+'/api/webservices/getProductsByCategoryId';
//
//     var map = new Map<String, dynamic>();
//     // map['grant_type'] = 'password';
//     // map['client_id'] = '3MVG9dZJodJWITSviqdj3EnW.LrZ81MbuGBqgIxxxdD6u7Mru2NOEs8bHFoFyNw_nVKPhlF2EzDbNYI0rphQL';
//     // map['client_secret'] = '42E131F37E4E05313646E1ED1D3788D76192EBECA7486D15BDDB8408B9726B42';
//     map['category_id'] = widget.id;
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
//     Collection.fromJson(json.decode(response.body)).data.products;
//
//
//     print("Response Body of Form Data Api : $responcebody");
//     print("Response code Form Data Api : $responseCode");
//
//     if (200 == response.statusCode) {
//
//       setState(() {
//         collection =Collection.fromJson(json.decode(response.body)).data.products;
//         collectionName=Collection.fromJson(json.decode(response.body)).data.title;
//
//       });
//
//
//
//
//     }
//
//   }
//   getMainCategory() async{
//     print(" Get Main Category Api Mehtode Call ");
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/categories?sort=''&page=1&per_page=10'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form Main Category Data Api : $responcebody");
//     print("Response code Form Main Category Data Api : $responseCode");
//
//     setState(() {
//       print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $mainCategory");
//       final parsed = jsonDecode(responcebody).cast<Map<String, dynamic>>();
//
//       mainCategory = parsed.map<MainCategory>((json) => MainCategory.fromJson(json)).toList();
//       var displayName=mainCategory[0].displayName;
//       print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $displayName");
//
//       if(responseCode==200)
//       {
//         // getCategorySpinnerList();
//         setState(() {
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
//   // getMainCollection() async{
//   //   print(" Get Main Collection  Api Mehtode Call ");
//   //   http.Response response = await http.get(Uri.parse('http://rosdev.rosettaproducts.com/api/categories/$SingleSelectedCategory/collections?sort=&page=2&per_page=10'),
//   //     headers: {
//   //       HttpHeaders.authorizationHeader: 'bearer $MyToken',
//   //     },
//   //   );
//   //
//   //   var responcebody = response.body;
//   //   var responseCode = response.statusCode;
//   //   print("Response Body of Form Main Collection  Data Api : $responcebody");
//   //   print("Response code Form Main Collection  Data Api : $responseCode");
//   //
//   //   setState(()
//   //   {
//   //     print(" Get Main Collection  Api Mehtode Call >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $mainCollection");
//   //     final parsed = jsonDecode(responcebody).cast<Map<String, dynamic>>();
//   //
//   //     mainCollection = parsed.map<MainCollection>((json) => MainCollection.fromJson(json)).toList();
//   //
//   //     var displayName=mainCollection[0].displayName;
//   //     print(" Get Main Collection  Api Mehtode Call @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $displayName");
//   //
//   //     if(responseCode==200)
//   //     {
//   //
//   //       setState(() {
//   //         getCollectionSpinnerList();
//   //         _isInAsyncCall=false;
//   //       });
//   //
//   //     }
//   //
//   //   });
//   //
//   //
//   //
//   // }
//   // getMainCololrs() async{
//   //   print(" Get Main Colors  Api Mehtode Call ");
//   //
//   //   http.Response response = await http.get(Uri.parse('http://rosdev.rosettaproducts.com/api/categories/$SingleSelectedCategory/collections/IBADA/colours?sort=&page=1&per_page=10'),
//   //     headers: {
//   //       HttpHeaders.authorizationHeader: 'bearer $MyToken',
//   //     },
//   //   );
//   //
//   //   var responcebody = response.body;
//   //   var responseCode = response.statusCode;
//   //   print("Response Body of Form Main Colors  Data Api : $responcebody");
//   //   print("Response code Form Main Colors  Data Api : $responseCode");
//   //
//   //   setState(() {
//   //
//   //     print(" Get Main  Colors   Api Mehtode Call >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $mainColors");
//   //     final parsed = jsonDecode(responcebody).cast<Map<String, dynamic>>();
//   //     mainColors = parsed.map<MainColors>((json) => MainColors.fromJson(json)).toList();
//   //
//   //     var displayName=mainColors[0].displayName;
//   //     print(" Get Main Colors  Api Mehtode Call @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $displayName");
//   //
//   //
//   //     if(responseCode==200)
//   //     {
//   //
//   //       setState(() {
//   //         getColorsSpinnerList();
//   //         _isInAsyncCall=false;
//   //       });
//   //
//   //     }
//   //
//   //
//   //
//   //
//   //   });
//   //
//   //
//   //
//   // }
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
//   // getCategorySpinnerList() async {
//   //   print("Get Category List Methode Call");
//   //   var length = mainCategory.length;
//   //   print("MainCategory lsi length is $length");
//   //
//   //   setState(() {
//   //     for(int i=0;i<mainCategory.length;i++)
//   //     {
//   //       print("Loop is Called ");
//   //       spinnerSelectCollection.add(mainCategory[i].displayName);
//   //       var displayname = spinnerSelectCollection[i];
//   //       SelectedCollection=spinnerSelectCollection[0];
//   //
//   //       print("SpinnerSelectedList Name $displayname");
//   //     }
//   //   });
//   //
//   // }
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
//
//
//
//   // To get All Inventory on Select Lot
//
//
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
//
//
//   String MyToken;
//   String MyUserName="";
//   String MyCompanyId;
//   String  MyMemberId;
//   String  MyMemberType;
//   String  Myparent_distributor_id;
//   String  Myparent_distributor_nav_id;
//
//   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~OPen File Location Code
//   var _openResult = 'Unknown';
//   Future<void> openFile(String path) async {
//
//     print("Open File Methode Call $path");
//     var filePath = r''+path;
//
//     final _result = await OpenFile.open(filePath);
//     print(_result.message);
//
//     setState(() {
//       _openResult = "type=${_result.type}  message=${_result.message}";
//     });
//   }
//
//
//
//   @override
//   void initState() {
//
//     //_controller = AnimationController(  vsync: this,
//     //  duration: new Duration(milliseconds: 5000),)..repeat();
//     super.initState();
//
//     // getPermission();
//
//     //print("Data From SelectedAutoSuggestStirng "+widget.SelectedAutoSuggestStirng + "Dealer Name "+widget.spinnerDealerSelectes.name+" Selected Quantity "+widget.SelectedQuantity+"Selected Value is  "+widget.SelectedValue);
//     getSessionData();
//     _isChecked=new List();
//
//   }
//   String  downloadPercontage="";
//   bool isSinglePDFDownload = false;
//
//
//   //get Permission to Storage
//   String imgUrl = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
//   String pdfCollectiveUrl ="https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
//
//   var dio = Dio();
//   void getPermission() async {
//     print(">>>>>>>>Get Permission");
//     //await PermissionHandler().requestPermissions([PermissionGroup.storage]);
//     // await  Permission.storage;
//
//
//     if (await Permission.contacts.request().isGranted) {
//       // Either the permission was already granted before or the user just granted it.
//     }
//
// // You can request multiple permissions at once.
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.location,
//       Permission.storage,
//     ].request();
//     print("Permission Status "+statuses[Permission.location].toString());
//   }
//
//   Future<String> download2(Dio dio, String url, String savePath,StateSetter updateState_bottom) async {
//     //get pdf from link
//
//     updateState_bottom(() {
//       isSinglePDFDownload=false;
//
//     });
//
//     print("Save Path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$savePath");
//
//     try
//     {
//
//
//       var response = await dio.get(
//         url,
//
//         onReceiveProgress: ((received,total){
//           if (total != -1) {
//             print((received / total * 100).toStringAsFixed(0) + "%");
//             updateState_bottom(() {
//               downloadPercontage=(received / total * 100).toStringAsFixed(0);
//
//               print("Download pdf Percentage is $downloadPercontage % ");
//               if(downloadPercontage=="100")
//               {
//
//
//                 list1.clear();
//                 allSelectedColorCode.clear();
//                 collectiveNamePdf="";
//                 isSinglePDFDownload=true;
//                 setState(() {
//                   isSinglePDFDownload=true;
//
//                 });
//                 print(">>>>>>>>>>>>>>>>>>.."+downloadPercontage);
//                 // Navigator.of(context, rootNavigator: true).pop();
//                 updateState_bottom((){
//                   getPdfLinkresult=false;
//                 });
//
//                 // openFile(savePath);
//
//
//
//
//                 return downloadPercontage;
//               }
//             });
//           }
//         }),
//         //showDownloadProgress,
//         //Received data with List<int>
//         options: Options(
//             responseType: ResponseType.bytes,
//             followRedirects: false,
//             validateStatus: (status) {
//               return status < 500;
//             }),
//       );
//
//       //write in download folder
//       File file = File(savePath);
//       var raf = file.openSync(mode: FileMode.write);
//       raf.writeFromSync(response.data);
//       await raf.close();
//
//
//     }catch(e)
//     {
//       print(" Error >>>>>>>>>> $e");
//
//       return e.toString();
//     }
//
//
//
//
//   }
//
//
//   void showDownloadProgress(received,total)
//   {
//     if (total != -1) {
//       print((received / total * 100).toStringAsFixed(0) + "%");
//       setState(() {
//         downloadPercontage=(received / total * 100).toStringAsFixed(0);
//         if(downloadPercontage=="100")
//         {
//           print(">>>>>>>>>>>>>>>>>>.."+downloadPercontage);
//           Navigator.pop(context, false);
//         }
//       });
//     }
//
//   }
//
//   ///Api For Pdf
//   ///
//   ///
//   List<String> allSelectedColorCode =[];
//   String collectiveNamePdf="";
//   String collectivePdfNames="";
//   bool getPdfLinkresult=false;
//   var getpdfResponse;
//
//
//   bool singlePdfCall = false;
//   Future<bool> getPdfLink(String itemCode) async{
//
//
//     getPdfLinkresult=false;
//
//     print("Single PDF Api Methode call $getPdfLinkresult");
//
//     var  uri = "https://laravel.cppatidar.com/rosetta/api/webservices/getProductPdfByColorCode";
//
//     var map = new Map<String, dynamic>();
//
//     map['product_color_code'] = "$itemCode";
//
//
//
//
//     http.Response response = await http.post(Uri.parse(uri), body: map,);
//
//
//
//
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
//         getPdfLinkresult =PdfResponse.fromJson(json.decode(responcebody)).status;
//
//         if(getPdfLinkresult)
//         {
//           String pdfUrl =PdfResponse.fromJson(json.decode(responcebody)).data;
//           imgUrl=pdfUrl;
//           print("Pdf Url is $pdfUrl");
//
//         }
//         else if(!getPdfLinkresult)
//         {
//
//           Navigator.of(context, rootNavigator: true).pop();
//           showToastDialog(context, "This Pdf is Not available");
//
//         }
//
//
//       });
//
//
//
//     } else {
//
//     }
//     return PdfResponse.fromJson(json.decode(responcebody)).status;
//   }
//
//   bool collectivePdfCall = false;
//   Future<int> getCollectivePdfLink(String itemCode) async{
//
//
//
//
//
//     print("Collective PDF Api Methode call"+allSelectedColorCode.length.toString());
//
//     var  uri = "https://laravel.cppatidar.com/rosetta/api/webservices/getProductPdfForColorCode";
//
//     var map = new Map<String, dynamic>();
//
//
//
//     //  map['product_color_code[]'] =allSelectedColorCode;
//
//     var res = await http.post(Uri.parse(uri),body: jsonEncode({"product_color_code":allSelectedColorCode}));
//     print("Response From Json Array "+res.body);
//
//
//
//
//
//     // http.Response response = await http.post(Uri.parse(uri), body: map,);
//     //
//     // var responcebody = response.body;
//     // var responseCode = response.statusCode;
//
//
//
//
//     print("Collective PDf Response Body of Form Data PDF  Api : "+res.body);
//     print("Collective PDf Response code Form Data  PDF Api : "+res.statusCode.toString());
//
//
//
//     if (200 == res.statusCode) {
//
//
//       bool result = PdfResponse.fromJson(json.decode(res.body)).status;
//
//       if(result)
//       {
//         setState(() {
//
//           String pdfUrl =PdfResponse.fromJson(json.decode(res.body)).data;
//           pdfCollectiveUrl=pdfUrl;
//
//           print("Collective Pdf Url is $pdfUrl");
//         });
//       }
//
//       if(!result)
//       {
//         //Navigator.of(context, rootNavigator: true).pop();
//         // showToastDialog(context, "This Pdf is Not available");
//       }
//
//
//
//     } else {
//
//     }
//     return res.statusCode;
//   }
//
//
//
//   String ImageUrlSpecific="";
//
//
//   Future<int> getSpecificIamge2(String ItemColorCode) async{
//
//
//     print("ItemColorCode in Product List "+ItemColorCode);
//
//
//
//     print("Get Image Api Methode Call ");
//     var uri = API_CMS_BASE_URL+'/api/webservices/getProductColorImage';
//
//     var map = new Map<String, dynamic>();
//     map['product_color_code'] = '$ItemColorCode';
//
//     http.Response response ;
//
//
//     try {
//       response = await http.post(Uri.parse(uri), body: map,);
//       var responcebody = response.body;
//       var responseCode = response.statusCode;
//       print("Response Body Get Image  of Form Data Api : $responcebody"+ItemColorCode);
//       print("Response code Get Image Form Data Api : $responseCode"+ItemColorCode);
//       if (responseCode == 200) {
//         setState(() {
//           List<DatumIamge> data = GetSingleImage
//               .fromJson(json.decode(responcebody))
//               .data;
//
//           String ImageUrl;
//
//
//           print("image url is $ImageUrl");
//           ImageUrlSpecific = GetSingleImage
//               .fromJson(json.decode(responcebody))
//               .data[0].imagePath;
//
//
//
//
//
//
//         });
//       }
//       else {
//
//       }
//     }
//     catch (e) {
//       print("Image Api Methode Error $e");
//       return null;
//
//     }
//
//
//     return response.statusCode;
//
//
//
//
//
//   }
//
//
//
//   getSessionData() async
//   {
//     print("Get Session Methode Call");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token');
//     String  userName = prefs.getString('UserName');
//     String  mycompanyId = prefs.getString('companyId');
//     String  mymemberId = prefs.getString('memberId');
//     String  mymemberType  = prefs.getString('memberType');
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
//
//
//     print("Search Page >>>>>>>>>>>Session Data   $userName $mycompanyId $mycompanyId $mymemberType");
//
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
//         print("Home Page Session Data Myparent_distributor_id  $parent_distributor_id , Myparent_distributor_nav_id $parent_distributor_nav_id");
//       }
//     });
//
//     if(token.isNotEmpty)
//     {
//
//
//       img =  imgDown;
//       fetchData();
//       getMainCategory();
//       // getMainCollection();
//       //getMainCololrs();
//       getCollection();
//       setDataonImageList();
//       int datumImageLength =  listofImageCode.length;
//       print("Image Datum length is $datumImageLength");
//       //~~~~~~~~~~~~~~~~Spinear Dealer
//       //getDealerList();
//
//
//       //getSpecificIamge(widget.listsearchProducts);
//
//
//       get_All_Collection_Categoty_ColorCde(widget.SelectedDealer2);
//
//
//
//
//     }
//   }
//   setDataonImageList()
//   {
//     int length  =  widget.listsearchProducts.length;
//     print("Set Data on Image List is call $length");
//     //displayNameColor= widget.listsearchProducts[index].colour!=null?widget.listsearchProducts[index].colour.displayName:"";
//     for(int i=0;i<length;i++)
//     {
//       String  displayNameColor= widget.listsearchProducts[i].colour!=null?widget.listsearchProducts[i].colour.displayName:"";
//       print("Set Data on Image List is image code is  $displayNameColor");
//
//       if(displayNameColor==""||displayNameColor==null)
//       {
//         print("Set Data on Image Not Found   $displayNameColor");
//         setState(() {
//           imageListOfProduct.add("");
//           listofImageCode.add(null);
//         });
//
//
//       }
//       else
//       {
//         print("Set Data on Image  Found   $displayNameColor");
//         //getSpecificIamge2(displayNameColor);
//       }
//
//     }
//
//
//   }
//   fetchData() async {
//     var products = await loadProducts();
//     setState(() {
//       list.clear();
//       list.addAll(products);
//
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
//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }
//
//
//
//   Future<List<LotInventory>>  getAllInventory(StateSetter updateState,Inventory obj)
//   async {
//
//     int id = obj.id;//596
//
//
//     print("Getget All Inventory   Methode Call >>>>>>>>>>>>>>>>>>");
//     print("Product Object Id $id");
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory/$id?cust_type=DISTRIBUTO&distributor=5'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form get All Inventory    Data Api : $responcebody");
//     print("Response code Form get All Inventory   Data Api : $responseCode");
//
//
//
//
//
//     if (200 == response.statusCode) {
//
//       updateState(() {
//         lotInventory=null;
//         lotInventory= lotInventoryFromJson(response.body);
//       });
//
//
//
//
//       return lotInventoryFromJson(response.body);
//     } else {
//       return <LotInventory>[];
//     }
//
//
//   }
//
//   String SelectedDeopName="";
//   bool  FlagOnSelectedInventory=true;
//   getSelectedInventory(StateSetter updateState,Inventory obj,int selectId)
//   async {
//
//     int Product_Id = obj.id;//596
//
//     int stock_point_id=selectId;
//
//
//     print("Getget Selected Inventory   Methode Call >>>>>>>>>>>>>>>>>> $stock_point_id  Product Id $Product_Id");
//     String StockApiURL="";
//
//     if(widget.SelectedDealer2=="Self Stock")
//     {
//
//       print("Self Stock is Selected For Inventory");
//       StockApiURL=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory/$Product_Id?cust_type=DISTRIBUTO&distributor=$MyMemberId&stock_point_id=$stock_point_id&stock_point_source=StockPoint';
//
//     }
//     else
//     {
//       int id = widget.spinnerDealerSelectes.id;
//       String name = widget.spinnerDealerSelectes.name;
//       print("Specif Inventory    Dealer  ID $id");
//
//       print("Dealers Selected ForSpecific Inventory  Api");
//       //http://rosdev.rosettaproducts.com/api/companies/3/distributors/4/inventory/663?cust_type=DEALER&dealer=1687&stock_point_id=1&stock_point_source=StockPoint
//       StockApiURL=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/inventory/$Product_Id?cust_type=DEALER&dealer=$id&stock_point_id=$stock_point_id&stock_point_source=StockPoint';
//       // StockApiURL='http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/inventory/$Product_Id?cust_type=DISTRIBUTO&dealer=$id&stock_point_id=$stock_point_id&stock_point_source=StockPoint';
//     }
//
//
//
//     http.Response response = await http.get(Uri.parse(StockApiURL),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form get Selected Inventory    Data Api : $responcebody");
//     print("Response code Form get Selected Inventory   Data Api : $responseCode");
//
//
//
//
//
//     if (response.statusCode==200) {
//
//       updateState(() {
//
//         lotInventory= lotInventoryFromJson(response.body);
//         if(lotInventory.length!=0) {
//           SelectedDeopName = lotInventory[0].locationName;
//
//           print("Selected  DepoName     $SelectedDeopName ");
//         }
//       });
//
//
//
//
//
//     }
//
//
//   }
//
//
//   var  queryParameters =
//   {
//     "cart_items": [
//       {
//         "product_id": 596,
//         "batch_no": "32-15 I/PT056",
//         "order_quantity": "10",
//         "stock_point_code": "WAREHOUSE",
//         "stock_point_source": "StockPoint",
//         "rate_type": "CL",
//         "unit_price": 94.6,
//         "discount": 0,
//         "onlineDiscount": 0
//       },
//       {
//         "product_id": 596,
//         "batch_no": "33-15 I/PT056",
//         "order_quantity": "10",
//         "stock_point_code": "WAREHOUSE",
//         "stock_point_source": "StockPoint",
//         "rate_type": "CL",
//         "unit_price": 94.6,
//         "discount": 0,
//         "onlineDiscount": 0
//       }
//     ]
//   };
//   var jsonData;
//   var newJsonData;
//   bool isValueAddedtoCart=false;
//   bool isValueBlockedtoCart=false;
//
//
//   bool FlagCartItems=false;
//   Future<int>  AddToCartItems( List<CartItem> NewListCartItems,StateSetter updateState) async
//   {
//
//     print("Add To Cart Items Methode Call ..");
//     String AddCartUrl;
//     if(widget.SelectedDealer2=="Self Stock")
//     {
//
//       print("Self Stock is Selected For Add To Cart");
//       AddCartUrl=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/cart_items';
//
//     }
//     else
//     {  int id = widget.spinnerDealerSelectes.id;
//     String name = widget.spinnerDealerSelectes.name;
//     print("Add to Cart Api    Dealer  ID $id");
//
//     print("Dealers Selected For Add to Cart Api");
//     AddCartUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$id/cart_items';
//     }
//
//
//     try{
//
//       print("CartItmes List >>>>>>>>>>>>>>>>>>>."+NewListCartItems.toString());
//       jsonData = jsonEncode(NewListCartItems);
//       newJsonData = {
//         "cart_items":NewListCartItems
//       };
//       print("Josn From CartItems  List >>>>>>>>>>>>>>>>>>>. $jsonData");
//
//     }
//     catch(Exception)
//     {
//       print("#############Exception $Exception");
//     }
//
//
//
//     var headers = {
//       'Authorization': 'bearer $MyToken',
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('POST', Uri.parse(AddCartUrl));
//     // request.body = jsonData;
//     //request.body = jsonData;
//     request.body = jsonEncode(newJsonData);
//     //'''{\n    "cart_items": [\n        {\n            "product_id": 596,\n            "batch_no": "32-15 I/PT056",\n            "order_quantity": "10",\n            "stock_point_code": "WAREHOUSE",\n            "stock_point_source": "StockPoint",\n            "rate_type": "CL",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0\n        },\n        {\n            "product_id": 596,\n            "batch_no": "33-15 I/PT056",\n            "order_quantity": "10",\n            "stock_point_code": "WAREHOUSE",\n            "stock_point_source": "StockPoint",\n            "rate_type": "CL",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0\n        }\n    ]\n}''';
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     int responseCode = response.statusCode;
//     print("Responce code of Add To Cart Api $responseCode");
//
//     if (response.statusCode == 200) {
//       print("Add To Cart Successfulyy 200");
//       updateState(() {
//         isValueAddedtoCart=true;
//         FlagCartItems=false;
//       });
//
//
//       print(await response.stream.bytesToString());
//     }
//     else {
//       print(response.reasonPhrase);
//       var err = response.reasonPhrase;
//       print("Some thing went wrong $err");
//     }
//
//     return response.statusCode;
//   }
//
//
//   bool FlagBlockItems=true;
//   Future<int> BlockToCartItems(List<CartItem> NewListCartItems,StateSetter updateState2) async
//   {
//     print("Block Api Call $FlagBlockItems");
//     // isValueAddedtoCart=false;
//
//     String AddCartUrl;
//     if(widget.SelectedDealer2=="Self Stock")
//     {
//
//       print("Self Stock is Selected For Block Cart");
//       AddCartUrl=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/block_items';
//
//     }
//     else
//     {  int id = widget.spinnerDealerSelectes.id;
//     String name = widget.spinnerDealerSelectes.name;
//     print("Add to Block  Api    Dealer  ID $id");
//
//     print("Dealers Selected For Block  to Cart Api");
//
//     AddCartUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$id/block_items';
//     }
//
//
//
//     print("Block To Cart Items Methode Call ..");
//
//
//     try{
//
//       print("Block CartItmes List >>>>>>>>>>>>>>>>>>>."+NewListCartItems.toString());
//       jsonData = jsonEncode(NewListCartItems);
//       newJsonData = {
//         "block_items":NewListCartItems
//       };
//       print("Block Josn From CartItems  List >>>>>>>>>>>>>>>>>>>. $newJsonData");
//
//     }
//     catch(Exception)
//     {
//       print("Block #############Exception $Exception");
//     }
//
//
//
//     var headers = {
//       'Authorization': 'bearer $MyToken',
//       'Content-Type': 'application/json'
//     };
//     var request = http.Request('POST', Uri.parse(AddCartUrl));
//     // request.body = jsonData;
//     //request.body = jsonData;
//     request.body = jsonEncode(newJsonData);
//     //'''{\n    "cart_items": [\n        {\n            "product_id": 596,\n            "batch_no": "32-15 I/PT056",\n            "order_quantity": "10",\n            "stock_point_code": "WAREHOUSE",\n            "stock_point_source": "StockPoint",\n            "rate_type": "CL",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0\n        },\n        {\n            "product_id": 596,\n            "batch_no": "33-15 I/PT056",\n            "order_quantity": "10",\n            "stock_point_code": "WAREHOUSE",\n            "stock_point_source": "StockPoint",\n            "rate_type": "CL",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0\n        }\n    ]\n}''';
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     int responseCode = response.statusCode;
//     print("Block Responce code of Add To Cart Api $responseCode");
//
//     if (response.statusCode == 200) {
//       print("Block  To Cart Successfulyy 200");
//       updateState2(() {
//         isValueBlockedtoCart=true;
//         print("is Selected Added Cart $isValueAddedtoCart");
//         return;
//       });
//
//
//
//     }
//     else {
//       print(response.reasonPhrase);
//       var err = response.reasonPhrase;
//       print("Block Some thing went wrong $err");
//     }
//
//     return response.statusCode;
//   }
//
//   var inventoryLength;
//   // For Search Product Api
//   Future<List<Inventory>> SearchProduct(String SuggestValue) async {
//
//
//     print("Length of List Of list on Refreshing "+widget.listsearchProducts.length.toString());
//
//
//     String SelectedQuantity = widget.SelectedQuantity;
//     String SelectedMinPrice = widget.SelectedMinPrice;
//     String SelectedmaxPrice= widget.SelectedmaxPrice;
//
//     print(">>>>>>>>>>>>....Form Data  "+SuggestValue );
//     // print(">>>>>>>>>>>>....Form Data  "+SuggestValue + widget.SelectedDesign +widget.SelectedQuantity +  widget.SelectedMinPrice +  widget.SelectedmaxPrice +  "$dealerId");
//
//     print("Search Result App is call");
//
//     String apiUrl="";
//     if(MyMemberType=="Distributor")
//     {
//       if(widget.SelectedDealer2=="Self Stock")
//       {
//         setState(() {
//           widget.SelectedValueForSearch="Self Stock";
//         });
//         // print(">>>>>>>>>>>>....Form Data  $SelectedAutoSuggestStirng $SelectedDesign $SelectedQuantity $SelectedMinPrice $SelectedmaxPrice   $SelectedDealer2");
//
//         print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>. Api For Self stock ");
//
//         apiUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&distributor=$MyMemberId&cust_type=DISTRIBUTO&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice';
//       }
//       else
//       {
//         setState(() {
//           widget.SelectedValueForSearch="Dealer";
//         });
//         var dealerIdSelected = widget.spinnerDealerSelectes.id;
//         print(">>>>>>>>>>>>....Form Data  $dealerIdSelected  $dealerIdSelected");
//
//         print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>. Api For Dealer stock  $dealerIdSelected");
//         apiUrl =  API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice&dealer=$dealerIdSelected&cust_type=DEALER';
//
//         // apiUrl =  'http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&dealer=$dealerIdSelected&cust_type=DEALER&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice';
//       }
//     }
//     else
//     {
//       if(MyMemberType=="DUC")
//       {
//         print("Search Result App is call >>>>>>>>>>>>>>>>>>>>>>>>>>>>. DUC ");
//         apiUrl=API_ROS_PROD__BASE_URL+"/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&dealer=$MyMemberId&cust_type=DEALER&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice";
//         //apiUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&distributor=$MyMemberId&cust_type=DISTRIBUTO&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice';
//         // SelectedValue="CARPET";
//       }
//       else if(MyMemberType=="DUD")
//       {
//         print("Search Result App is call >>>>>>>>>>>>>>>>>>>>>>>>>>>>. DUD ");
//         String MyNavDistrributorId=Myparent_distributor_id;
//         print("DUD my member Id $MyMemberId");
//         print("DUD my MyNavDistrributorId is $MyNavDistrributorId");
//         apiUrl = API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyNavDistrributorId/inventory?sort=&page=1&per_page=10&$SuggestValue&quantity=%253E$SelectedQuantity&min_price=$SelectedMinPrice&max_price=$SelectedmaxPrice&dealer=$MyMemberId&cust_type=DEALER';
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
//     final response = await http.get(
//       Uri.parse(apiUrl),
//       // Send authorization headers to the backend.
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     final responseJson = jsonDecode(response.body);
//
//
//     var result = response.statusCode;
//     var resultBody = response.body;
//
//     print("Response Code Of Search Product  is  $result");
//     print("Response Body  Of Search Product  is  $resultBody");
//     // var total =   SearchProductsList.fromJson(json.decode(response.body)).total;
//     // print("Total Search $total");
//
//
//     // setState(() {
//     //   widget.listsearchProducts  = SearchProductsList.fromJson(json.decode(response.body)).inventory;
//     //    inventoryLength = widget.listsearchProducts.length;
//     // });
//
//
//
//
//
//
//
//     print("SearchProductsList length is $inventoryLength");
//     // print("Range in Quantity $quntyList");
//     // print("Range in Price $priceList");
//
//
//     if(SearchProductsList.fromJson(json.decode(response.body)).inventory.length==0)
//     {
//       Navigator.pop(context);
//       print("Inventory not found ");
//
//     }
//     else
//     {
//       //Navigator.pop(context);
//       // Navigator.pop(context,false);
//
//     }
//
//
//
//
//
//     return SearchProductsList.fromJson(json.decode(response.body)).inventory;
//
//   }
//
//
//
//   //~~~~~~~~~~~~~~~~~~~~~~~~~Spinner Dealer Api
//   Future<List<SpinnerSpinnerDealerList>> getDealerList() async {
//     print("Get SpinnerDealer List Methode Call >>>>>>>>>>>>>>>>>>");
//
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers'),//?sort=&page=1&per_page=20
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
//     // print("New Cart List Length >>>>>> >>>>>>>>> $inventoryLength");
//     setState(() {
//       //NewDealerList.fromJson(json.decode(str));
//       // newCartItesmFromJson(response.body);
//       widget.spinnerDelerList =spinnerSpinnerDealerListFromJson((response.body));
//       if(responseCode==200)
//       {
//         getDelaerSpinnerList();
//       }
//
//
//
//     });
//
//
//     int newinventoryLength =  widget.spinnerDelerList.length;
//     print("New SpinnerDealer List   Length >>>>>>>>>>>>>>> $newinventoryLength");
//     spinnerSpinnerDealerListFromJson(json.decode(response.body));
//   }
//
//
//
//   getDelaerSpinnerList() async {
//
//
//     print("Get Spinner Dealer List Methode Call");
//
//     var length = widget.spinnerDelerList.length;
//     print(" Spinner Dealer List   lsi length is $length");
//
//     for(int i=0;i<widget.spinnerDelerList.length;i++)
//     {
//       var displayname;
//       print(" Spinner Dealer List  Loop is Called ");
//       setState(() {
//         if(i==0)
//         {
//           widget.spinnerSelectDealer2.add("Select Dealer");
//           widget.spinnerSelectDealer2.add("Self Stock");
//           widget.spinnerSelectDealer2.add(widget.spinnerDelerList[i].name);
//           displayname = widget.spinnerSelectDealer2[i];
//         }
//         else
//         {
//           widget.spinnerSelectDealer2.add(widget.spinnerDelerList[i].name);
//           displayname = widget.spinnerSelectDealer2[i];
//         }
//
//         ///SelectedDealer2=spinnerSelectDealer2[0];
//       });
//
//
//       print(" Spinner Dealer List   Name $displayname");
//     }
//   }
//
//
//   LowToHighFilterd() async{
//     List<Inventory> TeamplistsearchProducts= widget.listsearchProducts;
//
//     // setState(() {
//     //   widget.listsearchProducts.clear();
//     // });
//
//
//
//     List<int> arr  =   [78, 34, 1, 3, 90, 34, -1, -4, 6, 55, 20, -65];
//     print("Array elements after sorting: Low To High ");
//
//     for (int i = 0; i < TeamplistsearchProducts.length; i++)
//     {
//       for (int j = i + 1; j < TeamplistsearchProducts.length; j++)
//       {
//         Inventory tmp = null;
//         if (TeamplistsearchProducts[i].price.unit > TeamplistsearchProducts[j].price.unit)
//         {
//           tmp = TeamplistsearchProducts[i];
//           TeamplistsearchProducts[i] = TeamplistsearchProducts[j];
//           TeamplistsearchProducts[j] = tmp;
//           // setState(() {
//           //   widget.listsearchProducts.add(tmp);
//           // });
//
//         }
//       }
//
//       print(TeamplistsearchProducts[i].price.unit);
//     }
//     setState(() {
//
//       widget.listsearchProducts=TeamplistsearchProducts;
//
//     });
//     print("Length After Filtered List "+TeamplistsearchProducts.length.toString());
//
//
//
//
//   }
//   HighToLowFilterd() async{
//     List<Inventory> TeamplistsearchProducts= widget.listsearchProducts;
//
//     // setState(() {
//     //   widget.listsearchProducts.clear();
//     // });
//
//
//
//     List<int> arr  =   [78, 34, 1, 3, 90, 34, -1, -4, 6, 55, 20, -65];
//     print("Array elements after sorting:  High to Low ");
//
//     for (int i = 0; i < TeamplistsearchProducts.length; i++)
//     {
//       for (int j = i + 1; j < TeamplistsearchProducts.length; j++)
//       {
//         Inventory tmp = null;
//         if (TeamplistsearchProducts[i].price.unit < TeamplistsearchProducts[j].price.unit)
//         {
//           tmp = TeamplistsearchProducts[i];
//           TeamplistsearchProducts[i] = TeamplistsearchProducts[j];
//           TeamplistsearchProducts[j] = tmp;
//           // setState(() {
//           //   widget.listsearchProducts.add(tmp);
//           // });
//
//         }
//       }
//
//       print(TeamplistsearchProducts[i].price.unit);
//     }
//     setState(() {
//
//       widget.listsearchProducts=TeamplistsearchProducts;
//
//     });
//     print("Length After Filtered List "+TeamplistsearchProducts.length.toString());
//
//
//
//
//   }
//   get_All_Collection_Categoty_ColorCde(String User) async {
//     http.Response response;
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
//         print("get_All_Collection_Categoty_ColorCde Self Stock");
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
//         int id = widget.spinnerDealerSelectes.id;
//         String name = widget.spinnerDealerSelectes.name;
//         print("get_All_Collection_Categoty_ColorCde Self Stock Dealer $id");
//
//
//         response = await http.get(
//           Uri.parse(API_ROS_PROD__BASE_URL+"/api/companies/3/dealers/1997/customer_product_attributes"),
//           headers: {
//             HttpHeaders.authorizationHeader: 'bearer $MyToken',
//           },
//         );
//
//       }
//
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
//
//
//
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form get_All_Collection_Categoty_ColorCde Api  : $responcebody");
//     print("Response code Form get_All_Collection_Categoty_ColorCde Api  : $responseCode");
//
//     List<AllRossCollectionsRoss> listAllCollectonsRoss =  allRossCollectionsRossFromJson(response.body);
//     int length = listAllCollectonsRoss.length;
//     print("Length of get_All_Collection_Categoty_ColorCde List is $length");
//     String categoryValue="";
//     String collectionValue="";
//
//     for(int i=0;i<listAllCollectonsRoss.length;i++)
//     {
//       String category=listAllCollectonsRoss[i].code;
//       categoryValue=category;
//
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
//           String NewColors = ProductColorList[k].code;
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
//   String selectedValueCategory;
//
//
//
//   //
//   _launchURLApp(String itemCode) async {
//     print("View In Studio Item Code Is $itemCode");
//     String url = 'https://laravel.cppatidar.com/rosetta/appconfigurator/$itemCode';
//     if (await canLaunch(url)) {
//       await launch(url,forceSafariVC: true, forceWebView: true );//forceSafariVC: true, forceWebView: true
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//
//   _launchURLAppSinglePdf(String itemCode) async {
//     print("View In Studio Item Code Is $itemCode");
//     String url = 'https://laravel.cppatidar.com/rosetta/api/webservices/getProductPdfByColorCode/$itemCode';
//     if (await canLaunch(url)) {
//       await launch(url, );//forceSafariVC: true, forceWebView: true
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//
//   _launchURLAppCollectivePdf(String itemCodes) async {
//     print("View In Studio Item Code Is $itemCodes");
//     String url = 'https://laravel.cppatidar.com/rosetta/api/webservices/getProductPdfForColorCode/$itemCodes';
//     if (await canLaunch(url)) {
//       await launch(url, );//forceSafariVC: true, forceWebView: true
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   //For Shared Data
//
//   @override
//   Widget build(BuildContext context) {
//     var checkboximage=ic_check;
//
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.width;
//     return Scaffold(
//
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(50),
//         child:MyAppBar(false,"",MyUserName),
//       ),
//
//       resizeToAvoidBottomInset: false,
//       body:  SafeArea(
//         child: SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(maxHeight:double.infinity,
//                 maxWidth:  MediaQuery.of(context).size.width),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//
//
//                 ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Search Form End ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                 Container(
//                   margin: EdgeInsets.only(left: 15,right: 15,top: 10),
//
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//
//                       Container(
//
//
//                         width: (width /2)-25,
//                         height: 35,
//                         child: Container(
//                           alignment: Alignment.center,
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           child:  new DropdownButton<String>(
//                             value: dropdownValue3,
//
//                             hint: new Text("Select Here"),
//                             isExpanded: true,
//                             icon: Icon(
//                               Icons.arrow_drop_down,
//                               color:
//                               Colors.black,
//                               size: 15,
//                             ),
//
//                             elevation: 0,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: textSizeSmall,
//                             ),
//                             underline: Container(
//                               height: 0,
//                             ),
//                             onChanged: (String value) {
//                               setState(() {
//                                 dropdownValue3 = value;
//
//                                 print("$dropdownValue3");
//
//                                 //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Sorting Technique
//                                 if(dropdownValue3=="Low to High")
//                                 {
//                                   LowToHighFilterd();
//                                 }
//                                 if(dropdownValue3=="High to Low")
//                                 {
//                                   HighToLowFilterd();
//                                 }
//
//
//
//                                 //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                               });
//                             },
//                             items: spinnerItems3
//                                 .map<DropdownMenuItem<String>>(
//                                     (String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//
//                                     child: text(value,
//                                         fontSize: textSizeSmall,
//                                         fontFamily: fontRegular
//                                         ,textColor: Colors.white),
//                                   );
//                                 }).toList(),
//                             dropdownColor: sh_colorPrimary,
//                           ),
//                         ),
//                         decoration: BoxDecoration(
//                             color: sh_colorPrimary,
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(5.0))),
//                       ),
//
//
//                       Container(
//                         child: MaterialButton(
//                           minWidth: (width/2)-25,
//                           padding: EdgeInsets.fromLTRB(20,5,20,5),
//                           child: text("Search Filter", fontSize:textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                           textColor: sh_white,
//                           shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
//                           color: sh_colorPrimary,
//                           onPressed: () => {
//
//                             showAlertFilterDialog(context, setState),
//
//
//                           },
//                         ),
//                       ),
//
//                     ],
//
//                   ),
//                 ),
//
//
//                 Container(
//                   margin: EdgeInsets.only(left: 15,right: 15,top: 0),
//                   child:
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Search Result - "+widget.listsearchProducts.length.toString()+" found",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),),
//                       MaterialButton(
//                         minWidth: (width/2)-25,
//                         padding: EdgeInsets.all(10),
//                         child: text(buttonStringDownload, fontSize:textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                         textColor: sh_white,
//                         shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
//                         color: sh_colorPrimary,
//                         onPressed: () => {
//
//                           setState(() {
//                             isVisibleCheckbox=true;
//                             if(buttonStringDownload=="Download Catalog")
//                             {
//
//                               if(allSelectedColorCode.length!=0) {
//                                 collectivePdfCall=true;
//                                 isSinglePDFDownload=false;
//                                 showAlertDialogCollectivePDF(context, setState, "$collectiveNamePdf");
//                                 //  _launchURLAppCollectivePdf(collectivePdfNames);
//                               }
//                               else
//                               {
//                                 showToastDialog(context, "Please select products");
//                               }
//
//                             }
//                             else
//                             {
//                               buttonStringDownload="Download Catalog";
//
//                             }
//                           })
//                           // ShHomeScreen().launch(context),
//                           //  DistributorShipingDetails().launch(context),
//
//                         },
//                       ),
//
//                     ],
//                   ),
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
//                 ),
//                 SizedBox(height: 10,),
//                 Container(
//                   child: widget.listsearchProducts.length!=0?  ListView.builder(
//
//                       scrollDirection: Axis.vertical,
//                       itemCount:widget.listsearchProducts.length,
//                       // list.length,
//                       //listsearchProducts
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//
//                       itemBuilder: (context, index)
//                       {
//
//
//
//
//                         List<StockPoint> listStockPoint =  widget.listsearchProducts[index].stockPoints;
//                         String displayNameColor = "";
//
//
//
//                         var NewPrice = widget.listsearchProducts[index].price.unit!=null?widget.listsearchProducts[index].price.unit:"0";
//
//                         var NewCategoryName =  widget.listsearchProducts[index].category.code;
//                         var NewImageUrl = widget.listsearchProducts[index].imageUrl;
//                         displayNameColor= widget.listsearchProducts[index].colour!=null?widget.listsearchProducts[index].colour.displayName:"";
//                         var NewQuantity = widget.listsearchProducts[index].inventory!=0?widget.listsearchProducts[index].inventory.truncateToDouble().toStringAsFixed(0):"0";//toStringAsFixed(2)
//                         //var NewQuantity = widget.listsearchProducts[index].inventory!=0?widget.listsearchProducts[index].inventory.toStringAsFixed(0):"0";//toStringAsFixed(2)
//                         int totalImages =   imageListOfProduct.length;
//                         // var EnterdQunatity= double.parse(widget.SelectedQuantity).toStringAsFixed(0);
//                         print("Total Image Url Is $totalImages");
//
//                         print("Collectrion  Name From Search Result  $NewCategoryName   "+ widget.listsearchProducts[index].collection.categoryCode.toString()+widget.listsearchProducts[index].category.code.toString());
//
//                         is_allow_cl =   widget.listsearchProducts[index].category.allowCl;
//                         String plankSize="0",in_multipels="0";
//
//                         String rateTypeDescription="";
//
//
//                         if(is_allow_cl==false)
//                         {
//                           if( widget.listsearchProducts[index].colour.inMultiples.toString()=="0"&&widget.listsearchProducts[index].colour.plankSize.toString()=="0")
//                           {
//                             //At Color Level
//
//                             if( widget.listsearchProducts[index].collection.inMultiples.toString()=="0"&&widget.listsearchProducts[index].collection.plankSize.toString()=="0")
//                             {
//                               //Al Collection Level
//                               if( widget.listsearchProducts[index].category.inMultiples.toString()=="0"&&widget.listsearchProducts[index].category.plankSize.toString()=="0")
//                               {
//                                 //AT Category Level
//                                 print("Categoty Rate Type is RL/CL >>>>>>>>>>>>>>>>>>>.");
//
//
//                               }
//                               else
//                               {
//                                 if( widget.listsearchProducts[index].category.inMultiples.toString()!="0"&&widget.listsearchProducts[index].category.plankSize.toString()!="0")
//                                 {
//
//                                   if(widget.listsearchProducts[index].category.displayName!="CARPETTILE")
//                                   {
//                                     print("Categoty Rate Type is Plank/Piece  >>>>>>>>>>>>>>>>>>>.");
//                                     rateTypeDescription="Plank/Piece";
//                                     plankSize=""+widget.listsearchProducts[index].category.plankSize.toString();
//                                     in_multipels=""+widget.listsearchProducts[index].category.inMultiples.toString();
//                                   }
//                                   else
//                                   {
//                                     print("Categoty Rate Type is Tile/Piece  >>>>>>>>>>>>>>>>>>>.");
//                                     rateTypeDescription="Tile/Piece";
//                                     plankSize=""+widget.listsearchProducts[index].category.plankSize.toString();
//                                     in_multipels=""+widget.listsearchProducts[index].category.inMultiples.toString();
//                                   }
//
//
//                                 }
//                                 else
//                                 {
//                                   print("Categoty Rate Type is BOX/Piece  >>>>>>>>>>>>>>>>>>>.");
//                                   rateTypeDescription="BOX/Piece";
//                                   plankSize=""+widget.listsearchProducts[index].category.plankSize.toString();
//                                   in_multipels=""+widget.listsearchProducts[index].category.inMultiples.toString();
//
//                                 }
//
//
//                               }
//
//
//
//                             }
//                             else
//                             {
//                               if( widget.listsearchProducts[index].collection.inMultiples.toString()!="0"&&widget.listsearchProducts[index].collection.plankSize.toString()!="0")
//                               {
//                                 if(widget.listsearchProducts[index].category.displayName!="CARPETTILE")
//                                 {
//                                   print("Collections Rate Type is Plank/Piece  >>>>>>>>>>>>>>>>>>>.");
//                                   rateTypeDescription="Plank/Piece";
//                                   plankSize=""+widget.listsearchProducts[index].collection.plankSize.toString();
//                                   in_multipels=""+widget.listsearchProducts[index].collection.inMultiples.toString();
//                                 }
//                                 else
//                                 {
//                                   print("Collections Rate Type is Tile/Piece  >>>>>>>>>>>>>>>>>>>.");
//                                   rateTypeDescription="Tile/Piece";
//                                   plankSize=""+widget.listsearchProducts[index].collection.plankSize.toString();
//                                   in_multipels=""+widget.listsearchProducts[index].collection.inMultiples.toString();
//                                 }
//
//
//                               }
//                               else
//                               {
//                                 print("Collections Rate Type is BOX/Piece  >>>>>>>>>>>>>>>>>>>.");
//                                 rateTypeDescription="BOX/Piece";
//                                 plankSize=""+widget.listsearchProducts[index].collection.plankSize.toString();
//                                 in_multipels=""+widget.listsearchProducts[index].collection.inMultiples.toString();
//
//
//
//                               }
//
//
//                             }
//                           }
//                           else
//                           {
//                             if( widget.listsearchProducts[index].colour.inMultiples.toString()!="0"&&widget.listsearchProducts[index].colour.plankSize.toString()!="0")
//                             {
//                               if(widget.listsearchProducts[index].category.displayName!="CARPETTILE")
//                               {
//                                 print("Colour  Rate Type is Plank/Piece  >>>>>>>>>>>>>>>>>>>.");
//                                 rateTypeDescription="Plank/Piece";
//                                 plankSize=""+widget.listsearchProducts[index].colour.plankSize.toString();
//                                 in_multipels=""+widget.listsearchProducts[index].colour.inMultiples.toString();
//                               }
//                               else
//                               {
//                                 print("Colour Rate Type is Tile/Piece  >>>>>>>>>>>>>>>>>>>.");
//                                 rateTypeDescription="Tile/Piece";
//                                 plankSize=""+widget.listsearchProducts[index].colour.plankSize.toString();
//                                 in_multipels=""+widget.listsearchProducts[index].colour.inMultiples.toString();
//                               }
//
//                             }
//                             else
//                             {
//                               print("Colour Rate Type is BOX/Piece  >>>>>>>>>>>>>>>>>>>.");
//                               rateTypeDescription="BOX/Piece";
//                               plankSize=""+widget.listsearchProducts[index].colour.plankSize.toString();
//                               in_multipels=""+widget.listsearchProducts[index].colour.inMultiples.toString();
//
//
//
//                             }
//
//
//                           }
//                         }
//                         else
//                         {
//                           rateTypeDescription="RL/CL";
//                         }
//
//
//
//
//
//
//
//                         return Container(
//                           // height: 240,
//
//                           margin: EdgeInsets.only(bottom: 15,left: 15,right: 15),
//
//                           padding: EdgeInsets.all(10.0),
//
//
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   //Image and Color
//                                   InkWell(
//                                     child:  Container(
//                                       child:
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//
//                                           SizedBox(height: 2,),
//                                           Container(
//                                             width: width * 0.30,//width * 0.3,
//                                             height: 110,
//
//
//
//
//
//                                             child:NewImageUrl!=null?Image.network(NewImageUrl, fit: BoxFit.fill):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.fill),
//
//                                           ),
//
//
//                                           Container(
//                                             //  height: 26,
//                                             // height: 26,
//                                             width: width * 0.30,
//                                             padding: EdgeInsets.only(top: 5),
//                                             color: sh_textColorSecondarylight,
//                                             child: Text(displayNameColor!=null?displayNameColor:"",
//                                               textAlign: TextAlign.center,style: TextStyle(color: Colors.black,),),
//                                           )
//                                         ],
//
//                                       ),
//                                     ),
//                                     onTap: ()
//                                     {
//
//                                       Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultProductDeatails(id: widget.listsearchProducts[index].navId,MyPageTitle:""+widget.listsearchProducts[index].category.displayName,isnavId:true,listsearchProducts:widget.listsearchProducts,SelectedProductDetailt:widget.listsearchProducts[index],SelectedValueForSearch:widget.SelectedValueForSearch,SelectedDealer2:widget.SelectedDealer2,spinnerDealerSelectes: widget.spinnerDealerSelectes,rateTypeDescription: rateTypeDescription,plankSize: plankSize,in_multipels: in_multipels,SelectedQuantity: widget.SelectedQuantity,)));
//
//
//
//                                     },
//                                   ),
//                                   Container(
//                                     height: 150,
//
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         //Collection Name
//                                         Row(
//
//
//                                           children: [
//                                             Container(
//
//                                               child: Text(
//
//                                                 //list[index].name.toString(),
//                                                 widget.listsearchProducts[index].collection.displayName,
//                                                 style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.w500),
//                                               ),
//                                               width: (width-((width * 0.30)+60))-22,
//                                             ),
//                                             Visibility(
//                                               child:InkWell(
//                                                 child: Container(
//                                                   child: list1.contains(index) ? imgUp:imgDown,
//                                                 ),
//                                                 onTap: ()
//                                                 {
//                                                   setState(() {
//                                                     selectedindex=index;
//                                                     if(list1.contains(index))
//                                                     {
//                                                       list1.remove(index);
//                                                       allSelectedColorCode.remove(widget.listsearchProducts[index].colour!=null?widget.listsearchProducts[index].colour.displayName:"");
//                                                       String removeString = widget.listsearchProducts[index].colour!=null?widget.listsearchProducts[index].colour.displayName:"";
//                                                       collectiveNamePdf= collectiveNamePdf.substring(removeString.trim().length);
//                                                       print("Remove Collective Pdf Name  "+collectiveNamePdf);
//
//                                                       String removeString2 = (widget.listsearchProducts[index].colour!=null?widget.listsearchProducts[index].colour.displayName:"")+"/";
//                                                       collectivePdfNames=collectivePdfNames.substring(removeString2.trim().length);
//
//                                                       print("Remove  Pdf url Names >>>>>>>>>>>>>>>>>>>>>>> $collectivePdfNames");
//
//
//                                                     }
//                                                     else
//                                                     {
//
//                                                       print("Display Color Name On Check Box is "+displayNameColor);
//                                                       if(displayNameColor!="")
//                                                       {
//
//
//                                                         //~~~~~~~~~~~~~~~~~~~~~~~~Check 5 pdf  selected
//                                                         if(list1.length>=5)
//                                                         {
//                                                           showToastDialog(context, "Please Generate Catalog up to 5 Products ");
//
//                                                         }
//                                                         else
//                                                         {
//
//                                                           list1.add(index);
//                                                           allSelectedColorCode.add(widget.listsearchProducts[index].colour!=null?widget.listsearchProducts[index].colour.displayName:"");
//                                                           String addString = widget.listsearchProducts[index].colour!=null?widget.listsearchProducts[index].colour.displayName.replaceAll(" ", ""):"";
//
//                                                           collectiveNamePdf=collectiveNamePdf+","+addString.trim();
//                                                           print("Add Collective Pdf Name "+collectiveNamePdf);
//
//                                                           collectivePdfNames=collectivePdfNames+(widget.listsearchProducts[index].colour!=null?widget.listsearchProducts[index].colour.displayName:"")+"/";
//                                                           print("New Pdf url Names >>>>>>>>>>>>>>>>>>>>>>> $collectivePdfNames");
//                                                         }
//
//
//                                                       }
//                                                       else
//                                                       {
//                                                         showToastDialog(context, "Please Select Another one ");
//                                                       }
//
//
//
//                                                     }
//                                                   });
//                                                 },
//                                               ),
//
//
//                                               maintainSize: true,
//                                               maintainAnimation: true,
//                                               maintainState: true,
//                                               visible: isVisibleCheckbox,
//                                             ),
//                                           ],
//
//                                         ),
//
//                                         //Category Name
//                                         Text(
//                                           //"$NewCategoryName".replaceAll("Code.", ""),
//                                           widget.listsearchProducts[index].category.displayName,
//                                           style: TextStyle(
//                                               color: sh_textColorSecondary,
//                                               fontSize: textSizeMedium,fontWeight: FontWeight.w400),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "$NewPrice".toCurrencyFormat().toString(),
//                                               style: TextStyle(fontSize: textSizeLargeMedium,color:sh_colorPrimary,fontWeight: FontWeight.w500),
//                                             ),
//
//                                             // Text(
//                                             //   "5665".toCurrencyFormat().toString(),
//                                             //   style: TextStyle(color: sh_textColorSecondary, fontSize: textSizeLargeMedium, decoration: TextDecoration.lineThrough),
//                                             // ),
//                                           ],
//                                         ),
//                                         Container(
//                                           // width: width-156,
//                                           child: Row(
//
//                                             children: [
//                                               ( widget.listsearchProducts[index].inventory!=0)? Image.asset(ic_circularGreenCheckBox,height:15,width: 15,):Image.asset(ic_circularcancel,height:15,width: 15,),
//
//                                               Container(
//
//                                                 child:( widget.listsearchProducts[index].inventory!=0)? Text(" Stock $NewQuantity Sqft",style: TextStyle(
//                                                     color: sh_textColorSecondary,
//                                                     fontSize: textSizeMedium,fontWeight: FontWeight.w500),):
//                                                 Text("",style: TextStyle(fontSize: 10,color:Colors.red,fontWeight: FontWeight.bold),
//
//
//                                                 ),
//
//
//                                               ),
//
//
//                                             ],
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           ),
//                                         ),
//                                         Container(
//                                           // width: width-156,
//                                           child: Row(
//
//                                             children: [
//                                               Image.asset(ic_block_red,height:15,width: 15,),
//
//                                               Container(
//
//                                                   child:Text(" Block "+widget.listsearchProducts[index].blocked.toStringAsFixed(0)+" Sqft",style: TextStyle(
//                                                       color: sh_textColorSecondary,
//                                                       fontSize: textSizeMedium,fontWeight: FontWeight.w500),)
//
//
//                                               ),
//
//
//                                             ],
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           ),
//                                         ),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//
//                                           children: [
//
//
//                                             //Download Icon
//                                             InkWell(
//                                               child: Image.asset(ic_download_round,height: 35,width: 35,),
//                                               onTap: () async {
//
//                                                 if(displayNameColor!="")
//                                                 {
//
//                                                   singlePdfCall=true;
//                                                   isSinglePDFDownload=false;
//                                                   showAlertDialogPDF(context,setState,displayNameColor);
//
//                                                   // _launchURLAppSinglePdf(displayNameColor);
//
//                                                 }
//                                                 else
//                                                 {
//                                                   showToastDialog(context, "Please Select Another One ");
//                                                 }
//
//
//
//
//
//
//
//                                               },
//                                             ),
//
//
//                                             SizedBox(width: 3,),
//                                             InkWell(
//                                               child: Image.asset(ic_share_round,height: 35,width: 35,),
//                                               onTap:(){
//                                                 sharedImageUrl=NewImageUrl!=null?NewImageUrl:"https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg";
//                                                 sharedString="\nCategory : "+widget.listsearchProducts[index].category.displayName+"\nCollection : "+widget.listsearchProducts[index].collection.displayName.toString()+"\nColour :"+displayNameColor;
//
//                                                 share();
//                                               } ,
//                                             ),
//
//                                             SizedBox(width: 3,),
//
//                                             // For Select Lot
//                                             Container(
//                                               //NewQuantity==115.0
//                                               child:(false)?
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//
//                                                 children: [
//                                                   //Download Icon
//                                                   InkWell(
//                                                     child: Image.asset(ic_circular_bucket,height: 35,width: 35,),
//                                                     onTap: (){
//                                                       showAlertDialogAddToCart(context);
//                                                     },
//                                                   ),
//
//
//                                                   SizedBox(width: 10,),
//
//                                                   InkWell(
//                                                     child:  Image.asset(ic_block_red,height: 35,width: 35,),
//                                                     onTap: (){
//                                                       showAlertDialogBlocked(context);
//                                                     },
//                                                   ),
//
//
//
//
//
//
//                                                 ],
//                                               ):MaterialButton(
//                                                 elevation: 0,
//
//                                                 padding:  EdgeInsets.fromLTRB(12.0, 7.0, 12.0, 7.0),
//                                                 child: text("Select Lot", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: sh_white),
//                                                 textColor: sh_white,
//
//                                                 shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
//                                                 color: sh_colorPrimary,
//                                                 onPressed: () => {
//
//                                                   if(displayNameColor!="")
//                                                     {
//                                                       showAlertStockDialog(context,listStockPoint,widget.listsearchProducts[index],widget.SelectedQuantity,widget.listsearchProducts[index].category.allowCl,rateTypeDescription,plankSize,in_multipels),
//
//                                                     }
//                                                   else
//                                                     {
//                                                       showToastDialog(context, "Please Select Another one "),
//                                                     },
//
//                                                   //   _bottomSheetMore(context,int.parse(widget.SelectedQuantity),widget.listsearchProducts[index],false),
//
//                                                 },
//                                               ),
//
//                                             ),
//
//
//
//
//
//
//                                           ],
//                                         ),
//
//
//                                       ],
//                                     ),
//                                     margin: EdgeInsets.only(left: 10),
//                                   ),
//
//
//
//
//                                 ],
//                               ),
//                               SizedBox(height: 10,),
//                               // Container(height: 1,color: sh_textColorVerticleLine,),
//                               //   SizedBox(height: 10,),
//                               // Container(
//                               //   child: Flexible(
//                               //     child :   Row(
//                               //       mainAxisAlignment: MainAxisAlignment.start,
//                               //       children: [
//                               //
//                               //         Container(
//                               //           //NewQuantity==115.0
//                               //           child:(false)?
//                               //           Row(
//                               //             mainAxisAlignment: MainAxisAlignment.start,
//                               //
//                               //             children: [
//                               //               //Download Icon
//                               //               InkWell(
//                               //                 child: Image.asset(ic_circular_bucket,height: 35,width: 35,),
//                               //                 onTap: (){
//                               //                   showAlertDialogAddToCart(context);
//                               //                   },
//                               //               ),
//                               //
//                               //
//                               //               SizedBox(width: 10,),
//                               //
//                               //               InkWell(
//                               //                 child:  Image.asset(ic_block_red,height: 35,width: 35,),
//                               //                 onTap: (){
//                               //                   showAlertDialogBlocked(context);
//                               //                 },
//                               //               ),
//                               //
//                               //
//                               //
//                               //
//                               //
//                               //
//                               //             ],
//                               //           ):MaterialButton(
//                               //             elevation: 0,
//                               //
//                               //             padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
//                               //             child: text("Select Lot", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: sh_white),
//                               //             textColor: sh_white,
//                               //
//                               //             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
//                               //             color: sh_colorPrimary,
//                               //             onPressed: () => {
//                               //             showAlertStockDialog(context,listStockPoint,widget.listsearchProducts[index],widget.SelectedQuantity,widget.listsearchProducts[index].category.allowCl,rateTypeDescription,plankSize,in_multipels),
//                               //
//                               //            //   _bottomSheetMore(context,int.parse(widget.SelectedQuantity),widget.listsearchProducts[index],false),
//                               //
//                               //             },
//                               //           ),
//                               //
//                               //         ),
//                               //         SizedBox(width: 10,),
//                               //        true?Container(): Container(
//                               //
//                               //           child:
//                               //           MaterialButton(
//                               //             elevation: 0,
//                               //
//                               //             padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
//                               //             child: text("View In Studio", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: sh_white),
//                               //             textColor: sh_white,
//                               //
//                               //             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
//                               //             color: sh_colorPrimary,
//                               //             onPressed: () => {
//                               //               _launchURLApp(displayNameColor),
//                               //               // ShHomeScreen().launch(context),
//                               //
//                               //
//                               //             },
//                               //           ),
//                               //         ),
//                               //         // InkWell(
//                               //         //   child:  Container(
//                               //         //     padding: EdgeInsets.only(left: 10,right: 10),
//                               //         //     child: Container(
//                               //         //       alignment: Alignment.center,
//                               //         //       child: Text("Select Lot",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),
//                               //         //       ),
//                               //         //     ),
//                               //         //
//                               //         //     decoration: BoxDecoration(
//                               //         //         color: sh_colorPrimary,
//                               //         //         borderRadius: BorderRadius.all(Radius.circular(5.0))
//                               //         //     ),
//                               //         //
//                               //         //   ),
//                               //         //   onTap: (){
//                               //         //
//                               //         //
//                               //         //     _bottomSheetMore(context);
//                               //         //
//                               //         //   },
//                               //         // ),
//                               //
//                               //
//                               //
//                               //         // InkWell(
//                               //         //   child:   Stack(
//                               //         //     children: [
//                               //         //
//                               //         //
//                               //         //       Container(
//                               //         //         padding: EdgeInsets.only(left: 10,right: 10),
//                               //         //
//                               //         //
//                               //         //
//                               //         //
//                               //         //         //width: (width * 0.3)+10,
//                               //         //
//                               //         //         child: Container(
//                               //         //           margin: EdgeInsets.only(left: 15),
//                               //         //
//                               //         //
//                               //         //
//                               //         //           alignment: Alignment.center,
//                               //         //           child: Text("View In Studio",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600,fontSize: 12),
//                               //         //           ),
//                               //         //         ),
//                               //         //
//                               //         //         decoration: BoxDecoration(
//                               //         //             color: sh_colorPrimary,
//                               //         //             borderRadius: BorderRadius.all(Radius.circular(5.0))
//                               //         //         ),
//                               //         //
//                               //         //       ),
//                               //         //       Container(
//                               //         //           alignment: Alignment.centerLeft,
//                               //         //           padding: EdgeInsets.only(left: 5),
//                               //         //           child: Image.asset("images/studio.png",width:15,height:15,fit: BoxFit.fill,)),
//                               //         //
//                               //         //     ],
//                               //         //   ),
//                               //         //   onTap: (){
//                               //         //
//                               //         //   },
//                               //         // ),
//                               //
//                               //
//                               //
//                               //       ],
//                               //     ),
//                               //   ),
//                               //
//                               //
//                               //
//                               //
//                               //
//                               //
//                               //
//                               // ),
//                             ],
//                           ),
//
//
//                           decoration: BoxDecoration(
//
//                             color: sh_itemText_background,
//                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: sh_textColorEelevation,
//                                 spreadRadius: 1,
//                                 blurRadius: 0.5,
//
//                                 offset: Offset(0, 0), //
//
//                                 // shadow direction: bottom right
//                               )
//                             ],
//                           ),
//
//                           // decoration: BoxDecoration(
//                           //   color: sh_itemText_background,
//                           //
//                           //   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                           //   borderRadius: BorderRadius.all(Radius.circular(5)),
//                           // ),
//                         );
//                       }
//                   ):
//                   Container(
//                     child: Text("please wait loading... "),
//                   ),
//                 ),
//                 // Container(
//                 //     margin: EdgeInsets.only(left: 15),
//                 //     alignment: Alignment.centerLeft,
//                 //
//                 //     child:Row(
//                 //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //       children: [
//                 //         MaterialButton(
//                 //           padding: EdgeInsets.all(10),
//                 //           child: text("Generate Catalog", fontSize:textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                 //           textColor: sh_white,
//                 //           shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
//                 //           color: sh_colorPrimary,
//                 //           onPressed: () => {
//                 //
//                 //             setState(() {
//                 //               isVisibleCheckbox=true;
//                 //             })
//                 //             // ShHomeScreen().launch(context),
//                 //             //  DistributorShipingDetails().launch(context),
//                 //
//                 //           },
//                 //         ),
//                 //
//                 //         //InfoIcon
//                 //         Container(
//                 //           margin: EdgeInsets.only(right: 15),
//                 //           child: Row(
//                 //             children:
//                 //             [
//                 //               Visibility(
//                 //                 child:   Container(
//                 //
//                 //                   child: Row(
//                 //                     children: [
//                 //                       Stack(
//                 //                         children: [
//                 //
//                 //                           Container(
//                 //                             margin: EdgeInsets.only(top: 5,left: 2),
//                 //                             width: width*0.4,
//                 //
//                 //                             child: Row(
//                 //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //                               children: [
//                 //                                 Container(),
//                 //                                 Align(
//                 //                                   alignment: Alignment.centerRight,
//                 //                                   child: new RotationTransition(
//                 //                                     turns: new AlwaysStoppedAnimation(50 / 360),
//                 //                                     child: Container(
//                 //
//                 //
//                 //                                       height: 20,
//                 //                                       width: 20,
//                 //                                       padding :EdgeInsets.all(10.0),
//                 //                                       color:sh_textColorSecondarylight,
//                 //                                       //  child: Text("",style:TextStyle(fontSize: 10),)),,
//                 //                                     ),
//                 //                                   ),
//                 //                                 ),
//                 //                               ],
//                 //                             ),
//                 //                           ),
//                 //                           Container(
//                 //
//                 //                               padding :EdgeInsets.all(10.0),
//                 //                               color:sh_textColorSecondarylight,
//                 //                               child: Text("Can Select up to 5 Products",style:TextStyle(fontSize: 10),)),
//                 //
//                 //                         ],
//                 //                       )
//                 //
//                 //
//                 //                     ],
//                 //                   ),
//                 //                 ),
//                 //
//                 //
//                 //
//                 //
//                 //
//                 //                 maintainSize: true,
//                 //                 maintainAnimation: true,
//                 //                 maintainState: true,
//                 //                 visible: isVisibleMessage,
//                 //               ),
//                 //
//                 //               SizedBox(width: 10,),
//                 //               InkWell(
//                 //                 child:   Image.asset(ic_info_icon,height: 15,width: 15,),
//                 //                 onTap: (){
//                 //                   setState(() {
//                 //                     if(isVisibleMessage)
//                 //                     {
//                 //                       isVisibleMessage=false;
//                 //                     }
//                 //                     else
//                 //                     {
//                 //                       isVisibleMessage=true;
//                 //                     }
//                 //
//                 //                   });
//                 //                 },
//                 //               )
//                 //
//                 //             ],
//                 //           ),
//                 //         )
//                 //
//                 //       ],
//                 //     )
//                 //
//                 // ),
//
//                 //Search Text
//
//
//
//
//
//
//               ],
//             ),
//           ),
//         ),
//       ),
//       endDrawer: MyDrwaer(),
//     );
//   }
//
//   showAlertDialog(BuildContext context) {
//     // Create button
//     Widget okButton = FlatButton(
//       child: Text("OK"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//
//     AlertDialog alert = AlertDialog(
//       title: Text("Simple Alert"),
//       content: Text("This is an alert message."),
//       actions: [
//         okButton,
//       ],
//     );
//
//     // showDialog(
//     //   context: context,
//     //   builder: (BuildContext context) {
//     //     return alert;
//     //   },
//     // );
//
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//
//             child: Container(
//               height: 520,
//
//
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   Container(
//                     color: backgroundSearchProductForm,
//
//                     margin: EdgeInsets.only(top: 5),
//
//                     height: 150,
//                     padding: EdgeInsets.all(15),
//                     child:Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           alignment: Alignment.centerLeft,
//
//                           width:100,
//                           height: 30,
//                           child:  TextFormField(
//                             keyboardType: TextInputType.emailAddress,
//                             autofocus: false,
//                             textCapitalization: TextCapitalization.words,
//                             style: TextStyle(
//                                 color: sh_textColorPrimary,
//                                 fontFamily: fontRegular,
//                                 fontSize: textSizeSmall),
//                             decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: backgroundSearchProductFormInput,
//                                 focusColor: sh_editText_background_active,
//                                 hintText: "Quantity",
//                                 hintStyle: TextStyle(
//                                     color: sh_textColorSecondary,
//                                     fontFamily: fontRegular,
//                                     fontSize: textSizeSmall),
//                                 contentPadding:
//                                 EdgeInsets.only(left: 15,right: 15),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius:
//                                     BorderRadius.circular(round_border_form),
//                                     borderSide: BorderSide(
//                                         color: sh_black, width: 0.5)),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderRadius:
//                                     BorderRadius.circular(round_border_form),
//                                     borderSide: BorderSide(
//                                         color: sh_black,
//
//                                         width: 0.5))),
//                           ),
//
//                         ),
//                         Container(
//
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("SATURN", style: TextStyle(color: Colors.black,fontSize: 15),),
//                                   Text("Carpet(4520)",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
//                                 ],
//                               ),
//
//                               Container(
//                                   child: Text("Available")
//                               ),
//                             ],
//
//                           ),
//                         ),
//                         Container(
//                           child:Column(
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.only(left: 0,right: 10),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Text("Unit",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),),
//                                     ),
//                                     Container(
//                                       child: Text("Size",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),),
//                                     ) ,
//                                     Container(
//                                       child: Text("Total",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),),
//                                     )
//
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(left: 0,right: 5,),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Text("Rolls"),
//                                     ),
//                                     Container(
//                                       child: Text("200sqft"),
//                                     ) ,
//                                     Container(
//                                       child: Text("5986"),
//                                     ),
//
//
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//
//
//                   ),
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       margin: EdgeInsets.only(left: 15,top: 15),
//                       child: Text("Select Lot",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)),
//                   Container(
//                     margin: EdgeInsets.only(top: 5),
//                     height: 252,
//                     child:   ListView.builder(
//
//                         scrollDirection: Axis.vertical,
//                         itemCount: 4,
//
//                         shrinkWrap: true,
//
//                         itemBuilder: (context, index) {
//                           return Container(
//                             alignment: Alignment.centerLeft,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//
//
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       child: Checkbox(
//                                         activeColor: sh_colorPrimary,
//
//                                         value: this.value,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             this.value = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(top: 15,),
//                                       child: Row(
//
//                                         children: [
//                                           Text("Batch No. : ",style: TextStyle(fontSize: 12),),
//                                           Text("Adj/jan20/2",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(top: 15,left: 20),
//
//                                       child: Row(
//                                         children: [
//                                           Text("Qty : ",style: TextStyle(fontSize: 12),),
//                                           Text("85 sqft",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
//                                         ],
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(left: 15,right: 15),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Container(
//
//
//
//                                         width :160,
//                                         height: 30,
//                                         child:  TextFormField(
//                                           keyboardType: TextInputType.emailAddress,
//                                           autofocus: false,
//                                           textCapitalization: TextCapitalization.words,
//                                           style: TextStyle(
//                                               color: sh_textColorPrimary,
//                                               fontFamily: fontRegular,
//                                               fontSize: textSizeSmall),
//                                           decoration: InputDecoration(
//                                               filled: true,
//                                               fillColor: backgroundSearchProductFormInput,
//                                               focusColor: sh_editText_background_active,
//                                               hintText: "10",
//                                               hintStyle: TextStyle(
//                                                   color: sh_textColorSecondary,
//                                                   fontFamily: fontRegular,
//                                                   fontSize: textSizeSmall),
//                                               contentPadding:
//                                               EdgeInsets.only(left: 10,right: 10),
//                                               focusedBorder: OutlineInputBorder(
//                                                   borderRadius:
//                                                   BorderRadius.circular(round_border_form),
//                                                   borderSide: BorderSide(
//                                                       color: sh_black, width: 0.5)),
//                                               enabledBorder: OutlineInputBorder(
//                                                   borderRadius:
//                                                   BorderRadius.circular(round_border_form),
//                                                   borderSide: BorderSide(
//                                                       color: sh_black,
//
//                                                       width: 0.5))),
//                                         ),
//
//                                       ),
//                                       SizedBox(width: 5,),
//                                       Image.asset(ic_circular_bucket,height:25,width: 25,),
//                                       SizedBox(width: 5,),
//                                       Image.asset(ic_blockround,height:25,width: 25,),
//                                       SizedBox(width: 5,),
//                                       InkWell(
//                                         onTap: (){
//                                           //showAlertStockDialog(context);
//                                         },
//                                         child:  Image.asset(ic_golden_eye,height:25,width: 25,),
//                                       ),
//
//
//
//
//                                     ],
//
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                           );
//                           // return Chats(mListings[index], index);
//                         }),
//
//
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 5),
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     height: 70,
//
//                     color: sh_colorPrimary,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Total Qty", style: TextStyle(color: sh_white,fontSize: 15),),
//                             Text("40",style: TextStyle(fontSize: 15,color: sh_white,fontWeight: FontWeight.bold),),
//                           ],
//                         ),
//
//                         Container(
//                           child: MaterialButton(
//                             padding: EdgeInsets.all(15),
//                             child: Text("ADD & CLOSE", style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
//                             textColor: sh_colorPrimary,
//                             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                             color: sh_white,
//                             onPressed: () => {
//
//                               //DisApproveOrder().launch(context),
//                               Navigator.pop(context, false),
//
//
//                             },
//                           ),
//                         ),
//                       ],
//
//                     ),
//
//
//                   ),
//
//                 ],
//               ),
//
//
//
//             ),
//           );
//         });
//   }
//
//
//
//
//   bool isOpenViewDetails=false;
//   showAlertStockDialog(BuildContext context, List<StockPoint> listStockPoint,Inventory obj,String SelectedQuantityt,bool isAllowCl,String rateTypedescriptions,String plank,String multilple)
//   {
//
//
//     if(obj.stockPoints.length!=0)
//     {
//       print("Selected Object Value "+obj.id.toString()+"    Name "+obj.stockPoints[0].name.toString()+" Stcok Point ID "+obj.stockPoints[0].id.toString());
//
//     }
//     else
//     {
//       print("Stock Point Data Not Found ");
//     }
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Dialog(
//
//               child: StatefulBuilder(
//
//                 builder: (BuildContext context, setState) {
//
//
//                   return Container(
//                     height: 395,
//                     width:MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.only(top: 20,bottom: 20),
//
//                     child:
//
//
//                     Column(
//                       children: [
//                         Stack(
//                           children: [
//
//
//                             Container(
//                               child:
//
//
//                               Image.asset(ic_stock,height: 50,width: 50, fit: BoxFit.fill,),
//                               alignment: Alignment.topCenter,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(right: 15),
//                               child: InkWell(
//                                 child: Image.asset(ic_cross_dialog,height: 25,width: 25,
//                                   color: sh_colorPrimary,),
//                                 onTap: (){
//                                   Navigator.pop(context, false);
//                                 },
//                               ),
//                               alignment: Alignment.topRight,
//
//                             ),
//                           ],
//                         ),
//
//
//                         Container(
//                           alignment: Alignment.center,
//                           width: MediaQuery.of(context).size.width,
//
//                           height: 40,
//                           child: Text("Stocks Details",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                         ),
//
//
//
//                         Container(
//                           margin: EdgeInsets.only(top: 10,left: 10,right: 10),
//                           height: 200,
//                           child:   ListView.builder(
//
//                               scrollDirection: Axis.vertical,
//                               itemCount: obj.stockPoints.length,//listStockPoint.length,
//                               //itemCount: listStockPoint.length,//listStockPoint.length,
//
//                               shrinkWrap: true,
//
//
//                               itemBuilder: (context, index) {
//
//                                 // double availabeQuantity = listStockPoint[index].inventory;
//                                 // double blockedQuantity =  listStockPoint[index].blocked;
//                                 // var nameStockPoint = listStockPoint[index].name;
//                                 double availabeQuantity =obj.stockPoints[index].inventory;
//                                 double blockedQuantity =  obj.stockPoints[index].blocked;
//                                 var nameStockPoint = obj.stockPoints[index].name;
//
//                                 print("Stcok Point Name in Stock Details   $nameStockPoint");
//
//
//                                 return availabeQuantity.toStringAsFixed(0)=="0"&&blockedQuantity.toStringAsFixed(0)=="0"?Container():Container(
//                                   padding: EdgeInsets.only(left: 5,right: 5,),
//
//                                   child:
//
//                                   GestureDetector(
//
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Stocklist1.contains(index)  ? imgUpstock:imgDownstock,//ischeckstock//Stocklist1.contains(index)
//
//
//                                             Container(
//
//                                               child: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//
//                                                     child: Column(
//                                                       mainAxisAlignment: MainAxisAlignment.start,
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//
//                                                       children: [
//                                                         Text(listStockPoint[index].name.toString()
//                                                           ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//
//                                                       ],
//                                                     ),
//                                                     width: (MediaQuery.of(context).size.width/3)-37,
//                                                     alignment: Alignment.centerLeft,
//                                                   ),
//                                                   SizedBox(height: 5,),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Container(
//                                                         child: Column(
//                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                           crossAxisAlignment: CrossAxisAlignment.start,
//
//                                                           children: [
//                                                             Text("Available",style: TextStyle(color: Colors.black,),),
//                                                             SizedBox(height: 5,),
//                                                             Text(availabeQuantity.truncateToDouble().toStringAsFixed(0)+" Sqft",style: TextStyle(color: Colors.green),)
//                                                           ],
//                                                         ),
//                                                         width: (MediaQuery.of(context).size.width/2)-70,
//                                                         alignment: Alignment.centerLeft,
//                                                       ),
//
//                                                       Container(
//
//                                                         child: Column(
//                                                           mainAxisAlignment: MainAxisAlignment.start,
//                                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                                           children: [
//                                                             Text("Blocked",style: TextStyle(color: Colors.black,),),
//                                                             SizedBox(height: 5,),
//                                                             Text(blockedQuantity.truncateToDouble().toStringAsFixed(0)+" Sqft",style: TextStyle(color: Colors.red),)
//                                                           ],
//                                                         ),
//                                                         width:(MediaQuery.of(context).size.width/2)-70,
//                                                         alignment: Alignment.centerRight,
//
//                                                       ),
//                                                     ],
//                                                   ),
//
//
//                                                 ],
//                                               ),
//                                               margin: EdgeInsets.only(left: 10),
//                                             ),
//                                           ],
//                                         ),
//
//                                         Container(
//                                           margin: EdgeInsets.only(top: 10,bottom: 10),
//                                           height: 1,
//                                           color:sh_textColorVerticleLine,
//                                         ),
//
//                                       ],
//                                     ),//ischeckstock//Stocklist1.contains(index)
//                                     onTap: (){
//                                       setState(() {
//
//                                         if(!Stocklist1.contains(index))
//                                         {
//                                           Stocklist1.clear();
//                                           Stocklist1.add(index);
//                                           selectedStcokindex=listStockPoint[index].id;
//                                           selectedStockSource=listStockPoint[index].source;
//
//
//
//                                         }
//
//                                         // else
//                                         //   {
//                                         //     Stocklist1.clear();
//                                         //     Stocklist1.add(index);
//                                         //     selectedStcokindex=listStockPoint[0].id;
//                                         //   }
//
//                                         print(" SelectedStcokindex    >>>>>>>>>>>>     $selectedStcokindex ");
//                                         print(" SelectedStcok Source  >>>>>>>>>>>>     $selectedStockSource ");
//
//
//
//
//                                         if(ischeckstock)
//                                         {
//                                           ischeckstock=false;
//                                         }
//                                         else
//                                         {
//                                           ischeckstock=true;
//                                           isOpenViewDetails=true;
//
//                                         }
//
//                                         print("Stock Check Box >>>>>>>> $ischeckstock");
//
//
//                                         //  print(img.toString()+"Show1");
//                                       });
//
//                                     },
//                                   ),
//
//
//
//                                 );
//                                 // return Chats(mListings[index], index);
//                               }),
//
//
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 5),
//
//
//
//                           color: sh_white,
//                           child:   Container(
//
//                             child: MaterialButton(
//                               padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
//
//
//                               child: Text("View Details", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
//                               textColor: sh_white,
//                               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                               color: sh_colorPrimary,
//                               onPressed: () => {
//
//                                 ischeckstock,
//                                 print("Is Checked Stock Poinr $ischeckstock"),
//                                 FlagOnSelectedInventory=true,
//                                 if(isOpenViewDetails)
//                                   {
//
//                                     DisSelectedInventory(
//                                         widget.SelectedQuantity,
//                                         obj,
//                                         true,
//                                         widget.SelectedValueForSearch,
//                                         widget.SelectedDealer2,
//                                         widget.spinnerDealerSelectes,selectedStcokindex,isAllowCl,rateTypedescriptions,plank,multilple,selectedStockSource).launch(context),
//
//
//
//
//
//                                     //  _bottomSheetMore(context,int.parse(widget.SelectedQuantity),obj,true,),
//
//                                   }
//                                 else
//                                   {
//                                     showToastDialog(context,"Please Select Stock Point"),
//                                     print("Please Select Any Stock "),
//
//                                   }
//
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
//
//                 },
//               )
//
//
//
//           );
//         }).then((value){
//       print("Methode Call Dialog Stcok Close ");
//       setState(() {
//         Stocklist1.clear();
//         ischeckstock=false;
//         isOpenViewDetails=false;
//       });
//
//     });
//   }
//
//
//   _bottomSheetMore(context, int selectQuantity,Inventory obj,bool isSengleSelected) {
//     showModalBottomSheet(
//
//
//       isScrollControlled: true,
//       context: context,
//
//
//       builder: (BuildContext context) {
//         var isSwitched = true;
//         // bool toggleTextChange=true;
//         var toggleText  = "RL";
//         double totlaQuantitySelected = 0;
//         int finaltotlaQuantitySelected = 0;
//         double onChangedQuantity=0;
//         double newValue=0;
//
//         CartItem cartItemsSelected;
//         List<CartItem> ListCartItemsSelected= [];
//
//         String ratetypeString = "RL";
//         // if(obj.price.allowCl)
//         //   {
//         //     ratetypeString = "CL";
//         //   }
//         // else
//         //   {
//         //     ratetypeString = "RL";
//         //   }
//
//         //Perameters to Add To Cart Api
//         int  productIdSelected=obj.id;
//         String  batchNoSelected;
//         String  orderQuantitySelected;
//         String stockPointCodeSelected;
//         String stockPointSourceSelected;
//         String rateTypeSelected=ratetypeString;
//         double unitPriceSelected=obj.price.unit;
//         double tempUnitPrice=obj.price.unit;
//         double  discountSelected=0;
//         //obj.price.discount;
//         int  onlineDiscountSelected=0;
//         //int  onlineDiscountSelected=obj.price.onlineDiscount;
//
//
//
//
//
//         //To call Methode All Inventory From Api Response
//
//
//
//
//         return BottomSheet(
//           onClosing: () {},
//           builder: (BuildContext context)
//           {
//             bool checkboxvalue = false;
//             Image imgUp =  Image.asset(ic_check,height: 15,width: 15,);
//             Image imgDown =  Image.asset(ic_uncheck,height: 15,width: 15,);
//             /*SvgPicture imgUp =  SvgPicture.asset(ic_svg_check,height: 15,width: 15,);
//             SvgPicture imgDown =  SvgPicture.asset(ic_svg_uncheck,height: 15,width: 15,);*/
//
//             var selectedindex;
//             var list1 = [];
//
//             var lsitToggleSelected=[];
//
//             bool readOnlyText=true;
//
//
//             String dropdownValue1 = 'Approve';
//             List<String> spinnerItems1 = [
//               'Approve',
//               'Reject',
//
//             ];
//             double tempQuantity = 0;
//             double onChangedQuantity=0;
//
//
//
//             return StatefulBuilder(
//                 builder: (BuildContext context, setState)
//                 {
//                   if(isSengleSelected)
//                   {
//
//                     if(FlagOnSelectedInventory)
//                     {
//                       getSelectedInventory(setState,obj,selectedStcokindex);
//                       setState((){
//                         FlagOnSelectedInventory=false;
//                       });
//
//                     }
//                   }
//                   else
//                   {
//                     //    getAllInventory(setState,obj);
//                   }
//
//                   String newQuantitiy;
//                   return
//                     Container(
//
//                       height:MediaQuery.of(context).size.height * 0.65,
//
//
//
//                       width: MediaQuery.of(context).size.width,
//                       child: ListView(
//                         children: [
//                           Container(
//                             color: backgroundSearchProductForm,
//                             padding: EdgeInsets.all(15),
//                             child:Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//
//                                 Row(children: [
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//
//                                     width:(MediaQuery.of(context).size.width/2)-20,
//
//
//                                     child:  TextFormField(
//                                       initialValue: "$selectQuantity",
//                                       keyboardType: TextInputType.emailAddress,
//                                       autofocus: false,
//                                       textCapitalization: TextCapitalization.words,
//
//                                       style: TextStyle(
//                                           color: sh_textColorPrimary,
//                                           fontFamily: fontRegular,
//                                           fontSize: textSizeSMedium),
//
//                                       decoration: InputDecoration(
//                                           filled: true,
//                                           fillColor: backgroundSearchProductFormInput,
//                                           focusColor: sh_editText_background_active,
//                                           hintText: "Quantity",
//
//                                           hintStyle: TextStyle(
//                                               color: sh_textColorSecondary,
//                                               fontFamily: fontRegular,
//                                               fontSize: textSizeSmall),
//                                           contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 15.0),
//                                           //EdgeInsets.only(left: 10,right: 10),
//                                           focusedBorder: OutlineInputBorder(
//                                               borderRadius:
//                                               BorderRadius.circular(round_border_form),
//                                               borderSide: BorderSide(
//                                                   color: sh_black, width: 0.5)),
//                                           enabledBorder: OutlineInputBorder(
//                                               borderRadius:
//                                               BorderRadius.circular(round_border_form),
//                                               borderSide: BorderSide(
//                                                   color: sh_black,
//
//                                                   width: 0.5))),
//                                       onChanged: ((value){
//                                         newQuantitiy=value;
//                                       }),
//                                     ),
//
//                                   ),
//                                   SizedBox(width: 10,),
//                                   Container(
//
//                                     width: (MediaQuery.of(context).size.width/2)-20,
//                                     child:  MaterialButton(
//                                       child: Container(
//                                           padding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
//                                           alignment: Alignment.center,
//                                           child: text("Update", fontSize: textSizeMedium, fontFamily: fontMedium, textColor: Colors.white)),
//                                       textColor: sh_white,
//                                       shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                       color: sh_colorPrimary,
//                                       onPressed: () => {
//                                         setState((){
//                                           widget.SelectedQuantity=newQuantitiy;
//                                         })
//                                         //  SearchProductResult().launch(context),
//
//                                       },
//                                       elevation: 0,
//                                     ),
//
//                                   ),
//                                 ],),
//                                 SizedBox(height: 10,),
//
//                                 Container(
//
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(obj.collection.displayName==null?"":obj.collection.displayName, style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
//                                           Text(obj.category.displayName.toString()+"("+obj.colour.displayName+")",style: TextStyle(fontSize: 15,color: Colors.black,),),
//                                         ],
//                                       ),
//
//                                       Container(
//                                           child: Text("Available",style: TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),)
//                                       ),
//                                     ],
//
//                                   ),
//                                 ),
//                                 SizedBox(height: 10,),
//                                 Container(
//                                   child:Column(
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.only(left: 0,right: 10),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//
//                                             Column(
//                                               children: [
//                                                 Container(
//                                                   child: Text("Price",style:  TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
//                                                 ) ,
//                                                 SizedBox(height: 5,),
//                                                 Container(
//                                                   child: Text(unitPriceSelected.toString()+"".toCurrencyFormat(),style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
//                                                 ) ,
//                                               ],
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                             ),
//
//
//                                             Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
//                                             Column(
//                                               children: [
//                                                 Container(
//                                                   child: Text("Block",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
//                                                 ),
//                                                 SizedBox(height: 5,),
//                                                 Container(
//                                                   child: Text(obj.blocked.toStringAsFixed(0)+"sqft",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
//                                                 ),
//                                               ],
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                             ),
//                                             Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
//                                             Column(
//                                               children: [
//                                                 Container(
//                                                   child: Text("Stock",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
//                                                 ),
//                                                 SizedBox(height: 5,),
//                                                 Container(
//                                                   child: Text(obj.inventory.toStringAsFixed(0)+"sqft",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
//                                                 ),
//                                               ],
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                             ),
//
//
//
//
//                                           ],
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//
//                           ),
//                           Container(
//                               alignment: Alignment.centerLeft,
//                               margin: EdgeInsets.only(left: 15,top: 15),
//                               child: Text("Select Lot ($SelectedDeopName)",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)),
//                           Container(
//
//
//
//                             child:  lotInventory==null?Container(
//                               margin:  EdgeInsets.only(left: 15,top: 15),
//                               child: Text("Inventory Loading ..."),
//                             ): ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 scrollDirection: Axis.vertical,
//                                 itemCount: lotInventory.length,
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   String batchNo="";
//                                   double lotQuantity=0;
//                                   bool toggleTextChange=true;
//
//                                   batchNo = lotInventory[index].lotNo;
//                                   lotQuantity = lotInventory[index].remainingQuantity;
//                                   var  ShowlotQuantity = lotInventory[index].remainingQuantity.toStringAsFixed(0);
//
//
//
//
//
//                                   // to Stroe on Changed in a Input Filed treat as total quantiy
//
//
//                                   return Container(
//                                     alignment: Alignment.centerLeft,
//                                     padding: EdgeInsets.only(left: 15,right: 15),
//                                     margin: EdgeInsets.only(top: 10,bottom: 10),
//                                     child:Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//
//
//                                         InkWell(
//                                           child:Row(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             children: [
//                                               Container(
//
//
//                                                 child:list1.contains(index) ? imgUp:imgDown,
//
//
//                                               ),
//                                               //Batch No //Quantityt
//                                               Container(
//
//                                                 child: Column(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     Container(
//                                                       child: Row(
//                                                         mainAxisAlignment: MainAxisAlignment.start,
//                                                         children: [
//
//                                                           Container(
//
//                                                             child: Row(
//                                                               children: [
//                                                                 Text("Batch No : ",style: TextStyle(fontSize: 14),),
//                                                                 Text("$batchNo",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 5,),
//                                                     Container(
//
//                                                       child: Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Container(
//
//
//                                                             child: Row(
//                                                               mainAxisAlignment: MainAxisAlignment.start,
//                                                               children: [
//                                                                 Container(
//                                                                     child:Text(lsitToggleSelected.contains(index)?"CL":"RL",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
//                                                                 ),
//
//                                                                 Container(
//                                                                     height: 20,
//                                                                     width: 50,
//                                                                     child:    Switch(
//
//                                                                       onChanged:list1.contains(index)?
//                                                                           (value){
//                                                                         setState(() {
//                                                                           isSwitched=value;
//                                                                           if(value)
//                                                                           {
//                                                                             toggleText="RL";
//
//                                                                             // unitPriceSelected=tempUnitPrice;
//                                                                             toggleTextChange=true;
//                                                                             lsitToggleSelected.add(index);
//                                                                           }
//                                                                           else{
//                                                                             toggleText="CL";
//                                                                             unitPriceSelected;
//                                                                             // unitPriceSelected=unitPriceSelected+ ((unitPriceSelected*12)/100);
//
//                                                                             // print("Cutlength Price is  $unitPriceSelected ");
//
//                                                                             toggleTextChange=false;
//                                                                             lsitToggleSelected.remove(index);
//
//
//                                                                           }
//
//                                                                         });
//                                                                       }:null,
//                                                                       value: lsitToggleSelected.contains(index),
//                                                                       activeColor: sh_track_green,
//                                                                       activeTrackColor: sh_more_infoHeading_background,
//                                                                       inactiveThumbColor: sh_track_yellow,
//                                                                       inactiveTrackColor: sh_more_infoHeading_background,
//                                                                     )
//                                                                 ),
//                                                                 Text("Qty : ",style: TextStyle(fontSize: 14),),
//                                                                 Text("$ShowlotQuantity",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//                                                               ],
//                                                             ),
//                                                           ),
//
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 margin: EdgeInsets.only(left: 10),
//                                               ),
//                                             ],
//                                           ),
//                                           onTap: ()
//                                           {
//                                             setState((){
//                                               selectedindex=index;
//                                               if(list1.contains(index))
//                                               {
//                                                 list1.remove(index);
//                                                 ListCartItemsSelected.removeAt(index);
//
//
//
//                                                 //finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.toStringAsFixed(0))-int.parse(lotQuantity.toStringAsFixed(0)));
//                                                 print("Delete  Total Lot Quantitiy  $lotQuantity");
//
//                                                 print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");
//
//
//                                                 finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.toStringAsFixed(0))-int.parse(lotQuantity.toStringAsFixed(0));
//                                                 print("Delete  Total Lot Quantitiy  $lotQuantity");
//
//                                                 print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");
//                                                 tempQuantity=0;
//
//
//                                                 //Logic To Remove  Cart Items in List
//
//                                               }
//                                               else
//                                               {
//
//
//
//                                                 list1.add(index);
//                                                 finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.toStringAsFixed(0))+int.parse(lotQuantity.toStringAsFixed(0));
//                                                 print("Add  Total Lot Quantitiy  $lotQuantity");
//
//
//                                                 print("Temporary Add  Total Lot Quantitiy  $tempQuantity");
//
//
//                                                 //Logic To Add Cart Items in List
//
//                                                 batchNoSelected=lotInventory[index].lotNo;
//                                                 orderQuantitySelected="$finaltotlaQuantitySelected";
//                                                 stockPointCodeSelected=lotInventory[index].locationCode;
//                                                 stockPointSourceSelected=lotInventory[index].locationSource;
//
//
//                                                 cartItemsSelected  = CartItem(
//                                                     productId:productIdSelected,
//                                                     batchNo:batchNoSelected,
//                                                     orderQuantity:orderQuantitySelected,
//                                                     stockPointCode:stockPointCodeSelected,
//                                                     stockPointSource:stockPointSourceSelected,
//                                                     rateType:rateTypeSelected,
//                                                     unitPrice:unitPriceSelected,
//                                                     discount:discountSelected,
//                                                     onlineDiscount:onlineDiscountSelected);
//
//
//
//
//                                                 if(finaltotlaQuantitySelected==0)
//                                                 {
//                                                   print("0>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Please enter Quantity");
//                                                   showToastDialog(context, "Please enter Quantity");
//                                                 }
//                                                 else
//                                                 {
//                                                   ListCartItemsSelected.add(cartItemsSelected);
//                                                 }
//
//                                               }
//                                             });
//
//                                           },
//                                         ),
//
//
//                                         //TextField
//                                         Container(
//                                           width :60,
//                                           height: 30,
//                                           child:  TextFormField(
//                                             initialValue:lsitToggleSelected.contains(index)?"":lotQuantity.toStringAsFixed(0),
//                                             keyboardType: TextInputType.emailAddress,
//                                             autofocus: false,
//                                             readOnly: !lsitToggleSelected.contains(index),
//                                             textCapitalization: TextCapitalization.words,
//                                             style: TextStyle(
//                                                 color: sh_textColorPrimary,
//                                                 fontFamily: fontRegular,
//                                                 fontSize: textSizeSmall),
//
//                                             decoration: InputDecoration(
//                                                 filled: true,
//                                                 fillColor: backgroundSearchProductFormInput,
//                                                 focusColor: sh_editText_background_active,
//                                                 hintText: "0",
//                                                 hintStyle: TextStyle(
//                                                     color: sh_textColorSecondary,
//                                                     fontFamily: fontRegular,
//                                                     fontSize: textSizeSmall),
//                                                 contentPadding:
//                                                 EdgeInsets.only(left: 12,right: 10),
//                                                 focusedBorder: OutlineInputBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(round_border_form),
//                                                     borderSide: BorderSide(
//                                                         color: sh_black, width: 0.5)),
//                                                 enabledBorder: OutlineInputBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(round_border_form),
//                                                     borderSide: BorderSide(
//                                                         color: sh_black,
//
//                                                         width: 0.5))),
//                                             onChanged: (total)
//                                             {
//
//                                             },
//                                           ),
//
//                                         ),
//
//
//
//
//                                       ],
//                                     ),
//                                   );
//                                   // return Chats(mListings[index], index);
//                                 }),
//
//
//                           ),
//
//
//                           Container(
//                             margin: EdgeInsets.only(top: 5),
//                             padding: EdgeInsets.symmetric(horizontal: 8),
//                             height: 70,
//
//                             color: sh_colorPrimary,
//                             child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children:[
//                                   Container(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         // Text("Total Qty", style: TextStyle(color: sh_white,fontSize: 15),),
//                                         //  Text((finaltotlaQuantitySelected).toStringAsFixed(0),style: TextStyle(fontSize: 15,color: sh_white,fontWeight: FontWeight.bold),),
//                                       ],
//                                     ),
//                                   ),
//
//                                   Container(
//
//
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//
//
//
//                                         Container(
//                                           width:(MediaQuery.of(context).size.width/3)-8,
//                                           margin: EdgeInsets.only(left: 0),
//                                           child: MaterialButton(
//
//                                             padding:  EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
//                                             child: Text("ADD",  style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
//                                             textColor: sh_colorPrimary,
//                                             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                                             color: sh_white,
//                                             onPressed: () => {
//
//                                               if(ListCartItemsSelected.isNotEmpty)
//                                                 {
//                                                   FlagCartItems=true,
//                                                   showAlertDialogAddToCartSearchResult(context,ListCartItemsSelected,setState,obj),
//                                                   // AddToCartItems(ListCartItemsSelected),
//
//                                                 }
//                                               else
//                                                 {
//                                                   //Show Dialog To
//                                                   print("Please select Batch"),
//                                                 },
//
//
//
//
//
//                                             },
//
//                                           ),
//                                         ),
//                                         SizedBox(width: 4,),
//                                         Container(
//                                           width:(MediaQuery.of(context).size.width/3)-8,
//                                           margin: EdgeInsets.only(left: 0),
//                                           child: MaterialButton(
//
//                                             padding:  EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
//                                             child: Text("Block",  style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
//                                             textColor: sh_colorPrimary,
//                                             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                                             color: sh_white,
//                                             onPressed: () => {
//
//                                               if(ListCartItemsSelected.isNotEmpty)
//                                                 {
//                                                   // showAlertDialogBlocked(context),
//                                                   //  BlockToCartItems(ListCartItemsSelected,setState),
//                                                   FlagBlockItems=true,
//                                                   showAlertDialogBlockToCartSearchResult(context,ListCartItemsSelected)
//
//                                                 }
//                                               else
//                                                 {
//                                                   //Show Dialog To
//                                                   print("Please select Batch"),
//                                                 },
//
//
//                                             },
//
//                                           ),
//                                         ),
//                                         // Container(
//                                         //   width:(MediaQuery.of(context).size.width/3)-8,
//                                         //   margin: EdgeInsets.only(left: 0),
//                                         //   child: MaterialButton(
//                                         //
//                                         //     padding:  EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
//                                         //     child: Text("Next",  style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
//                                         //     textColor: sh_colorPrimary,
//                                         //     shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                                         //     color: sh_white,
//                                         //     onPressed: () => {
//                                         //
//                                         //       showAlertBlock(context),
//                                         //
//                                         //     },
//                                         //
//                                         //   ),
//                                         // ),
//
//
//                                       ],
//
//                                     ),
//                                   ),
//                                 ]
//                             ),
//
//
//
//
//                           ),
//
//                         ],
//                       ),
//
//
//
//                     );
//                 }
//
//             );
//           },
//         );
//       },
//
//
//
//
//     );
//   }
//
//
//   showAlertBlock(BuildContext context) {
//     // Create button
//     Widget okButton = FlatButton(
//       child: Text("OK"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//
//     AlertDialog alert = AlertDialog(
//       title: Text("Simple Alert"),
//       content: Text("This is an alert message."),
//       actions: [
//         okButton,
//       ],
//     );
//
//
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//
//             child: Container(
//               height: 280,
//               padding: EdgeInsets.only(top: 15),
//
//
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 children: [
//                   SizedBox(height: 10,),
//                   Container(
//                     child:Image.asset(ic_dealer,height: 50,width: 50, fit: BoxFit.fill,),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     width: MediaQuery.of(context).size.width,
//
//                     height: 40,
//                     child: Text("Select Dealer",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                   ),
//
//                   Container(
//                     width: 225,
//                     margin: EdgeInsets.only(top: 20,),
//                     padding: EdgeInsets.only(left: 15,right: 15),
//                     child: new DropdownButton<String>(
//                       value: dropdownValue4,
//                       hint: new Text("Select Here"),
//                       isExpanded: true,
//                       icon: Icon(
//                         Icons.arrow_drop_down,
//                         color:
//                         backgroundSearchProductFormButtons,
//                         size: 25,
//                       ),
//                       iconSize: 24,
//                       elevation: 16,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                       ),
//                       underline: Container(
//                         height: 2,
//                       ),
//                       onChanged: (String value) {
//                         setState(() {
//                           dropdownValue4 = value;
//                         });
//                       },
//                       items: spinnerItems4
//                           .map<DropdownMenuItem<String>>(
//                               (String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: text(value,
//                                   fontSize: textSizeSmall,
//                                   fontFamily: fontRegular,
//                                   textColor: sh_colorPrimary),
//                             );
//                           }).toList(),
//                     ),
//                     decoration: BoxDecoration(
//
//                       border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                       borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 25,right: 25,top: 15),
//
//
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(),
//                         Container(
//
//
//                           child: MaterialButton(
//                             padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
//                             child: Text("Next", style: TextStyle(fontSize: textSizeSMedium,),),
//                             textColor: sh_white,
//                             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
//                             color: sh_colorPrimary,
//                             onPressed: () => {
//
//                               //DisApproveOrder().launch(context),
//                               Navigator.pop(context, false),
//
//
//                             },
//                           ),
//                         ),
//                         Container(),
//
//                       ],
//                     ),
//
//                   ),
//
//
//                 ],
//               ),
//
//
//
//
//             ),
//           );
//         });
//   }
//
//
//
//   showAlertDialogAddToCartSearchResult(BuildContext context, List<CartItem> ListCartItemsSelected,StateSetter updateState_bottom,Inventory obj) {
//     // Create button
//
//
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return  Dialog(
//
//               child: StatefulBuilder(
//
//
//                 builder: (BuildContext context, setState)
//                 {
//                   //Methode Call to Add To Cart
//                   if(FlagCartItems)
//                   {
//                     AddToCartItems(ListCartItemsSelected,setState).then((value) {
//
//                       if(value==200)
//                       {
//                         updateState_bottom((){
//                           FlagCartItems=false;
//
//                         });
//
//
//                       }
//                       else
//                       {
//                         updateState_bottom((){
//                           FlagCartItems=false;
//                         });
//
//                       }
//
//                     });
//
//                   }
//
//                   return Container(
//                     height: 250,
//                     width:MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.only(top: 20,bottom: 20),
//
//                     child:Container(
//
//
//                         color: Colors.white,
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               children: [
//
//
//                                 Container(
//                                   child:
//
//
//                                   Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
//                                   alignment: Alignment.topCenter,
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(right: 15),
//                                   child: InkWell(
//                                     child: Image.asset(ic_cross_dialog,height: 25,width: 25,
//                                       color: sh_colorPrimary,),
//                                     onTap: (){
//                                       Navigator.pop(context, false);
//                                       Navigator.pop(context, false);
//                                     },
//                                   ),
//                                   alignment: Alignment.topRight,
//
//                                 ),
//                               ],
//                             ),
//                             // Stack(
//                             //   children: [
//                             //     Container(
//                             //       alignment: Alignment.centerLeft,
//                             //       child:Image.asset(ic_notice_addtocart,height: 50,width: 50, fit: BoxFit.fill,),
//                             //     ),
//                             //     Container(
//                             //       alignment: Alignment.center,
//                             //       child:Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
//                             //     ),
//                             //   ],
//                             // ),
//
//                             Container(
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width,
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//
//
//                               child: isValueAddedtoCart?Text("Items added successfully",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),):
//                               Text("Please wait, while we add your items to the cart",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//
//                               child:isValueAddedtoCart? IntrinsicWidth(
//                                 child:MaterialButton(
//
//                                   padding: EdgeInsets.only(left: 15,right: 15,top: 13,bottom: 13),
//                                   child: text("Go To Cart", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                                   textColor: Colors.white,
//                                   shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                   color: backgroundSearchProductFormButtons,
//                                   onPressed: () async {
//
//                                     print("Send Selected Value For Cart Page "+widget.SelectedValueForSearch);
//                                     //                                                    SearchProductResult(value,SelectedAutoSuggestStirng,spinnerDealerSelectes,SelectedQuantity,this.SingleSelectedCategory,SelectedDealer2,SelectedMinPrice,SelectedmaxPrice,SelectedValue,spinnerDelerList,spinnerSelectDealer2).launch(context);
//                                     Navigator.pop(context, false);
//                                     Navigator.pop(context);
//                                     await Navigator.of(context)
//                                         .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder(SelectedDealer2:widget.SelectedDealer2,spinnerDealerSelectes:widget.spinnerDealerSelectes,SelectedValueForSearch:widget.SelectedValueForSearch)));
//                                     setState((){});
//
//                                   },
//                                   // onPressed: () => {
//                                   //  // Navigator.pop(context),
//                                   //   SelectProductPlaceOrder().launch(context),
//                                   // },
//                                   elevation: 0,
//                                 ),
//                               ):Container(),
//                             ),
//
//                           ],
//                         )),
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
//
//
//
//         }).then((Exit){
//
//       setState(() {
//
//
//         isValueAddedtoCart=false;
//         print(">>>>>>>>>>>>>>>>>>>>>>>Variable isValueAddedtoCart Update $isValueAddedtoCart");
//
//
//
//       });
//
//       updateState_bottom((){
//         // lotInventory.clear();
//         // int lotInventoryLength =     lotInventory.length;
//         // print("Lot Inventory Length After close Dialog $lotInventoryLength");
//         // getSelectedInventory(updateState_bottom,obj,selectedStcokindex);
//         // list1.clear();
//
//
//       });
//
//     });
//   }
//   showAlertDialogBlockToCartSearchResult(BuildContext context, List<CartItem> ListCartItemsSelected) {
//     // Create button
//
//
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return  Dialog(
//
//               child: StatefulBuilder(
//
//
//                 builder: (BuildContext context, setState) {
//                   //Methode Call to Add To Cart
//                   if(FlagBlockItems){
//                     print("Flag Block Up");
//                     BlockToCartItems(ListCartItemsSelected,setState).then((value){
//                       if(value==200)
//                       {
//                         FlagBlockItems=false;
//                       }
//                       else
//                       {
//                         FlagBlockItems=false;
//                       }
//                     });
//
//                   }
//                   else{
//                     print("Flag Block Down");
//                   }
//
//                   return Container(
//                     height: 250,
//                     width:MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.only(top: 20,bottom: 20),
//
//                     child:Container(
//
//
//                         color: Colors.white,
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               children: [
//
//
//                                 Container(
//                                   child:
//
//
//                                   Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
//                                   alignment: Alignment.topCenter,
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(right: 15),
//                                   child: InkWell(
//                                     child: Image.asset(ic_cross_dialog,height: 25,width: 25,
//                                       color: sh_colorPrimary,),
//                                     onTap: (){
//                                       Navigator.pop(context, false);
//
//                                     },
//                                   ),
//                                   alignment: Alignment.topRight,
//
//                                 ),
//                               ],
//                             ),
//                             // Stack(
//                             //   children: [
//                             //     Container(
//                             //       alignment: Alignment.centerLeft,
//                             //       child:Image.asset(ic_notice_addtocart,height: 50,width: 50, fit: BoxFit.fill,),
//                             //     ),
//                             //     Container(
//                             //       alignment: Alignment.center,
//                             //       child:Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
//                             //     ),
//                             //   ],
//                             // ),
//
//                             Container(
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width,
//
//
//                               child: isValueBlockedtoCart?Text("Item added to Blocked List successfully. ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),):
//                               Text("Your items are being added in BLOCKED List",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//
//                               child:isValueBlockedtoCart? IntrinsicWidth(
//                                 child:MaterialButton(
//
//                                   padding: EdgeInsets.only(left: 15,right: 15,top: 13,bottom: 13),
//                                   child: text("Go To Cart", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                                   textColor: Colors.white,
//                                   shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                   color: backgroundSearchProductFormButtons,
//                                   onPressed: () async {
//                                     Navigator.pop(context, false);
//                                     Navigator.pop(context);
//                                     await Navigator.of(context)
//                                         .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder(SelectedDealer2:widget.SelectedDealer2,spinnerDealerSelectes:widget.spinnerDealerSelectes,SelectedValueForSearch:widget.SelectedValueForSearch)));
//                                     setState((){});
//
//                                   },
//                                   // onPressed: () => {
//                                   //  // Navigator.pop(context),
//                                   //   SelectProductPlaceOrder().launch(context),
//                                   // },
//                                   elevation: 0,
//                                 ),
//                               ):Container(),
//                             ),
//
//                           ],
//                         )),
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
//
//
//
//         }).then((Exit) {
//
//
//       setState(() {
//         isValueBlockedtoCart=false;
//         print(">>>>>>>>>>>>>>>>>>>>>>>Variable isValueBlockedtoCart Update $isValueBlockedtoCart");
//       });
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
//
// // Custom Alert Dialog
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
//                               padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
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
//   showToastDialogPdf(BuildContext context,String Message)
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
//                               child: Text("Colse", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
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
//
//   showProgressDialog(BuildContext context)
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
//                     height: 311,
//
//                     width:MediaQuery.of(context).size.width,
//                     color: sh_white,
//                     padding: EdgeInsets.only(top: 20,bottom: 20),
//
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Stack(
//                           children: [
//
//
//                             Container(
//                               child:
//
//
//                               Image.asset(ic_form_preloader_gif,height: 100,width: 100, fit: BoxFit.fill,),
//                               alignment: Alignment.topCenter,
//                             ),
//
//                           ],
//                         ),
//
//
//                         Container(
//                           alignment: Alignment.center,
//                           width: MediaQuery.of(context).size.width,
//
//                           height: 40,
//                           child: Text("Search Product...",style: TextStyle(color: sh_black,fontSize: 18,fontWeight: FontWeight.bold),),
//                         ),
//
//                         Container(
//                             alignment: Alignment.center,
//                             margin: EdgeInsets.symmetric(horizontal: 15),
//
//
//                             child:Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(),
//                                 Text("Please wait while we load your search",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
//                                 Container(),
//                               ],
//
//                             )
//
//                         ),
//
//                         Container(
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.symmetric(horizontal: 15),
//
//
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(),
//                               Text("results",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
//                               Container(),
//                             ],
//
//                           ),
//                         ),
//                         // Container(
//                         //   alignment: Alignment.center,
//                         //   width: MediaQuery.of(context).size.width,
//                         //
//                         //
//                         //   child: Text("Check your Internet connection",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
//                         // ),
//
//
//                         Container(
//                           margin: EdgeInsets.only(top: 5),
//
//
//
//                           color: sh_white,
//                           child:   Container(
//                             color: sh_no_internet_background,
//
//                             child: MaterialButton(
//                               padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
//
//
//                               child: Text("close", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
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
//
//   String openFullPath="";
//   showAlertDialogPDF(BuildContext context, StateSetter updateState_bottom,String displayNameColor) {
//     // Create button
//
//
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return  Dialog(
//
//               child: StatefulBuilder(
//
//
//                 builder: (BuildContext context, setState)
//                 {
//                   //Methode Call to Add To Cart
//
//                   bool isProgress= false;
//
//
//                   if(singlePdfCall)
//                   {
//                     print("Flag of Single Pdf is  >>>>>>>>>>>>>>>>>>>>>>>>> $getPdfLinkresult");
//
//                     getPdfLink(displayNameColor).then((value) async {
//
//                       print("Response code pdf Api is "+value.toString());
//                       if(value==true)
//                       {
//                         if(getPdfLinkresult)
//                         {
//                           updateState_bottom((){
//                             singlePdfCall=false;
//                           });
//
//
//
//                           ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                           String path =  await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
//                           var time = DateTime.now().microsecondsSinceEpoch;
//
//                           String fullPath = "$path/$time.pdf";
//
//                           print("External Storage Path >>>>>>>>>>>>>>>>>$fullPath");
//
//
//
//                           // //Create App name Folder
//                           // final folderName="RosettaDoc";
//                           // final path2= Directory("$path/$folderName");
//                           // if ((await path2.exists())){
//                           //
//                           //   print("exist RosettaDoc >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//                           // }else{
//                           //
//                           //   print("not exist RosettaDoc >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//                           //   path2.create().onError((error, stackTrace){
//                           //
//                           //     print("File Create Issues >>>>>>>>>>>>>>>>>>>>  $error");
//                           //   });
//                           // }
//
//
//
//
//
//
//
//                           updateState_bottom((){
//                             openFullPath=fullPath;
//                           });
//
//
//
//
//                           download2(dio, imgUrl, fullPath,setState).then((value){
//
//                             //print("Result of Download Pdf Is "+value.toString());
//
//
//
//                           });
//
//
//
//
//
//
//
//
//                         }
//                         else
//                         {
//                           updateState_bottom((){
//                             singlePdfCall=false;
//
//                           });
//                         }
//
//
//
//
//
//
//
//                       }
//                     });
//
//
//                   }
//
//
//
//                   return Container(
//                     height: 250,
//                     width:MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.only(top: 20,bottom: 20),
//
//                     child:Container(
//
//
//                         color: Colors.white,
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               children: [
//
//
//                                 Container(
//                                   child:
//
//
//                                   isSinglePDFDownload?Image.asset(ic_greencheck,height: 80,width: 80, fit: BoxFit.fill,):Image.asset(ic_form_preloader_gif,height: 100,width: 100, fit: BoxFit.fill,),
//                                   alignment: Alignment.topCenter,
//                                 ),
//
//                               ],
//                             ),
//
//                             Container(
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width,
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//
//
//
//                               child:  Column(
//                                 children: [
//                                   isSinglePDFDownload?  Text("Successfully Pdf Download ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),)
//                                       :Text("Please wait, while we download your PDF ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                   // Row(
//                                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   //   children: [
//                                   //     Container(),
//                                   //     Text(" Success Fully Download pdf .....$downloadPercontage",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                   //     Container(),
//                                   //   ],
//                                   // ),
//                                   //isSinglePDFDownload
//                                   isSinglePDFDownload? Container(
//                                     alignment: Alignment.center,
//
//                                     child: IntrinsicWidth(
//                                       child:MaterialButton(
//
//                                         padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
//                                         child: text("View", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                                         textColor: Colors.white,
//                                         shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                         color: backgroundSearchProductFormButtons,
//                                         onPressed: () async {
//
//                                           // print("Send Selected Value For Cart Page "+widget.SelectedValueForSearch);
//                                           //                                                    SearchProductResult(value,SelectedAutoSuggestStirng,spinnerDealerSelectes,SelectedQuantity,this.SingleSelectedCategory,SelectedDealer2,SelectedMinPrice,SelectedmaxPrice,SelectedValue,spinnerDelerList,spinnerSelectDealer2).launch(context);
//                                           // Navigator.pop(context, false);
//                                           Navigator.pop(context);
//                                           openFile(openFullPath);
//
//
//
//                                         },
//                                         // onPressed: () => {
//                                         //  // Navigator.pop(context),
//                                         //   SelectProductPlaceOrder().launch(context),
//                                         // },
//                                         elevation: 0,
//                                       ),
//
//                                     ),
//                                   ):Container(),
//                                 ],
//                               ),
//                             ),
//
//
//                           ],
//                         )),
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
//
//
//
//         }).then((Exit){
//
//       setState(() {
//         if(getPdfLinkresult)
//         {
//           //openFile(openFullPath);
//
//         }
//
//
//         print(">>>>>>>>>>>>>>>>>>>>>>>>>>Pdf Download Success Fully ");
//         //showToastDialogPdf(context, "Pdf Downloaded  SuccessFully ");
//
//
//
//
//
//
//
//
//       });
//
//       updateState_bottom((){
//         // lotInventory.clear();
//         // int lotInventoryLength =     lotInventory.length;
//         // print("Lot Inventory Length After close Dialog $lotInventoryLength");
//         // getSelectedInventory(updateState_bottom,obj,selectedStcokindex);
//         // list1.clear();
//
//
//       });
//
//     });
//   }
//   showAlertDialogCollectivePDF(BuildContext context, StateSetter updateState_bottom,String displayNameColor) {
//     // Create button
//
//
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return  Dialog(
//
//               child: StatefulBuilder(
//
//
//                 builder: (BuildContext context, setState)
//                 {
//                   //Methode Call to Add To Cart
//                   String fullPath;
//
//                   if(collectivePdfCall)
//                   {
//                     print("true Value of collectivePdfCall  $collectivePdfCall");
//
//                     print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Call PDf Methode ");
//                     getCollectivePdfLink(displayNameColor).then((value) async
//                     {
//
//
//                       print("Response code pdf Api is ");
//                       if(value==200)
//                       {
//                         ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                         updateState_bottom((){
//                           collectivePdfCall=false ;
//                         });
//
//
//                         String path =  await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
//                         String name ="Collective";
//                         var time = DateTime.now().microsecondsSinceEpoch;
//                         fullPath = "$path/"+name+"$time.pdf";
//                         // String fullPath = "$path/$displayNameColor.pdf";
//
//                         print("External Storage Path >>>>>>>>>>>>>>>>>$fullPath");
//                         updateState_bottom((){
//                           openFullPath=fullPath;
//                         });
//
//                         //download2(dio, pdfCollectiveUrl, fullPath,updateState_bottom)
//                         download2(dio, pdfCollectiveUrl, fullPath,setState).then((value){
//
//                           print("Result of Download Collective  Pdf Is "+value);
//
//                           if(value==100)
//                           {
//
//                           }
//
//                         });
//
//
//
//                       }
//                       else
//                       {
//                         updateState_bottom((){
//                           collectivePdfCall=false ;
//                         });
//                       }
//                     });
//
//
//                   }
//                   else
//                   {
//
//                     print("false Value of collectivePdfCall  $collectivePdfCall");
//                   }
//
//
//
//
//
//                   return Container(
//                     height: 250,
//                     width:MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.only(top: 20,bottom: 20),
//
//                     child:Container(
//
//
//                         color: Colors.white,
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               children: [
//
//
//                                 Container(
//                                   child:
//
//
//                                   isSinglePDFDownload? Image.asset(ic_greencheck,height: 80,width: 80, fit: BoxFit.fill,):  Image.asset(ic_form_preloader_gif,height: 100,width: 100, fit: BoxFit.fill,),
//                                   alignment: Alignment.topCenter,
//                                 ),
//
//                               ],
//                             ),
//
//                             Container(
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width,
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//
//
//
//                               child:  Column(
//                                 children: [
//                                   isSinglePDFDownload?  Text("Successfully Pdf Download ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),)
//                                       :Text("Please wait, while we download your PDF ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                   // Row(
//                                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   //   children: [
//                                   //     Container(),
//                                   //     Text(" Success Fully Download pdf .....$downloadPercontage",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                   //     Container(),
//                                   //   ],
//                                   // ),
//
//                                   isSinglePDFDownload? Container(
//                                     alignment: Alignment.center,
//
//                                     child: IntrinsicWidth(
//                                       child:MaterialButton(
//
//                                         padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
//                                         child: text("View", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                                         textColor: Colors.white,
//                                         shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                         color: backgroundSearchProductFormButtons,
//                                         onPressed: () async {
//
//                                           // print("Send Selected Value For Cart Page "+widget.SelectedValueForSearch);
//                                           //                                                    SearchProductResult(value,SelectedAutoSuggestStirng,spinnerDealerSelectes,SelectedQuantity,this.SingleSelectedCategory,SelectedDealer2,SelectedMinPrice,SelectedmaxPrice,SelectedValue,spinnerDelerList,spinnerSelectDealer2).launch(context);
//                                           // Navigator.pop(context, false);
//                                           Navigator.pop(context);
//                                           openFile(openFullPath);
//
//
//
//                                         },
//                                         // onPressed: () => {
//                                         //  // Navigator.pop(context),
//                                         //   SelectProductPlaceOrder().launch(context),
//                                         // },
//                                         elevation: 0,
//                                       ),
//
//                                     ),
//                                   ):Container(),
//
//                                 ],
//                               ),
//                             ),
//
//
//                           ],
//                         )),
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
//
//
//
//         }).then((Exit){
//
//       setState(() {
//         // showToastDialogPdf(context, "Pdf Downloaded  SuccessFully ");
//
//         // isValueAddedtoCart=false;
//         // print(">>>>>>>>>>>>>>>>>>>>>>>Variable isValueAddedtoCart Update $isValueAddedtoCart");
//         // openFile(openFullPath);
//
//
//
//       });
//
//       updateState_bottom((){
//         // lotInventory.clear();
//         // int lotInventoryLength =     lotInventory.length;
//         // print("Lot Inventory Length After close Dialog $lotInventoryLength");
//         // getSelectedInventory(updateState_bottom,obj,selectedStcokindex);
//         // list1.clear();
//
//
//       });
//
//     });
//   }
//
//
//
//   // on Filterd Dialog Box
//   showAlertFilterDialog(BuildContext context,StateSetter updateState_Dialog) {
//
//
//
//
//     showDialog(
//         context: context,
//
//         builder: (BuildContext context) {
//
//           return StatefulBuilder(
//               builder: (BuildContext context, setState)
//               {
//
//                 var width = MediaQuery.of(context).size.width;
//                 var height = MediaQuery.of(context).size.height;
//                 return AlertDialog(
//
//                   insetPadding: EdgeInsets.zero,
//
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0)), //this right here
//                   content: Container(
//                     // height: 360,
//                       color: Colors.white,
//                       //backgroundSearchProductForm
//                       width: MediaQuery.of(context).size.width,
//                       child: SingleChildScrollView(
//                         child: Column(
//
//                           children: [
//                             Container(
//
//                               width: width,
//                               padding: EdgeInsets.all(0.0),
//
//
//                               color:sh_white,
//                               child: Column(
//                                 children: [
//                                   //~~~~~~~~~~~~~Search Heading
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(sh_form_searchProductOrder,style: TextStyle(
//                                         fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black
//                                     ),),
//                                   ),
//                                   SizedBox(height: 10,),
//                                   //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Selecte Deale Start
//                                   // widget.spinnerSelectDealer2.length==0?Container(
//                                   //
//                                   //   child: Container(
//                                   //     padding: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
//                                   //     width: double.infinity,
//                                   //     child:Row(
//                                   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   //       children: [
//                                   //         text("Loading Dealers..",
//                                   //             fontSize: textSizeSmall,
//                                   //             fontFamily: fontRegular,
//                                   //             textColor: sh_textColorSecondary),
//                                   //         Image.asset(ic_form_preloader_gif,height: 20,width: 20,)
//                                   //
//                                   //
//                                   //
//                                   //       ],
//                                   //     ),
//                                   //
//                                   //
//                                   //
//                                   //
//                                   //
//                                   //     decoration: BoxDecoration(
//                                   //       color: Colors.white,
//                                   //
//                                   //       border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   //       borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                   //     ),
//                                   //   ),
//                                   // ) :
//                                   // Container(
//                                   //   width: width,
//                                   //
//                                   //
//                                   //   padding: EdgeInsets.symmetric(horizontal: 20),
//                                   //   child: new DropdownButton<String>(
//                                   //     value: widget.SelectedDealer2,
//                                   //     hint: new Text("Select Here"),
//                                   //     isExpanded: true,
//                                   //     icon: Icon(
//                                   //       Icons.arrow_drop_down,
//                                   //       color:
//                                   //       sh_textColorSecondary,
//                                   //       size: 25,
//                                   //     ),
//                                   //     iconSize: 24,
//                                   //     elevation: 16,
//                                   //     style: TextStyle(
//                                   //       color: Colors.black,
//                                   //       fontSize: 18,
//                                   //     ),
//                                   //     underline: Container(
//                                   //       height: 2,
//                                   //     ),
//                                   //     onChanged: (String value) {
//                                   //       setState(() {
//                                   //         widget.SelectedDealer2 = value;
//                                   //
//                                   //         if(widget.SelectedDealer2=="Self Stock")
//                                   //         {
//                                   //           print("Self Stock is Selected ");
//                                   //           get_All_Collection_Categoty_ColorCde(widget.SelectedDealer2);
//                                   //         }
//                                   //         else
//                                   //         {
//                                   //           final index = widget.spinnerDelerList.indexWhere((element) =>
//                                   //           element.name == widget.SelectedDealer2);
//                                   //
//                                   //           print(">>>>>>Selected Dealer List Index $index");
//                                   //           widget.spinnerDealerSelectes=widget.spinnerDelerList[index];
//                                   //           get_All_Collection_Categoty_ColorCde(widget.SelectedDealer2);
//                                   //         }
//                                   //
//                                   //
//                                   //
//                                   //
//                                   //
//                                   //
//                                   //       });
//                                   //     },
//                                   //     items: widget.spinnerSelectDealer2
//                                   //         .map<DropdownMenuItem<String>>(
//                                   //             (String value) {
//                                   //           return DropdownMenuItem<String>(
//                                   //             value: value,
//                                   //             child: text(value,
//                                   //                 fontSize: textSizeSmall,
//                                   //                 textColor: sh_textColorSecondary,
//                                   //                 fontFamily: fontRegular),
//                                   //           );
//                                   //         }).toList(),
//                                   //   ),
//                                   //   decoration: BoxDecoration(
//                                   //     color: Colors.white,
//                                   //
//                                   //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   //     borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                   //   ),
//                                   //
//                                   // ),
//                                   //
//                                   // SizedBox(height: 10,),
//
//                                   // Select Auto Suggest For Dealer
//                                   MyMemberType=="Distributor"?  Container(
//                                     child:Autocomplete(
//                                       initialValue: TextEditingValue(text: widget.SelectedDealer2),
//
//
//                                       optionsBuilder: (TextEditingValue value) {
//                                         // When the field is empty
//                                         if (value.text.isEmpty) {
//                                           return [];
//                                         }
//
//                                         // The logic to find out which ones should appear
//                                         return widget.spinnerSelectDealer2.where((suggestion) => suggestion.toString()
//                                             .toLowerCase()
//                                             .contains(value.text.toLowerCase()));
//                                       },
//
//                                       fieldViewBuilder: (BuildContext context,
//                                           TextEditingController textEditingController,
//                                           FocusNode focusNode, VoidCallback onFieldSubmitted) {
//                                         return TextFormField(
//                                           controller: textEditingController,
//                                           //  decoration: myTextFieldDecoration(topLabel: "Another Input", hintText: "Type or select from list"),
//                                           decoration: InputDecoration(
//                                             filled: true,
//                                             prefixIcon: Icon(Icons.search,color:backgroundSearchProductFormButtons,size: 20,),
//                                             fillColor: backgroundSearchProductFormInput,
//                                             focusColor: sh_editText_background_active,
//
//                                             hintText: "Search Dealers",
//                                             hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                             contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0)
//
//                                             ),),
//                                           focusNode: focusNode,
//                                           onFieldSubmitted: (String value) {
//                                             onFieldSubmitted();
//                                             print('You just typed a new entry  $value');
//
//                                           },
//                                         );
//                                       },
//
//                                       onSelected: (value) {
//                                         updateState_Dialog(() {
//
//                                           print("Selected Dealer From Auto Suggest is "+value);
//
//
//                                           widget.SelectedDealer2 = value;
//
//                                           if(widget.SelectedDealer2=="Self Stock")
//                                           {
//                                             print("Self Stock is Selected ");
//                                             get_All_Collection_Categoty_ColorCde(widget.SelectedDealer2);
//                                           }
//                                           else
//                                           {
//                                             final index = widget.spinnerDelerList.indexWhere((element) =>
//                                             element.name == widget.SelectedDealer2);
//
//                                             print(">>>>>>Selected Dealer List Index $index");
//                                             widget.spinnerDealerSelectes=widget.spinnerDelerList[index];
//                                             get_All_Collection_Categoty_ColorCde(widget.SelectedDealer2);
//                                           }
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
//                                         });
//
//                                       },
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//
//                                       border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                       borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                     ),
//
//                                   ):Container(),
//
//
//                                   SizedBox(height: 10,),
//
//                                   //Select Auto Suggest
//                                   Container(
//                                     child:Autocomplete(
//                                       initialValue: TextEditingValue(text: widget.SelectedValue),
//
//                                       optionsBuilder: (TextEditingValue value) {
//                                         // When the field is empty
//                                         if (value.text.isEmpty) {
//                                           return [];
//                                         }
//
//                                         // The logic to find out which ones should appear
//                                         return spinnerSelectCollection.where((suggestion) => suggestion.toString()
//                                             .toLowerCase()
//                                             .contains(value.text.toLowerCase()));
//                                       },
//
//                                       fieldViewBuilder: (BuildContext context,
//                                           TextEditingController textEditingController,
//                                           FocusNode focusNode, VoidCallback onFieldSubmitted) {
//                                         return TextFormField(
//                                           controller: textEditingController,
//                                           //  decoration: myTextFieldDecoration(topLabel: "Another Input", hintText: "Type or select from list"),
//                                           decoration: InputDecoration(
//                                             filled: true,
//                                             prefixIcon: Icon(Icons.search,color:backgroundSearchProductFormButtons,size: 20,),
//                                             fillColor: backgroundSearchProductFormInput,
//                                             focusColor: sh_editText_background_active,
//
//                                             hintText: sh_hint_SearchCollection2,
//                                             hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                             contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0)
//
//                                             ),),
//                                           focusNode: focusNode,
//                                           onFieldSubmitted: (String value) {
//                                             onFieldSubmitted();
//                                             print('You just typed a new entry  $value');
//
//                                           },
//                                         );
//                                       },
//
//                                       onSelected: (value) {
//                                         updateState_Dialog(() {
//                                           SelectAutoSuggest obj = value;
//                                           String SelectedValue =   obj.value;
//                                           String SelectedCode  =  obj.Code;
//                                           widget.SelectedValue= obj.value;
//
//                                           print("Selected Category >>>>>>>>>>>>>>>>> $value   $SelectedValue   $SelectedCode ");
//
//                                           //category=CARPET
//                                           widget.SelectedAutoSuggestStirng="$SelectedCode=$SelectedValue";
//                                           selectedValueCategory=SelectedValue;
//                                           widget.SingleSelectedCategory=value;
//                                           spinnerSelectCollection2.clear();
//
//                                           mockResults.clear();
//
//
//
//
//
//
//
//                                         });
//
//                                       },
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//
//                                       border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                       borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                     ),
//
//                                   ),
//
//
//
//                                 ],
//                               ),
//
//
//
//
//                             ),
//
//
//                             SizedBox(height: 10,),
//
//
//
//
//                             //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Select Dealer End
//
//                             //Loading Colors
//                             // Container(
//                             //   margin: EdgeInsets.only(left: 15,right: 15),
//                             //   width: width,
//                             //   child: Column(
//                             //     children: <Widget>[
//                             //       mockResults.isEmpty?Container(
//                             //         child: Container(
//                             //           padding: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
//                             //           width: double.infinity,
//                             //           child: text("Loading Colors..",
//                             //               fontSize: textSizeSmall,
//                             //               fontFamily: fontRegular,
//                             //               textColor: sh_textColorSecondary),
//                             //           decoration: BoxDecoration(
//                             //             color: Colors.white,
//                             //
//                             //             border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                             //             borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                             //           ),
//                             //         ),
//                             //       ):Container(
//                             //         padding: EdgeInsets.only(left: 15,right: 10),
//                             //         child: ChipsInput(
//                             //           key: _chipKey,
//                             //           keyboardAppearance: Brightness.dark,
//                             //           textCapitalization: TextCapitalization.words,
//                             //           textStyle: const TextStyle(height: 1.5, fontFamily: 'Roboto', fontSize: 16),
//                             //           decoration: const InputDecoration(
//                             //             border: InputBorder.none,
//                             //             focusedBorder: InputBorder.none,
//                             //             enabledBorder: InputBorder.none,
//                             //             errorBorder: InputBorder.none,
//                             //             disabledBorder: InputBorder.none,
//                             //             hintText: 'Search Colors',
//                             //             hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                             //           ),
//                             //           findSuggestions: (String query) {
//                             //
//                             //             if (query.isNotEmpty) {
//                             //               var lowercaseQuery = query.toLowerCase();
//                             //               return mockResults.where((profile) {
//                             //                 return profile.name
//                             //                     .toLowerCase()
//                             //                     .contains(query.toLowerCase()) ||
//                             //                     profile.email
//                             //                         .toLowerCase()
//                             //                         .contains(query.toLowerCase());
//                             //               }).toList(growable: false)
//                             //                 ..sort((a, b) => a.name
//                             //                     .toLowerCase()
//                             //                     .indexOf(lowercaseQuery)
//                             //                     .compareTo(
//                             //                     b.name.toLowerCase().indexOf(lowercaseQuery)));
//                             //             }
//                             //
//                             //             return mockResults;
//                             //           },
//                             //           onChanged: (data) {
//                             //             // print(data);
//                             //           },
//                             //           chipBuilder: (context, state, dynamic profile) {
//                             //             return InputChip(
//                             //               key: ObjectKey(profile),
//                             //               label: Text(profile.name),
//                             //               avatar: CircleAvatar(
//                             //                 backgroundImage: NetworkImage(profile.imageUrl),
//                             //               ),
//                             //               onDeleted: () => state.deleteChip(profile),
//                             //               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                             //             );
//                             //           },
//                             //           suggestionBuilder: (context, state, dynamic profile) {
//                             //             return ListTile(
//                             //               key: ObjectKey(profile),
//                             //               leading: CircleAvatar(
//                             //                 backgroundImage: NetworkImage(profile.imageUrl),
//                             //               ),
//                             //               title: Text(profile.name),
//                             //               subtitle: Text(profile.email),
//                             //               onTap: () => state.selectSuggestion(profile),
//                             //             );
//                             //           },
//                             //         ),
//                             //         decoration: BoxDecoration(
//                             //           color: Colors.white,
//                             //
//                             //           border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                             //           borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                             //         ),
//                             //       ),
//                             //
//                             //     ],
//                             //   ),
//                             // ),
//                             // SizedBox(height: 10,),
//
//                             //Design & Quantity
//                             Container(
//                               margin: EdgeInsets.only(left: 0,right: 0),
//                               child: SizedBox(
//                                 // width: double.infinity,
//                                 child: Row(
//                                   children: <Widget>[
//
//                                     //~~~~~~~~~~`Select Design
//                                     // Expanded(
//                                     //   flex: 1,
//                                     //   child: Container(
//                                     //     // width: 100,
//                                     //     width:width*0.25,
//                                     //     padding: EdgeInsets.only(left: 15,right: 10),
//                                     //
//                                     //     child:  new DropdownButton<String>(
//                                     //       value: dropdownValue1,
//                                     //       hint: new Text("Select Here"),
//                                     //       isExpanded: true,
//                                     //       icon: Icon(
//                                     //         Icons.arrow_drop_down,
//                                     //         color:
//                                     //         sh_textColorSecondary,
//                                     //         size: 25,
//                                     //       ),
//                                     //       iconSize: 24,
//                                     //       elevation: 16,
//                                     //       style: TextStyle(
//                                     //         color: Colors.black,
//                                     //         fontSize: 18,
//                                     //       ),
//                                     //       underline: Container(
//                                     //         height: 2,
//                                     //       ),
//                                     //       onChanged: (String value) {
//                                     //         setState(() {
//                                     //           dropdownValue1 = value;
//                                     //           widget.SelectedDesign=value;
//                                     //         });
//                                     //       },
//                                     //       items: spinnerItems1
//                                     //           .map<DropdownMenuItem<String>>(
//                                     //               (String value) {
//                                     //             return DropdownMenuItem<String>(
//                                     //               value: value,
//                                     //               child: text(value,
//                                     //                   fontSize: textSizeSmall,
//                                     //                   fontFamily: fontRegular,
//                                     //                   textColor: sh_textColorSecondary),
//                                     //             );
//                                     //           }).toList(),
//                                     //     ),
//                                     //     decoration: BoxDecoration(
//                                     //       color: Colors.white,
//                                     //
//                                     //       border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                     //       borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                     //     ),
//                                     //
//                                     //   ),),
//
//
//
//                                     //Select Quantitiy
//                                     Expanded(
//                                       // flex: 1,
//                                       child: Container(
//                                         // width: width*0.25,
//                                         //   width: 100,
//                                         margin: EdgeInsets.only(left: 0),
//                                         child: TextFormField(
//                                           initialValue: widget.SelectedQuantity,
//                                            keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                           autofocus: false,
//                                           onChanged: (value){
//
//                                             updateState_Dialog((){
//
//
//                                               widget.SelectedQuantity=value;
//
//                                             });
//
//                                           },
//
//                                           textCapitalization: TextCapitalization.words,
//                                           style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                           decoration: InputDecoration(
//
//                                               filled: true,
//                                               fillColor: backgroundSearchProductFormInput,
//                                               focusColor: sh_editText_background_active,
//                                               hintText: sh_hint_EnterQty,
//                                               hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                               contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                         ),
//                                         decoration: BoxDecoration(
//
//                                           border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                           borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                         ),
//
//                                       ),)
//
//
//
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//
//
//                             //~~~~~~~~~~~~Min , MAx & Search
//                             Container(
//                               margin: EdgeInsets.only(left: 0,right: 0),
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 child: Row(
//                                   children: [
//                                     //~~~~~~~~~~~~~~Select Min Price
//                                     Expanded(
//                                       flex: 1,
//                                       child:   Container(
//                                         width:width*0.25,
//                                         child:TextFormField(
//                                            keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                           initialValue: widget.SelectedMinPrice,
//                                           autofocus: false,
//                                           onChanged: (value){
//                                             print("Max Price   >>>>>>>>>>>>>>>>>>>...$value");
//
//                                             if(value=="")
//                                             {
//                                               print("Max Price  zero >>>>>>>>>>>>>>>>>>>...$value");
//                                             }
//
//
//                                             updateState_Dialog((){
//                                               widget.SelectedMinPrice=value;
//
//                                             });
//                                           },
//
//                                           textCapitalization: TextCapitalization.words,
//                                           style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                           decoration: InputDecoration(
//
//                                               filled: true,
//                                               fillColor: backgroundSearchProductFormInput,
//                                               focusColor: sh_editText_background_active,
//                                               hintText: sh_hint_Min,
//                                               hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                               contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                         ),
//                                         decoration: BoxDecoration(
//
//                                           border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                           borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                         ),
//                                       ),),
//                                     SizedBox(width: 10,),
//
//                                     //~~~~~~~~~~~Select Max Price
//                                     Expanded(
//                                       flex: 1,
//                                       child:   Container(
//                                         width:width*0.25,
//                                         child:TextFormField(
//                                            keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                           initialValue: widget.SelectedmaxPrice,
//                                           autofocus: false,
//                                           onChanged: (value){
//
//                                             updateState_Dialog((){
//                                               widget.SelectedmaxPrice=value;
//
//                                             });
//                                           },
//
//                                           textCapitalization: TextCapitalization.words,
//                                           style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                           decoration: InputDecoration(
//
//                                               filled: true,
//                                               fillColor: backgroundSearchProductFormInput,
//                                               focusColor: sh_editText_background_active,
//                                               hintText: sh_hint_Max,
//                                               hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                               contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_textColorSecondary, width: 0.5)),
//                                               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                         ),
//
//                                         decoration: BoxDecoration(
//
//                                           border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                           borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
//                                         ),
//                                       ),),
//                                     SizedBox(width: 10,),
//
//                                     //~~~~~~~~~~~Search Button
//                                     Expanded(
//                                       flex: 1,
//                                       child:   Container(
//                                         width:width*0.25,
//
//                                         child: MaterialButton(
//
//
//
//                                           child: Container(
//                                             padding: EdgeInsets.fromLTRB(5.0, 17.0, 5.0, 17.0),
//                                             alignment: Alignment.center,
//
//                                             child: Text(sh_lbl_search,style: TextStyle(fontSize: textSizeSMedium),),
//                                             //text(sh_lbl_search, fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
//                                           ),
//                                           textColor: sh_white,
//                                           shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
//                                           color: sh_colorPrimary,
//                                           onPressed: () => {
//
//                                             //spinnerDealerSelectes
//
//                                             // print("Selected Spinner Delaer State is "+widget.spinnerDealerSelectes.name+" ID "+widget.spinnerDealerSelectes.id.toString()),
//
//                                             //SelectedAutoSuggestStirng!=null && SelectedDesign!=null && SelectedQuantity!=null && SelectedmaxPrice!=null && SelectedMinPrice!=null
//
//                                             if(widget.SelectedAutoSuggestStirng!=null && widget.SelectedQuantity!=null )
//                                               {
//                                                 //showProgressDialog(context),
//                                                 updateState_Dialog(() {
//                                                   widget.listsearchProducts.clear();
//                                                   list1.clear();
//                                                   allSelectedColorCode.clear();
//                                                   collectivePdfNames="";
//
//
//                                                   print("Length On Refressing "+ widget.listsearchProducts.length.toString());
//                                                 }),
//                                                 print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Suggest Value "+widget.SelectedAutoSuggestStirng),
//                                                 showProgressDialog(context),
//                                                 SearchProduct(widget.SelectedAutoSuggestStirng).then((value) async {
//
//
//
//
//
//                                                   // List<Inventory> inventoryFilterdList=[];
//
//
//
//                                                   int responseLength =  value.length;
//                                                   int quntyList=0;
//                                                   int priceList=0;
//                                                   if(responseLength!=0)
//                                                   {
//                                                     updateState_Dialog(() {
//                                                       isVisibleCheckbox=false;
//
//                                                       buttonStringDownload = "Generate Catalog";
//
//                                                     });
//                                                     print("Progress Dialog Close ");
//                                                     Navigator.of(context, rootNavigator: true).pop();
//                                                     Navigator.of(context, rootNavigator: true).pop();
//
//                                                   }
//                                                   for(int i=0;i<responseLength;i++)
//                                                   {
//                                                     var qunty = value[i].inventory;
//                                                     var price = value[i].price.unit;
//                                                     updateState_Dialog(() {
//
//                                                       widget.listsearchProducts.add(value[i]);
//
//                                                     });
//
//                                                     if( double.parse(widget.SelectedQuantity)<=qunty)
//                                                     {
//
//
//                                                       // if(price>=double.parse(SelectedMinPrice) && price<=double.parse(SelectedmaxPrice) )
//                                                       // {
//                                                       //   priceList++;
//                                                       //
//                                                       // }
//
//
//                                                       quntyList++;
//                                                       updateState_Dialog(() {
//
//                                                         // widget.listsearchProducts.add(value[i]);
//
//                                                       });
//                                                     }
//
//
//                                                   }
//                                                   int responseFilterdLength =  widget.listsearchProducts.length;
//                                                   print("***********************Response Length is $responseLength");
//                                                   print("***********************Response Filterd Length is $responseFilterdLength");
//                                                   print("Range in Quantity $quntyList");
//                                                   print("Range in Price $priceList");
//
//
//
//
//
//                                                   if(widget.listsearchProducts.length==0)
//                                                   {
//                                                     print("Data Not Found");
//
//                                                     Navigator.of(context, rootNavigator: true).pop();
//
//                                                     showToastDialog(context,"Data Not Found");
//                                                     // if(quntyList==0)
//                                                     //   {
//                                                     //     print("Entered Quantityt Not Available");
//                                                     //     showToastDialog(context,"Entered Quantityt Not Available");
//                                                     //   }
//                                                   }
//
//                                                   // else  if(priceList==0)
//                                                   //  {
//                                                   //    print("Entered Price Range  Not Available");
//                                                   //    showToastDialog(context,"Entered Price Range  Not Available ");
//
//                                                   //  }
//
//
//
//
//
//
//
//                                                 }),
//
//                                               }
//                                             else
//                                               {
//
//                                                 showToastDialog(context,"Please Fill All Field "),
//                                                 print("Please Fill All Field "),
//
//                                               }
//
//                                             ///SearchProductResult().launch(context),
//
//
//                                           },
//                                           elevation: 0,
//                                         ),
//
//                                       ),),
//
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//
//                         ),
//                       )
//
//
//                   ),
//                 );
//               }
//           );
//
//
//         });
//   }
//
//
//
//
// }