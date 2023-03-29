// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:nb_utils/nb_utils.dart';
// // import 'package:rosetta_fluter_app/Services/DistributorDealers/Models/PaymentTermsData.dart';
// // import 'package:rosetta_fluter_app/Services/DistributorDealers/PersonalDeatilsForm.dart';
// // import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';
// //
// // import 'package:http/http.dart' as http;
// //
// // import '../../../main/utils/AppColors.dart';
// // import '../../../main/utils/AppWidget.dart';
// // import '../../../rosetta/MyClass/UppercaseTextFormat.dart';
// // import '../../../rosetta/models/AddDealerError.dart';
// // import '../../../rosetta/models/DealersDetails.dart';
// // import '../../../rosetta/utils/ShColors.dart';
// // import '../../../rosetta/utils/ShConstant.dart';
// // import '../../../rosetta/utils/ShFunction.dart';
// // import '../../../rosetta/utils/ShImages.dart';
// // import '../ViewDealers.dart';
// //
// //
// //
// // SharedPreferences prefs;
// //
// // class MyTextInformationForm extends StatefulWidget {
// //
// //   String dealer_type,distributorId,companyId,name,contact,address,address2,state,city,zipcode,
// //       paymentTerms,paymentMethod,credit_limit,phone,email,password,fax,customer_type="Registered",registration_type,number="",
// //       number_pan="",status_pan,reference_number_pan,overdue_balance,email_user,phone_user,password_user,postcode;
// //   bool isEditDeler;
// //   DealersDetsils dealersDetsils;
// //
// //
// //
// //
// //
// //
// //
// //   MyTextInformationForm(
// //       this.dealer_type,
// //       this.name,
// //       this.contact,
// //       this.address,
// //       this.address2,
// //       this.state,
// //       this.city,
// //       this.paymentTerms,
// //       this.paymentMethod,
// //       this.credit_limit,
// //       this.phone,
// //       this.email,
// //       this.password,
// //       this.fax,
// //       this.overdue_balance,
// //       this.email_user,
// //       this.phone_user,
// //       this.password_user,
// //       this.postcode,
// //       this.isEditDeler,
// //       this.dealersDetsils
// //
// //       );
// //
// //
// //
// //   @override
// //   _MyTextInformationFormState createState() => _MyTextInformationFormState();
// //
// //
// // }
// //
// // class _MyTextInformationFormState extends State<MyTextInformationForm> {
// //   int count = 0;
// //   bool    isValidGst = true ;
// //   List<String> spinnerAllCustomerType = ["Registered","Unregistered"];
// //   String selected_CustomerType="Registered";//Registered
// //   var checkNetconnection=null;
// //   String MyToken;
// //   String MyUserName="";
// //   String MyCompanyId;
// //   String MyMemberId;
// //   String MyMemberType;
// //   String  Myparent_distributor_id;
// //   String  Myparent_distributor_nav_id;
// //   var newJsonData;
// //
// //
// //   List<String> spinnerAllPANStatus = ["Select Status","Pan Applied","Pan Invalid","Pan Not Available"];
// //   String selected_PANStatus="Select Status";
// //
// //   List<String> stateCodesList = [
// //     'JK',
// //     'PUN' ,
// //     'CH' ,
// //     'CG' ,
// //     'ARP' ,
// //     'AS' ,
// //     'BIH' ,
// //     'GOA',
// //     'GUJ' ,
// //     'HR' ,
// //     'JHK' ,
// //     'KER' ,
// //     'MAN' ,
// //     'MP' ,
// //     'NAG' ,
// //     'ND',
// //     'ORI' ,
// //     'RAJ',
// //     'SIK' ,
// //     'TN',
// //     'UP' ,
// //     'WB' ,
// //     'KAR' ,
// //     'MAH',
// //     'UK' ,
// //     'PY' ,
// //     'MZ' ,
// //     'MR' ,
// //     'ML',
// //     'LD' ,
// //     'HP',
// //     'DH',
// //     'DD' ,
// //     'AN' ,
// //     'ANP' ,
// //     'AD',
// //   ];
// //
// //   List<String> stateNoList =
// //   [
// //     '01',
// //     '03',
// //     '04',
// //     '22',
// //     '12',
// //     '18',
// //     '10',
// //     '30',
// //     '24',
// //     '06',
// //     '20',
// //     '32',
// //     '14',
// //     '23',
// //     '13',
// //     '07',
// //     '21',
// //     '08',
// //     '11',
// //     '33',
// //     '09',
// //     '19',
// //     '29',
// //     '27',
// //     ' 05',
// //     '34',
// //     '15',
// //     '16',
// //     '17',
// //     '31',
// //     '02',
// //     '26',
// //     '25',
// //     '35',
// //     '36',
// //     '37',
// //   ];
// //
// //
// //
// //
// //
// //
// //   @override
// //   void dispose() {
// //     // _scrollController.dispose(); // dispose the controller
// //     super.dispose();
// //   }
// //
// //
// //
// //   getSessionData() async
// //   {
// //     print("Get Session Methode Call");
// //     prefs = await SharedPreferences.getInstance();
// //     String token = prefs.getString('token');
// //     String  userName = prefs.getString('UserName');
// //     String  mycompanyId = prefs.getString('companyId');
// //     String  mymemberId = prefs.getString('memberId');
// //     String  mymemberType = prefs.getString('memberType');
// //     API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');
// //
// //
// //
// //
// //     if(prefs.getString("customer_type").isEmptyOrNull)
// //     {
// //       selected_CustomerType="Registered";
// //     }
// //     else
// //     {
// //       selected_CustomerType=prefs.getString("customer_type");
// //
// //     }//status_pan
// //
// //
// //
// //
// //     if(prefs.getString("status_pan").isEmptyOrNull)
// //     {
// //       selected_PANStatus="Select Status";
// //     }
// //     else
// //     {
// //       selected_PANStatus=prefs.getString("status_pan");
// //
// //     }//status_pan
// //
// //
// //
// //     String  parent_distributor_id ="0";
// //     String  parent_distributor_nav_id = "0";
// //     if(mymemberType!="Distributor")
// //     {
// //
// //       parent_distributor_id = prefs.getString('parent_distributor_id');
// //       parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');
// //
// //     }
// //
// //     print(">>>>>>>>>>>Session Token $token  $userName $mycompanyId $mymemberId");
// //     print(">>>>>>>>>>>Session Token $token");
// //     setState(() {
// //       MyToken=token;
// //       MyUserName=userName;
// //       MyCompanyId=mycompanyId;
// //       MyMemberId=mymemberId;
// //       MyMemberType=mymemberType;
// //       if(MyMemberType!="Distributor")
// //       {
// //         Myparent_distributor_id=parent_distributor_id;
// //         Myparent_distributor_nav_id=parent_distributor_nav_id;
// //         print("DisSelected Inventory  Page Session Data Myparent_distributor_id  $parent_distributor_id , Myparent_distributor_nav_id $parent_distributor_nav_id");
// //       }
// //
// //
// //     });
// //
// //     if(token.isNotEmpty)
// //     {
// //       print(">>>>>>>>>>>>>>>>>>Token is Not Empty>>>>>>>>>>>>>>>>>>>");
// //
// //
// //
// //
// //       checkNetconnection = isInternatAvailable();
// //       print("Response od internet Menthode $checkNetconnection");
// //       print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$checkNetconnection.");
// //       if(checkNetconnection!=null)
// //       {
// //
// //
// //
// //       }
// //       if(checkNetconnection!=null)
// //       {
// //         print("Please check your Internet Connection ");
// //         // showAlertStockDialog(context);
// //         //interNetPopup();
// //       }
// //     }
// //   }
// //
// //
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     String testSateCode = "MAH";
// //
// //
// //
// //     if(stateCodesList.contains(testSateCode))
// //     {
// //       int indexofStatecode =  stateCodesList.indexOf(testSateCode);
// //       String selectedSateNo = stateNoList[indexofStatecode];
// //       print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
// //     }
// //
// //
// //
// //
// //
// //     getSessionData();
// //
// //
// //
// //     if(widget.isEditDeler)
// //     {
// //
// //       setState(()
// //       {
// //         widget.customer_type=widget.dealersDetsils.taxInformation.gst.customerType.value==null?"":widget.dealersDetsils.taxInformation.gst.customerType.value;
// //         widget.number=widget.dealersDetsils.taxInformation.gst.number==null?"":widget.dealersDetsils.taxInformation.gst.number;
// //         widget.status_pan=widget.dealersDetsils.taxInformation.pan.status==null?"":widget.dealersDetsils.taxInformation.pan.status.key;
// //         widget.number_pan=widget.dealersDetsils.taxInformation.pan.number==null?"":widget.dealersDetsils.taxInformation.pan.number;
// //         widget.reference_number_pan=widget.dealersDetsils.taxInformation.pan.referenceNumber.toString()==null?"":widget.dealersDetsils.taxInformation.pan.referenceNumber.toString();
// //         selected_CustomerType=widget.dealersDetsils.taxInformation.gst.customerType.value;
// //
// //         print("Data Customer Type "+widget.customer_type);
// //         print("Data Customer Type "+widget.status_pan);
// //         print("GST Customer Type "+selected_CustomerType);
// //         if(!widget.customer_type.isEmptyOrNull)
// //         {
// //           selected_CustomerType=widget.customer_type;
// //         }
// //         if(!widget.status_pan.isEmptyOrNull)
// //         {
// //           //selected_PANStatus=widget.dealersDetsils.taxInformation.pan.status.value;
// //           //selected_PANStatus="Pan Applied";
// //
// //           //"Pan Applied","Pan Invalid","Pan Not Available"
// //
// //
// //         }
// //
// //
// //
// //
// //
// //
// //       });
// //     }
// //
// //   }
// //
// //
// //   int responseCode=0;
// //   bool flagAddDealer=true;
// //   bool closedialog = true;
// //   Future<int> addDealerMethode() async {
// //     closedialog = true;
// //     responseCode=0;
// //
// //     print("Add Dealer  Api Call "+widget.dealer_type );
// //
// //     String gst_number = widget.number;
// //
// //
// //     var gstJosnData;
// //
// //     if(widget.dealer_type=="2")
// //     {
// //       gstJosnData={
// //         "customer_type": "Unregistered",
// //         "registration_type": "GSTIN",
// //         "number": ""
// //       };
// //     }
// //     else
// //     {
// //       gstJosnData=  {
// //         "customer_type": widget.customer_type,
// //         "registration_type": "GSTIN",
// //         "number": widget.number//27ACEPH9757K1Z1
// //       };
// //     }
// //
// //
// //
// //
// //
// //     newJsonData = {
// //       "dealer_type": widget.dealer_type,
// //       "distributorId": MyMemberId,
// //       "companyId": MyCompanyId,
// //       "name": widget.name,
// //       "contact": widget.contact,
// //       "address": widget.address,
// //       "address2": widget.address2,
// //       "state": widget.state,
// //       "city": widget.city,
// //       "zipcode": ""+widget.postcode,
// //       "paymentTerms": widget.paymentTerms,
// //       "paymentMethod": widget.paymentMethod,
// //       "credit_limit": widget.credit_limit,
// //       "phone": widget.phone,
// //       "email": widget.email,
// //       "password": widget.password,
// //       "fax": "",
// //       "tax_information":
// //       {
// //         "gst": gstJosnData,
// //
// //         // {
// //         //   "customer_type": "Unregistered",
// //         //   "registration_type": "GSTIN",
// //         //   "number": ""
// //         // },
// //         // "gst": {
// //         //   "customer_type": widget.customer_type,
// //         //   "registration_type": "GSTIN",
// //         //   "number": widget.customer_type=="Unregistered"?"":widget.number//27ACEPH9757K1Z1
// //         // },
// //         "pan": {
// //           "number": "",
// //           "status": "",
// //           "reference_number": ""
// //         }
// //       },
// //       "overdue_balance": widget.overdue_balance,
// //       "user": {
// //         "email": widget.email,
// //         "phone": widget.phone,
// //         "password": widget.password
// //       }
// //     };
// //
// //
// //     print("JSON OF ADD DELAER >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  $newJsonData");
// //
// //     var res = await http.post(Uri.parse(API_ROS_PROD__BASE_URL +
// //         '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers'),
// //         body: jsonEncode(newJsonData),
// //         headers: {
// //           'Authorization': 'bearer $MyToken',
// //           'Content-Type': 'application/json'
// //         }
// //     );
// //
// //     print("Add Dealer  Api Status Code " + res.statusCode.toString());
// //     print("Add Dealer  Api Status bODY " + res.body.toString());
// //
// //     // final parsedJson = jsonDecode(res.body);
// //     // print('${parsedJson.runtimeType} : $parsedJson');
// //
// //
// //
// //     if(res.statusCode!=200) {
// //
// //       setState(() {
// //
// //         closedialog = false;
// //       });
// //       Map<String, dynamic> res2 = jsonDecode(res.body);
// //       print(res2.containsKey("country"));
// //       print("Json Keys " + res2.keys.toString());
// //       String myKey = res2.keys.toString();
// //
// //
// //       var error_message="";
// //       res2.keys.forEach((element) {
// //         print("Json Key Value  $element");
// //         error_message =error_message+'\n'+ AddDealerError
// //             .fromJson(jsonDecode(res.body), element)
// //             .name[0];
// //
// //
// //         // Navigator.of(context, rootNavigator: true).pop();
// //
// //
// //
// //         print("Error message is >>>>>>>>>>>>>>>  " + error_message.toString());
// //       });
// //
// //       if(error_message.isNotEmpty)
// //       {
// //
// //
// //         error_message_add_dealer=error_message;
// //         prefs.setString('error_message', error_message);
// //
// //
// //         Navigator.of(context, rootNavigator: true).pop();
// //
// //
// //         Navigator.of(context).pop();
// //         Navigator.of(context).pop(error_message);
// //         //showToastDialog2(context, error_message.replaceAll(".", " "));
// //       }
// //     }
// //
// //
// //
// //
// //
// //     print(">>>>>>Josn Object key "+jsonEncode(res.body));
// //
// //
// //
// //
// //
// //
// //
// //
// //     setState(() {
// //
// //       responseCode=res.statusCode;
// //
// //
// //     });
// //
// //     if(res.statusCode==200)
// //     {
// //       prefs.setString("paymentTerms","");
// //       prefs.setString("paymentMethod","");
// //       prefs.setString("credit_limit","2000");
// //       prefs.setString("overdueBalance","0");
// //       prefs.setString("gst","");
// //       prefs.setString("reference_number_pan","");
// //       prefs.setString("number_pan","");
// //       prefs.setString("customer_type","");
// //       prefs.setString("status_pan","");
// //
// //
// //     }
// //
// //     return res.statusCode;
// //
// //
// //   }
// //
// //
// //   Future<int> editDealerMethode() async {
// //     // closedialog = true;
// //     //responseCode=0;
// //
// //     print("Edit  Dealer  Api Call "+widget.dealersDetsils.id.toString() );
// //
// //     //  String gst_number = widget.number;
// //
// //
// //
// //     var gstJosnData;
// //     widget.dealer_type=widget.dealersDetsils.dealerType.toString();
// //
// //     if(widget.dealer_type=="2")
// //     {
// //       gstJosnData={
// //         "customer_type": "Unregistered",
// //         "registration_type": "GSTIN",
// //         "number": ""
// //       };
// //     }
// //     else
// //     {
// //       gstJosnData=  {
// //         "customer_type": widget.dealersDetsils.taxInformation.gst.customerType.value,
// //         "registration_type": "GSTIN",
// //         "number": widget.dealersDetsils.taxInformation.gst.number//27ACEPH9757K1Z1
// //       };
// //     }
// //
// //
// //
// //
// //
// //
// //
// //     newJsonData = {
// //       "dealer_type": widget.dealersDetsils.dealerType,
// //       "distributorId": MyMemberId,
// //       "companyId": MyCompanyId,
// //       "name": widget.dealersDetsils.name,
// //       "contact": widget.dealersDetsils.contact,
// //       "address": widget.dealersDetsils.address,
// //       "address2": widget.dealersDetsils.address2,
// //       "state": widget.dealersDetsils.state.code,
// //       "city": widget.dealersDetsils.city,
// //       "zipcode":widget.dealersDetsils.zipcode,
// //       "paymentTerms": widget.dealersDetsils.paymentTerms.key,
// //       "paymentMethod": widget.dealersDetsils.paymentMethod.key,
// //       "credit_limit": widget.dealersDetsils.creditLimit,
// //       "phone": widget.dealersDetsils.phone,
// //       "email": widget.dealersDetsils.email,
// //       "fax": "",
// //       "tax_information":
// //       {
// //         "gst": gstJosnData,
// //
// //         // {
// //         //   "customer_type": "Unregistered",
// //         //   "registration_type": "GSTIN",
// //         //   "number": ""
// //         // },
// //         // "gst": {
// //         //   "customer_type": widget.customer_type,
// //         //   "registration_type": "GSTIN",
// //         //   "number": widget.customer_type=="Unregistered"?"":widget.number//27ACEPH9757K1Z1
// //         // },
// //         "pan": {
// //           "number": widget.dealersDetsils.taxInformation.pan.number.isEmptyOrNull?"":widget.dealersDetsils.taxInformation.pan.number,
// //           "status":widget.dealersDetsils.taxInformation.pan.status?.key.isEmptyOrNull?"":widget.dealersDetsils.taxInformation.pan.status?.key,
// //           "reference_number": widget.dealersDetsils.taxInformation.pan.referenceNumber.toString().isEmptyOrNull?"":widget.dealersDetsils.taxInformation.pan.referenceNumber.toString()
// //         }
// //       },
// //       "overdue_balance": widget.dealersDetsils.overdueBalance,
// //       "user": {
// //         "email": widget.dealersDetsils.email,
// //         "phone": widget.dealersDetsils.phone,
// //
// //       }
// //     };
// //
// //
// //     print("JSON OF Edit DELAER >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  $newJsonData");
// //
// //
// //     //http://rosdev.rosettaproducts.com/api/companies/3/distributors/103/dealers/2315
// //     var res = await http.put(Uri.parse(API_ROS_PROD__BASE_URL +
// //         '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers/'+widget.dealersDetsils.id.toString()),
// //         body: jsonEncode(newJsonData),
// //         headers: {
// //           'Authorization': 'bearer $MyToken',
// //           'Content-Type': 'application/json'
// //         }
// //     );
// //
// //     print("Edit  Dealer  Api Status Code " + res.statusCode.toString());
// //     print("Edit Dealer  Api Status bODY " + res.body.toString());
// //
// //     // final parsedJson = jsonDecode(res.body);
// //     // print('${parsedJson.runtimeType} : $parsedJson');
// //
// //
// //
// //     if(res.statusCode!=200) {
// //
// //       setState(() {
// //
// //         // closedialog = false;
// //       });
// //       Map<String, dynamic> res2 = jsonDecode(res.body);
// //       print(res2.containsKey("country"));
// //       print("Json Keys " + res2.keys.toString());
// //       String myKey = res2.keys.toString();
// //
// //
// //       var error_message="";
// //       res2.keys.forEach((element) {
// //         print("Json Key Value  $element");
// //         error_message =error_message+'\n'+ AddDealerError
// //             .fromJson(jsonDecode(res.body), element).name[0];
// //
// //
// //         // Navigator.of(context, rootNavigator: true).pop();
// //
// //
// //
// //         print("Error message is >>>>>>>>>>>>>>>  " + error_message.toString());
// //       });
// //
// //       if(error_message.isNotEmpty)
// //       {
// //
// //
// //         error_message_add_dealer=error_message;
// //         prefs.setString('error_message', error_message);
// //
// //
// //         Navigator.of(context, rootNavigator: true).pop();
// //
// //
// //         Navigator.of(context).pop();
// //         Navigator.of(context).pop(error_message);
// //         //showToastDialog2(context, error_message.replaceAll(".", " "));
// //       }
// //     }
// //
// //
// //
// //
// //
// //     print(">>>>>>Josn Object key "+jsonEncode(res.body));
// //
// //
// //
// //
// //
// //
// //
// //
// //     setState(() {
// //
// //       //responseCode=res.statusCode;
// //
// //
// //     });
// //
// //     if(res.statusCode==200)
// //     {
// //       // prefs.setString("paymentTerms","");
// //       // prefs.setString("paymentMethod","");
// //       // prefs.setString("credit_limit","2000");
// //       // prefs.setString("overdueBalance","0");
// //       // prefs.setString("gst","");
// //       // prefs.setString("reference_number_pan","");
// //       // prefs.setString("number_pan","");
// //       // prefs.setString("customer_type","");
// //       // prefs.setString("status_pan","");
// //
// //
// //     }
// //
// //     return res.statusCode;
// //
// //
// //   }
// //   showAlertDialogDealer(BuildContext context) {
// //     // Create button
// //
// //
// //     showDialog(
// //         context: context,
// //         barrierDismissible: false,
// //         builder: (BuildContext context) {
// //           return StatefulBuilder(
// //
// //               builder: (BuildContext context, setState)
// //               {
// //                 isInternatAvailable2(context);
// //
// //                 //Order Placed Api Methode Call
// //
// //                 if(flagAddDealer){
// //
// //                   setState((){
// //                     flagAddDealer=false;
// //
// //                   });
// //
// //                   editDealerMethode().then((value) {
// //                     setState((){
// //                       responseCode=value;
// //                     });
// //                   });
// //                 }
// //
// //
// //
// //
// //
// //                 return  MediaQuery(
// //                   data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
// //                   child:
// //
// //                   WillPopScope(
// //                     onWillPop: () async {
// //                       return false;
// //                     },
// //                     child:  AlertDialog(
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(15.0)), //this right here
// //                       content: Container(
// //                           height: 200,
// //
// //                           color: Colors.white,
// //                           width: MediaQuery.of(context).size.width,
// //                           child: Column(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //
// //                               Container(
// //                                 child:responseCode==200?Image.asset(ic_greencheck,height: 50,width: 50, fit: BoxFit.fill,):
// //                                 Image.asset(ic_form_preloader_gif,height: 50,width: 50, fit: BoxFit.fill,),
// //                               ),
// //                               Container(
// //                                 alignment: Alignment.center,
// //                                 width: MediaQuery.of(context).size.width,
// //
// //
// //                                 child:responseCode==200?
// //
// //                                 Container(child:
// //                                 Column(
// //                                   children: [
// //                                     Row(
// //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                       children: [
// //                                         Container(),
// //                                         Text(
// //                                           widget.dealersDetsils.dealerType==1?  "Dealer information successfully":"Retailer information successfully",
// //                                           style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
// //                                         Container()
// //
// //                                       ],
// //                                     ) ,
// //                                     Row(
// //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                       children: [
// //                                         Container(),
// //                                         Text("updated.",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
// //                                         Container()
// //
// //                                       ],
// //                                     ) ,
// //                                   ],
// //                                 ),):
// //
// //                                 Text("Please wait",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
// //                               ),
// //                               true?Container(
// //                                 alignment: Alignment.center,
// //
// //                                 child: MaterialButton(
// //
// //                                   padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
// //                                   child: text("Close", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
// //                                   textColor: Colors.white,
// //                                   shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
// //                                   color: sh_colorPrimary,
// //                                   onPressed: () async => {
// //                                     Navigator.pop(context,false),
// //
// //
// //                                     if(responseCode==200)
// //                                       {
// //                                         // Navigator.pop(context, false),
// //                                         //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewDealers(true))),//28
// //                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false))),//29jun
// //                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers())),
// //
// //                                         //  Navigator.pop(context,false),
// //
// //
// //                                       }
// //                                     else
// //                                       {
// //                                         //      Navigator.pop(context),
// //                                       }
// //
// //
// //
// //                                     //   await Navigator.of(context)
// //                                     //   .push(new MaterialPageRoute(builder: (context) => NewDistributorDashboard())),
// //                                     // setState((){}),
// //
// //                                     //
// //                                     // Navigator.of(context, rootNavigator:
// //                                     // true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
// //                                     //     NewDistributorDashboard()), (route) => false),
// //
// //
// //                                     //DisOrderHistory(backArrowVisible: true,
// //                                     //SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",).launch(context),
// //
// //
// //                                     //G MAy 25
// //                                     // await Navigator.of(context)
// //                                     // .push(new MaterialPageRoute(builder: (context) => DisOrderHistory(
// //                                     //   backArrowVisible: true,
// //                                     //   SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",
// //                                     // ))),
// //
// //
// //
// //
// //
// //
// //
// //                                   },
// //                                   elevation: 0,
// //                                 ),
// //                               ):Container(),
// //
// //                             ],
// //                           )),
// //                     ),
// //                   ),);
// //
// //
// //               }
// //           );
// //
// //
// //         }).then((value){
// //
// //       if(closedialog)
// //       {
// //
// //
// //         print("Add Dialog Close >>>>>>>>>>>>>>>>>>>>>>>>>>>.");
// //
// //         FocusScope.of(context).unfocus();
// //         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false)));
// //         //ViewDealers(false).launch(context);
// //         Navigator.pushAndRemoveUntil(
// //             context,
// //             MaterialPageRoute(
// //                 builder: (context) => ViewDealers(true)
// //             ),
// //                 (Route)=>false
// //           // ModalRoute.withName("/ShHomeFragment")
// //         );
// //       }
// //     });
// //   }
// //
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     var width = MediaQuery.of(context).size.width;
// //     var height = MediaQuery.of(context).size.height;
// //     return MediaQuery(
// //         data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
// //         child:
// //
// //         Scaffold(
// //
// //
// //           resizeToAvoidBottomInset: false,
// //           appBar: PreferredSize(
// //             preferredSize: const Size.fromHeight(50),
// //             child:MyAppBar(false,"MY TaxInformation Details Update","",false,true)
// //
// //
// //           ),
// //           body:
// //           SingleChildScrollView(
// //
// //
// //             child: Container(
// //
// //
// //                 child: Column(
// //
// //                   children: [
// //                       Container(
// //                         color: sh_ColorPrimary2,
// //                         padding: EdgeInsets.all(15.0),
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //
// //                             Row(
// //                               children: [
// //                                 Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary,),
// //                                 SizedBox(width: 3,),
// //                                 Text("Personal Details",style: TextStyle(fontSize: 13.0,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),
// //                               ],
// //                             ),
// //                             Row(
// //                               children: [
// //                                 Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary,),
// //                                 SizedBox(width: 3,),
// //                                 Text("Payment",style: TextStyle(fontSize: 13.0,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),
// //
// //
// //                               ],
// //                             ),
// //                             Row(
// //                                 children: [
// //                                   Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary),
// //                                   SizedBox(width: 3,),
// //                                   Text("Tax Information",style: TextStyle(fontSize: 13.0,color:Colors.black, ),),
// //                                 ]
// //                             ),
// //
// //
// //                           ],
// //                         )
// //
// //                     ),
// //                      Container(
// //                       width: width,
// //                       height: 3,
// //                       color: sh_colorPrimary,
// //                     ) ,
// //
// //
// //                     Container(
// //                       height: height-150,
// //                       padding: EdgeInsets.symmetric(horizontal: 15.0),
// //
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //
// //                         children: [
// //
// //                           Column(
// //                             mainAxisAlignment: MainAxisAlignment.start,
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //
// //
// //                               SizedBox(height: 15,),
// //                               Text("GST Customer Type"),
// //                               widget.isEditDeler?
// //                               Container(
// //
// //                                 width: width,
// //                                 child:Text(widget.dealersDetsils.taxInformation.gst.customerType.key,style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),),
// //                                 padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
// //                                 decoration: BoxDecoration(
// //                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
// //                                   borderRadius: BorderRadius.all(Radius.circular(5)),
// //                                 ),
// //                               ):
// //                               widget.dealer_type=="1"?Container(
// //                                 width: width,
// //                                 //   width: 100,
// //                                 child:
// //                                 SizedBox(
// //                                     height: height_textFormfiled,
// //                                     child: Padding(
// //                                       padding: const EdgeInsets.only(left:10,top: 10),
// //                                       child: Text("RegisterdTTT",
// //                                         style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
// //                                       ),
// //                                     )
// //
// //
// //                                 ),
// //                                 decoration: BoxDecoration(
// //                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
// //                                   borderRadius: BorderRadius.all(Radius.circular(5)),
// //                                 ),
// //
// //                               )
// //                                   :
// //                               Container(
// //
// //                                 padding: EdgeInsets.only(left: 15,right: 10),
// //
// //                                 child:  new DropdownButton<String>(
// //                                   //value: selected_PaymentTerms,
// //                                   value: selected_CustomerType,
// //                                   //prefs.getString("customer_type").isEmptyOrNull?selected_CustomerType: prefs.getString("customer_type"),
// //                                   hint: new Text("Select Here"),
// //                                   isExpanded: true,
// //                                   icon: Icon(
// //                                     Icons.arrow_drop_down,
// //                                     color:
// //                                     sh_textColorSecondary,
// //                                     size: 25,
// //                                   ),
// //                                   iconSize: 24,
// //                                   elevation: 16,
// //                                   style: TextStyle(
// //                                     color: Colors.black,
// //                                     fontSize: 18,
// //                                   ),
// //                                   underline: Container(
// //                                     height: 2,
// //                                   ),
// //                                   onChanged: (String value) {
// //                                     setState(() {
// //                                       selected_CustomerType = value;
// //                                       widget.customer_type=selected_CustomerType;
// //                                       prefs.setString("customer_type",  widget.customer_type);
// //                                       // widget.dealersDetsils.taxInformation.gst.customerType.key=widget.customer_type;
// //                                       // widget.dealersDetsils.taxInformation.gst.customerType.key=widget.customer_type;
// //
// //
// //
// //
// //                                     });
// //                                   },
// //                                   items: spinnerAllCustomerType
// //                                       .map<DropdownMenuItem<String>>(
// //                                           (String value) {
// //                                         return DropdownMenuItem<String>(
// //                                           value: value,
// //                                           child: text(value,
// //                                               fontSize: textSizeSmall,
// //                                               fontFamily: fontRegular,
// //                                               textColor: sh_textColorSecondary),
// //                                         );
// //                                       }).toList(),
// //                                 ),
// //                                 decoration: BoxDecoration(
// //                                   color:Colors.white,
// //
// //                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
// //                                   borderRadius: BorderRadius.all(Radius.circular(5)),
// //                                 ),
// //
// //                               ),
// //
// //
// //
// //                               selected_CustomerType=="Unregistered"? Container():SizedBox(height: 15,),
// //                               selected_CustomerType=="Unregistered"?Container(): Text("GST Number *"),
// //                               selected_CustomerType=="Unregistered"?Container():Container(
// //
// //                                 //   width: 100,
// //                                 child:
// //                                 SizedBox(
// //                                     height: height_textFormfiled,
// //                                     child:
// //                                     TextFormField(
// //                                       keyboardType: TextInputType.text,
// //                                       readOnly: widget.isEditDeler,
// //                                       initialValue: widget.isEditDeler?widget.dealersDetsils.taxInformation.gst.number: prefs.getString("gst"),
// //                                       inputFormatters: [
// //                                         new LengthLimitingTextInputFormatter(15),
// //                                         UpperCaseTextFormatter()
// //                                       ],
// //                                       autofocus: false,
// //                                       onChanged: (value){
// //                                         setState(() {
// //                                           //   widget.number=value;
// //
// //                                           widget.number=value;
// //                                           widget.dealersDetsils.taxInformation.gst.number=value;
// //
// //                                           prefs.setString("gst",  widget.number);
// //
// //
// //
// //
// //                                           String gst_regex = "^[0-9]{2}[A-Z]{5}[0-9]{4}" + "[A-Z]{1}[1-9A-Z]{1}" + "Z[0-9A-Z]{1}";
// //                                           if(!RegExp(gst_regex).hasMatch(widget.number))
// //                                           {
// //                                             print("Please Enter valid GST Number");
// //                                             // showToastDialog(context, "Please enter valid GST number");
// //                                             setState(() {
// //
// //                                               isValidGst=false;
// //                                             });
// //
// //                                           }
// //                                           else
// //                                           {
// //                                             print("Selected State Code   >>>>>>>>>>>>>>>>>   "+widget.state);
// //                                             if(stateCodesList.contains(widget.state))
// //                                             {
// //                                               int indexofStatecode =  stateCodesList.indexOf(widget.state);
// //                                               String selectedSateNo = stateNoList[indexofStatecode];
// //                                               print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
// //                                               print("Selected State No Match with GST    >>>>>>>>>>>>>>>>>   $selectedSateNo  "+widget.state.startsWith(selectedSateNo).toString());
// //
// //
// //
// //
// //                                               if(widget.number.startsWith(selectedSateNo)==false)
// //                                               {
// //                                                 // showToastDialog(context, "Please enter valid GST number with state");
// //                                                 setState(() {
// //                                                   isValidGst=false;
// //                                                 });
// //
// //                                               }
// //                                               else
// //                                               {
// //                                                 setState(() {
// //                                                   isValidGst=true;
// //
// //                                                 });
// //                                               }
// //
// //
// //                                             }
// //
// //
// //                                           }
// //
// //                                         });
// //
// //
// //                                       },
// //
// //                                       textCapitalization: TextCapitalization.words,
// //                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
// //                                       decoration: InputDecoration(
// //
// //                                           filled: true,
// //                                           fillColor: backgroundSearchProductFormInput,
// //                                           focusColor: sh_editText_background_active,
// //                                           hintText:"",
// //                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
// //                                           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
// //                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
// //                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
// //                                     )),
// //                                 decoration: BoxDecoration(
// //
// //                                   border: Border.all(color: isValidGst?sh_textColorSecondarylight:Colors.red,
// //                                     width: 1,),
// //                                   borderRadius: BorderRadius.all(Radius.circular(5)),
// //                                 ),
// //
// //                               ),
// //                               isValidGst?Container():Text("GST No. Invalid",style: TextStyle(color: Colors.red, fontFamily: fontRegular, fontSize: textSizeSmall),),
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //                               SizedBox(height: 15,),
// //                               Text("P.A.N. Status"),
// //                               // Container(
// //                               //
// //                               //   //   width: 100,
// //                               //   child:
// //                               //   SizedBox(
// //                               //     height: height_textFormfiled,
// //                               //     child:
// //                               //   TextFormField(
// //                               //     keyboardType: TextInputType.text,
// //                               //     autofocus: false,
// //                               //     initialValue:prefs.getString("status_pan"),
// //                               //     onChanged: (value){
// //                               //          setState(() {
// //                               //            widget.status_pan=value;
// //                               //            prefs.setString("status_pan", widget.status_pan);
// //                               //
// //                               //
// //                               //
// //                               //          });
// //                               //
// //                               //
// //                               //     },
// //                               //
// //                               //     textCapitalization: TextCapitalization.words,
// //                               //     style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
// //                               //     decoration: InputDecoration(
// //                               //
// //                               //         filled: true,
// //                               //         fillColor: backgroundSearchProductFormInput,
// //                               //         focusColor: sh_editText_background_active,
// //                               //         hintText:"",
// //                               //         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
// //                               //         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
// //                               //         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
// //                               //         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
// //                               //   )),
// //                               //   decoration: BoxDecoration(
// //                               //
// //                               //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
// //                               //     borderRadius: BorderRadius.all(Radius.circular(5)),
// //                               //   ),
// //                               //
// //                               // ),
// //
// //
// //                               /// DROPDOW CHANGE
// //
// //
// //                               Container(
// //
// //                                 padding: EdgeInsets.only(left: 15,right: 10),
// //
// //                                 child:  new DropdownButton<String>(
// //                                   //value: selected_PaymentTerms,
// //                                   value: selected_PANStatus,
// //                                   //prefs.getString("customer_type").isEmptyOrNull?selected_CustomerType: prefs.getString("customer_type"),
// //                                   //hint: new Text("Select Here"),
// //                                   isExpanded: true,
// //                                   icon: Icon(
// //                                     Icons.arrow_drop_down,
// //                                     color:
// //                                     Colors.transparent,
// //                                     size: 25,
// //                                   ),
// //                                   iconSize: 24,
// //                                   elevation: 16,
// //                                   style: TextStyle(
// //                                     color: Colors.black,
// //                                     fontSize: 18,
// //                                   ),
// //                                   underline: Container(
// //                                     height: 2,
// //                                   ),
// //                                   // onChanged: (String value) {
// //                                   //   setState(() {
// //                                   //     print("PAN STATUS >>>>>>>>>>>>>> "+value);
// //                                   //
// //                                   //     selected_PANStatus = value;
// //                                   //     // widget.dealersDetsils.taxInformation.pan.status?.key=selected_PANStatus;
// //                                   //
// //                                   //     // if(widget.isEditDeler)
// //                                   //     // {
// //                                   //     //   print("***1");
// //                                   //     //   widget.dealersDetsils.taxInformation.pan.status?.key=selected_PANStatus;
// //                                   //     // }
// //                                   //     //
// //                                   //     // prefs.setString("status_pan",  widget.status_pan);
// //                                   //
// //                                   //     if(selected_PANStatus=="Select Status")
// //                                   //     {
// //                                   //       widget.status_pan="";
// //                                   //     }
// //                                   //     else
// //                                   //     {
// //                                   //       widget.status_pan=selected_PANStatus;
// //                                   //       prefs.setString("status_pan",  widget.status_pan);
// //                                   //     }//Select Status
// //                                   //
// //                                   //
// //                                   //
// //                                   //
// //                                   //
// //                                   //   });
// //                                   // },
// //                                   items: spinnerAllPANStatus
// //                                       .map<DropdownMenuItem<String>>(
// //                                           (String value) {
// //                                         return DropdownMenuItem<String>(
// //                                           value: value,
// //                                           child: text(value,
// //                                               fontSize: textSizeSmall,
// //                                               fontFamily: fontRegular,
// //                                               textColor: sh_textColorSecondary),
// //                                         );
// //                                       }).toList(),
// //                                 ),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.white,
// //
// //                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
// //                                   borderRadius: BorderRadius.all(Radius.circular(5)),
// //                                 ),
// //
// //                               ),
// //
// //
// //                               SizedBox(height: 15,),
// //                               Text("P.A.N. No."),
// //                               Container(
// //
// //                                 //   width: 100,
// //                                 child:
// //                                 SizedBox(
// //                                     height: height_textFormfiled,
// //                                     child:
// //                                     TextFormField(
// //                                       keyboardType: TextInputType.text,
// //                                       readOnly: widget.isEditDeler,
// //                                       inputFormatters: [
// //                                         new LengthLimitingTextInputFormatter(10),
// //                                         UpperCaseTextFormatter()
// //                                       ],
// //                                       initialValue: widget.isEditDeler?widget.dealersDetsils.taxInformation.pan.number:prefs.getString("number_pan"),
// //                                       autofocus: false,
// //                                       onChanged: (value){
// //
// //                                         setState(() {
// //                                           widget.number_pan=value;
// //                                           widget.dealersDetsils.taxInformation.pan.number=value;
// //
// //                                           prefs.setString("number_pan", widget.number_pan);
// //                                         });
// //
// //
// //                                       },
// //
// //                                       textCapitalization: TextCapitalization.words,
// //                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
// //                                       decoration: InputDecoration(
// //
// //                                           filled: true,
// //                                           fillColor: backgroundSearchProductFormInput,
// //                                           focusColor: sh_editText_background_active,
// //                                           hintText:"",
// //                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
// //                                           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
// //                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
// //                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
// //                                     )),
// //                                 decoration: BoxDecoration(
// //
// //                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
// //                                   borderRadius: BorderRadius.all(Radius.circular(5)),
// //                                 ),
// //
// //                               ),
// //
// //
// //                               SizedBox(height: 15,),
// //                               Text("P.A.N. Reference No."),
// //                               Container(
// //
// //                                 //   width: 100,
// //                                 child:
// //                                 SizedBox(
// //                                     height: height_textFormfiled,
// //                                     child:
// //                                     TextFormField(
// //                                       readOnly: widget.isEditDeler,
// //                                       keyboardType: TextInputType.text,
// //                                       initialValue: widget.isEditDeler?widget.dealersDetsils.taxInformation.pan.referenceNumber: prefs.getString("reference_number_pan"),
// //                                       autofocus: false,
// //                                       onChanged: (value){
// //
// //                                         setState(() {
// //                                           widget.reference_number_pan=value;
// //                                           widget.dealersDetsils.taxInformation.pan.referenceNumber=value;
// //
// //                                           prefs.setString("reference_number_pan", widget.reference_number_pan);
// //                                         });
// //
// //                                       },
// //
// //
// //
// //                                       textCapitalization: TextCapitalization.words,
// //                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
// //                                       decoration: InputDecoration(
// //
// //                                           filled: true,
// //                                           fillColor: backgroundSearchProductFormInput,
// //                                           focusColor: sh_editText_background_active,
// //                                           hintText:"",
// //                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
// //                                           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
// //                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
// //                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
// //                                     )),
// //                                 decoration: BoxDecoration(
// //
// //                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
// //                                   borderRadius: BorderRadius.all(Radius.circular(5)),
// //                                 ),
// //
// //                               ),
// //
// //
// //                             ],
// //                           ),
// //                           Container(),
// //
// //                           widget.isEditDeler? InkWell(onTap: (){
// //
// //                             flagAddDealer=true;
// //                             showAlertDialogDealer(context);
// //
// //                             // if(selected_CustomerType=="Unregistered"||selected_CustomerType=="Unregistred")
// //                             // {
// //                             //   flagAddDealer=true;
// //                             //   showAlertDialogDealer(context);
// //                             // }
// //                             // else
// //                             // {
// //                             //   if(widget.number.isEmptyOrNull&&widget.dealersDetsils.taxInformation.gst.customerType.key!="Unregistered")
// //                             //   {
// //                             //     print("Please Enter Gst Number");
// //                             //     showToastDialog(context, "Please enter  GST number");
// //                             //
// //                             //   }
// //                             //   else
// //                             //   {
// //                             //     String gst_regex = "^[0-9]{2}[A-Z]{5}[0-9]{4}" + "[A-Z]{1}[1-9A-Z]{1}" + "Z[0-9A-Z]{1}";
// //                             //     if(!RegExp(gst_regex).hasMatch(widget.dealersDetsils.taxInformation.gst.number))
// //                             //     {
// //                             //       print("Please Enter valid GST Number");
// //                             //       showToastDialog(context, "Please enter valid GST number");
// //                             //
// //                             //     }
// //                             //
// //                             //     else
// //                             //     {
// //                             //       print("Selected State Code   >>>>>>>>>>>>>>>>>   "+widget.dealersDetsils.state.name);
// //                             //       if(stateCodesList.contains(widget.dealersDetsils.state.code))
// //                             //       {
// //                             //         int indexofStatecode =  stateCodesList.indexOf(widget.dealersDetsils.state.code);
// //                             //         String selectedSateNo = stateNoList[indexofStatecode];
// //                             //         print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
// //                             //         print("Selected State No Match with GST    >>>>>>>>>>>>>>>>>   $selectedSateNo  "+widget.state.startsWith(selectedSateNo).toString());
// //                             //
// //                             //
// //                             //
// //                             //
// //                             //         if(widget.number.startsWith(selectedSateNo)==false)
// //                             //         {
// //                             //           showToastDialog(context, "Please enter valid GST number with state");
// //                             //         }
// //                             //         else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.number_pan)&&widget.number_pan.isNotEmpty)
// //                             //         {
// //                             //
// //                             //
// //                             //           showToastDialog(context, "Please enter valid Pan no.");
// //                             //
// //                             //         }
// //                             //         else
// //                             //         {
// //                             //
// //                             //
// //                             //
// //                             //
// //                             //
// //                             //
// //                             //
// //                             //           flagAddDealer=true;
// //                             //           showAlertDialogDealer(context);
// //                             //
// //                             //         }
// //                             //
// //                             //
// //                             //       }
// //                             //
// //                             //
// //                             //     }
// //                             //
// //                             //
// //                             //
// //                             //   }
// //                             // }
// //
// //
// //
// //
// //
// //
// //                           },
// //                               child: Container(
// //                                 width:width-20,
// //                                 padding: EdgeInsets.all(10.0),
// //                                 child: Text("UPDATE", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
// //                                 decoration: BoxDecoration(
// //                                   color: sh_colorPrimary,
// //                                   borderRadius: BorderRadius.all(
// //                                     Radius.circular(5),
// //
// //                                   ),
// //
// //                                 ),
// //
// //                               )
// //                           ):
// //                           Container(
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 InkWell(onTap: (){
// //                                   // Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDeatilsForm()));
// //                                   PaymentTermsData obj = PaymentTermsData(widget.paymentTerms, widget.paymentMethod, widget.credit_limit, widget.overdue_balance);
// //                                   Navigator.of(context).pop(obj);
// //                                 },
// //                                     child: Container(
// //                                       width: ((width/2)-20),
// //                                       padding: EdgeInsets.all(10.0),
// //                                       child: Text("Previous", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
// //                                       decoration: BoxDecoration(
// //                                         color: sh_textColorSecondary,
// //                                         borderRadius: BorderRadius.all(
// //                                           Radius.circular(5),
// //
// //                                         ),
// //
// //                                       ),
// //                                     )
// //                                 ),
// //                                 SizedBox(width: 10.0,),
// //                                 InkWell(onTap: (){
// //
// //
// //
// //                                   if(selected_CustomerType=="Unregistered")
// //                                   {
// //                                     flagAddDealer=true;
// //                                     showAlertDialog(context);
// //                                   }
// //                                   else
// //                                   {
// //                                     if(widget.number.isEmptyOrNull)
// //                                     {
// //                                       print("Please Enter Gst Number");
// //                                       showToastDialog(context, "Please enter  GST number");
// //
// //                                     }
// //                                     else
// //                                     {
// //                                       String gst_regex = "^[0-9]{2}[A-Z]{5}[0-9]{4}" + "[A-Z]{1}[1-9A-Z]{1}" + "Z[0-9A-Z]{1}";
// //                                       if(!RegExp(gst_regex).hasMatch(widget.number))
// //                                       {
// //                                         print("Please Enter valid GST Number");
// //                                         showToastDialog(context, "Please enter valid GST number");
// //
// //                                       }
// //
// //                                       else
// //                                       {
// //                                         print("Selected State Code   >>>>>>>>>>>>>>>>>   "+widget.state);
// //                                         if(stateCodesList.contains(widget.state))
// //                                         {
// //                                           int indexofStatecode =  stateCodesList.indexOf(widget.state);
// //                                           String selectedSateNo = stateNoList[indexofStatecode];
// //                                           print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
// //                                           print("Selected State No Match with GST    >>>>>>>>>>>>>>>>>   $selectedSateNo  "+widget.state.startsWith(selectedSateNo).toString());
// //
// //
// //
// //
// //                                           if(widget.number.startsWith(selectedSateNo)==false)
// //                                           {
// //                                             showToastDialog(context, "Please enter valid GST number with state");
// //                                           }
// //                                           else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.number_pan)&&widget.number_pan.isNotEmpty)
// //                                           {
// //
// //
// //                                             showToastDialog(context, "Please enter valid Pan no.");
// //
// //                                           }
// //                                           else
// //                                           {
// //
// //
// //
// //
// //
// //
// //
// //                                             flagAddDealer=true;
// //                                             showAlertDialog(context);
// //
// //                                           }
// //
// //
// //                                         }
// //
// //
// //                                       }
// //
// //
// //
// //                                     }
// //                                   }
// //
// //
// //
// //
// //
// //
// //                                 },
// //                                     child: Container(
// //                                       width: ((width/2)-20),
// //                                       padding: EdgeInsets.all(10.0),
// //                                       child: Text("Submit", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
// //                                       decoration: BoxDecoration(
// //                                         color: sh_colorPrimary,
// //                                         borderRadius: BorderRadius.all(
// //                                           Radius.circular(5),
// //
// //                                         ),
// //
// //                                       ),
// //
// //                                     )
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           SizedBox(height: 15,),
// //
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 )
// //             ),
// //
// //           ),
// //
// //           endDrawer: MyDrwaer(),
// //         ));
// //   }
// //
// //
// //   showAlertDialog(BuildContext context) {
// //     // Create button
// //
// //
// //     showDialog(
// //         context: context,
// //         barrierDismissible: false,
// //         builder: (BuildContext context) {
// //           return StatefulBuilder(
// //
// //               builder: (BuildContext context, setState)
// //               {
// //                 isInternatAvailable2(context);
// //
// //                 //Order Placed Api Methode Call
// //
// //                 if(flagAddDealer){
// //
// //                   setState((){
// //                     flagAddDealer=false;
// //
// //                   });
// //
// //                   addDealerMethode().then((value) {
// //                     setState((){
// //                       responseCode=value;
// //                     });
// //                   });
// //                 }
// //
// //
// //
// //
// //
// //                 return  MediaQuery(
// //                   data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
// //                   child:
// //
// //                   WillPopScope(
// //                     onWillPop: () async {
// //                       return false;
// //                     },
// //                     child:  AlertDialog(
// //                       shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(15.0)), //this right here
// //                       content: Container(
// //                           height: 200,
// //
// //                           color: Colors.white,
// //                           width: MediaQuery.of(context).size.width,
// //                           child: Column(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //
// //                               Container(
// //                                 child:responseCode==200?Image.asset(ic_greencheck,height: 50,width: 50, fit: BoxFit.fill,):
// //                                 Image.asset(ic_form_preloader_gif,height: 50,width: 50, fit: BoxFit.fill,),
// //                               ),
// //                               Container(
// //                                 alignment: Alignment.center,
// //                                 width: MediaQuery.of(context).size.width,
// //
// //
// //                                 child:responseCode==200?
// //
// //                                 Container(child:
// //                                 Column(
// //                                   children: [
// //                                     Row(
// //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                       children: [
// //                                         Container(),
// //                                         Text("Congratulations!",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
// //                                         Container()
// //
// //                                       ],
// //                                     ) ,
// //                                     Text(" Your New Customer has been ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
// //                                     Row(
// //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                       children: [
// //                                         Container(),
// //                                         Text("Created!",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
// //                                         Container()
// //
// //                                       ],
// //                                     )
// //                                   ],
// //                                 ),):
// //
// //                                 Text("Please wait",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
// //                               ),
// //                               true?Container(
// //                                 alignment: Alignment.center,
// //
// //                                 child: MaterialButton(
// //
// //                                   padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
// //                                   child: text("Close", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
// //                                   textColor: Colors.white,
// //                                   shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
// //                                   color: sh_colorPrimary,
// //                                   onPressed: () async => {
// //                                     Navigator.pop(context,false),
// //
// //
// //                                     if(responseCode==200)
// //                                       {
// //                                         // Navigator.pop(context, false),
// //                                         //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewDealers(true))),//28
// //                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false))),//29jun
// //                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers())),
// //
// //                                         //  Navigator.pop(context,false),
// //
// //
// //                                       }
// //                                     else
// //                                       {
// //                                         //      Navigator.pop(context),
// //                                       }
// //
// //
// //
// //                                     //   await Navigator.of(context)
// //                                     //   .push(new MaterialPageRoute(builder: (context) => NewDistributorDashboard())),
// //                                     // setState((){}),
// //
// //                                     //
// //                                     // Navigator.of(context, rootNavigator:
// //                                     // true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
// //                                     //     NewDistributorDashboard()), (route) => false),
// //
// //
// //                                     //DisOrderHistory(backArrowVisible: true,
// //                                     //SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",).launch(context),
// //
// //
// //                                     //G MAy 25
// //                                     // await Navigator.of(context)
// //                                     // .push(new MaterialPageRoute(builder: (context) => DisOrderHistory(
// //                                     //   backArrowVisible: true,
// //                                     //   SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",
// //                                     // ))),
// //
// //
// //
// //
// //
// //
// //
// //                                   },
// //                                   elevation: 0,
// //                                 ),
// //                               ):Container(),
// //
// //                             ],
// //                           )),
// //                     ),
// //                   ),);
// //
// //
// //               }
// //           );
// //
// //
// //         }).then((value){
// //
// //       if(closedialog)
// //       {
// //
// //
// //         print("Add Dialog Close >>>>>>>>>>>>>>>>>>>>>>>>>>>.");
// //
// //         FocusScope.of(context).unfocus();
// //         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false)));
// //         //ViewDealers(false).launch(context);
// //         Navigator.pushAndRemoveUntil(
// //             context,
// //             MaterialPageRoute(
// //                 builder: (context) => ViewDealers(true)
// //             ),
// //                 (Route)=>false
// //           // ModalRoute.withName("/ShHomeFragment")
// //         );
// //       }
// //     });
// //   }
// //   showToastDialog(BuildContext context,String Message)
// //   {
// //
// //
// //     showDialog(
// //         barrierDismissible: false,
// //         context: context,
// //         builder: (BuildContext context) {
// //           return   MediaQuery(
// //             data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
// //             child:
// //
// //             Dialog(
// //
// //                 child: StatefulBuilder(
// //
// //                   builder: (BuildContext context, setState){
// //
// //                     return  Container(
// //                       height: 125,
// //
// //                       width:MediaQuery.of(context).size.width,
// //                       color: sh_white,
// //                       padding: EdgeInsets.only(top: 20,bottom: 20),
// //
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Container(child:Text("$Message",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
// //
// //                           Container(
// //                             margin: EdgeInsets.only(top: 5),
// //
// //
// //
// //                             color: sh_white,
// //                             child:   Container(
// //                               color: Colors.white,
// //
// //                               child: MaterialButton(
// //                                 padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
// //
// //
// //                                 child: Text("Retry", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
// //                                 textColor: sh_white,
// //                                 shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
// //                                 color: sh_colorPrimary,
// //                                 onPressed: () => {
// //
// //                                   //DisApproveOrder().launch(context),
// //                                   Navigator.pop(context, false),
// //
// //
// //                                 },
// //                               ),
// //                             ),
// //
// //
// //                           ),
// //
// //
// //                         ],
// //                       ),
// //
// //
// //
// //                     );
// //                   },
// //                 )
// //
// //
// //
// //             ),
// //           );
// //         });
// //
// //   }
// //
// //   showToastDialog2(BuildContext context,String Message)
// //   {
// //
// //
// //     showDialog(
// //         barrierDismissible: false,
// //         context: context,
// //         builder: (BuildContext context) {
// //           return   MediaQuery(
// //             data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
// //             child:
// //
// //             Dialog(
// //
// //                 child: StatefulBuilder(
// //
// //                   builder: (BuildContext context, setState){
// //
// //                     return  Container(
// //                       height: 130,
// //
// //                       width:MediaQuery.of(context).size.width,
// //                       color: sh_white,
// //                       padding: EdgeInsets.only(top: 20,bottom: 20),
// //
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Container(child:Text("$Message",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
// //
// //                           Container(
// //                             margin: EdgeInsets.only(top: 5),
// //
// //
// //
// //                             color: sh_white,
// //                             child:   Container(
// //                               color: Colors.white,
// //
// //                               child: MaterialButton(
// //                                 padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
// //
// //
// //                                 child: Text("Retry", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
// //                                 textColor: sh_white,
// //                                 shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
// //                                 color: sh_colorPrimary,
// //                                 onPressed: () => {
// //
// //                                   //DisApproveOrder().launch(context),
// //
// //
// //                                   // Navigator.pop(context, false),
// //                                   // FocusScope.of(context).unfocus(),
// //
// //                                   Navigator.of(context).pop(),
// //
// //
// //
// //
// //                                 },
// //                               ),
// //                             ),
// //
// //
// //                           ),
// //
// //
// //                         ],
// //                       ),
// //
// //
// //
// //                     );
// //                   },
// //                 )
// //
// //
// //
// //             ),
// //           );
// //         }).then((value) {
// //
// //     });
// //
// //   }
// // }
//
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:rosetta_fluter_app/Services/DistributorDealers/Models/PaymentTermsData.dart';
// import 'package:rosetta_fluter_app/Services/DistributorDealers/PersonalDeatilsForm.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';
//
//
// import 'package:http/http.dart' as http;
//
// import '../../../main/utils/AppColors.dart';
// import '../../../main/utils/AppWidget.dart';
// import '../../../rosetta/MyClass/UppercaseTextFormat.dart';
// import '../../../rosetta/models/AddDealerError.dart';
// import '../../../rosetta/models/DealersDetails.dart';
// import '../../../rosetta/utils/ShColors.dart';
// import '../../../rosetta/utils/ShConstant.dart';
// import '../../../rosetta/utils/ShFunction.dart';
// import '../../../rosetta/utils/ShImages.dart';
// import '../ViewDealers.dart';
//
//
// SharedPreferences prefs;
//
// class MyTextInformationForm extends StatefulWidget {
//
//   String dealer_type,distributorId,companyId,name,contact,address,address2,state,city,zipcode,
//       paymentTerms,paymentMethod,credit_limit,phone,email,password,fax,customer_type="Registered",registration_type,number="",
//       number_pan="",status_pan,reference_number_pan,overdue_balance,email_user,phone_user,password_user,postcode;
//   bool isEditDeler;
//   DealersDetsils dealersDetsils;
//
//
//
//
//
//
//
//   MyTextInformationForm(
//       this.dealer_type,
//       this.name,
//       this.contact,
//       this.address,
//       this.address2,
//       this.state,
//       this.city,
//       this.paymentTerms,
//       this.paymentMethod,
//       this.credit_limit,
//       this.phone,
//       this.email,
//       this.password,
//       this.fax,
//       this.overdue_balance,
//       this.email_user,
//       this.phone_user,
//       this.password_user,
//       this.postcode,
//       this.isEditDeler,
//       this.dealersDetsils
//
//       );
//
//
//
//   @override
//   _MyTextInformationFormState createState() => _MyTextInformationFormState();
//
//
// }
//
// class _MyTextInformationFormState extends State<MyTextInformationForm> {
//   int count = 0;
//   bool    isValidGst = true ;
//   List<String> spinnerAllCustomerType = ["Registered","Unregistered"];
//   String selected_CustomerType="Registered";//Registered
//   var checkNetconnection=null;
//   String MyToken;
//   String MyUserName="";
//   String MyCompanyId;
//   String MyMemberId;
//   String MyMemberType;
//   String  Myparent_distributor_id;
//   String  Myparent_distributor_nav_id;
//   var newJsonData;
//
//
//   List<String> spinnerAllPANStatus = ["Select Status","Pan Applied","Pan Invalid","Pan Not Available"];
//   String selected_PANStatus="Select Status";
//
//   List<String> stateCodesList = [
//     'JK',
//     'PUN' ,
//     'CH' ,
//     'CG' ,
//     'ARP' ,
//     'AS' ,
//     'BIH' ,
//     'GOA',
//     'GUJ' ,
//     'HR' ,
//     'JHK' ,
//     'KER' ,
//     'MAN' ,
//     'MP' ,
//     'NAG' ,
//     'ND',
//     'ORI' ,
//     'RAJ',
//     'SIK' ,
//     'TN',
//     'UP' ,
//     'WB' ,
//     'KAR' ,
//     'MAH',
//     'UK' ,
//     'PY' ,
//     'MZ' ,
//     'MR' ,
//     'ML',
//     'LD' ,
//     'HP',
//     'DH',
//     'DD' ,
//     'AN' ,
//     'ANP' ,
//     'AD',
//   ];
//
//   List<String> stateNoList =
//   [
//     '01',
//     '03',
//     '04',
//     '22',
//     '12',
//     '18',
//     '10',
//     '30',
//     '24',
//     '06',
//     '20',
//     '32',
//     '14',
//     '23',
//     '13',
//     '07',
//     '21',
//     '08',
//     '11',
//     '33',
//     '09',
//     '19',
//     '29',
//     '27',
//     ' 05',
//     '34',
//     '15',
//     '16',
//     '17',
//     '31',
//     '02',
//     '26',
//     '25',
//     '35',
//     '36',
//     '37',
//   ];
//
//
//
//
//
//
//   @override
//   void dispose() {
//     // _scrollController.dispose(); // dispose the controller
//     super.dispose();
//   }
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
//
//
//
//     if(prefs.getString("customer_type").isEmptyOrNull)
//     {
//       selected_CustomerType="Registered";
//     }
//     else
//     {
//       selected_CustomerType=prefs.getString("customer_type");
//
//     }//status_pan
//
//
//
//
//     if(prefs.getString("status_pan").isEmptyOrNull)
//     {
//       selected_PANStatus="Select Status";
//     }
//     else
//     {
//       selected_PANStatus=prefs.getString("status_pan");
//
//     }//status_pan
//
//
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
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     String testSateCode = "MAH";
//
//
//
//     if(stateCodesList.contains(testSateCode))
//     {
//       int indexofStatecode =  stateCodesList.indexOf(testSateCode);
//       String selectedSateNo = stateNoList[indexofStatecode];
//       print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
//     }
//
//
//
//
//
//     getSessionData();
//
//
//
//     if(widget.isEditDeler)
//     {
//
//       setState(()
//       {
//         widget.customer_type=widget.dealersDetsils.taxInformation.gst.customerType.value==null?"":widget.dealersDetsils.taxInformation.gst.customerType.value;
//         widget.number=widget.dealersDetsils.taxInformation.gst.number==null?"":widget.dealersDetsils.taxInformation.gst.number;
//         widget.status_pan=widget.dealersDetsils.taxInformation.pan.status==null?"":widget.dealersDetsils.taxInformation.pan.status.key;
//         widget.number_pan=widget.dealersDetsils.taxInformation.pan.number==null?"":widget.dealersDetsils.taxInformation.pan.number;
//         widget.reference_number_pan=widget.dealersDetsils.taxInformation.pan.referenceNumber.toString()==null?"":widget.dealersDetsils.taxInformation.pan.referenceNumber.toString();
//         selected_CustomerType=widget.dealersDetsils.taxInformation.gst.customerType.value;
//
//         print("Data Customer Type "+widget.customer_type);
//         print("Data Customer Type "+widget.status_pan);
//         print("GST Customer Type "+selected_CustomerType);
//         if(!widget.customer_type.isEmptyOrNull)
//         {
//           selected_CustomerType=widget.customer_type;
//         }
//         if(!widget.status_pan.isEmptyOrNull)
//         {
//           //selected_PANStatus=widget.dealersDetsils.taxInformation.pan.status.value;
//           //selected_PANStatus="Pan Applied";
//
//           //"Pan Applied","Pan Invalid","Pan Not Available"
//
//
//         }
//
//
//
//
//
//
//       });
//     }
//
//   }
//
//
//   int responseCode=0;
//   bool flagAddDealer=true;
//   bool closedialog = true;
//   Future<int> addDealerMethode() async {
//     closedialog = true;
//     responseCode=0;
//
//     print("Add Dealer  Api Call "+widget.dealer_type );
//
//     String gst_number = widget.number;
//
//
//     var gstJosnData;
//
//     if(widget.dealer_type=="2")
//     {
//       gstJosnData={
//         "customer_type": "Unregistered",
//         "registration_type": "GSTIN",
//         "number": ""
//       };
//     }
//     else
//     {
//       gstJosnData=  {
//         "customer_type": widget.customer_type,
//         "registration_type": "GSTIN",
//         "number": widget.number//27ACEPH9757K1Z1
//       };
//     }
//
//
//
//
//
//     newJsonData = {
//       "dealer_type": widget.dealer_type,
//       "distributorId": MyMemberId,
//       "companyId": MyCompanyId,
//       "name": widget.name,
//       "contact": widget.contact,
//       "address": widget.address,
//       "address2": widget.address2,
//       "state": widget.state,
//       "city": widget.city,
//       "zipcode": ""+widget.postcode,
//       "paymentTerms": widget.paymentTerms,
//       "paymentMethod": widget.paymentMethod,
//       "credit_limit": widget.credit_limit,
//       "phone": widget.phone,
//       "email": widget.email,
//       "password": widget.password,
//       "fax": "",
//       "tax_information":
//       {
//         "gst": gstJosnData,
//
//         // {
//         //   "customer_type": "Unregistered",
//         //   "registration_type": "GSTIN",
//         //   "number": ""
//         // },
//         // "gst": {
//         //   "customer_type": widget.customer_type,
//         //   "registration_type": "GSTIN",
//         //   "number": widget.customer_type=="Unregistered"?"":widget.number//27ACEPH9757K1Z1
//         // },
//         "pan": {
//           "number": "",
//           "status": "",
//           "reference_number": ""
//         }
//       },
//       "overdue_balance": widget.overdue_balance,
//       "user": {
//         "email": widget.email,
//         "phone": widget.phone,
//         "password": widget.password
//       }
//     };
//
//
//     print("JSON OF ADD DELAER >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  $newJsonData");
//
//     var res = await http.post(Uri.parse(API_ROS_PROD__BASE_URL +
//         '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers'),
//         body: jsonEncode(newJsonData),
//         headers: {
//           'Authorization': 'bearer $MyToken',
//           'Content-Type': 'application/json'
//         }
//     );
//
//     print("Add Dealer  Api Status Code " + res.statusCode.toString());
//     print("Add Dealer  Api Status bODY " + res.body.toString());
//
//     // final parsedJson = jsonDecode(res.body);
//     // print('${parsedJson.runtimeType} : $parsedJson');
//
//
//
//     if(res.statusCode!=200) {
//
//       setState(() {
//
//         closedialog = false;
//       });
//       Map<String, dynamic> res2 = jsonDecode(res.body);
//       print(res2.containsKey("country"));
//       print("Json Keys " + res2.keys.toString());
//       String myKey = res2.keys.toString();
//
//
//       var error_message="";
//       res2.keys.forEach((element) {
//         print("Json Key Value  $element");
//         error_message =error_message+'\n'+ AddDealerError
//             .fromJson(jsonDecode(res.body), element)
//             .name[0];
//
//
//         // Navigator.of(context, rootNavigator: true).pop();
//
//
//
//         print("Error message is >>>>>>>>>>>>>>>  " + error_message.toString());
//       });
//
//       if(error_message.isNotEmpty)
//       {
//
//
//         error_message_add_dealer=error_message;
//         prefs.setString('error_message', error_message);
//
//
//         Navigator.of(context, rootNavigator: true).pop();
//
//
//         Navigator.of(context).pop();
//         Navigator.of(context).pop(error_message);
//         //showToastDialog2(context, error_message.replaceAll(".", " "));
//       }
//     }
//
//
//
//
//
//     print(">>>>>>Josn Object key "+jsonEncode(res.body));
//
//
//
//
//
//
//
//
//     setState(() {
//
//       responseCode=res.statusCode;
//
//
//     });
//
//     if(res.statusCode==200)
//     {
//       prefs.setString("paymentTerms","");
//       prefs.setString("paymentMethod","");
//       prefs.setString("credit_limit","2000");
//       prefs.setString("overdueBalance","0");
//       prefs.setString("gst","");
//       prefs.setString("reference_number_pan","");
//       prefs.setString("number_pan","");
//       prefs.setString("customer_type","");
//       prefs.setString("status_pan","");
//
//
//     }
//
//     return res.statusCode;
//
//
//   }
//
//
//   Future<int> editDealerMethode() async {
//     // closedialog = true;
//     //responseCode=0;
//
//     print("Edit  Dealer  Api Call "+widget.dealersDetsils.id.toString() );
//
//     //  String gst_number = widget.number;
//
//
//
//     var gstJosnData;
//     widget.dealer_type=widget.dealersDetsils.dealerType.toString();
//
//     if(widget.dealer_type=="2")
//     {
//       gstJosnData={
//         "customer_type": "Unregistered",
//         "registration_type": "GSTIN",
//         "number": ""
//       };
//     }
//     else
//     {
//       gstJosnData=  {
//         "customer_type": widget.dealersDetsils.taxInformation.gst.customerType.value,
//         "registration_type": "GSTIN",
//         "number": widget.dealersDetsils.taxInformation.gst.number//27ACEPH9757K1Z1
//       };
//     }
//
//
//
//
//
//
//
//     newJsonData = {
//       "dealer_type": widget.dealersDetsils.dealerType,
//       "distributorId": MyMemberId,
//       "companyId": MyCompanyId,
//       "name": widget.dealersDetsils.name,
//       "contact": widget.dealersDetsils.contact,
//       "address": widget.dealersDetsils.address,
//       "address2": widget.dealersDetsils.address2,
//       "state": widget.dealersDetsils.state.code,
//       "city": widget.dealersDetsils.city,
//       "zipcode":widget.dealersDetsils.zipcode,
//       "paymentTerms": widget.dealersDetsils.paymentTerms.key,
//       "paymentMethod": widget.dealersDetsils.paymentMethod.key,
//       "credit_limit": widget.dealersDetsils.creditLimit,
//       "phone": widget.dealersDetsils.phone,
//       "email": widget.dealersDetsils.email,
//       "fax": "",
//       "tax_information":
//       {
//         "gst": gstJosnData,
//
//         // {
//         //   "customer_type": "Unregistered",
//         //   "registration_type": "GSTIN",
//         //   "number": ""
//         // },
//         // "gst": {
//         //   "customer_type": widget.customer_type,
//         //   "registration_type": "GSTIN",
//         //   "number": widget.customer_type=="Unregistered"?"":widget.number//27ACEPH9757K1Z1
//         // },
//         "pan": {
//           "number": widget.dealersDetsils.taxInformation.pan.number.isEmptyOrNull?"":widget.dealersDetsils.taxInformation.pan.number,
//           "status":widget.dealersDetsils.taxInformation.pan.status?.key.isEmptyOrNull?"":widget.dealersDetsils.taxInformation.pan.status?.key,
//           "reference_number": widget.dealersDetsils.taxInformation.pan.referenceNumber.toString().isEmptyOrNull?"":widget.dealersDetsils.taxInformation.pan.referenceNumber.toString()
//         }
//       },
//       "overdue_balance": widget.dealersDetsils.overdueBalance,
//       "user": {
//         "email": widget.dealersDetsils.email,
//         "phone": widget.dealersDetsils.phone,
//
//       }
//     };
//
//
//     print("JSON OF Edit DELAER >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  $newJsonData");
//
//
//     //http://rosdev.rosettaproducts.com/api/companies/3/distributors/103/dealers/2315
//     var res = await http.put(Uri.parse(API_ROS_PROD__BASE_URL +
//         '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers/'+widget.dealersDetsils.id.toString()),
//         body: jsonEncode(newJsonData),
//         headers: {
//           'Authorization': 'bearer $MyToken',
//           'Content-Type': 'application/json'
//         }
//     );
//
//     print("Edit  Dealer  Api Status Code " + res.statusCode.toString());
//     print("Edit Dealer  Api Status bODY " + res.body.toString());
//
//     // final parsedJson = jsonDecode(res.body);
//     // print('${parsedJson.runtimeType} : $parsedJson');
//
//
//
//     if(res.statusCode!=200) {
//
//       setState(() {
//
//         // closedialog = false;
//       });
//       Map<String, dynamic> res2 = jsonDecode(res.body);
//       print(res2.containsKey("country"));
//       print("Json Keys " + res2.keys.toString());
//       String myKey = res2.keys.toString();
//
//
//       var error_message="";
//       res2.keys.forEach((element) {
//         print("Json Key Value  $element");
//         error_message =error_message+'\n'+ AddDealerError
//             .fromJson(jsonDecode(res.body), element).name[0];
//
//
//         // Navigator.of(context, rootNavigator: true).pop();
//
//
//
//         print("Error message is >>>>>>>>>>>>>>>  " + error_message.toString());
//       });
//
//       if(error_message.isNotEmpty)
//       {
//
//
//         error_message_add_dealer=error_message;
//         prefs.setString('error_message', error_message);
//
//
//         Navigator.of(context, rootNavigator: true).pop();
//
//
//         Navigator.of(context).pop();
//         Navigator.of(context).pop(error_message);
//         //showToastDialog2(context, error_message.replaceAll(".", " "));
//       }
//     }
//
//
//
//
//
//     print(">>>>>>Josn Object key "+jsonEncode(res.body));
//
//
//
//
//
//
//
//
//     setState(() {
//
//       //responseCode=res.statusCode;
//
//
//     });
//
//     if(res.statusCode==200)
//     {
//       // prefs.setString("paymentTerms","");
//       // prefs.setString("paymentMethod","");
//       // prefs.setString("credit_limit","2000");
//       // prefs.setString("overdueBalance","0");
//       // prefs.setString("gst","");
//       // prefs.setString("reference_number_pan","");
//       // prefs.setString("number_pan","");
//       // prefs.setString("customer_type","");
//       // prefs.setString("status_pan","");
//
//
//     }
//
//     return res.statusCode;
//
//
//   }
//   showAlertDialogDealer(BuildContext context) {
//     // Create button
//
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
//
//                 if(flagAddDealer){
//
//                   setState((){
//                     flagAddDealer=false;
//
//                   });
//
//                   editDealerMethode().then((value) {
//                     setState((){
//                       responseCode=value;
//                     });
//                   });
//                 }
//
//
//
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
//                                 child:responseCode==200?Image.asset(ic_greencheck,height: 50,width: 50, fit: BoxFit.fill,):
//                                 Image.asset(ic_form_preloader_gif,height: 50,width: 50, fit: BoxFit.fill,),
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.of(context).size.width,
//
//
//                                 child:responseCode==200?
//
//                                 Container(child:
//                                 Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(),
//                                         Text(
//                                           widget.dealersDetsils.dealerType==1?  "Dealer information successfully":"Retailer information successfully",
//                                           style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                         Container()
//
//                                       ],
//                                     ) ,
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(),
//                                         Text("updated.",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                         Container()
//
//                                       ],
//                                     ) ,
//                                   ],
//                                 ),):
//
//                                 Text("Please wait",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                               ),
//                               true?Container(
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
//                                     Navigator.pop(context,false),
//
//
//                                     if(responseCode==200)
//                                       {
//                                         // Navigator.pop(context, false),
//                                         //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewDealers(true))),//28
//                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false))),//29jun
//                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers())),
//
//                                         //  Navigator.pop(context,false),
//
//
//                                       }
//                                     else
//                                       {
//                                         //      Navigator.pop(context),
//                                       }
//
//
//
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
//       if(closedialog)
//       {
//
//
//         print("Add Dialog Close >>>>>>>>>>>>>>>>>>>>>>>>>>>.");
//
//         FocusScope.of(context).unfocus();
//         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false)));
//         //ViewDealers(false).launch(context);
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ViewDealers(true)
//             ),
//                 (Route)=>false
//           // ModalRoute.withName("/ShHomeFragment")
//         );
//       }
//     });
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return MediaQuery(
//         data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//         child:
//
//         Scaffold(
//
//
//           resizeToAvoidBottomInset: false,
//           appBar: PreferredSize(
//               preferredSize: const Size.fromHeight(50),
//               child:MyAppBar(false,"MY TaxInformation Details Update","",false,true)
//
//
//
//           ),
//           body:
//           SingleChildScrollView(
//
//
//             child: Container(
//
//
//                 child: Column(
//
//                   children: [
//                     Container(
//                         color: sh_ColorPrimary2,
//                         padding: EdgeInsets.all(15.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//
//                             Row(
//                               children: [
//                                 Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary,),
//                                 SizedBox(width: 3,),
//                                 Text("Personal Details",style: TextStyle(fontSize: 13.0,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary,),
//                                 SizedBox(width: 3,),
//                                 Text("Payment",style: TextStyle(fontSize: 13.0,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),
//
//
//                               ],
//                             ),
//                             Row(
//                                 children: [
//                                   Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary),
//                                   SizedBox(width: 3,),
//                                   Text("Tax Information",style: TextStyle(fontSize: 13.0,color:Colors.black, ),),
//                                 ]
//                             ),
//
//
//                           ],
//                         )
//
//                     ),
//                     Container(
//                       width: width,
//                       height: 3,
//                       color: sh_colorPrimary,
//                     ) ,
//
//
//                     Container(
//                       height: height-150,
//                       padding: EdgeInsets.symmetric(horizontal: 15.0),
//
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//
//                         children: [
//
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//
//
//                               SizedBox(height: 15,),
//                               Text("GST Customer Type"),
//                               widget.isEditDeler?
//                               Container(
//
//                                 width: width,
//                                 child:Text(widget.dealersDetsils.taxInformation.gst.customerType.key,style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),),
//                                 padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//                               )
//                                   :
//                               widget.dealer_type=="1"?Container(
//                                 width: width,
//                                 //   width: 100,
//                                 child:
//                                 SizedBox(
//                                     height: height_textFormfiled,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left:10,top: 10),
//                                       child: Text("Registerd",
//                                         style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       ),
//                                     )
//                                   // TextFormField(
//                                   //   keyboardType: TextInputType.text,
//                                   //  // readOnly: true,
//                                   //
//                                   //   autofocus: false,
//                                   //   onChanged: (value){
//                                   //     setState(() {
//                                   //    //   widget.number=value;
//                                   //
//                                   //       widget.customer_type=value;
//                                   //       widget.dealersDetsils.taxInformation.gst.customerType.value=widget.customer_type;
//                                   //       widget.dealersDetsils.taxInformation.gst.customerType.key=widget.customer_type;
//                                   //
//                                   //
//                                   //     });
//                                   //
//                                   //
//                                   //   },
//                                   //
//                                   //   textCapitalization: TextCapitalization.words,
//                                   //   style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                   //   decoration: InputDecoration(
//                                   //     //  initialValue: "";
//                                   //       filled: true,
//                                   //       fillColor: backgroundSearchProductFormInput,
//                                   //       focusColor: sh_editText_background_active,
//                                   //       hintText:"Registered",
//                                   //       hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                   //       contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                                   //       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                   //       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                   // )
//
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ):
//                               Container(
//
//                                 padding: EdgeInsets.only(left: 15,right: 10),
//
//                                 child:  new DropdownButton<String>(
//                                   //value: selected_PaymentTerms,
//                                   value: selected_CustomerType,
//                                   //prefs.getString("customer_type").isEmptyOrNull?selected_CustomerType: prefs.getString("customer_type"),
//                                   hint: new Text("Select Here"),
//                                   isExpanded: true,
//                                   icon: Icon(
//                                     Icons.arrow_drop_down,
//                                     color:
//                                     sh_textColorSecondary,
//                                     size: 25,
//                                   ),
//                                   iconSize: 24,
//                                   elevation: 16,
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18,
//                                   ),
//                                   underline: Container(
//                                     height: 2,
//                                   ),
//                                   onChanged: (String value) {
//                                     setState(() {
//                                       selected_CustomerType = value;
//                                       widget.customer_type=selected_CustomerType;
//                                       prefs.setString("customer_type",  widget.customer_type);
//                                       // widget.dealersDetsils.taxInformation.gst.customerType.key=widget.customer_type;
//                                       // widget.dealersDetsils.taxInformation.gst.customerType.key=widget.customer_type;
//
//
//
//
//                                     });
//                                   },
//                                   items: spinnerAllCustomerType
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: text(value,
//                                               fontSize: textSizeSmall,
//                                               fontFamily: fontRegular,
//                                               textColor: sh_textColorSecondary),
//                                         );
//                                       }).toList(),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color:Colors.white,
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ),
//
//
//
//                               selected_CustomerType=="Unregistered"? Container():SizedBox(height: 15,),
//                               selected_CustomerType=="Unregistered"?Container(): Text("GST Number *"),
//                               selected_CustomerType=="Unregistered"?Container():Container(
//
//                                 //   width: 100,
//                                 child:
//                                 SizedBox(
//                                     height: height_textFormfiled,
//                                     child:
//                                     TextFormField(
//                                       keyboardType: TextInputType.text,
//                                       readOnly: widget.isEditDeler,
//                                       initialValue: widget.isEditDeler?widget.dealersDetsils.taxInformation.gst.number: prefs.getString("gst"),
//                                       inputFormatters: [
//                                         new LengthLimitingTextInputFormatter(15),
//                                         UpperCaseTextFormatter()
//                                       ],
//                                       autofocus: false,
//                                       onChanged: (value){
//                                         setState(() {
//                                           //   widget.number=value;
//
//                                           widget.number=value;
//                                           widget.dealersDetsils.taxInformation.gst.number=value;
//
//                                           prefs.setString("gst",  widget.number);
//
//
//
//
//                                           String gst_regex = "^[0-9]{2}[A-Z]{5}[0-9]{4}" + "[A-Z]{1}[1-9A-Z]{1}" + "Z[0-9A-Z]{1}";
//                                           if(!RegExp(gst_regex).hasMatch(widget.number))
//                                           {
//                                             print("Please Enter valid GST Number");
//                                             // showToastDialog(context, "Please enter valid GST number");
//                                             setState(() {
//
//                                               isValidGst=false;
//                                             });
//
//                                           }
//                                           else
//                                           {
//                                             print("Selected State Code   >>>>>>>>>>>>>>>>>   "+widget.state);
//                                             if(stateCodesList.contains(widget.state))
//                                             {
//                                               int indexofStatecode =  stateCodesList.indexOf(widget.state);
//                                               String selectedSateNo = stateNoList[indexofStatecode];
//                                               print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
//                                               print("Selected State No Match with GST    >>>>>>>>>>>>>>>>>   $selectedSateNo  "+widget.state.startsWith(selectedSateNo).toString());
//
//
//
//
//                                               if(widget.number.startsWith(selectedSateNo)==false)
//                                               {
//                                                 // showToastDialog(context, "Please enter valid GST number with state");
//                                                 setState(() {
//                                                   isValidGst=false;
//                                                 });
//
//                                               }
//                                               else
//                                               {
//                                                 setState(() {
//                                                   isValidGst=true;
//
//                                                 });
//                                               }
//
//
//                                             }
//
//
//                                           }
//
//                                         });
//
//
//                                       },
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//
//                                           filled: true,
//                                           fillColor: backgroundSearchProductFormInput,
//                                           focusColor: sh_editText_background_active,
//                                           hintText:"",
//                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                     )),
//                                 decoration: BoxDecoration(
//
//                                   border: Border.all(color: isValidGst?sh_textColorSecondarylight:Colors.red,
//                                     width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ),
//                               isValidGst?Container():Text("GST No. Invalid",style: TextStyle(color: Colors.red, fontFamily: fontRegular, fontSize: textSizeSmall),),
//
//
//
//                               SizedBox(height: 15,),
//                               Text("P.A.N. Status"),
//                               // Container(
//                               //
//                               //   //   width: 100,
//                               //   child:
//                               //   SizedBox(
//                               //     height: height_textFormfiled,
//                               //     child:
//                               //   TextFormField(
//                               //     keyboardType: TextInputType.text,
//                               //     autofocus: false,
//                               //     initialValue:prefs.getString("status_pan"),
//                               //     onChanged: (value){
//                               //          setState(() {
//                               //            widget.status_pan=value;
//                               //            prefs.setString("status_pan", widget.status_pan);
//                               //
//                               //
//                               //
//                               //          });
//                               //
//                               //
//                               //     },
//                               //
//                               //     textCapitalization: TextCapitalization.words,
//                               //     style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                               //     decoration: InputDecoration(
//                               //
//                               //         filled: true,
//                               //         fillColor: backgroundSearchProductFormInput,
//                               //         focusColor: sh_editText_background_active,
//                               //         hintText:"",
//                               //         hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                               //         contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                               //         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                               //         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                               //   )),
//                               //   decoration: BoxDecoration(
//                               //
//                               //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                               //     borderRadius: BorderRadius.all(Radius.circular(5)),
//                               //   ),
//                               //
//                               // ),
//
//                               Container(
//
//                                 padding: EdgeInsets.only(left: 15,right: 10),
//
//                                 child:  new DropdownButton<String>(
//                                   //value: selected_PaymentTerms,
//                                   value: selected_PANStatus,
//                                   //prefs.getString("customer_type").isEmptyOrNull?selected_CustomerType: prefs.getString("customer_type"),
//                                   // hint: new Text("Select Here"),
//                                   isExpanded: true,
//                                   icon: Icon(
//                                     Icons.arrow_drop_down,
//                                     color:
//                                     Colors.transparent,//sh_textColorSecondary,
//                                     size: 25,
//                                   ),
//                                   iconSize: 24,
//                                   elevation: 16,
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18,
//                                   ),
//                                   underline: Container(
//                                     height: 2,
//                                   ),
//                                   // onChanged: (String value) {
//                                   //   setState(() {
//                                   //     print("PAN STATUS >>>>>>>>>>>>>> "+value);
//                                   //
//                                   //     selected_PANStatus = value;
//                                   //     // widget.dealersDetsils.taxInformation.pan.status?.key=selected_PANStatus;
//                                   //
//                                   //     // if(widget.isEditDeler)
//                                   //     // {
//                                   //     //   print("***1");
//                                   //     //   widget.dealersDetsils.taxInformation.pan.status?.key=selected_PANStatus;
//                                   //     // }
//                                   //     //
//                                   //     // prefs.setString("status_pan",  widget.status_pan);
//                                   //
//                                   //     if(selected_PANStatus=="Select Status")
//                                   //     {
//                                   //       widget.status_pan="";
//                                   //     }
//                                   //     else
//                                   //     {
//                                   //       widget.status_pan=selected_PANStatus;
//                                   //       prefs.setString("status_pan",  widget.status_pan);
//                                   //     }//Select Status
//                                   //
//                                   //
//                                   //
//                                   //
//                                   //
//                                   //   });
//                                   // },
//                                   items: spinnerAllPANStatus
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: text(value,
//                                               fontSize: textSizeSmall,
//                                               fontFamily: fontRegular,
//                                               textColor: sh_textColorSecondary),
//                                         );
//                                       }).toList(),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ),
//
//
//                               SizedBox(height: 15,),
//                               Text("P.A.N. No."),
//                               Container(
//
//                                 //   width: 100,
//                                 child:
//                                 SizedBox(
//                                     height: height_textFormfiled,
//                                     child:
//                                     TextFormField(
//                                       keyboardType: TextInputType.text,
//
//                                       inputFormatters: [
//                                         new LengthLimitingTextInputFormatter(10),
//                                         UpperCaseTextFormatter()
//                                       ],
//                                       readOnly: widget.isEditDeler,
//                                       initialValue: widget.dealersDetsils.taxInformation.pan.number,
//                                       //initialValue: widget.isEditDeler?widget.dealersDetsils.taxInformation.pan.number:prefs.getString("number_pan"),
//                                       autofocus: false,
//                                       onChanged: (value){
//
//                                         setState(() {
//                                           widget.number_pan=value;
//                                           widget.dealersDetsils.taxInformation.pan.number=value;
//
//                                           prefs.setString("number_pan", widget.number_pan);
//                                         });
//
//
//                                       },
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//
//                                           filled: true,
//                                           fillColor: backgroundSearchProductFormInput,
//                                           focusColor: sh_editText_background_active,
//                                           hintText:"",
//                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                     )),
//                                 decoration: BoxDecoration(
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ),
//
//
//                               SizedBox(height: 15,),
//                               Text("P.A.N. Reference No."),
//                               Container(
//
//                                 //   width: 100,
//                                 child:
//                                 SizedBox(
//                                     height: height_textFormfiled,
//                                     child:
//                                     TextFormField(
//
//                                       keyboardType: TextInputType.text,
//                                       readOnly: widget.isEditDeler,
//                                       initialValue: widget.dealersDetsils.taxInformation.pan.referenceNumber,
//                                       //initialValue: widget.isEditDeler?widget.dealersDetsils.taxInformation.pan.referenceNumber: prefs.getString("reference_number_pan"),
//                                       autofocus: false,
//                                       onChanged: (value){
//
//                                         setState(() {
//                                           widget.reference_number_pan=value;
//                                           widget.dealersDetsils.taxInformation.pan.referenceNumber=value;
//
//                                           prefs.setString("reference_number_pan", widget.reference_number_pan);
//                                         });
//
//                                       },
//
//
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//
//                                           filled: true,
//                                           fillColor: backgroundSearchProductFormInput,
//                                           focusColor: sh_editText_background_active,
//                                           hintText:"",
//                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                     )),
//                                 decoration: BoxDecoration(
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ),
//
//
//                             ],
//                           ),
//                           Container(),
//
//                           widget.isEditDeler? InkWell(onTap: (){
//
//                             flagAddDealer=true;
//                             showAlertDialogDealer(context);
//
//                             // if(selected_CustomerType=="Unregistered"||selected_CustomerType=="Unregistred")
//                             // {
//                             //   flagAddDealer=true;
//                             //   showAlertDialogDealer(context);
//                             // }
//                             // else
//                             // {
//                             //   if(widget.number.isEmptyOrNull&&widget.dealersDetsils.taxInformation.gst.customerType.key!="Unregistered")
//                             //   {
//                             //     print("Please Enter Gst Number");
//                             //     showToastDialog(context, "Please enter  GST number");
//                             //
//                             //   }
//                             //   else
//                             //   {
//                             //     String gst_regex = "^[0-9]{2}[A-Z]{5}[0-9]{4}" + "[A-Z]{1}[1-9A-Z]{1}" + "Z[0-9A-Z]{1}";
//                             //     if(!RegExp(gst_regex).hasMatch(widget.dealersDetsils.taxInformation.gst.number))
//                             //     {
//                             //       print("Please Enter valid GST Number");
//                             //       showToastDialog(context, "Please enter valid GST number");
//                             //
//                             //     }
//                             //
//                             //     else
//                             //     {
//                             //       print("Selected State Code   >>>>>>>>>>>>>>>>>   "+widget.dealersDetsils.state.name);
//                             //       if(stateCodesList.contains(widget.dealersDetsils.state.code))
//                             //       {
//                             //         int indexofStatecode =  stateCodesList.indexOf(widget.dealersDetsils.state.code);
//                             //         String selectedSateNo = stateNoList[indexofStatecode];
//                             //         print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
//                             //         print("Selected State No Match with GST    >>>>>>>>>>>>>>>>>   $selectedSateNo  "+widget.state.startsWith(selectedSateNo).toString());
//                             //
//                             //
//                             //
//                             //
//                             //         if(widget.number.startsWith(selectedSateNo)==false)
//                             //         {
//                             //           showToastDialog(context, "Please enter valid GST number with state");
//                             //         }
//                             //         else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.number_pan)&&widget.number_pan.isNotEmpty)
//                             //         {
//                             //
//                             //
//                             //           showToastDialog(context, "Please enter valid Pan no.");
//                             //
//                             //         }
//                             //         else
//                             //         {
//                             //
//                             //
//                             //
//                             //
//                             //
//                             //
//                             //
//                             //           flagAddDealer=true;
//                             //           showAlertDialogDealer(context);
//                             //
//                             //         }
//                             //
//                             //
//                             //       }
//                             //
//                             //
//                             //     }
//                             //
//                             //
//                             //
//                             //   }
//                             // }
//
//
//
//
//
//
//                           },
//                               child: Container(
//                                 width:width-20,
//                                 padding: EdgeInsets.all(10.0),
//                                 child: Text("UPDATE", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
//                                 decoration: BoxDecoration(
//                                   color: sh_colorPrimary,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(5),
//
//                                   ),
//
//                                 ),
//
//                               )
//                           ):
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 InkWell(onTap: (){
//                                   // Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDeatilsForm()));
//                                   PaymentTermsData obj = PaymentTermsData(widget.paymentTerms, widget.paymentMethod, widget.credit_limit, widget.overdue_balance);
//                                   Navigator.of(context).pop(obj);
//                                 },
//                                     child: Container(
//                                       width: ((width/2)-20),
//                                       padding: EdgeInsets.all(10.0),
//                                       child: Text("Previous", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
//                                       decoration: BoxDecoration(
//                                         color: sh_textColorSecondary,
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(5),
//
//                                         ),
//
//                                       ),
//                                     )
//                                 ),
//                                 SizedBox(width: 10.0,),
//                                 InkWell(onTap: (){
//
//
//
//                                   if(selected_CustomerType=="Unregistered")
//                                   {
//                                     flagAddDealer=true;
//                                     showAlertDialog(context);
//                                   }
//                                   else
//                                   {
//                                     if(widget.number.isEmptyOrNull)
//                                     {
//                                       print("Please Enter Gst Number");
//                                       showToastDialog(context, "Please enter  GST number");
//
//                                     }
//                                     else
//                                     {
//                                       String gst_regex = "^[0-9]{2}[A-Z]{5}[0-9]{4}" + "[A-Z]{1}[1-9A-Z]{1}" + "Z[0-9A-Z]{1}";
//                                       if(!RegExp(gst_regex).hasMatch(widget.number))
//                                       {
//                                         print("Please Enter valid GST Number");
//                                         showToastDialog(context, "Please enter valid GST number");
//
//                                       }
//
//                                       else
//                                       {
//                                         print("Selected State Code   >>>>>>>>>>>>>>>>>   "+widget.state);
//                                         if(stateCodesList.contains(widget.state))
//                                         {
//                                           int indexofStatecode =  stateCodesList.indexOf(widget.state);
//                                           String selectedSateNo = stateNoList[indexofStatecode];
//                                           print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
//                                           print("Selected State No Match with GST    >>>>>>>>>>>>>>>>>   $selectedSateNo  "+widget.state.startsWith(selectedSateNo).toString());
//
//
//
//
//                                           if(widget.number.startsWith(selectedSateNo)==false)
//                                           {
//                                             showToastDialog(context, "Please enter valid GST number with state");
//                                           }
//                                           else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.number_pan)&&widget.number_pan.isNotEmpty)
//                                           {
//
//
//                                             showToastDialog(context, "Please enter valid Pan no.");
//
//                                           }
//                                           else
//                                           {
//
//
//
//
//
//
//
//                                             flagAddDealer=true;
//                                             showAlertDialog(context);
//
//                                           }
//
//
//                                         }
//
//
//                                       }
//
//
//
//                                     }
//                                   }
//
//
//
//
//
//
//                                 },
//                                     child: Container(
//                                       width: ((width/2)-20),
//                                       padding: EdgeInsets.all(10.0),
//                                       child: Text("Submit", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
//                                       decoration: BoxDecoration(
//                                         color: sh_colorPrimary,
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(5),
//
//                                         ),
//
//                                       ),
//
//                                     )
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 15,),
//
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//             ),
//
//           ),
//
//           endDrawer: MyDrwaer(),
//         ));
//   }
//
//
//   showAlertDialog(BuildContext context) {
//     // Create button
//
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
//
//                 if(flagAddDealer){
//
//                   setState((){
//                     flagAddDealer=false;
//
//                   });
//
//                   addDealerMethode().then((value) {
//                     setState((){
//                       responseCode=value;
//                     });
//                   });
//                 }
//
//
//
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
//                                 child:responseCode==200?Image.asset(ic_greencheck,height: 50,width: 50, fit: BoxFit.fill,):
//                                 Image.asset(ic_form_preloader_gif,height: 50,width: 50, fit: BoxFit.fill,),
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.of(context).size.width,
//
//
//                                 child:responseCode==200?
//
//                                 Container(child:
//                                 Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(),
//                                         Text("Congratulations!",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                         Container()
//
//                                       ],
//                                     ) ,
//                                     Text(" Your New Customer has been ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(),
//                                         Text("Created!",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                         Container()
//
//                                       ],
//                                     )
//                                   ],
//                                 ),):
//
//                                 Text("Please wait",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                               ),
//                               true?Container(
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
//                                     Navigator.pop(context,false),
//
//
//                                     if(responseCode==200)
//                                       {
//                                         // Navigator.pop(context, false),
//                                         //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewDealers(true))),//28
//                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false))),//29jun
//                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers())),
//
//                                         //  Navigator.pop(context,false),
//
//
//                                       }
//                                     else
//                                       {
//                                         //      Navigator.pop(context),
//                                       }
//
//
//
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
//       if(closedialog)
//       {
//
//
//         print("Add Dialog Close >>>>>>>>>>>>>>>>>>>>>>>>>>>.");
//
//         FocusScope.of(context).unfocus();
//         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false)));
//         //ViewDealers(false).launch(context);
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ViewDealers(true)
//             ),
//                 (Route)=>false
//           // ModalRoute.withName("/ShHomeFragment")
//         );
//       }
//     });
//   }
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
//                       height: 125,
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
//
//   showToastDialog2(BuildContext context,String Message)
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
//                       height: 130,
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
//
//
//                                   // Navigator.pop(context, false),
//                                   // FocusScope.of(context).unfocus(),
//
//                                   Navigator.of(context).pop(),
//
//
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
//         }).then((value) {
//
//     });
//
//   }
// }



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////// ???????????????????????????????????????? //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:rosetta_fluter_app/Services/DistributorDealers/Models/PaymentTermsData.dart';
// import 'package:rosetta_fluter_app/rosetta/models/DealersDetails.dart';
// import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';
//
// import '../../main/utils/AppColors.dart';
// import '../../main/utils/AppWidget.dart';
// import '../../rosetta/models/AddDealerError.dart';
// import '../../rosetta/models/MasterData.dart';
// import '../../rosetta/utils/ShColors.dart';
// import '../../rosetta/utils/ShConstant.dart';
// import '../../rosetta/utils/ShFunction.dart';
// import '../../rosetta/utils/ShImages.dart';
// import 'TaxInformationForm.dart';
// import 'package:http/http.dart' as http;
//
// import 'ViewDealers.dart';
// SharedPreferences prefs;
//
// class PaymentTermsForm extends StatefulWidget {
//
//   String dealer_type="";
//   String dealerName="",contactPerson="",email="",password="",phone="",fax="",address="",address2="",state="",city="",postcode="";
//   String  paymentTerms="",paymentMethod,credit_limit="2000",overdueBalance="0";
//   bool isEditDeler;
//   DealersDetsils dealersDetsils;
//
//   PaymentTermsForm(
//       this.dealer_type,
//       this.dealerName,
//       this.contactPerson,
//       this.email,
//       this.password,
//       this.phone,
//       this.fax,
//       this.address,
//       this.address2,
//       this.state,
//       this.city,
//       this.postcode,
//       this.isEditDeler,
//       this.dealersDetsils
//
//       );
//
//   @override
//   _PaymentTermsFormState createState() => _PaymentTermsFormState();
// }
//
// class _PaymentTermsFormState extends State<PaymentTermsForm> {
//   bool isPtermsSelected = false;
//   bool isPMethodeSelected = false;
//   var checkNetconnection=null;
//   String MyToken;
//   String MyUserName="";
//   String MyCompanyId;
//   String MyMemberId;
//   String MyMemberType;
//   String  Myparent_distributor_id;
//   String  Myparent_distributor_nav_id;
//   var newJsonData;
//
//
//   List<PaymentTerms> payment_term_list=[];
//   List<String> spinnerAllPaymentTerms = [];
//   String selected_PaymentTerms="PaymentTerms";
//
//
//   List<PaymentMethod> payment_methode_list=[];
//   List<String> spinnerAllPaymentMethod = [];
//   String selected_PaymentMethod="Payment Method";
//
//
//   String defaultPaymentTerms  = "";//spinnerAllPaymentTerms[1]
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//
//   getSessionData() async
//   {
//     print("Get Session Methode Call");
//     prefs = await SharedPreferences.getInstance();
//
//
//     if(widget.isEditDeler==false)
//     {
//       setAllData();
//     }
//
//
//
//
//
//
//
//
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
//
//         getAllDataMaster();
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
//   setAllData(){
//
//
//     setState(() {
//
//       widget.credit_limit =  prefs.getString("credit_limit");
//       widget.overdueBalance =  prefs.getString("overdueBalance");
//       selected_PaymentMethod=widget.paymentMethod;
//       selected_PaymentTerms=widget.paymentTerms;
//
//
//       print("paymentTerms   >>>>>>>>>>  "+widget.paymentTerms);
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
//   bool isOverDueEdit =false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//
//
//
//
//
//
//     if(widget.isEditDeler)
//     {
//
//       setState(()
//       {
//         isPMethodeSelected=true;
//
//         widget.paymentMethod=widget.dealersDetsils.paymentMethod.key==null?"":widget.dealersDetsils.paymentMethod.key;
//         widget.credit_limit=widget.credit_limit==null?"":widget.dealersDetsils.creditLimit.toString();
//         widget.overdueBalance=widget.dealersDetsils.overdueBalance==null?"":widget.dealersDetsils.overdueBalance.toString();
//
//         //  print("PAN Status >>>>>>>>>>>>>> "+widget.dealersDetsils.taxInformation.pan.status.toString());
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
//         if(widget.dealersDetsils.paymentTerms.key!=null||widget.dealersDetsils.paymentTerms.key!="")
//         {
//           selected_PaymentTerms=widget.dealersDetsils.paymentTerms.key;
//           widget.paymentTerms=widget.dealersDetsils.paymentTerms.key==null?"":widget.dealersDetsils.paymentTerms.key;
//
//         }
//         if(widget.dealersDetsils.paymentMethod.key!=null&&widget.dealersDetsils.paymentMethod.key!="")
//         {
//           selected_PaymentMethod=widget.dealersDetsils.paymentMethod.key;
//
//         }
//
//         if(widget.dealersDetsils.taxInformation.pan.status?.value.toString().isEmptyOrNull)
//         {
//           print("Pan Status null >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
//         }
//         else
//         {
//           print("Pan Status >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
//         }
//
//
//         //widget.dealersDetsils.fax.toString()
//
//
//
//         if(widget.dealersDetsils.overdueBalance==0)
//         {
//           setState(() {
//
//             isOverDueEdit=true;
//
//           });
//         }
//
//         print("Selected Terms >>>>>>>>>>>>>>>>>>>>> "+selected_PaymentTerms);
//
//
//
//
//       });
//     }
//     else
//     {
//       setState(() {
//         isPMethodeSelected=false;
//         print("**&&&&&");
//
//       });
//     }
//
//     //print("Payment Term Form Dealer Name "+widget.dealerName+"  "+widget.contactPerson+""+widget.email+""+widget.password+""+widget.phone+""+widget.fax+""+widget.address+""+widget.address2+""+widget.state+""+widget.city+""+widget.postcode+"");
//     getSessionData();
//
//
//
//
//
//
//     print("Data of Payment Methode "+selected_PaymentMethod);
//     print("Data of Payment Terms "+selected_PaymentTerms);
//     var x = spinnerAllPaymentMethod.isNotEmpty?isPMethodeSelected? selected_PaymentMethod:widget.paymentMethod:selected_PaymentMethod;
//     var y =spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms;
//     print("Data of Payment Methode $x");
//     print("Data of Payment Terms $y");
//
//
//
//
//   }
//
//   getAllDataMaster() async {
//
//     print("Get All Data Master Api Call >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
//     http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/master'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'bearer $MyToken',
//       },
//     );
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//     print("Response Body of Form Get All Data Master Api Call  Data Api : $responcebody");
//     print("Response code Form Get All Data Master Api Call  Data Api : $responseCode");
//     if(responseCode==200){
//
//
//       setState(()
//       {
//         var data = json.decode(responcebody);
//
//
//         var rest = data["payment_terms"] as List;
//         payment_term_list = rest.map<PaymentTerms>((json) => PaymentTerms.fromJson(json)).toList();
//         print("Shipping Methode List  Length >>>>>>>  "+payment_term_list.length.toString());
//         getSpinnerAllPaymentTerms();
//
//
//
//         var rest2 = data["payment_method"] as List;
//         payment_methode_list = rest2.map<PaymentMethod>((json) => PaymentMethod.fromJson(json)).toList();
//         print("Shipping Methode List  Length >>>>>>>  "+payment_methode_list.length.toString());
//         getSpinnerAllPaymentMethodes();
//
//
//
//       });
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
//       // ignore: missing_return
//
//
//
//
//
//
//
//
//     }
//   }
//   getSpinnerAllPaymentTerms () async {
//
//
//     print("Get spinnerAllPaymentTerms  List Methode Call");
//
//     String value = prefs.getString("paymentTerms");
//
//     print("A Payment Terms >>>>>>>>>>>>>>>>>>>  "+value.toString());
//
//     var length = payment_term_list.length;
//     print(" Spinner spinnerAllPaymentTerms  lsi length is $length");
//
//     for(int i=0;i<payment_term_list.length;i++)
//     {
//       var displayname;
//       print(" Spinner Sates List  Loop is Called ");
//       setState(() {
//
//
//         if(i==0)
//         {
//
//           spinnerAllPaymentTerms.add("PaymentTerms");
//
//
//           spinnerAllPaymentTerms.add(payment_term_list[i].key);
//           displayname = spinnerAllPaymentTerms[i];
//
//         }
//         else
//         {
//           spinnerAllPaymentTerms.add(payment_term_list[i].key);
//           displayname = spinnerAllPaymentTerms[i];
//         }
//
//         ///SelectedDealer2=spinnerSelectDealer2[0];
//       });
//
//
//
//
//
//       print(" Spinner Dealer List   Name $displayname");
//     }
//
//
//
//
//
//     if(prefs.getString("paymentTerms").isEmptyOrNull)
//     {
//       widget.paymentTerms = spinnerAllPaymentTerms[1];
//     }
//     else
//     {
//       widget.paymentTerms = prefs.getString("paymentTerms");
//     }
//
//
//
//
//
//     print("Length of Spinner All States length is "+spinnerAllPaymentTerms.length.toString()+"   "+ widget.paymentTerms);
//   }
//   getSpinnerAllPaymentMethodes () async {
//
//
//     print("Get spinnerAllPaymentTerms  List Methode Call");
//
//     var length = payment_methode_list.length;
//     print(" Spinner spinnerAllPaymentTerms  lsi length is $length");
//
//     for(int i=0;i<payment_methode_list.length;i++)
//     {
//       var displayname;
//       print(" Spinner Sates List  Loop is Called ");
//       setState(() {
//         if(i==0)
//         {
//
//           spinnerAllPaymentMethod.add("Payment Method");
//
//           spinnerAllPaymentMethod.add(payment_methode_list[i].key);
//           displayname = spinnerAllPaymentMethod[i];
//
//
//         }
//         else
//         {
//           spinnerAllPaymentMethod.add(payment_methode_list[i].key);
//           displayname = spinnerAllPaymentMethod[i];
//         }
//
//         ///SelectedDealer2=spinnerSelectDealer2[0];
//       });
//
//
//       print(" Spinner Dealer List   Name $displayname");
//     }
//
//     //widget.paymentMethod=spinnerAllPaymentMethod[1];
//
//
//     if(prefs.getString("paymentTerms").isEmptyOrNull)
//     {
//
//       widget.paymentMethod=spinnerAllPaymentMethod[1];
//     }
//     else
//     {
//       widget.paymentMethod = prefs.getString("paymentMethod");
//     }
//
//
//
//     print("Length of Spinner All States length is "+spinnerAllPaymentMethod.length.toString()+"  "+widget.paymentMethod);
//   }
//
//
//
//   bool flagAddDealer =true;
//   Future<int> addDealerMethode() async {
//
//     print("Add Dealer  Api Call " );
//
//     newJsonData = {
//       "dealer_type": "1",
//       "distributorId": 103,
//       "companyId": 3,
//       "name": "TestDlrG",
//       "contact": "Haider",
//       "address": "Clover Center",
//       "address2": "Camp",
//       "state": "MAH",
//       "city": "Pune",
//       "zipcode": "411001",
//       "paymentTerms": "1 MONTH",
//       "paymentMethod": "AS AGREED",
//       "credit_limit": "50000",
//       "phone": "8987889876",
//       "email": "testdlrg1@test.com",
//       "password": "passw0rd!",
//       "fax": "",
//       "tax_information": {
//         "gst": {
//           "customer_type": "Registered",
//           "registration_type": "GSTIN",
//           "number": "27ACEPH9757K1Z1"
//         },
//         "pan": {
//           "number": "",
//           "status": "",
//           "reference_number": ""
//         }
//       },
//       "overdue_balance": 0,
//       "user": {
//         "email": "testdlr88@test.com",
//         "phone": "8917689819",
//         "password": "passw0rd!"
//       }
//     };
//
//     var res = await http.post(Uri.parse(API_ROS_PROD__BASE_URL +
//         '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers'),
//         body: jsonEncode(newJsonData),
//         headers: {
//           'Authorization': 'bearer $MyToken',
//           'Content-Type': 'application/json'
//         }
//     );
//
//     print("Add Dealer  Api Status Code " + res.statusCode.toString());
//
//
//   }
//
//
//
//
//   int responseCode=0;
//   bool closedialog = true;
//   Future<int> editDealerMethode() async {
//     // closedialog = true;
//     //responseCode=0;
//
//     print("Edit  Dealer  Api Call "+widget.dealersDetsils.id.toString() );
//
//     //  String gst_number = widget.number;
//
//
//
//     var gstJosnData;
//     widget.dealer_type=widget.dealersDetsils.dealerType.toString();
//
//     if(widget.dealer_type=="2")
//     {
//       gstJosnData={
//         "customer_type": "Unregistered",
//         "registration_type": "GSTIN",
//         "number": ""
//       };
//     }
//     else
//     {
//       gstJosnData=  {
//         "customer_type": widget.dealersDetsils.dealerType,
//         "registration_type": "GSTIN",
//         "number": widget.dealersDetsils.taxInformation.gst.number//27ACEPH9757K1Z1
//       };
//     }
//
//
//
//
//
//     newJsonData = {
//       "dealer_type": widget.dealersDetsils.dealerType,
//       "distributorId": MyMemberId,
//       "companyId": MyCompanyId,
//       "name": widget.dealersDetsils.name,
//       "contact": widget.dealersDetsils.contact,
//       "address": widget.dealersDetsils.address,
//       "address2": widget.dealersDetsils.address2,
//       "state": widget.dealersDetsils.state.code,
//       "city": widget.dealersDetsils.city,
//       "zipcode":widget.dealersDetsils.zipcode,
//       "paymentTerms": widget.dealersDetsils.paymentTerms.key,
//       "paymentMethod": widget.dealersDetsils.paymentMethod.key,
//       "credit_limit": widget.dealersDetsils.creditLimit,
//       "phone": widget.dealersDetsils.phone,
//       "email": widget.dealersDetsils.email,
//       "fax": "",
//       "tax_information":
//       {
//         "gst": gstJosnData,
//
//         // {
//         //   "customer_type": "Unregistered",
//         //   "registration_type": "GSTIN",
//         //   "number": ""
//         // },
//         // "gst": {
//         //   "customer_type": widget.customer_type,
//         //   "registration_type": "GSTIN",
//         //   "number": widget.customer_type=="Unregisterd"?"":widget.number//27ACEPH9757K1Z1
//         // },
//         "pan": {
//           "number": widget.dealersDetsils.taxInformation.pan.number,
//           "status": widget.dealersDetsils.taxInformation.pan.status?.value==null?"":widget.dealersDetsils.taxInformation.pan.status?.value,
//           "reference_number": widget.dealersDetsils.taxInformation.pan.referenceNumber
//         }
//       },
//       "overdue_balance": widget.dealersDetsils.overdueBalance,
//       "user": {
//         "email": widget.dealersDetsils.email,
//         "phone": widget.dealersDetsils.phone,
//
//       }
//     };
//
//
//     print("JSON OF Edit DELAER >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  $newJsonData");
//
//
//     //http://rosdev.rosettaproducts.com/api/companies/3/distributors/103/dealers/2315
//     var res = await http.put(Uri.parse(API_ROS_PROD__BASE_URL +
//         '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers/'+widget.dealersDetsils.id.toString()),
//         body: jsonEncode(newJsonData),
//         headers: {
//           'Authorization': 'bearer $MyToken',
//           'Content-Type': 'application/json'
//         }
//     );
//
//     print("Edit  Dealer  Api Status Code " + res.statusCode.toString());
//     print("Edit Dealer  Api Status bODY " + res.body.toString());
//
//     // final parsedJson = jsonDecode(res.body);
//     // print('${parsedJson.runtimeType} : $parsedJson');
//
//
//
//     if(res.statusCode!=200) {
//
//       setState(() {
//
//         // closedialog = false;
//       });
//       Map<String, dynamic> res2 = jsonDecode(res.body);
//       print(res2.containsKey("country"));
//       print("Json Keys " + res2.keys.toString());
//       String myKey = res2.keys.toString();
//
//
//       var error_message="";
//       res2.keys.forEach((element) {
//         print("Json Key Value  $element");
//         error_message =error_message+'\n'+ AddDealerError
//             .fromJson(jsonDecode(res.body), element).name[0];
//
//
//         // Navigator.of(context, rootNavigator: true).pop();
//
//
//
//         print("Error message is >>>>>>>>>>>>>>>  " + error_message.toString());
//       });
//
//       if(error_message.isNotEmpty)
//       {
//
//
//         error_message_add_dealer=error_message;
//         prefs.setString('error_message', error_message);
//
//
//         Navigator.of(context, rootNavigator: true).pop();
//
//
//         Navigator.of(context).pop();
//         Navigator.of(context).pop(error_message);
//         //showToastDialog2(context, error_message.replaceAll(".", " "));
//       }
//     }
//
//
//
//
//
//     print(">>>>>>Josn Object key "+jsonEncode(res.body));
//
//
//
//
//
//
//
//
//     setState(() {
//
//       //responseCode=res.statusCode;
//
//
//     });
//
//     if(res.statusCode==200)
//     {
//       // prefs.setString("paymentTerms","");
//       // prefs.setString("paymentMethod","");
//       // prefs.setString("credit_limit","2000");
//       // prefs.setString("overdueBalance","0");
//       // prefs.setString("gst","");
//       // prefs.setString("reference_number_pan","");
//       // prefs.setString("number_pan","");
//       // prefs.setString("customer_type","");
//       // prefs.setString("status_pan","");
//
//
//     }
//
//     return res.statusCode;
//
//
//   }
//   showAlertDialog(BuildContext context) {
//     // Create button
//
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
//
//                 if(flagAddDealer){
//
//                   setState((){
//                     flagAddDealer=false;
//
//                   });
//
//                   editDealerMethode().then((value) {
//                     setState((){
//                       responseCode=value;
//                     });
//                   });
//                 }
//
//
//
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
//                                 child:responseCode==200?Image.asset(ic_greencheck,height: 50,width: 50, fit: BoxFit.fill,):
//                                 Image.asset(ic_form_preloader_gif,height: 50,width: 50, fit: BoxFit.fill,),
//                               ),
//                               Container(
//                                 alignment: Alignment.center,
//                                 width: MediaQuery.of(context).size.width,
//
//
//                                 child:responseCode==200?
//
//                                 Container(child:
//                                 Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(),
//                                         Text(
//                                           widget.dealersDetsils.dealerType==1?  "Dealer information successfully":"Retailer information successfully",
//                                           style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                         Container()
//
//                                       ],
//                                     ) ,
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(),
//                                         Text("updated.",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                                         Container()
//
//                                       ],
//                                     ) ,
//                                   ],
//                                 ),):
//
//                                 Text("Please wait",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
//                               ),
//                               true?Container(
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
//                                     Navigator.pop(context,false),
//
//
//                                     if(responseCode==200)
//                                       {
//                                         // Navigator.pop(context, false),
//                                         //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewDealers(true))),//28
//                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false))),//29jun
//                                         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers())),
//
//                                         //  Navigator.pop(context,false),
//
//
//                                       }
//                                     else
//                                       {
//                                         //      Navigator.pop(context),
//                                       }
//
//
//
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
//       if(closedialog)
//       {
//
//
//         print("Add Dialog Close >>>>>>>>>>>>>>>>>>>>>>>>>>>.");
//
//         FocusScope.of(context).unfocus();
//         // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false)));
//         //ViewDealers(false).launch(context);
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ViewDealers(true)
//             ),
//                 (Route)=>false
//           // ModalRoute.withName("/ShHomeFragment")
//         );
//       }
//     });
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return MediaQuery(
//         data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
//         child:
//
//         Scaffold(
//
//
//           resizeToAvoidBottomInset: false,
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(50),
//             child:widget.isEditDeler?MyAppBar(false,"Payment Details Update","",false,true):
//             MyAppBar2(false,"Add Customer","",false),
//           ),
//           body: SingleChildScrollView(
//             child: Container(
//
//
//                 child: Column(
//                   children: [
//                     widget.isEditDeler?Container():Container(
//                         color: sh_ColorPrimary2,
//                         padding: EdgeInsets.all(15.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//
//
//                             Row(
//                               children: [
//                                 Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary,),
//                                 SizedBox(width: 3,),
//                                 Text("Personal Details",style: TextStyle(fontSize: 13.0,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary,),
//                                 SizedBox(width: 3,),
//                                 Text("Payment",style: TextStyle(fontSize: 13.0,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),
//
//
//                               ],
//                             ),
//                             Row(
//                                 children: [
//                                   Image.asset(ic_nextdisable,height:13,width: 13,color: secondColor),
//                                   SizedBox(width: 3,),
//                                   Text("Tax Information",style: TextStyle(fontSize: 13.0,color:sh_textColorSecondarylight2, ),),
//                                 ]
//                             ),
//
//
//                           ],
//                         )
//
//                     ),
//                     widget.isEditDeler?Container(): Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: width-(width/3),
//                           height: 3,
//                           color: sh_colorPrimary,
//                         ) ,
//                         Container(
//                           width: width/3,
//                           height: 3,
//                           color: sh_textColorSecondarylight,
//                         )
//
//                       ],
//                     ),
//
//
//
//                     Container(
//                       height: height-150,
//                       padding: EdgeInsets.symmetric(horizontal: 15.0),
//
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//
//                         children: [
//
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//
//
//                               SizedBox(height: 15,),
//                               Text("Payment Terms"),
//                               SizedBox(height: 10,),
//                               Container(
//
//                                 padding: EdgeInsets.only(left: 15,right: 10),
//
//                                 child:  new DropdownButton<String>(
//                                   //value: selected_PaymentTerms,
//                                   value:
//                                   spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms,
//                                   // value:widget.isEditDeler?selected_PaymentTerms:
//                                   // spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms,
//                                   hint: new Text("Select Here"),
//                                   isExpanded: true,
//                                   icon: Icon(
//                                     Icons.arrow_drop_down,
//                                     color:
//                                     sh_textColorSecondary,
//                                     size: 25,
//                                   ),
//                                   iconSize: 24,
//                                   elevation: 16,
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18,
//                                   ),
//                                   underline: Container(
//                                     height: 2,
//                                   ),
//                                   onChanged: (String value) {
//                                     setState(() {
//
//
//
//
//                                       isPtermsSelected=true;
//
//                                       selected_PaymentTerms = value;
//                                       widget.paymentTerms=value;
//
//                                       // widget.dealersDetsils.paymentTerms.key=value;
//                                       // widget.dealersDetsils.paymentTerms.value=value;
//
//                                       if(widget.isEditDeler)
//                                       {
//                                         print("***1");
//                                         widget.dealersDetsils.paymentTerms.key=value;
//                                         widget.dealersDetsils.paymentTerms.value=value;
//                                       }
//
//
//
//                                       prefs.setString("paymentTerms", widget.paymentTerms);
//
//
//
//                                     });
//                                   },
//                                   items: spinnerAllPaymentTerms
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: text(value,
//                                               fontSize: textSizeSmall,
//                                               fontFamily: fontRegular,
//                                               textColor: sh_textColorSecondary),
//                                         );
//                                       }).toList(),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ),
//
//
//
//                               SizedBox(height: 15,),
//                               Text("Payment Methods"),
//                               SizedBox(height: 10,),
//                               // widget.isEditDeler&&widget.dealersDetsils.paymentTerms.key.isNotEmpty?
//                               //
//                               //
//                               // Container(
//                               //   width: width,
//                               //   child:Text(widget.dealersDetsils.paymentMethod.key,style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),),
//                               //   padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                               //   decoration: BoxDecoration(
//                               //     color: Colors.blue,
//                               //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                               //     borderRadius: BorderRadius.all(Radius.circular(5)),
//                               //   ),
//                               //
//                               //
//                               //
//                               //
//                               // )
//
//                               widget.isEditDeler&&widget.dealersDetsils.paymentTerms.key.isNotEmpty?
//
//                               Container(
//
//
//                                 padding: EdgeInsets.only(left: 15,right: 10),
//
//                                 child:  new DropdownButton<String>(
//                                   //spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms,
//
//                                   value:
//                                   widget.isEditDeler?selected_PaymentMethod:
//                                   spinnerAllPaymentMethod.isNotEmpty?
//                                   isPMethodeSelected? selected_PaymentMethod:widget.paymentMethod
//
//                                       :selected_PaymentMethod,
//
//                                   hint: new Text("Select Here"),
//                                   isExpanded: true,
//                                   icon: Icon(
//                                     Icons.arrow_drop_down,
//                                     color:
//                                     sh_textColorSecondary,
//                                     size: 25,
//                                   ),
//                                   iconSize: 24,
//                                   elevation: 16,
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18,
//                                   ),
//                                   underline: Container(
//                                     height: 2,
//                                   ),
//                                   onChanged: (String value) {
//                                     setState(() {
//
//                                       isPMethodeSelected=true;
//                                       selected_PaymentMethod = value;
//                                       widget.paymentMethod=value;
//                                       if(widget.isEditDeler)
//                                       {
//                                         print("***1");
//                                         widget.dealersDetsils.paymentMethod.key=value;
//                                         widget.dealersDetsils.paymentMethod.value=value;
//                                       }
//                                       else
//                                       {
//                                         print("***1");
//                                       }
//
//                                       prefs.setString("paymentMethod", widget.paymentMethod);
//
//
//
//                                     });
//                                   },
//                                   items: spinnerAllPaymentMethod
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: text(value,
//                                               fontSize: textSizeSmall,
//                                               fontFamily: fontRegular,
//                                               textColor: sh_textColorSecondary),
//                                         );
//                                       }).toList(),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               )
//                               //  Container(
//                               //    width: width,
//                               //    //height: 2,
//                               // //   child:Text(widget.dealersDetsils.paymentMethod.key,style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),),
//                               //    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                               //    decoration: BoxDecoration(
//                               //     // color: Colors.blue,
//                               //      border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                               //      borderRadius: BorderRadius.all(Radius.circular(5)),
//                               //    ),
//                               //    child:  new DropdownButton<String>(
//                               //      //spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms,
//                               //
//                               //      value:widget.isEditDeler?selected_PaymentMethod:
//                               //      spinnerAllPaymentMethod.isNotEmpty?isPMethodeSelected? selected_PaymentMethod:widget.paymentMethod:selected_PaymentMethod,
//                               //
//                               //      hint: new Text("Select Here"),
//                               //      isExpanded: true,
//                               //      icon: Icon(
//                               //        Icons.arrow_drop_down,
//                               //        color:
//                               //        sh_textColorSecondary,
//                               //        size: 25,
//                               //      ),
//                               //      iconSize: 24,
//                               //      elevation: 16,
//                               //      style: TextStyle(
//                               //        color: Colors.black,
//                               //        fontSize: 18,
//                               //      ),
//                               //      underline: Container(
//                               //        height: 2,
//                               //      ),
//                               //      onChanged: (String value) {
//                               //        setState(() {
//                               //
//                               //          isPMethodeSelected=true;
//                               //          selected_PaymentMethod = value;
//                               //          widget.paymentMethod=value;
//                               //          if(widget.isEditDeler)
//                               //          {
//                               //            print("***1");
//                               //            widget.dealersDetsils.paymentMethod.key=value;
//                               //            widget.dealersDetsils.paymentMethod.value=value;
//                               //          }
//                               //          else
//                               //          {
//                               //            print("***1");
//                               //          }
//                               //
//                               //          prefs.setString("paymentMethod", widget.paymentMethod);
//                               //
//                               //
//                               //
//                               //        });
//                               //      },
//                               //      items: spinnerAllPaymentMethod
//                               //          .map<DropdownMenuItem<String>>(
//                               //              (String value) {
//                               //            return DropdownMenuItem<String>(
//                               //              value: value,
//                               //              child: text(value,
//                               //                  fontSize: textSizeSmall,
//                               //                  fontFamily: fontRegular,
//                               //                  textColor: sh_textColorSecondary),
//                               //            );
//                               //          }).toList(),
//                               //    ),
//                               //
//
//
//                               //   )
//                                   :Container(
//
//
//                                 padding: EdgeInsets.only(left: 15,right: 10),
//
//                                 child:  new DropdownButton<String>(
//                                   //spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms,
//
//                                   value:widget.isEditDeler?selected_PaymentMethod:
//                                   spinnerAllPaymentMethod.isNotEmpty?isPMethodeSelected? selected_PaymentMethod:widget.paymentMethod:selected_PaymentMethod,
//
//                                   hint: new Text("Select Here"),
//                                   isExpanded: true,
//                                   icon: Icon(
//                                     Icons.arrow_drop_down,
//                                     color:
//                                     sh_textColorSecondary,
//                                     size: 25,
//                                   ),
//                                   iconSize: 24,
//                                   elevation: 16,
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 18,
//                                   ),
//                                   underline: Container(
//                                     height: 2,
//                                   ),
//                                   onChanged: (String value) {
//                                     setState(() {
//
//                                       isPMethodeSelected=true;
//                                       selected_PaymentMethod = value;
//                                       widget.paymentMethod=value;
//
//                                       print("TTTTTTTTTTTTTTTTTTTTT DDDDDDDDDDDDDDDDDDDDDDdddd");
//                                       print(selected_PaymentMethod);
//                                       print(widget.paymentMethod);
//                                       print(spinnerAllPaymentMethod);
//                                       print(value);
//                                       if(widget.isEditDeler)
//                                       {
//                                         print("***1");
//                                         widget.dealersDetsils.paymentMethod.key=value;
//                                         widget.dealersDetsils.paymentMethod.value=value;
//                                       }
//                                       else
//                                       {
//                                         print("***1");
//                                       }
//
//                                       prefs.setString("paymentMethod", widget.paymentMethod);
//
//
//
//                                     });
//                                   },
//                                   items: spinnerAllPaymentMethod
//                                       .map<DropdownMenuItem<String>>(
//                                           (String value) {
//                                         return DropdownMenuItem<String>(
//                                           value: value,
//                                           child: text(value,
//                                               fontSize: textSizeSmall,
//                                               fontFamily: fontRegular,
//                                               textColor: sh_textColorSecondary),
//                                         );
//                                       }).toList(),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ),
//
//
//                               SizedBox(height: 15,),
//                               Text("Credit Limit *"),
//                               SizedBox(height: 10,),
//                               Container(
//
//                                 //   width: 100,
//                                 child:
//                                 SizedBox(
//                                     height: height_textFormfiled,
//                                     child:
//                                     TextFormField(
//                                       keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                       initialValue: widget.isEditDeler?widget.dealersDetsils.creditLimit.toString():widget.credit_limit,
//
//                                       autofocus: false,
//                                       onChanged: (value){
//
//                                         setState(() {
//                                           widget.credit_limit=value;
//
//
//
//                                           widget.dealersDetsils.creditLimit=value.toInt();
//
//                                           prefs.setString("credit_limit", widget.credit_limit);
//
//
//                                         });
//
//                                       },
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//
//                                           filled: true,
//                                           fillColor: backgroundSearchProductFormInput,
//                                           focusColor: sh_editText_background_active,
//                                           hintText:"",
//                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                     )),
//                                 decoration: BoxDecoration(
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ),
//
//
//                               SizedBox(height: 15,),
//                               Text("Overdue Balance"),
//                               SizedBox(height: 10,),
//                               Container(
//
//                                 //   width: 100,
//                                 child:
//                                 SizedBox(
//                                     height: height_textFormfiled,
//                                     child:
//                                     TextFormField(
//                                       keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//                                       initialValue: widget.isEditDeler?widget.dealersDetsils.overdueBalance.toString(): widget.overdueBalance,
//                                       //readOnly: widget.isEditDeler?(isOverDueEdit?false:true):false,
//                                       // widget.isEditDeler,
//                                       autofocus: false,
//                                       onChanged: (value){
//                                         setState(() {
//                                           widget.overdueBalance=value;
//                                           widget.dealersDetsils.overdueBalance=value.toInt();
//                                           prefs.setString("overdueBalance", widget.overdueBalance);
//                                         });
//
//
//                                       },
//
//                                       textCapitalization: TextCapitalization.words,
//                                       style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
//                                       decoration: InputDecoration(
//
//                                           filled: true,
//                                           fillColor: backgroundSearchProductFormInput,
//                                           focusColor: sh_editText_background_active,
//                                           hintText:"",
//                                           hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
//                                           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
//                                           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
//                                     )),
//                                 decoration: BoxDecoration(
//
//                                   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
//                                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 ),
//
//                               ),
//
//
//                             ],
//                           ),
//
//                           widget.isEditDeler? InkWell(onTap: () async {
//
//                             if(widget.credit_limit.isEmpty)
//                             {
//
//
//                               showToastDialog(context, "Please Enter Credit Limit");
//                             }
//
//                             else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.credit_limit))
//                             {
//
//                               showToastDialog(context, "Please enter digits in credit limits ");
//
//                             }
//                             else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.overdueBalance)&&widget.overdueBalance.isNotEmpty)
//                             {
//
//                               showToastDialog(context, "Please enter digits in overdue balance ");
//
//                             }
//                             else
//                             {
//
//                               flagAddDealer=true;
//                               showAlertDialog(context);
//
//
//                             }
//
//                             //   addDealerMethode();
//                           },
//                               child: Container(
//                                 width: width-20,
//
//                                 padding: EdgeInsets.all(10.0),
//                                 child: Text("UPDATE", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
//                                 decoration: BoxDecoration(
//                                   color: sh_colorPrimary,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(5),
//
//                                   ),
//
//                                 ),
//
//                               )
//                           ):
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 InkWell(onTap: (){
//                                   // Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDeatilsForm()));
//                                   FocusScope.of(context).unfocus();
//                                   Navigator.of(context).pop();
//                                 },
//                                     child: Container(
//                                       width: ((width/2)-20),
//                                       padding: EdgeInsets.all(10.0),
//                                       child: Text("Previous", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
//                                       decoration: BoxDecoration(
//                                         color: sh_textColorSecondary,
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(5),
//
//                                         ),
//
//                                       ),
//                                     )
//                                 ),
//                                 SizedBox(width: 10.0,),
//                                 InkWell(onTap: () async {
//
//                                   if(widget.credit_limit.isEmpty)
//                                   {
//
//
//                                     showToastDialog(context, "Please Enter Credit Limit");
//                                   }
//
//                                   else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.credit_limit))
//                                   {
//
//                                     showToastDialog(context, "Please enter digits in credit limits ");
//
//                                   }
//                                   else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.overdueBalance)&&widget.overdueBalance.isNotEmpty)
//                                   {
//
//                                     showToastDialog(context, "Please enter digits in overdue balance ");
//
//                                   }
//                                   else
//                                   {
//
//                                     //  prefs.setString("paymentTerms", widget.paymentTerms);
//                                     //prefs.setString("paymentMethod", widget.paymentMethod);
//                                     prefs.setString("credit_limit", widget.credit_limit);
//                                     prefs.setString("overdueBalance", widget.overdueBalance);
//
//                                     var credeitLimis1= widget.credit_limit;
//                                     var overduebalance= widget.overdueBalance;
//
//
//                                     widget.credit_limit="";
//                                     widget.overdueBalance="";
//
//                                     var obj =   await Navigator.push(context, MaterialPageRoute(builder: (context) => TextInformationForm(
//                                         widget.dealer_type,
//                                         widget.dealerName,
//                                         widget.contactPerson,
//                                         widget.address,
//                                         widget.address2,
//                                         widget.state,
//                                         widget.city,
//                                         widget.paymentTerms,
//                                         widget.paymentMethod,
//                                         credeitLimis1,
//                                         widget.phone,
//                                         widget.email,
//                                         widget.password,
//                                         widget.fax,
//                                         overduebalance,
//                                         widget.email,
//                                         widget.phone,
//                                         widget.password,
//                                         widget.postcode,
//                                         false,
//                                         null
//
//
//                                     ))) ;
//
//
//
//
//                                     PaymentTermsData obj2 = obj as PaymentTermsData;
//
//                                     // print("PaymentTerms Recived Data >>>>>>>>>>>>>>>>>>>>>>>>>>>"+obj2.creditLimits);
//
//                                     setState(() {
//
//
//
//
//                                     });
//
//                                   }
//
//                                   //   addDealerMethode();
//                                 },
//                                     child: Container(
//                                       width: ((width/2)-20),
//                                       padding: EdgeInsets.all(10.0),
//                                       child: Text("Next", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
//                                       decoration: BoxDecoration(
//                                         color: sh_colorPrimary,
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(5),
//
//                                         ),
//
//                                       ),
//
//                                     )
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 15,),
//
//
//
//
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//             ),
//
//           ),
//
//           endDrawer: MyDrwaer(),
//         ));
//   }
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
// }