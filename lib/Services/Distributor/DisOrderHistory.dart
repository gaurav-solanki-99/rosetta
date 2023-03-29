import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:rosetta_fluter_app/Services/shimmer_list.dart';
import 'package:rosetta_fluter_app/main/utils/AppColors.dart';
import 'package:rosetta_fluter_app/rosetta/models/DealersPosDistributor.dart';
import 'package:rosetta_fluter_app/rosetta/models/OrderHistoryList.dart';

import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';

import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/rosetta/models/SpinnerDealersList.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShFunction.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';

import '../../rosetta/models/AllDealerOrderHistory.dart';
import '../../rosetta/models/SkipButtonApi.dart';
import 'DisAprroveOrder.dart';
import 'DistributorOrderDetails.dart';
import 'NewDisOrderDetailsPage.dart';
import 'distributorShippingPage.dart';
import 'package:http/http.dart' as http;



class DisOrderHistory  extends StatefulWidget {
  List<SalesOrder> DealerssalesOrdersTemp=[];

  bool isResetDealerList=false;

  List<PurchaseOrderHitory> purchaseOrderHitoryListTemporary = [];
  List<SalesOrderAllDealer> SalesOrderAllDealerTemporary = [];
  bool isResetSelfList=false;



  String SelectedDealer2="Select Dealer";
  String HeadingText="";
  final Widget child;
  final GlobalKey navigatorKey;
  bool backArrowVisible;
  String SelectedValueForSearch;

  DisOrderHistory({this.navigatorKey, this.child,this.backArrowVisible,this.SelectedValueForSearch});


  static String tag = '/ShProfileFragment';

  @override
  ShWishlistFragmentState createState() => ShWishlistFragmentState();
}

class ShWishlistFragmentState extends State<DisOrderHistory> {
  // Session Used Variables
  var checkNetconnection=null;
  String MyToken;
  String MyUserName="";
  String MyCompanyId;
  String  MyMemberId;
  String MyMemberType;
  String  Myparent_distributor_id;
  String  Myparent_distributor_nav_id;
  int val = 1;
  
  bool DealerDropDownVisible = false;

  // Get Session Data
  getSessionData() async
  {
    print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String  userName = prefs.getString('UserName');
    String  mycompanyId = prefs.getString('companyId');
    String  mymemberId = prefs.getString('memberId');
    API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');

    String  mymemberType = prefs.getString('memberType');

    String  parent_distributor_id ="0";
    String  parent_distributor_nav_id = "0";
    if(mymemberType!="Distributor")
    {

      parent_distributor_id = prefs.getString('parent_distributor_id');
      parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');

    }

    print(">>>>>>>>>>>Session Token $token  $userName $mycompanyId $mycompanyId");

    print(">>>>>>>>>>>Session Token $token");
    setState(() {
      MyToken=token;
      MyUserName=userName;
      MyCompanyId=mycompanyId;
      MyMemberId=mymemberId;
      MyMemberType=mymemberType;
      if(MyMemberType!="Distributor")
      {
        Myparent_distributor_id=parent_distributor_id;
        Myparent_distributor_nav_id=parent_distributor_nav_id;
        print("DisSelected Inventory  Page Session Data Myparent_distributor_id  $parent_distributor_id , Myparent_distributor_nav_id $parent_distributor_nav_id");
      }
    });

    if(token.isNotEmpty)
    {
      print(">>>>>>>>>>>>>>>>>> Token is Not Empty >>>>>>>>>>>>>>>>>>>");




      checkNetconnection = isInternatAvailable();
      print("Response od internet Menthode $checkNetconnection");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$checkNetconnection.");
      if(checkNetconnection!=null)
      {
        print("MyMemberType Order History Page "+MyMemberType);

        if (MyMemberType=="Distributor")
          {

            print("Distributore Order History Page "+widget.SelectedValueForSearch);
            getDealerList();
            if(widget.SelectedValueForSearch=="Self Stock")
            {
              widget.SelectedDealer2="Self Stock";



              print("Get Self Stock PO List   List Methode Call >>>>>>>>>>>>>>>>>> $widget.SelectedValueForSearch");

              setState(() {
                val=1;
                isDealerListVisible=false;
                isDistributoListVisible=true;
                DealerDropDownVisible=false;
                widget.HeadingText="Purchase Orders History";
              });

              getOrderHistoryList();


            }
            else if(widget.SelectedValueForSearch=="Dealer")
            {

              print("Dealer Order History Page ");
              widget.SelectedDealer2="Select Dealer";
              print("My Dealer is Selected >>>>>>>>>>>>>>>>>>>>>>>..");
              getOrderHistoryListAllDealerOFDistribuor();

              //  print("Get Self Stock Dealer   List Methode Call >>>>>>>>>>>>>>>>>> $widget.SelectedValueForSearch    "+spinnerDealerSelectes.id.toString());
              // int idSelected;

              setState(() {
                isALLDealerListVisible=true;
                val=2;
                isDealerListVisible=false;
                isDistributoListVisible=false;
                DealerDropDownVisible=true;
                widget.HeadingText="Sales Orders History";

              });



              //  getDealerListPos(idSelected);

            }
          }
          else
            {
              print("Else Order History Page ");

              getOrderHistoryList();
            }


        //getDealerList();









      }
      if(checkNetconnection!=null)
      {
        print("Please check your Internet Connection ");
        // showAlertStockDialog(context);
        //interNetPopup();
      }
    }
  }

  //Get Order History List Methode

  List<PurchaseOrderHitory> purchaseOrderHitoryList = [];
  bool purchaseOrderHitoryListNotAvailable = false;


  List<SalesOrderAllDealer> salesOrderAllDealerList = [];
  bool salesOrderAllDealerListNotFound= false;

  List<SalesOrderAllDealer> _Temp_salesOrderAllDealerList=[];

  bool isDealerListVisible = false;
  bool isALLDealerListVisible = false;
  bool isDistributoListVisible = true;

  int purchaseOrderHitoryListLength =0;
  int allDealerOrderHitoryListLength =0;
  Future<List<PurchaseOrderHitory>> getOrderHistoryList() async {
    purchaseOrderHitoryListNotAvailable=false;
    print("purchaseOrderHitoryList Methode Call >>>>>>>>>>>>>>>>>>");
    http.Response response;

    if (MyMemberType == "Distributor")
      {
        print("purchaseOrderHitoryList Methode Call   >>>>>>>>>>>>>>>>>> $widget.SelectedValueForSearch");
        //response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/blanket_orders?sort=&page=1&per_page=30&selectedCustomerTypeCode=DISTRIBUTO'),
        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/blanket_orders?sort=&page=1&per_page=200&selectedCustomerTypeCode=DISTRIBUTO'),
            headers: {
              HttpHeaders.authorizationHeader: 'bearer $MyToken',
            }
        );
      }
    else
      {
        if(MyMemberType=="DUC")
         {
           print(" $MyMemberType purchaseOrderHitoryList Methode Call >>>>>>>>>>>>>>>>>>");
           //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/blanket_orders?sort=&page=1&per_page=50&selectedCustomerTypeCode=DISTRIBUTO
           response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/blanket_orders?sort=&page=1&per_page=50&selectedCustomerTypeCode=DISTRIBUTO'),
               headers: {
                 HttpHeaders.authorizationHeader: 'bearer $MyToken',
               }
           );


         }
        else if(MyMemberType=="DUD")
         {
           print(" $MyMemberType purchaseOrderHitoryList Methode Call  >>>>>>>>>>>>>>>>>>");
           //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1997/blanket_orders
           response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/blanket_orders?sort=&page=1&per_page=50'),
               headers: {
                 HttpHeaders.authorizationHeader: 'bearer $MyToken',
               }
           );
         }
      }



    // else if(widget.SelectedValueForSearch=="Dealer")
    // {
    //   print("Get Block  List Methode Call >>>>>>>>>>>>>>>>>> $widget.SelectedValueForSearch    "+spinnerDealerSelectes.id.toString());
    //   int idSelected = spinnerDealerSelectes.id;
    //   response = await http.get(Uri.parse('http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/dealers/$idSelected/blanket_orders?sort=&page=1&per_page=30&selectedCustomerTypeCode=DISTRIBUTO'),
    //     headers: {
    //       HttpHeaders.authorizationHeader: 'bearer $MyToken',
    //     },
    //   );
    // }
    // else
    // {
    //   print("Get Block  List Methode Call >>>>>>>>>>>>>>>>>> $widget.SelectedValueForSearch");
    //
    //   response = await http.get(Uri.parse('http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/distributors/$MyMemberId/blanket_orders?sort=&page=1&per_page=30&selectedCustomerTypeCode=DISTRIBUTO'),
    //     headers: {
    //       HttpHeaders.authorizationHeader: 'bearer $MyToken',
    //     },
    //   );
    // }

    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form purchaseOrderHitoryList  Methode   Data Api : $responcebody");
    print("Response code Form purchaseOrderHitoryList  Data Api : $responseCode");
    // int inventoryLength =  newCartItesmFromJson(json.decode(response.body)).length;
    //
    // print("New Cart List Length >>>>>>>>>>>>>>> $inventoryLength");
    setState(() {
      purchaseOrderHitoryList =  OrderHistoryList.fromJson(json.decode(responcebody)).purchaseOrders;
      widget.purchaseOrderHitoryListTemporary =  OrderHistoryList.fromJson(json.decode(responcebody)).purchaseOrders;

    });
    int newinventoryLength =  purchaseOrderHitoryList.length;
    purchaseOrderHitoryListLength=newinventoryLength;
    print("purchaseOrderHitoryList  Length >>>>>>>>>>>>>>> $newinventoryLength");

    if(purchaseOrderHitoryList.length==0&&responseCode==200)
      {
        setState(() {
          purchaseOrderHitoryListNotAvailable=true;
        });
      }


    return OrderHistoryList.fromJson(json.decode(responcebody)).purchaseOrders;
  }



  Future<List<PurchaseOrderHitory>> getOrderHistoryListAllDealerOFDistribuor() async {
    salesOrderAllDealerListNotFound=false;
    print("AllDealerOFDistribuor Api  Methode Call >>>>>>>>>>>>>>>>>>");
    http.Response response;

    if (MyMemberType == "Distributor")
      {
        print("AllDealerOFDistribuor Api Methode Call   >>>>>>>>>>>>>>>>>> $widget.SelectedValueForSearch");
        //http://rosdev.rosettaproducts.com/api/companies/3/distributors/4/sales_orders?sort=&page=1&per_page=50
        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/sales_orders?sort=&page=1&per_page=50'),
            headers: {
              HttpHeaders.authorizationHeader: 'bearer $MyToken',
            }
        );
      }





    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form AllDealerOFDistribuor  Methode   Data Api : $responcebody");
    print("Response code Form AllDealerOFDistribuor  Data Api : $responseCode");

    setState(() {
      salesOrderAllDealerList =  AllDealerOrderHistory.fromJson(json.decode(responcebody)).salesOrders;
      widget.SalesOrderAllDealerTemporary =  AllDealerOrderHistory.fromJson(json.decode(responcebody)).salesOrders;

    });
    int newinventoryLength =  salesOrderAllDealerList.length;
    allDealerOrderHitoryListLength=newinventoryLength;


    if(responseCode==200&&salesOrderAllDealerList.length==0)
      {
        setState(() {
          salesOrderAllDealerListNotFound=true;

        });
      }
    print("AllDealerOFDistribuor  Length >>>>>>>>>>>>>>> "+salesOrderAllDealerList.length.toString());

  }















  List<SalesOrder> DealerssalesOrders=[];
  bool DealerssalesOrdersNotAvailable=false;

  List<SalesOrder> _Temp_DealerssalesOrders=[];




  int dealerssalesOrdersHitoryListLength =0;
  getDealerListPos(int  dealerIDSelected) async {

    DealerssalesOrdersNotAvailable=false;

    print("Get  Dealer List Order Api Call $dealerIDSelected");

    http.Response response;

    response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/sales_orders?sort=&page=1&per_page=50&customer_id=$dealerIDSelected'),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );


    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form  Delaer purchaseOrderHitoryList  Methode   Data Api : $responcebody");
    print("Response code Form Dealer  purchaseOrderHitoryList  Data Api : $responseCode");

    setState(() {
       DealerssalesOrders   =  DealersPosDistributor.fromJson(json.decode(responcebody)).salesOrders;
       widget.DealerssalesOrdersTemp   =  DealersPosDistributor.fromJson(json.decode(responcebody)).salesOrders;
    });


    int newinventoryLength =  DealerssalesOrders.length;
    dealerssalesOrdersHitoryListLength=newinventoryLength;
    print("DealerssalesOrders  Length >>>>>>>>>>>>>>> $newinventoryLength");

    if(responseCode==200&&DealerssalesOrders.length==0)
      {
        setState(() {
          DealerssalesOrdersNotAvailable=true;

        });
      }



  }



 String startSelectedDate,endSelectedDate;



  DateTime selectedDate = DateTime.now();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  bool isStartDateSelected=false;
  bool isEndDateSeleted=false;




  String showStartDate="Start Date";
  String showEndDate="End Date";
  Future<void> _selectDate(BuildContext context,String whichDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        if(whichDate=="StartDate")
          {
            print("Start Date is "+selectedDate.toString());
            setState(() {

              selectedStartDate=selectedDate;
              isStartDateSelected=true;

              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              showStartDate  = formatter.format(selectedDate);

            });

          }
        else
          {
            print("End  Date is "+selectedDate.toString());
             setState(() {
               selectedEndDate=selectedDate;
               isEndDateSeleted=true;


               final DateFormat formatter = DateFormat('yyyy-MM-dd');
               showEndDate  = formatter.format(selectedDate);


             });

          }



        print("Selected Date is "+selectedDate.toString());
        print("Time Stamp Value On Selected Date is "+selectedDate.toUtc().millisecondsSinceEpoch.toString());

      });
  }

  String dropdownValue = 'Add Customer and Shiping Details';

  List<String> spinnerItems = [
    'Add Customer and Shiping Details',
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ];

  //Pending
  String dropdownValue2 = 'Pending';

  List<String> spinnerItems2 = [
    'Pending',
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ];

  //Start Date
  String dropdownValue3 = 'Start Date';

  List<String> spinnerItems3 = [
    'Start Date',
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ];



  //End Date
  String dropdownValue4 = 'End Date';

  List<String> spinnerItems4 = [
    'End Date',
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ];

  //Dealer
  String dropdownValue5 = 'Dealer';

  List<String> spinnerItems5 = [
    'Dealer',
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ];


  List<ShProduct> list = [];
 String  _selectedOrderNumber="";

  List<PurchaseOrderHitory> _Temp_purchaseOrderHitoryList = [];
 filterdListOnSearch(String _selectedOrderNumber2, DateTime selectedDateStart, DateTime selectedDateEnd)
 {


   //purchaseOrderHitoryList.clear();
   setState(() {

     //widget.purchaseOrderHitoryListTemporary
     print("Temporary  List Lenght  "+widget.purchaseOrderHitoryListTemporary.length.toString());

  //   purchaseOrderHitoryList = widget.purchaseOrderHitoryListTemporary;
   });


   print("On Search Start Date "+selectedDateStart.toString());
   print("On Search End  Date "+selectedDateEnd.toString());
   print("On Search OrderNumber  "+_selectedOrderNumber2);

   final DateFormat formatter = DateFormat('yyyy-MM-dd');
   String formattedStartDate = formatter.format(selectedDateStart);
   String formattedEndDate = formatter.format(selectedDateEnd);

   print("StartDate Formate $formattedStartDate EndDate Formate $formattedEndDate");


   DateTime startDateTime = DateTime.parse(formattedStartDate);
   DateTime endDateTime = DateTime.parse(formattedEndDate);

   print("@@@@@@>>>>>>>>>>>>>>>>>>>>>>> $startDateTime  >>>>>>>>>>>> $endDateTime ");


   print("Selected Order Number in a Functions is " + _selectedOrderNumber2);


   print("Length of list is >>>>>>>>>>" +
       purchaseOrderHitoryListLength.toString());

   //Start Logic From their
   if (isStartDateSelected == false && isEndDateSeleted == false && _selectedOrderNumber2 == "") {
     print("In Dealer Please Enter Valid Fields ");
     showToastDialog(context, "Please Enter Valid Fields");
   }
   else {


     print("Self Satart Filterd >>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
     int count = 0;
     int dateCount = 0;
     for (int i = 0; i < purchaseOrderHitoryListLength; i++) {
       int timeStamp = int.parse(purchaseOrderHitoryList[i].createdAt);
       var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
       String allDate = formatter.format(date2);

       print("On Search time Stamp Date ======$allDate");
       DateTime allDateTime = DateTime.parse(allDate);




       if ((allDateTime.compareTo(startDateTime) > 0 ||
           allDateTime.compareTo(startDateTime) == 0)) {
         if (allDateTime.compareTo(endDateTime) == 0 ||
             allDateTime.compareTo(endDateTime) < 0) {
           dateCount++;
           print("$allDateTime Dates Founds $dateCount");
           setState(() {
             if (_selectedOrderNumber2 != "") {
               print("Search with Order Number ");

               if(isStartDateSelected == true && isEndDateSeleted == true)
                 {
                   if (purchaseOrderHitoryList[i].number.toLowerCase() ==
                       _selectedOrderNumber2.toLowerCase()) {
                     setState(() {
                       count++;
                       _Temp_purchaseOrderHitoryList.add(purchaseOrderHitoryList[i]);
                     });

                     print("$count Results found on Search Date Count ");
                   }
                 }


             }
             else {
               print("Search with Only Dates  ");

               _Temp_purchaseOrderHitoryList.add(purchaseOrderHitoryList[i]);
             }
           });
         }
       }





       if (isStartDateSelected == false && isEndDateSeleted == false) {
         if (purchaseOrderHitoryList[i].number.toLowerCase() ==
             _selectedOrderNumber2.toLowerCase()) {
           setState(() {
             count++;
             _Temp_purchaseOrderHitoryList.add(purchaseOrderHitoryList[i]);
           });

           print("$count Results found on Search Date Count ");
         }
       }
     }

     print("List OF Filterd Length is "+_Temp_purchaseOrderHitoryList.length.toString());

     if(_Temp_purchaseOrderHitoryList.length==0)
       {
         purchaseOrderHitoryList =widget.purchaseOrderHitoryListTemporary;

         print("Reslut Not Found >>>>>>>>"+purchaseOrderHitoryList.length.toString());




         showToastDialog(context, "Result not found");
        // purchaseOrderHitoryList =purchaseOrderHitoryList;

       }
     else
       {
         purchaseOrderHitoryList = _Temp_purchaseOrderHitoryList;
       }



     // if (count != 0) {

     // }

   }
 }

  filterdListOnSearchDealer(String _selectedOrderNumber2, DateTime selectedDateStart, DateTime selectedDateEnd)
  {
    print("On Search Start Date "+selectedDateStart.toString());
    print("On Search End  Date "+selectedDateEnd.toString());
    print("On Search OrderNumber  "+_selectedOrderNumber2);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedStartDate = formatter.format(selectedDateStart);
    String formattedEndDate = formatter.format(selectedDateEnd);

    print("StartDate Formate $formattedStartDate EndDate Formate $formattedEndDate");


    DateTime startDateTime = DateTime.parse(formattedStartDate);
    DateTime endDateTime = DateTime.parse(formattedEndDate);

    print("@@@@@@>>>>>>>>>>>>>>>>>>>>>>> $startDateTime  >>>>>>>>>>>> $endDateTime ");


    print("Selected Order Number in a Functions is " + _selectedOrderNumber2);


    print("Length of list is >>>>>>>>>>" +
        dealerssalesOrdersHitoryListLength.toString());

    //Start Logic From their
    if (isStartDateSelected == false && isEndDateSeleted == false && _selectedOrderNumber2 == "") {
      print("In Dealer Please Enter Valid Fields ");
      showToastDialog(context, "Please Enter Valid Fields");
    }
    else {

      setState(() {
      //  DealerssalesOrders.clear();
       // DealerssalesOrders = widget.DealerssalesOrdersTemp;
      });
      int count = 0;
      int dateCount = 0;
      for (int i = 0; i < dealerssalesOrdersHitoryListLength; i++) {
        int timeStamp = int.parse(DealerssalesOrders[i].createdAt);
        var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
        String allDate = formatter.format(date2);

        print("On Search time Stamp Date ======$allDate");
        DateTime allDateTime = DateTime.parse(allDate);


        if ((allDateTime.compareTo(startDateTime) > 0 ||
            allDateTime.compareTo(startDateTime) == 0)) {
          if (allDateTime.compareTo(endDateTime) == 0 ||
              allDateTime.compareTo(endDateTime) < 0) {
            dateCount++;
            print("$allDateTime Dates Founds $dateCount");
            setState(() {
              if (_selectedOrderNumber2 != "") {

                print("This is condition is run for Only Order Number in Date Selections ");

                print("Search with Order Number ");

                if(isStartDateSelected == true && isEndDateSeleted == true)
                  {
                    if (DealerssalesOrders[i].number.toLowerCase() ==
                        _selectedOrderNumber2.toLowerCase()) {
                      setState(() {
                        count++;
                        _Temp_DealerssalesOrders.add(DealerssalesOrders[i]);
                      });

                      print("$count Results found on Search Date Count ");
                    }
                  }

              }
              else {
                print("Search with Only Dates  ");

                _Temp_DealerssalesOrders.add(DealerssalesOrders[i]);
              }
            });
          }
        }


        if (isStartDateSelected == false && isEndDateSeleted == false) {
          print("This is condition is run for Only Order Number ");
          if (DealerssalesOrders[i].number.toLowerCase() ==
              _selectedOrderNumber2.toLowerCase()) {
            setState(() {
              count++;
              _Temp_DealerssalesOrders.add(DealerssalesOrders[i]);
            });

            print("$count Results found on Search Date Count ");
          }
        }
      }

      if(_Temp_DealerssalesOrders.length==0)
      {
        showToastDialog(context, "Result not found");
        DealerssalesOrders =widget.DealerssalesOrdersTemp;
      }
      else
      {
        DealerssalesOrders = _Temp_DealerssalesOrders;
      }

      // if (count != 0) {
     // DealerssalesOrders = _Temp_DealerssalesOrders;
      // }

    }
  }


  filterdListOnSearchDealerAll(String _selectedOrderNumber2, DateTime selectedDateStart, DateTime selectedDateEnd)
  {
    print("On Search Start Date "+selectedDateStart.toString());
    print("On Search End  Date "+selectedDateEnd.toString());
    print("On Search OrderNumber  "+_selectedOrderNumber2);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedStartDate = formatter.format(selectedDateStart);
    String formattedEndDate = formatter.format(selectedDateEnd);

    print("StartDate Formate $formattedStartDate EndDate Formate $formattedEndDate");


    DateTime startDateTime = DateTime.parse(formattedStartDate);
    DateTime endDateTime = DateTime.parse(formattedEndDate);

    print("@@@@@@>>>>>>>>>>>>>>>>>>>>>>> $startDateTime  >>>>>>>>>>>> $endDateTime ");


    print("Selected Order Number in a Functions is " + _selectedOrderNumber2);


    print("Length of list is >>>>>>>>>>" +
        allDealerOrderHitoryListLength.toString());

    //Start Logic From their
    if (isStartDateSelected == false && isEndDateSeleted == false && _selectedOrderNumber2 == "") {
      print("In Dealer Please Enter Valid Fields ");
      showToastDialog(context, "Please Enter Valid Fields");
    }
    else {

      setState(() {
        //salesOrderAllDealerList.clear();
      //  salesOrderAllDealerList = widget.SalesOrderAllDealerTemporary;
            //_Temp_salesOrderAllDealerList;
      });
      int count = 0;
      int dateCount = 0;
      for (int i = 0; i < allDealerOrderHitoryListLength; i++) {
        int timeStamp = int.parse(salesOrderAllDealerList[i].createdAt);
        var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
        String allDate = formatter.format(date2);

        print("On Search time Stamp Date ======$allDate");
        DateTime allDateTime = DateTime.parse(allDate);


        if ((allDateTime.compareTo(startDateTime) > 0 ||
            allDateTime.compareTo(startDateTime) == 0)) {
          if (allDateTime.compareTo(endDateTime) == 0 ||
              allDateTime.compareTo(endDateTime) < 0) {
            dateCount++;
            print("$allDateTime Dates Founds $dateCount");
            setState(() {
              if (_selectedOrderNumber2 != "") {

                print("This is condition is run for Only Order Number in Date Selections ");

                print("Search with Order Number ");

                if(isStartDateSelected == true && isEndDateSeleted == true)
                  {
                    if (salesOrderAllDealerList[i].number.toLowerCase() ==
                        _selectedOrderNumber2.toLowerCase()) {
                      setState(() {
                        count++;
                        _Temp_salesOrderAllDealerList.add(salesOrderAllDealerList[i]);
                      });

                      print("$count Results found on Search Date Count ");
                    }
                  }

              }
              else {
                print("Search with Only Dates  ");

                _Temp_salesOrderAllDealerList.add(salesOrderAllDealerList[i]);
              }
            });
          }
        }


        if (isStartDateSelected == false && isEndDateSeleted == false) {
          print("This is condition is run for Only Order Number ");
          if (salesOrderAllDealerList[i].number.toLowerCase() ==
              _selectedOrderNumber2.toLowerCase()) {
            setState(() {
              count++;
              _Temp_salesOrderAllDealerList.add(salesOrderAllDealerList[i]);
            });

            print("$count Results found on Search Date Count ");
          }
        }
      }

      if(_Temp_salesOrderAllDealerList.length==0)
      {
        showToastDialog(context, "Result not found");
        salesOrderAllDealerList =widget.SalesOrderAllDealerTemporary;
      }
      else
      {
        salesOrderAllDealerList = _Temp_salesOrderAllDealerList;
      }

      // if (count != 0) {
     // DealerssalesOrders = _Temp_DealerssalesOrders;
      // }

    }
  }











  bool isVisibleSkip=false;

  isVisibleSkipApi() async {
    String url = "https://laravel.cppatidar.com/rosetta/api/webservices/skip_button";
    try {
      final response = await http.get(Uri.parse(url));
      var reult = response.statusCode;
      print("Rsponse Code Of Category Api $reult");
      print(json.decode(response.body));



      print("Response of isVisible Api is >>>>>>>>>>>>>   "+response.body);

      setState(() {
        isVisibleSkip= SkipButtonApi.fromJson(json.decode(response.body)).status;

        print("Result of Skip  isVisible layout >>>>>>>>>>>>   "+isVisibleSkip.toString());

      });


    }
    catch(e)
    {

    }



  }
  @override
  void initState() {

    print("~~~~~~~~~~~~~~~~~~~~~DisOrder History Page ~~~~~~~~~~~~~~~~~~~~~~");
    print("~~~~~~~~~~~~~~~~~~~~~DisOrder History Page ~~~~~~~~~~~~~~~~~~~~~~"+widget.SelectedValueForSearch);
    super.initState();
    isInternatAvailable2(context);
    getSessionData();
    isVisibleSkipApi();
    fetchData();
  }

  fetchData() async {
    var products = await loadProducts();
    setState(() {
      list.clear();
      list.addAll(products);
    });
  }

  Future<List<ShProduct>> loadProducts() async {
    String jsonString =
    await loadContentAsset('assets/shophop_data/wishlist_products.json');
    final jsonResponse = json.decode(jsonString);
    return (jsonResponse as List).map((i) => ShProduct.fromJson(i)).toList();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }



  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~29 Dec Dealer Loading
  //~~~~~~~~~~~~~~~~~~~~~~~~~Spinner Dealer Api
  ///~~~~~~~~~~~~~~~~~~~~~~~Spineeer Dealer Variables
  ///For Select Dealerrs
  List<SpinnerSpinnerDealerList> spinnerDelerList = [];
  List<String> spinnerSelectDealer2 = [];
 
  SpinnerSpinnerDealerList spinnerDealerSelectes=null;
   getDealerList() async  {
    print("Get SpinnerDealer List Methode Call >>>>>>>>>>>>>>>>>> DisOrderHistory");

    //http://rosdev.rosettaproducts.com/api/companies/3/distributors/4/searchDealers?withOrders
   // http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyMemberId/distributors/$MyMemberId/dealers'),//?sort=&page=1&per_page=20
    http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/searchDealers?withOrders'),//?sort=&page=1&per_page=20
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );
    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form SpinnerDealer List Methode   Data Api : $responcebody");
    print("Response code Form SpinnerDealer List Methode  Data Api : $responseCode");

    // int inventoryLength =  newCartItesmFromJson(json.decode(response.body)).length;
    //
    // print("New Cart List Length >>>>>>>>>>>>>>> $inventoryLength");
    setState(() {
      //NewDealerList.fromJson(json.decode(str));
      // newCartItesmFromJson(response.body);
      spinnerDelerList = spinnerSpinnerDealerListFromJson((response.body));
      if(responseCode==200)
      {
        getDelaerSpinnerList();
      }



    });


    int newinventoryLength =  spinnerDelerList.length;
    print("New SpinnerDealer List   Length >>>>>>>>>>>>>>> $newinventoryLength");
  }
  getDelaerSpinnerList() async {


    print("Get Spinner Dealer List Methode Call");

    var length = spinnerDelerList.length;
    print(" Spinner Dealer List   lsi length is $length");

    for(int i=0;i<spinnerDelerList.length;i++)
    {
      var displayname;
      print(" Spinner Dealer List  Loop is Called ");
      setState(() {
        if(i==0)
        {
          //spinnerSelectDealer2.add("Select Dealer");
        //  spinnerSelectDealer2.add("Self Stock");
          spinnerSelectDealer2.add(spinnerDelerList[i].name);
          displayname = spinnerSelectDealer2[i];
        }
        else
        {
          spinnerSelectDealer2.add(spinnerDelerList[i].name);
          displayname = spinnerSelectDealer2[i];
        }

        widget.SelectedDealer2=spinnerSelectDealer2[0];
      });


      print(" Spinner Dealer List   Name $displayname");
    }
  }




  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
            child:
            Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child:MyAppBar(widget.backArrowVisible,"",MyUserName,isVisibleSkip,true),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [


                Container(


                  width: width,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),


                  color: backgroundSearchProductForm,
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(

                           child: Text(widget.HeadingText,style: TextStyle(color: sh_black,fontWeight:FontWeight.bold,fontSize: 15),),
                           margin: EdgeInsets.all(10.0),
                         ),
                         Container(),
                       ],

                     ),




                  Visibility(
                    // child:spinnerSelectDealer2.length==0?Container(
                    //
                    //     child: Container(
                    //       padding: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
                    //       width: double.infinity,
                    //       child:Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           text("Loading Dealers..",
                    //               fontSize: textSizeSmall,
                    //               fontFamily: fontRegular,
                    //               textColor: sh_textColorSecondary),
                    //           Image.asset(ic_form_preloader_gif,height: 20,width: 20,)
                    //
                    //
                    //
                    //         ],
                    //       ),
                    //
                    //
                    //
                    //
                    //
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //
                    //         border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                    //         borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                    //       ),
                    //     ),
                    //   ) :
                    child:Container(
                      child:Autocomplete(
                        //initialValue: TextEditingValue(text:widget.SelectedDealer2==null?"":widget.SelectedDealer2,),


                        optionsBuilder: (TextEditingValue value) {
                          // When the field is empty
                          if (value.text.isEmpty) {
                            return [];
                          }

                          // The logic to find out which ones should appear
                          return spinnerSelectDealer2.where((suggestion) => suggestion.toString()
                              .toLowerCase()
                              .contains(value.text.toLowerCase()));
                        },

                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode, VoidCallback onFieldSubmitted) {
                          return TextFormField(
                            controller: textEditingController,
                            //  decoration: myTextFieldDecoration(topLabel: "Another Input", hintText: "Type or select from list"),
                            decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.search,color:sh_colorPrimary,size: 20,),
                              fillColor: backgroundSearchProductFormInput,
                              focusColor: sh_editText_background_active,

                              hintText: "Search Dealers",
                              hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0)

                              ),),
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                              print('You just typed a new entry  $value');

                            },
                          );
                        },

                        onSelected: (value) {
                          setState(() {

                            print("Selected Dealer From Auto Suggest is "+value);


                            widget.SelectedDealer2 = value;

                            if(widget.SelectedDealer2=="Self Stock")
                            {
                              print("Self Stock is Selected ");
                              //  get_All_Collection_Categoty_ColorCde(widget.SelectedDealer2);
                            }
                            else {
                              final index = spinnerDelerList.indexWhere((
                                  element) =>
                              element.name == widget.SelectedDealer2);

                              print(">>>>>>Selected Dealer List Index $index");
                              spinnerDealerSelectes = spinnerDelerList[index];
                              // get_All_Collection_Categoty_ColorCde(widget.SelectedDealer2);

                              purchaseOrderHitoryList.clear();
                              int idSelected = spinnerDealerSelectes.id;
                              print("Selected Dealer Id $idSelected");
                              getDealerListPos(idSelected);

                              isDealerListVisible = true;
                              isDistributoListVisible = false;

                              isALLDealerListVisible=false;
                            }













                          });

                        },
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,

                        border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                        borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                      ),

                    ),

                    visible: DealerDropDownVisible,
                  ),

                      SizedBox(
                        height: 10,
                      ),
                      Container(

                        child: SizedBox(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[


                              Container(
                                width: width-30,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  textCapitalization:
                                  TextCapitalization.words,
                                  style: TextStyle(
                                      color: sh_textColorSecondary,
                                      fontFamily: fontRegular,
                                      fontSize: textSizeSmall),
                                  decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color:
                                        sh_colorPrimary,
                                        size: 20,
                                      ),
                                      fillColor:
                                      backgroundSearchProductFormInput,
                                      focusColor:
                                      sh_editText_background_active,
                                      hintText: sh_hint_SearchCollection3,
                                      hintStyle: TextStyle(
                                          color: sh_textColorSecondary,
                                          fontFamily: fontRegular,
                                          fontSize: textSizeSmall),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 15.0, 20.0, 15.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              round_border_form),
                                          borderSide: BorderSide(
                                              color: sh_colorPrimary,
                                              width: 0.5)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              round_border_form),
                                          borderSide: BorderSide(
                                              color: Colors.transparent,
                                              style: BorderStyle.none,
                                              width: 0))),

                                  onChanged: ((value){
                                    print("Selected Order Number is "+value);
                                    _selectedOrderNumber = value;

                                  }),
                                ),
                                decoration: BoxDecoration(

                                  border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                  borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                                ),
                              ),
                              SizedBox(width: 10,),
                              /*Container(
                                width: (width/2)-60,
                                padding: EdgeInsets.only(right: 10,left: 15),
                                child:  new DropdownButton<String>(
                                  value: dropdownValue5,
                                  hint: new Text("Select Here"),
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color:
                                    backgroundSearchProductFormButtons,
                                    size: 25,
                                  ),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(
                                    color: sh_textColorSecondary,
                                    fontSize: 18,
                                  ),
                                  underline: Container(
                                    height: 2,
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      dropdownValue5 = value;
                                    });
                                  },
                                  items: spinnerItems5
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: text(value,
                                              fontSize: textSizeSmall,
                                              fontFamily: fontRegular,
                                              textColor: sh_textColorSecondary),
                                        );
                                      }).toList(),
                                ),
                                decoration: BoxDecoration(
                                  color: sh_white,
                                  border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                  borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(

                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                child:  Container(
                                  width: (width/2)-36,
                                  padding: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(""+showStartDate,style: TextStyle(fontSize: textSizeSmall,color: sh_textColorSecondary),),
                                      Image.asset(ic_calender_icon,color:sh_colorPrimary,height: 15,width: 15,),

                                    ],

                                  ),
                                  decoration: BoxDecoration(
                                    color: sh_white,
                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                                  ),
                                ),
                                onTap:() {
                                  setState(() {
                                    _selectDate(context,"StartDate");
                                  });
                                },
                              ),

                              SizedBox(width: 5,),
                              InkWell(
                                child:  Container(
                                  width: (width/2)-36,
                                  padding: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(""+showEndDate,style: TextStyle(fontSize: textSizeSmall,color: sh_textColorSecondary),),
                                      Image.asset(ic_calender_icon,color:sh_colorPrimary,height: 15,width: 15,),

                                    ],

                                  ),
                                  decoration: BoxDecoration(
                                    color: sh_white,
                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    _selectDate(context,"EndDate");
                                  });
                                },
                              ),


                              SizedBox(width: 5,),

                              InkWell(
                                child: Image.asset(ic_search_round,height: 42,width: 42,fit: BoxFit.fill),
                                onTap: (){



                                  if(widget.SelectedValueForSearch=="Self Stock")
                                    {


                                      print("On Search Click widget.SelectedValueForSearch==Self Stock");

                                      setState(() {
                                        //purchaseOrderHitoryList.clear();
                                       // print("Temporary  List Lenght  "+widget.purchaseOrderHitoryListTemporary.length.toString());

                                       // purchaseOrderHitoryList = widget.purchaseOrderHitoryListTemporary;
                                        widget.isResetSelfList=true;

                                      });
                                      if(widget.isResetSelfList)
                                        {
                                          print("widget.isResetSelfList "+purchaseOrderHitoryList.length.toString());

                                          filterdListOnSearch(_selectedOrderNumber,selectedStartDate,selectedEndDate);

                                        }


                                    }
                                  else
                                    {
                                      print("On Search Click widget.SelectedValueForSearch==Dealer");

                                      if(isDealerListVisible)
                                        {
                                          print("Search on Dealer List");

                                          setState(() {
                                            //  DealerssalesOrders.clear();
                                            //  DealerssalesOrders = widget.DealerssalesOrdersTemp;
                                            widget.isResetDealerList=true;
                                          });

                                          if(widget.isResetDealerList) {
                                            print("widget.isResetDealerList "+DealerssalesOrders.length.toString());
                                            filterdListOnSearchDealer(_selectedOrderNumber, selectedStartDate, selectedEndDate);
                                          }
                                        }
                                        else
                                          {
                                            print("Search on All Dealer List");
                                            setState(() {
                                              //  DealerssalesOrders.clear();
                                              //  DealerssalesOrders = widget.DealerssalesOrdersTemp;
                                              widget.isResetDealerList=true;
                                            });

                                            if(widget.isResetDealerList) {
                                             // print("widget.isResetDealerList "+DealerssalesOrders.length.toString());
                                              filterdListOnSearchDealerAll(_selectedOrderNumber, selectedStartDate, selectedEndDate);
                                            }
                                          }




                                    }


                                },
                              )


                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Visibility(

                  child:  purchaseOrderHitoryList.isEmpty?
                  purchaseOrderHitoryListNotAvailable?Container(child: Text("Soryy, Data Not found"),):ShimmerDisOrderHistory()

                      : Container(


                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:purchaseOrderHitoryList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 15),
                        itemBuilder: (context, index) {

                          int Id= purchaseOrderHitoryList[index].id;
                          String DealerName=MyUserName;
                         String DealerName2= purchaseOrderHitoryList[index].dealerName==null?"":purchaseOrderHitoryList[index].dealerName;

                          //purchaseOrderHitoryList[index].dealerName.toString()==""?"":purchaseOrderHitoryList[index].dealerName.toString();
                          int  timeStamp=int.parse(purchaseOrderHitoryList[index].createdAt);
                          var date = new DateTime.fromMicrosecondsSinceEpoch(timeStamp * 1000);
                          var format = new DateFormat('MMM dd,yyyy');
                          var visibledate=format.format(date);
                          print("convertdate======$visibledate");
                          String contactNo="552255";
                          String orderNumber=purchaseOrderHitoryList[index].number;
                          String totalQuantity="";
                          var totalValue=purchaseOrderHitoryList[index].amount;

                          List<Po> pos =purchaseOrderHitoryList[index].pos;
                          String status=purchaseOrderHitoryList[index].status;

                          String allPoss="";
                          String twoposs="";
                          for(int i=0;i<pos.length;i++)
                          {
                            if(i<=2)
                            {
                              twoposs=twoposs+pos[i].soNumber+" ";
                            }

                            allPoss=allPoss+pos[i].soNumber+" ";
                          }


                          var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);

                          print("Distribuor Time Stamp Value "+timeStamp.toString());
                          print(" Time Stamp Value in A list Order History    "+purchaseOrderHitoryList[index].createdAt+"  Date   $date2");
                          print("Time Covertor in Order History "+DateFormat.yMMMMd().format(date2));

                          return
                            Container(
                              margin: EdgeInsets.all(5),


                              child: Column(
                                children: [

                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 5,top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(


                                          child: Text("$DealerName",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),
                                            width: (width/2)-20,
                                        ),


                                        Container(

                                          child: Text(""+DateFormat.yMMMMd().format(date2),style: TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          width: (width/2)-20,
                                          alignment: Alignment.centerRight,

                                        ) ,

                                      ],
                                    ),
                                  ),

                                  /*Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 10,bottom: 10),
                                    child: Text("+912358623",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                  ),*/
                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(

                                          children: [
                                            Container(
                                              child: Text("Order Number",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text("$orderNumber",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),

                                        // Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                        // Column(
                                        //   children: [
                                        //     Container(
                                        //       child: Text("Total Qty",style:  TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                        //     ) ,
                                        //     SizedBox(height: 5,),
                                        //     Container(
                                        //       child: Text("0",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                        //     ) ,
                                        //   ],
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        // ),
                                        // Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("Total Value",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text("$totalValue".toCurrencyFormat(),style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),




                                      ],
                                    ),
                                  ),

                                  DealerName2==""?Container(): Container(
                                    margin: EdgeInsets.only(left: 10,top: 10),

                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,


                                      children: [
                                        Text("Sold to - ",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),
                                        Text("$DealerName2",style:TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),


                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 10,top: 10),

                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,


                                      children: [
                                        Text("SO Number  ",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),
                                        Row(
                                          children: [
                                            Text("$twoposs",style:TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                            // Text("+2 More",style:TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),)
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                    child: Row(


                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children:
                                          [
                                            Container(

                                              child:
                                              InkWell(
                                                onTap: (){

                                                },
                                                child:status=="Approved"?
                                                              Image.asset(ic_circularGreenCheckBox,height:20,width: 20,)
                                                    :status=="Cancelled"?Image.asset(ic_circularcancel,height:20,width: 20,):
                                                     status=="Shipped"?Image.asset(ic_shippedstatus,height:20,width: 20,):
                                                     status=="Partially Shipped"?Image.asset(ic_partiallyshippedstatus,height:20,width: 20,):
                                                                                 Image.asset(ic_autocompleted,height:20,width: 20,),

                                              ),
                                              margin: EdgeInsets.only(top: 8,),

                                            ),
                                            SizedBox(width: 10,),
                                            Container(


                                              child: Text(
                                                "$status",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                            margin: EdgeInsets.only(top: 10),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            SizedBox(width: 20,),

                                            Container(

                                              child:
                                              MaterialButton(
                                                elevation: 0,

                                                padding:  EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                                                child: text("View Details", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: sh_white),
                                                textColor: sh_white,

                                                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                                color: sh_colorPrimary,
                                                onPressed: () => {
                                                  // ShHomeScreen().launch(context),
                                                  NewDistributorOrderDetails(searchId: Id,purchaseOrderHitory:purchaseOrderHitoryList[index]).launch(context),

                                                },
                                              ),
                                            ),
                                          ],

                                        ),

                                      ],
                                    ),
                                  ),




                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,

                                border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),


                            );
                          // return Chats(mListings[index], index);
                        }),
                  ),


                  visible: isDistributoListVisible,
                ),

                Visibility(
                  child:  DealerssalesOrders.isEmpty?

                  DealerssalesOrdersNotAvailable?Container(child: Text("Soryy, Data Not found"),):ShimmerDisOrderHistory()
                      : Container(

                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:DealerssalesOrders.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 15),
                        itemBuilder: (context, index) {

                          int Id= DealerssalesOrders[index].id;
                          String DealerName= DealerssalesOrders[index].customer.name==null?"":DealerssalesOrders[index].customer.name;

                          //purchaseOrderHitoryList[index].dealerName.toString()==""?"":purchaseOrderHitoryList[index].dealerName.toString();
                          int  timeStamp=int.parse(DealerssalesOrders[index].createdAt);;
                          String contactNo="552255";
                          String orderNumber=DealerssalesOrders[index].number;
                          String totalQuantity="";
                          var totalValue=DealerssalesOrders[index].amount;
                          List<String> pos =DealerssalesOrders[index].soNumbers;
                          String status=DealerssalesOrders[index].status;

                          String allPoss="";
                          String twoposs="";
                          for(int i=0;i<pos.length;i++)
                          {
                            if(i<=2)
                            {
                              twoposs=twoposs+pos[i]+" ";
                            }

                            allPoss=allPoss+pos[i]+" ";
                          }
                          print("Dealer  Time Stamp Value "+timeStamp.toString());

                          var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
                          print(" Time Stamp Value in A list Order History    "+DealerssalesOrders[index].createdAt+"  Date   $date2");
                          print("Time Covertor in Order History "+DateFormat.yMMMMd().format(date2));



                          return
                            Container(
                              margin: EdgeInsets.all(5),


                              child: Column(
                                children: [

                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 5,top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(


                                          child: Text("$DealerName",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),
                                          width: (width/2)-20,
                                        ),

                                        Container(
                                          child: Text(""+DateFormat.yMMMMd().format(date2),style: TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          width: (width/2)-20,
                                          alignment: Alignment.centerRight,


                                        ) ,

                                      ],
                                    ),
                                  ),

                                 
                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(

                                          children: [
                                            Container(
                                              child: Text("Order Number",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text("$orderNumber",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),

                                        // Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                        // Column(
                                        //   children: [
                                        //     Container(
                                        //       child: Text("Total Qty",style:  TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                        //     ) ,
                                        //     SizedBox(height: 5,),
                                        //     Container(
                                        //       child: Text("0",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                        //     ) ,
                                        //   ],
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        // ),
                                        // Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("Total Value",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text("$totalValue".toCurrencyFormat(),style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),




                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 10,top: 10),

                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,


                                      children: [
                                        // Text("SO Number  ",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),
                                        // Row(
                                        //   children: [
                                        //     Text("$twoposs",style:TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                        //     // Text("+2 More",style:TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),)
                                        //   ],
                                        // ),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                    child: Row(


                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children:
                                          [
                                            Container(

                                              child:
                                              InkWell(
                                                onTap: (){

                                                },
                                                child:status=="Approved"?
                                                Image.asset(ic_circularGreenCheckBox,height:20,width: 20,)
                                                    : Image.asset(ic_autocompleted,height:20,width: 20,),

                                              ),
                                              margin: EdgeInsets.only(top: 8,),

                                            ),
                                            SizedBox(width: 10,),
                                            Container(

                                              child: Text(
                                                "$status",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),

                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            SizedBox(width: 20,),

                                            Container(

                                              child:
                                              MaterialButton(
                                                elevation: 0,

                                                padding:  EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                                                child: text("View Details", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: sh_white),
                                                textColor: sh_white,

                                                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                                color: sh_colorPrimary,
                                                onPressed: () => {
                                                  // ShHomeScreen().launch(context),


                                                  NewDistributorOrderDetails(searchId: Id,dealerssalesOrders:DealerssalesOrders[index],SelectedValueForSearch:widget.SelectedValueForSearch,isAllDealerofDitributor: false).launch(context),
                                                 // NewDistributorOrderDetails(searchId: Id,purchaseOrderHitory:purchaseOrderHitoryList[index]).launch(context),

                                                },
                                              ),
                                            ),
                                          ],

                                        ),

                                      ],
                                    ),
                                  ),




                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,

                                border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),


                            );
                          // return Chats(mListings[index], index);
                        }),
                  ),

                  visible: isDealerListVisible,

                ),


                ///All Dealer Order Distributor
                Visibility(

                  child:  salesOrderAllDealerList.isEmpty?
                  salesOrderAllDealerListNotFound?Container(child: Text("Soryy, Data Not found"),):ShimmerDisOrderHistory()
                      : Container(

                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:salesOrderAllDealerList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 15),
                        itemBuilder: (context, index) {

                          int Id= salesOrderAllDealerList[index].id;
                          String DealerName= salesOrderAllDealerList[index].customer.name==null?"":salesOrderAllDealerList[index].customer.name;

                          //purchaseOrderHitoryList[index].dealerName.toString()==""?"":purchaseOrderHitoryList[index].dealerName.toString();
                          int  timeStamp=int.parse(salesOrderAllDealerList[index].createdAt);;
                          String contactNo="552255";
                          String orderNumber=salesOrderAllDealerList[index].number;
                          String totalQuantity="";
                          var totalValue=salesOrderAllDealerList[index].amount;
                          List<String> pos =salesOrderAllDealerList[index].soNumbers;
                          String status=salesOrderAllDealerList[index].status;

                          String allPoss="";
                          String twoposs="";
                          for(int i=0;i<pos.length;i++)
                          {
                            if(i<=2)
                            {
                              twoposs=twoposs+pos[i]+" ";
                            }

                            allPoss=allPoss+pos[i]+" ";
                          }
                          print("Dealer  Time Stamp Value "+timeStamp.toString());

                          var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
                          print(" Time Stamp Value in A list Order History    "+salesOrderAllDealerList[index].createdAt+"  Date   $date2");
                          print("Time Covertor in Order History "+DateFormat.yMMMMd().format(date2));



                          return
                            Container(
                              margin: EdgeInsets.all(5),


                              child: Column(
                                children: [

                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 5,top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(


                                          child: Text("$DealerName",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),
                                          width: (width/2)-20,
                                        ),

                                        Container(
                                          child: Text(""+DateFormat.yMMMMd().format(date2),style: TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          width: (width/2)-20,
                                          alignment: Alignment.centerRight,


                                        ) ,

                                      ],
                                    ),
                                  ),


                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(

                                          children: [
                                            Container(
                                              child: Text("Order Number",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text("$orderNumber",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),

                                        // Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                        // Column(
                                        //   children: [
                                        //     Container(
                                        //       child: Text("Total Qty",style:  TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                        //     ) ,
                                        //     SizedBox(height: 5,),
                                        //     Container(
                                        //       child: Text("0",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                        //     ) ,
                                        //   ],
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        // ),
                                        // Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                        Column(
                                          children: [
                                            Container(
                                              child: Text("Total Value",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text("$totalValue".toCurrencyFormat(),style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),




                                      ],
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 10,top: 10),

                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,


                                      children: [
                                        // Text("SO Number  ",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),
                                        // Row(
                                        //   children: [
                                        //     Text("$twoposs",style:TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                        //     // Text("+2 More",style:TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),)
                                        //   ],
                                        // ),

                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                    child: Row(


                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,

                                          children:
                                          [
                                            Container(

                                              child:
                                              InkWell(
                                                onTap: (){

                                                },
                                                child:status=="Approved"?
                                                Image.asset(ic_circularGreenCheckBox,height:20,width: 20,)
                                                    : Image.asset(ic_autocompleted,height:20,width: 20,),

                                              ),
                                              margin: EdgeInsets.only(top: 8,),

                                            ),
                                            SizedBox(width: 10,),
                                            Container(

                                              child: Text(
                                                "$status",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),

                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            SizedBox(width: 20,),

                                            Container(

                                              child:
                                              MaterialButton(
                                                elevation: 0,

                                                padding:  EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                                                child: text("View Details", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: sh_white),
                                                textColor: sh_white,

                                                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                                color: sh_colorPrimary,
                                                onPressed: () => {
                                                  // ShHomeScreen().launch(context),


                                                 NewDistributorOrderDetails(searchId: Id,SelectedValueForSearch:widget.SelectedValueForSearch,isAllDealerofDitributor: true,salesOrderAllDealer: salesOrderAllDealerList[index],).launch(context),
                                                  // NewDistributorOrderDetails(searchId: Id,purchaseOrderHitory:purchaseOrderHitoryList[index]).launch(context),

                                                },
                                              ),
                                            ),
                                          ],

                                        ),

                                      ],
                                    ),
                                  ),




                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,

                                border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),


                            );
                          // return Chats(mListings[index], index);
                        }),
                  ),

                  visible: isALLDealerListVisible,

                ),




                SizedBox(
                  height: 5,
                ),

              ],
            ),
          ),
        ),
      ),
      endDrawer: MyDrwaer(),
      //myDrawer(context),
    ),
    );
  }




// Custom Alert Dialog

  showToastDialog(BuildContext context,String Message)
  {


    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(

              child: StatefulBuilder(

                builder: (BuildContext context, setState){

                  return  Container(
                    height: 110,

                    width:MediaQuery.of(context).size.width,
                    color: sh_white,
                    padding: EdgeInsets.only(top: 20,bottom: 20),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child:Text("$Message",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),

                        Container(
                          margin: EdgeInsets.only(top: 5),



                          color: sh_white,
                          child:   Container(
                            color: Colors.white,

                            child: MaterialButton(
                              padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),


                              child: Text("Retry", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
                              textColor: sh_white,
                              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                              color: sh_colorPrimary,
                              onPressed: () => {

                                //DisApproveOrder().launch(context),
                                Navigator.pop(context, false),


                              },
                            ),
                          ),


                        ),


                      ],
                    ),



                  );
                },
              )



          );
        });

  }

  showProgressDialog(BuildContext context)
  {


    showDialog(
        barrierDismissible: true,
        context: context,

        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(

                child: StatefulBuilder(

                  builder: (BuildContext context, setState){

                    return  Container(
                      height: 220,


                      width:MediaQuery.of(context).size.width,
                      color: sh_white,
                      padding: EdgeInsets.only(top: 20,bottom: 20),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [


                              Container(
                                child:


                                Image.asset(ic_form_preloader_gif,height: 100,width: 100, fit: BoxFit.fill,),
                                alignment: Alignment.topCenter,
                              ),

                            ],
                          ),


                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,

                            height: 40,
                            child: Text("Loading...",style: TextStyle(color: sh_black,fontSize: 18,fontWeight: FontWeight.bold),),
                          ),

                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 15),


                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Text("Please wait while we search your record",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
                                  Container(),
                                ],

                              )

                          ),

                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 15),


                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Text("results",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
                                Container(),
                              ],

                            ),
                          ),


                          // Container(
                          //   margin: EdgeInsets.only(top: 5),
                          //
                          //
                          //
                          //   color: sh_white,
                          //   child:   Container(
                          //
                          //     child: MaterialButton(
                          //       padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
                          //
                          //
                          //       child: Text("close", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
                          //       textColor: sh_white,
                          //       shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                          //       color: sh_colorPrimary,
                          //       onPressed: () => {
                          //             setState(() {
                          //             isLoadAll=false;
                          //             }),
                          //
                          //         //DisApproveOrder().launch(context),
                          //         Navigator.pop(context, false),
                          //
                          //
                          //       },
                          //     ),
                          //   ),
                          //
                          //
                          // ),


                        ],
                      ),



                    );
                  },
                )



            ),
          );
        }).then((value) {
      if(value)
      {

        print("Search Dialog Close >>>>>>>>>>>>>>>>>>>>>>>>>>>.");
        FocusScope.of(context).unfocus();
      }
    });

  }

}
