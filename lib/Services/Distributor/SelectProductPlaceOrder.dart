import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
// import 'package:flutter_countdown_timer/current_remaining_time.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:rosetta_fluter_app/Services/shimmer_list.dart';
import 'package:rosetta_fluter_app/main.dart';
import 'package:rosetta_fluter_app/main/utils/AppColors.dart';
import 'package:rosetta_fluter_app/rosetta/models/DistributorCart.dart';
import 'package:rosetta_fluter_app/rosetta/models/NewBlockedItems.dart';
import 'package:rosetta_fluter_app/rosetta/models/NewCartItems.dart';

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
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'distributorShippingPage.dart';
//import 'package:syncfusion_flutter_gauges/gauges.dart';


class SelectProductPlaceOrder extends StatefulWidget {

  String SelectedDealer2="Select Dealer";
  //List <SpinnerSpinnerDealerList>  spinnerDealerSelectes = [] ;
  SpinnerSpinnerDealerList spinnerDealerSelectes= null ;
  //SpinnerSpinnerDealerList spinnerDealerSelectes= "" as SpinnerSpinnerDealerList ;
  String SelectedValueForSearch="Self Stock";
  String isCartBlock;
  bool isSelfStockDisable = false;
  bool ifselfStockRadioVisible = false;





  SelectProductPlaceOrder({this.navigatorKey, this.child,this.SelectedDealer2,this.spinnerDealerSelectes,this.SelectedValueForSearch,this.isCartBlock});

  final Widget child;
  final GlobalKey navigatorKey;
  static String tag = '/ShProfileFragment';


  @override
  ShWishlistFragmentState createState() => ShWishlistFragmentState();
}

class ShWishlistFragmentState extends State<SelectProductPlaceOrder> {

  int responceCodeCart;
  int responseCodeBlock;
  int lengthofCart;
  int lengthofBlock;

  String RemarkValue="";

  String dropdownValue = 'Select Dealer';

  List<String> spinnerItems = [
    'Select Dealer',
    'Self Stock',
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ];
  List<ShProduct> list = [];


  // for list check box
  Image img;
// example: Image.asset('images/camera.png',)
  Image imgUp =  Image.asset(ic_check,height: 15,width: 15,color: sh_colorPrimary,);
  Image imgDown =  Image.asset(ic_uncheck,height: 15,width: 15,color: sh_colorPrimary,);
  var tapcount=0;
  var selectedindex;
  var selectedindex2;
  var listlength=0;
  var list1 = [];
  var list2 = [];


  // For Increment Decrement Quantity
  var count =0;
  var checkNetconnection=null;
  String MyToken;
  String MyUserName="";
  String MyCompanyId;
  String MyMemberId;
  String MyMemberType;
  String  Myparent_distributor_id;
  String  Myparent_distributor_nav_id;
  List<String> MyspinnerDelerListOnCart = [];
  List<DistributorCart> cartInventory=null;
  List<NewCartItesm> newCartList=[];
  List<NewBlockedItems> newBlockedList = [];


  ///For Select Dealerrs
  List<SpinnerSpinnerDealerList> spinnerDelerList = [];
  List<String> spinnerSelectDealer2 = [];
  bool isDealersAvailable = false;




  //Selected Dealers & Cart Send to Shipping Page

  List<NewCartItesm> newCartListSelected=[];
  List<NewBlockedItems> newBlockedListSelected = [];



  bool isItemDeleted=false;
  bool isItemBlocked=false;

  Timer _timer;
  // int countdowntime=0;
  var countdowntime=0;
  //CountdownTimerController controller;
  //int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  bool BlockedListVisible;
  bool CartListVisible;

  bool isBolckEmpty=false;
  bool isCartEmpty=false;

  bool isBlockDealers =false;





  //
  Future<int>  startTimer(int _start) async {

    print("Timer Methode call Now with time stamp $_start");

    while(_start!=0)
    {
      _start = _start - 1;

      print("Count Down time is .. $_start");
      return _start;

    }
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) => setState(
              () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
              print("Count Down time is $_start");
            }
          },
        ),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    isInternatAvailable2(context);
    fetchData();






    if(widget.isCartBlock=="Cart")
    {
      setState(() {
        BlockedListVisible = false;
        CartListVisible = true;
        if(responceCodeCart==200&&lengthofCart==0)
        {

          showToastDialog(context, "No Block items found");
        }
      });
    }
    else
    {
      setState(() {
        BlockedListVisible = true;
        CartListVisible = false;
      });
    }
    getSessionData();
    if(widget.SelectedValueForSearch=="Self Stock")
    {
      val = 1;
    }
    else if(widget.SelectedValueForSearch=="Dealer")
    {
      val = 2;
      setState(() {
        DealerDropDownVisible=true;

      });

    }
    else
    {
      val = 1;
    }


    print("DealerDropDownVisible   >>>>>>>>>>>>>>>>   $DealerDropDownVisible");





    //  print(" Selected Dealer Come From Search Page "+widget.SelectedDealer2);


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

  Future<List<DistributorCart>> getList() async {
    print("Get List Methode Call >>>>>>>>>>>>>>>>>>");

    http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/3/dealers/179/cart_items'),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );
    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form List Methode   Data Api : $responcebody");
    print("Response code Form List Methode  Data Api : $responseCode");
    // int inventoryLength =  DistributorCart.fromJson(json.decode(response.body)).inventory.length;
    //int inventoryLength =  response.body.length;
    //print("CartList Length >>>>>>>>>>>>>>> $inventoryLength");
    setState(() {
      cartInventory  =    distributorCartFromJson(response.body);
    });
    int inventoryLength =  cartInventory.length;
    print("CartList  Length >>>>>>>>>>>>>>> $inventoryLength");
    return distributorCartFromJson(response.body);
  }

  int resCartList=0;
  int LenCartList=0;

  bool isCartLoad=false;

  Future<List<NewCartItesm>> getCartList() async {


    setState(() {
      isCartLoad=true;
      isCartEmpty=false;
       resCartList=0;
       LenCartList=0;

    });

    http.Response response;



    if(widget.ifselfStockRadioVisible==true)
      {
        widget.SelectedValueForSearch="Dealer";
      }
    print("Get Cart List Methode Call >>>>>>>>>>>>>>>>>> "+widget.SelectedValueForSearch);
    print("Get Cart List Methode Call Sledf Stcock  >>>>>>>>>>>>>>>>>> "+widget.isSelfStockDisable.toString());



    if (MyMemberType == "Distributor")
    {


      if (widget.SelectedValueForSearch == "Self Stock") {
        setState(() {
          DealerDropDownVisible = false;
        });
        // print("Get Cart List Methode Call >>>>>>>>>>>>>>>>>> "+widgetSelectedValueForSearch);
        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL +
            '/api/companies/$MyCompanyId/distributors/$MyMemberId/cart_items'),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer $MyToken',
          },
        );
      }
      else if (widget.SelectedValueForSearch == "Dealer") {
        print("Dealer Get Cart List Methode Call >>>>>>>>>>>>>>>>>> ");
        int idSelected;

        if(widget.spinnerDealerSelectes==null)
          {
            print("*1");
            setState(() {
              isCartEmpty=true;
            });
            return [];
          }
        else
          {
             idSelected = widget.spinnerDealerSelectes.id;
            print("Dealer Get Cart List Methode Call >>>>>>>>>>>>>>>>>> "+ widget.spinnerDealerSelectes.id.toString());
          }
        try{
          print("*2");
          response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/dealers/$idSelected/cart_items'),
            headers: {
              HttpHeaders.authorizationHeader: 'bearer $MyToken',
            },
          );
        }
        catch(e){
          print("*3");
          print("Exception >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. "+e.toString());
        }

      }
      else {
        print(
            "Get Cart List Methode Call >>>>>>>>>>>>>>>>>> $widget.SelectedValueForSearch");

        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL +
            '/api/companies/$MyCompanyId/distributors/$MyMemberId/cart_items'),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer $MyToken',
          },
        );
      }
    }
    else
    {
      if(MyMemberType=="DUC")
      {
        print("DUC Get Cart List Methode Call >>>>>>>>>>>>>>>>>> ");

        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/cart_items
        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/dealers/$MyMemberId/cart_items'),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer $MyToken',
          },
        );
      }
      else if(MyMemberType=="DUD")
      {

        print("DUD Get Cart List Methode Call >>>>>>>>>>>>>>>>>> ");

        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1687/cart_items
        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/dealers/$MyMemberId/cart_items'),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer $MyToken',
          },
        );
      }
    }

    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form Cart List Methode   Data Api : $responcebody");
    print("Response code Form Cart List Methode  Data Api : $responseCode");
    // int inventoryLength =  newCartItesmFromJson(json.decode(response.body)).length;
    //
    // print("New Cart List Length >>>>>>>>>>>>>>> $inventoryLength");
    setState(() {
      newCartList  =    newCartItesmFromJson(response.body).reversed.toList();
      responceCodeCart=response.statusCode;
      lengthofCart=newCartList.length;

      setState(() {
        resCartList=response.statusCode;
        LenCartList=newCartList.length;

      });


      if(responceCodeCart==200&&lengthofCart==0)
      {
        setState(() {
          isCartEmpty=true;
        });
        //showToastDialog(context, "No Cart items found");
      }

    });
    int newinventoryLength =  newCartList.length;
    if(newCartList.length==0){

      setState(() {
        //  CartListVisible=false;
      });

    }else{








    }

    print("New CartList  Length >>>>>>>>>>>>>>> $newinventoryLength $isCartLoad");
    // return newCartItesmFromJson(json.decode(response.body));
  }

  getBlockList() async {
    setState(() {
      isBolckEmpty=false;

    });
    print("Get Block List Methode Call >>>>>>>>>>>>>>>>>>");
    if(widget.ifselfStockRadioVisible==true)
    {
      widget.SelectedValueForSearch="Dealer";
    }
    print("Get Block List Methode Call >>>>>>>>>>>>>>>>>>"+widget.isSelfStockDisable.toString());
    print("Get Block List Methode Call >>>>>>>>>>>>>>>>>>"+widget.SelectedValueForSearch);

    http.Response response;
    print("$MyMemberType Get Block  List Methode Call >>>>>>>>>>>>>>>>>> "+widget.SelectedValueForSearch);


    if (MyMemberType == "Distributor")
    {
      if(widget.SelectedValueForSearch=="Self Stock")
      {
        print("Get Block  List Methode Call >>>>>>>>>>>>>>>>>> $widget.SelectedValueForSearch");
        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/blocked_items'),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer $MyToken',
          },
        );
      }
      else if(widget.SelectedValueForSearch=="Dealer")
      {
        print("Get Block  List Methode Call >>>>>>>>>>>>>>>>>>  ");
        int idSelected;

        if(widget.spinnerDealerSelectes==null)
        {
          print("*1");
          setState(() {
            isBolckEmpty=true;
          });
          return [];
        }
        else
          {
             idSelected = widget.spinnerDealerSelectes.id;
            print("Get Block  List Methode Call >>>>>>>>>>>>>>>>>>  "+widget.spinnerDealerSelectes.id.toString());
          }
        try{
          response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$idSelected/blocked_items'),
            headers: {
              HttpHeaders.authorizationHeader: 'bearer $MyToken',
            },
          );
        }
        catch(e){
          print("Exception "+e.toString());
        }

      }
      else
      {
        print("Get Block  List Methode Call >>>>>>>>>>>>>>>>>> $widget.SelectedValueForSearch");

        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/blocked_items'),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer $MyToken',
          },
        );
      }
    }
    else
    {
      if(MyMemberType=="DUC")
      {
        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/blocked_items
        print("DUC Get Block Methode Call ");
        print("DUC Get Block  List Methode Call >>>>>>>>>>>>>>>>>> MyCompanyId $MyCompanyId MyMemberId $MyMemberId ");
        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/blocked_items'),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer $MyToken',
          },
        );


      }
      if(MyMemberType=="DUD")
      {
        print("DUD Get Block Methode Call ");
        print("DUD Get Block  List Methode Call >>>>>>>>>>>>>>>>>> MyCompanyId $MyCompanyId MyMemberId $MyMemberId ");
        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1687/blocked_items
        response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/blocked_items'),
          headers: {
            HttpHeaders.authorizationHeader: 'bearer $MyToken',
          },
        );


      }
    }








    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form Block List Methode   Data Api : $responcebody");
    print("Response code Form Block List Methode  Data Api : $responseCode");
    // int inventoryLength3 =  newBlockedItemsFromJson(json.decode(response.body)).length;
    // print("New Block  Length >>>>>>>>>>>>>>> $inventoryLength3");
    setState(() {
      newBlockedList  =    newBlockedItemsFromJson(response.body).reversed.toList();
      responseCodeBlock=response.statusCode;
      lengthofBlock=newBlockedList.length;


    });
    int inventoryLengthBlock =  newBlockedList.length;
    if(newBlockedList.length==0){
      // BlockedListVisible=false;
    }else{
      // BlockedListVisible=true;
    }
    print("New Block List  Length >>>>>>>>>>>>>>> $inventoryLengthBlock");

  }








  Future<List<SpinnerSpinnerDealerList>> getDealerList() async {
    print("Cart Page");
    print("Get SpinnerDealer List Methode Call >>>>>>>>>>>>>>>>>> CartPage");
    //http://rosdev.rosettaproducts.com/api/companies/3/distributors/4/searchDealers?withCartItems

    // http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers'),//?sort=&page=1&per_page=20

    String url ="";
    if(isBlockDealers)
    {
      print("Dealer list Block ");

      url= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/searchDealers?withBlockedItems';
    }
    else
    {
      print("Dealer list Cart ");

      url= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/searchDealers?withCartItems';

    }
    http.Response response = await http.get(Uri.parse(url),//?sort=&page=1&per_page=20
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



      spinnerDelerList.clear();

      spinnerDelerList = spinnerSpinnerDealerListFromJson((response.body));
      if(responseCode==200)
      {
        if(spinnerDelerList.length!=0)
          {
            setState(() {
              isDealersAvailable=true;
             // isCartEmpty=true;


            });
          }

        getDelaerSpinnerList();
      }



    });


    int newinventoryLength =  spinnerDelerList.length;
    print(" Cart Page New SpinnerDealer List   Length >>>>>>>>>>>>>>> "+spinnerDelerList.length.toString());


    //spinnerSpinnerDealerListFromJson(json.decode(response.body));
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
          //spinnerSelectDealer2.add("Self Stock");
          spinnerSelectDealer2.add(spinnerDelerList[i].name);
          displayname = spinnerSelectDealer2[i];
        }
        else
        {
          spinnerSelectDealer2.add(spinnerDelerList[i].name);
          displayname = spinnerSelectDealer2[i];
        }
      });


      print(" Spinner Dealer List   Name $displayname");
    }
  }




  getSessionData() async
  {
    print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String  userName = prefs.getString('UserName');
    String  mycompanyId = prefs.getString('companyId');
    String  mymemberId = prefs.getString('memberId');
    API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');
    bool isAllowAddtoCart = prefs.getBool("AllowAddToCart");
    bool isAllowtoBlock = prefs.getBool("AllowtoBlock");
    bool AllowAdanceOrdering = prefs.getBool("AllowAdanceOrdering");

    print("CartPage Allow Add to Cart values $isAllowAddtoCart");
    print("CartPage Allow Block to Cart values $isAllowtoBlock");
    setState(() {


      print("isAllowAddtoCart >>>>>>>>>>>>>>>>>>>>>>>>>>>> $isAllowAddtoCart");

      if(isAllowAddtoCart)
      {
        widget.isSelfStockDisable=false;
      }

      if(!isAllowAddtoCart||!isAllowtoBlock)
      {
        widget.isSelfStockDisable=true;
        // widget.SelectedValueForSearch == "Dealer";
      }
      if(!isAllowAddtoCart&&!isAllowtoBlock)
      {
        widget.ifselfStockRadioVisible=true;
        // widget.SelectedValueForSearch == "Dealer";
      }

    });


    print("GSelf Stcok >>>>>>>>>>>>>>>>>>>>>>   "+widget.isSelfStockDisable.toString());

    List<String> spinnerDelerListOnCart2 = prefs.getStringList('spinnerDelerListOnCart');

    String  mymemberType = prefs.getString('memberType');

    String  parent_distributor_id ="0";
    String  parent_distributor_nav_id = "0";
    if(mymemberType!="Distributor")
    {

      parent_distributor_id = prefs.getString('parent_distributor_id');
      parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');

    }


    print(">>>>>>>>>>>Session Token $token   $mycompanyId $mymemberId");
    print("spinnerDelerListOnCart >>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+spinnerDelerListOnCart2.length.toString());


    print(">>>>>>>>>>>Session Token $token");
    setState(() {
      MyToken=token;
      MyUserName=userName;
      MyCompanyId=mycompanyId;
      MyMemberId=mymemberId;
      MyspinnerDelerListOnCart=spinnerDelerListOnCart2;
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
      print(">>>>>>>>>>>>>>>>>>Token is Not Empty>>>>>>>>>>>>>>>>>>>");




      checkNetconnection = isInternatAvailable();
      print("Response od internet Menthode $checkNetconnection");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$checkNetconnection.");
      if(checkNetconnection!=null)
      {
        //getList();


        if(MyMemberType=="Distributor")
        {
          getDealerList().then((value) {
            if(widget.ifselfStockRadioVisible&&MyMemberType=="Distributor"){
              isDealerClick();
            }
          });
        }
        getCartList().then((value){
          setState(() {
            isCartLoad=false;
            print("Cart List Methode finish >>>>>> $isCartLoad");
          });
        });
        getBlockList();






      }
      if(checkNetconnection!=null)
      {
        print("Please check your Internet Connection ");
        // showAlertStockDialog(context);
        //interNetPopup();
      }


    }
  }


   isDealerClick ()
  {
    if(widget.spinnerDealerSelectes==null)
    {
      setState(() {
        newCartList.clear();
        newBlockedList.clear();
        isCartEmpty=false;
        isBolckEmpty=false;
        BlockedListVisible = false;
        CartListVisible = true;

        if(spinnerDelerList.isNotEmpty)
        {
          widget.SelectedDealer2 = spinnerDelerList[0].name;
          widget.spinnerDealerSelectes=spinnerDelerList[0];
          print("Selected Dealer In List ID "+widget.spinnerDealerSelectes.id.toString()+" Dealer Name "+widget.spinnerDealerSelectes.name.toString());
          newCartList.clear();
          newBlockedList.clear();
          widget.SelectedValueForSearch="Dealer";
          print("widget.SelectedValueForSearch $widget.SelectedValueForSearch");
          getCartList().then((value){
            setState(() {
              isCartLoad=false;
              print("Cart List Methode finish >>>>>> $isCartLoad");
            });
          });
          getBlockList();
        }

      });
    }


    newCartList.clear();
    newBlockedList.clear();
    //CartListVisible=false;
    // BlockedListVisible=false;

    widget.SelectedValueForSearch="Dealer";
    print("widget.SelectedValueForSearch $widget.SelectedValueForSearch");
    DealerDropDownVisible=true;
    print(" 2 DealerDropDownVisible   >>>>>>>>>>>>>>>>   $DealerDropDownVisible");




    list2.clear();
    newBlockedListSelected.clear();
    list1.clear();
    newCartListSelected.clear();

  }


  bool FlagDeleteCartItems=false;
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Delete Cart Items
  Future<int> deleteCartItems(int id, int productId,StateSetter updateState2) async {
    String ApiUrlDelete ;


    if(MyMemberType=="Distributor")
    {
      if (widget.SelectedValueForSearch == "Self Stock")
      {
        print("Self Stock item Deleted ");
        ApiUrlDelete = API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/distributors/$MyMemberId/cart_items';
      }
      else {
        print("Dealer item Deleted ");
        int idSelected = widget.spinnerDealerSelectes.id;
        print("Id f Deleaer Delete is $idSelected");
        ApiUrlDelete = API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/dealers/$idSelected/cart_items';
      }
    }
    else
    {
      if(MyMemberType=="DUC")
      {
        print("DUC item Deleted ");
        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/cart_items
        ApiUrlDelete = API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/dealers/$MyMemberId/cart_items';
      }
      else if(MyMemberType=="DUD")
      {
        print("DUD item Deleted ");

        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1687/cart_items
        ApiUrlDelete = API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/dealers/$MyMemberId/cart_items';
      }
    }




    print("Delete Cart Items Call Id : $id   Product Id $productId");

    var headers = {
      'Authorization': 'bearer $MyToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse(ApiUrlDelete));
    request.body = '''{\n    "item_ids": [\n        $id,\n        $productId\n    ]\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      updateState2((){
        isItemDeleted=true;
        FlagDeleteCartItems=false;
      });
      print("Cart Items Delete SuccessFully "+response.reasonPhrase);
    }
    else {
      print(response.reasonPhrase);
      print("Error on Deleteing Cart Items "+response.reasonPhrase);
    }

    return response.statusCode;

  }


  bool FlagUnblockItems=false;
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~unBlockListItem
  Future<int> unBlockListItem(int id, int productId,StateSetter updateState2) async {

    String ApiUrlBlock ;

    if(MyMemberType=="Distributor")
    {

      if(widget.SelectedValueForSearch=="Self Stock")
      {
        ApiUrlBlock =API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/unBlock_items';
      }
      else
      {
        int idSelected = widget.spinnerDealerSelectes.id;
        print("Id f Deleaer Block  is $idSelected");
        ApiUrlBlock = API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$idSelected/unBlock_items';
      }

    }
    else
    {
      if(MyMemberType=="DUC")
      {
        print('$MyMemberType item unblock ');
        ApiUrlBlock = API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/unBlock_items';
      }
      else if(MyMemberType=="DUD")
      {
        print("$MyMemberType items unblock");

        ApiUrlBlock = API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/unBlock_items';
      }
    }







    print("unBlockListItem   Items Call Id : $id   Product Id $productId");
    var headers = {
      'Authorization': 'bearer $MyToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(ApiUrlBlock));
    request.body = '''{\n\t"blocked_Ids":[$id,$productId]\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("Successfully Items UnBlock");
      updateState2((){
        isItemBlocked=true;
      });
    }
    else {
      print(response.reasonPhrase);
      print("Error on unblock item "+response.reasonPhrase);
    }

    return response.statusCode;
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  bool _value = false;
  int val = 1;

  bool DealerDropDownVisible = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    int lengthSelectedList;
    int lengthSelectedListBlock;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
      child:

      Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child:MyAppBar(false,"",MyUserName,false,true),
        ),


        body: SafeArea(
          child:

          Container(

            child: SingleChildScrollView(


              child: Container(
                child: Column(

                  children: [

                    Container(
                      margin: EdgeInsets.only(left: 15,top: 15,bottom: 15),

                      child: Column(


                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child:
                            Text("Select Items and Place Order ", style: TextStyle(fontSize:textSizeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.bold  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


                        widget.ifselfStockRadioVisible==true?Container():Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width/2,
                          child: ListTile(
                            title: Text("Self Stock"),
                            leading: Radio(
                              value: 1,

                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  widget.spinnerDealerSelectes=null;
                                  isCartEmpty=false;
                                  isBolckEmpty=false;
                                  newCartList.clear();
                                  newBlockedList.clear();
                                  val = value;
                                  widget.SelectedValueForSearch="Self Stock";
                                  print("widget.SelectedValueForSearch $widget.SelectedValueForSearch");
                                  getCartList().then((value){
                                    setState(() {
                                      isCartLoad=false;
                                      print("Cart List Methode finish >>>>>> $isCartLoad");
                                    });
                                  });
                                  getBlockList();
                                  DealerDropDownVisible=false;



                                  list2.clear();
                                  newBlockedListSelected.clear();
                                  list1.clear();
                                  newCartListSelected.clear();
                                  CartListVisible=true;

                                  BlockedListVisible=false;



                                });
                              },
                              activeColor:sh_colorPrimary,
                            ),
                          ),
                        ),
                        Container(
                          width: width/2,
                          child: ListTile(
                            title: Text("Dealer"),
                            leading: Radio(
                              value: 2,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {

                                  print("on Select Dealer "+widget.spinnerDealerSelectes.toString());
                                  if(widget.spinnerDealerSelectes==null)
                                  {
                                    print("Step 1");
                                    setState(() {
                                      isCartEmpty=false;
                                      isBolckEmpty=false;
                                      BlockedListVisible = false;
                                      CartListVisible = true;
                                      print("on Select DealerList "+spinnerDelerList.toString());
                                     if(spinnerDelerList.isNotEmpty)
                                        {
                                          print("Step 2");
                                          widget.SelectedDealer2 = spinnerDelerList[0].name;
                                          widget.spinnerDealerSelectes=spinnerDelerList[0];
                                          print("Selected Dealer In List ID "+widget.spinnerDealerSelectes.id.toString()+" Dealer Name "+widget.spinnerDealerSelectes.name.toString());
                                          newCartList.clear();
                                          newBlockedList.clear();
                                          widget.SelectedValueForSearch="Dealer";
                                          print("widget.SelectedValueForSearch $widget.SelectedValueForSearch");
                                          getCartList().then((value){
                                            setState(() {
                                              isCartLoad=false;
                                              print("Cart List Methode finish >>>>>> $isCartLoad");
                                            });
                                          });
                                          getBlockList();
                                        }

                                      // else{
                                      //     print("GDealer is Empty");
                                      // }

                                    });
                                  }

                                  val = value;
                                  newCartList.clear();
                                  newBlockedList.clear();
                                  //CartListVisible=false;
                                  // BlockedListVisible=false;

                                  widget.SelectedValueForSearch="Dealer";
                                  print("widget.SelectedValueForSearch $widget.SelectedValueForSearch");
                                  DealerDropDownVisible=true;



                                  list2.clear();
                                  newBlockedListSelected.clear();
                                  list1.clear();
                                  newCartListSelected.clear();
                                });
                              },
                              activeColor: sh_colorPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),






                    //~~~~~~~~~~~~~~~~~~~~~~~~~~~List of Dealers


                    Visibility(
                      // spinnerSelectDealer2.length==0
                      child:spinnerSelectDealer2.length==0?Container(
                        child: Container(
                          margin: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
                          padding:  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                          width: double.infinity,
                          child: text(
                              spinnerSelectDealer2.isEmpty?"No Dealers Available":"Search Dealers",
                            //  (isDealersAvailable&&val==2)||val==1?"Loading Dealers..":"No Dealers Availabe",
                              fontSize: textSizeSmall,

                              fontFamily: fontRegular,
                              textColor: sh_textColorSecondary),
                          decoration: BoxDecoration(
                            color: Colors.white,

                            border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                            borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                          ),
                        ),
                      ) :
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),



                        child:Autocomplete(
                          initialValue: TextEditingValue(text:widget.spinnerDealerSelectes==null?"":widget.spinnerDealerSelectes.name,),
                          // initialValue: TextEditingValue(text:widget.SelectedDealer2==null?"":widget.SelectedDealer2,),


                          optionsBuilder: (TextEditingValue value) {
                            // When the field is empty
                            if (value.text.isEmpty) {
                              return [];
                            }

                                      // The logic to find out which ones should appear
                                  return spinnerSelectDealer2.where((suggestion) => suggestion.toString().toLowerCase().contains(value.text.toLowerCase()));
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


                              BlockedListVisible = false;
                              CartListVisible = true;


                              widget.SelectedDealer2 = value;

                              final index = spinnerDelerList.indexWhere((element) =>
                              element.name == widget.SelectedDealer2);

                              print(">>>>>>Selected Dealer List Index $index");
                              widget.spinnerDealerSelectes=spinnerDelerList[index];
                              print("Selected Dealer In List ID "+widget.spinnerDealerSelectes.id.toString()+" Dealer Name "+widget.spinnerDealerSelectes.name.toString());



                              newCartList.clear();
                              newBlockedList.clear();


                              widget.SelectedValueForSearch="Dealer";
                              print("widget.SelectedValueForSearch $widget.SelectedValueForSearch");
                              getCartList().then((value){
                                setState(() {
                                  isCartLoad=false;
                                  print("Cart List Methode finish >>>>>> $isCartLoad");
                                });
                              });
                              getBlockList();














                            });

                          },
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,

                          border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                          borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                        ),

                      ),
                      // Container(
                      //   width: width,
                      //
                      //   margin: EdgeInsets.symmetric(horizontal: 15),
                      //   padding: EdgeInsets.symmetric(horizontal: 20),
                      //   child: new DropdownButton<String>(
                      //     value: widget.SelectedDealer2,
                      //     hint: new Text("Select Here"),
                      //     isExpanded: true,
                      //     icon: Icon(
                      //       Icons.arrow_drop_down,
                      //       color:
                      //       sh_textColorSecondary,
                      //       size: 25,
                      //     ),
                      //     iconSize: 24,
                      //     elevation: 16,
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 18,
                      //     ),
                      //     underline: Container(
                      //       height: 2,
                      //     ),
                      //     onChanged: (String value) {
                      //       setState(() {
                      //         widget.SelectedDealer2 = value;
                      //
                      //         final index = spinnerDelerList.indexWhere((element) =>
                      //         element.name == widget.SelectedDealer2);
                      //
                      //         print(">>>>>>Selected Dealer List Index $index");
                      //         widget.spinnerDealerSelectes=spinnerDelerList[index];
                      //         print("Selected Dealer In List ID "+widget.spinnerDealerSelectes.id.toString()+" Dealer Name "+widget.spinnerDealerSelectes.name.toString());
                      //
                      //
                      //
                      //         newCartList.clear();
                      //         newBlockedList.clear();
                      //
                      //         widget.SelectedValueForSearch="Dealer";
                      //         print("widget.SelectedValueForSearch $widget.SelectedValueForSearch");
                      //         getCartList();
                      //         getBlockList();
                      //
                      //
                      //
                      //       });
                      //     },
                      //     items: spinnerSelectDealer2
                      //         .map<DropdownMenuItem<String>>(
                      //             (String value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value,
                      //             child: text(value,
                      //                 fontSize: textSizeSmall,
                      //                 textColor: sh_textColorSecondary,
                      //                 fontFamily: fontRegular),
                      //           );
                      //         }).toList(),
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //
                      //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                      //     borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                      //   ),
                      //
                      // ),
                      /* maintainSize: true,
                   maintainAnimation: true,
                   maintainState: true,*/
                      visible: DealerDropDownVisible,
                    ),


                    (isDealersAvailable&&val==2)||val==1?    Container(

                      padding: EdgeInsets.all(15.0),
                      color: sh_ColorPrimary2,
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            Container(
                                width: (width-40)/2,

                                padding: EdgeInsets.symmetric(horizontal: 10),

                                child:
                                MaterialButton(

                                  padding: EdgeInsets.all(0.0),

                                  child:   Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(),
                                            CartListVisible?   Text("Shopping Cart", style:TextStyle(fontSize: textSizeSmall,fontWeight: FontWeight.w500,color:
                                            sh_colorPrimary),): Text("Shopping Cart", style:TextStyle(fontSize: textSizeSmall,fontWeight: FontWeight.w500,color:
                                            sh_textColorSecondary),),
                                            Container(),

                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                  textColor: backgroundSearchProductFormButtons,
                                  // shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                  color: sh_white,

                                  onPressed: () => {
                                    // DisOrderHistory(backArrowVisible: false,SelectedValueForSearch:"Self Stock").launch(context),
                                    setState(() {

                                      spinnerDelerList.clear();
                                      spinnerSelectDealer2.clear();
                                      isBlockDealers=false;

                                      if(MyMemberType=="Distributor")
                                      {
                                        getDealerList();
                                      }





                                      BlockedListVisible=false;
                                      CartListVisible=true;
                                      list2.clear();
                                      newBlockedListSelected.clear();
                                      list1.clear();
                                      newCartListSelected.clear();
                                      getCartList().then((value){
                                        setState(() {
                                          isCartLoad=false;
                                          print("Cart List Methode finish >>>>>> $isCartLoad");
                                        });
                                      });


                                      // if(responceCodeCart==200&&lengthofCart==0)
                                      // {
                                      //   setState(() {
                                      //     isCartEmpty=true;
                                      //   });
                                      //   //showToastDialog(context, "No Cart items found");
                                      // }
                                    })
                                  },
                                  elevation: 0,
                                ),

                                decoration: BoxDecoration(
                                  color: sh_white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),

                                  ),

                                )
                            ),
                            SizedBox(width: 10,),
                            Container(
                                width: (width-40)/2,

                                padding: EdgeInsets.symmetric(horizontal: 10),

                                child:
                                MaterialButton(

                                  padding: EdgeInsets.all(0.0),

                                  child:   Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(),
                                            BlockedListVisible?  Text("Blocked Items", style:TextStyle(fontSize: textSizeSmall,fontWeight: FontWeight.w500,color:
                                            sh_colorPrimary),):
                                            Text("Blocked Items", style:TextStyle(fontSize: textSizeSmall,fontWeight: FontWeight.w500,color:
                                            sh_textColorSecondary),),
                                            Container(),

                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                  textColor: backgroundSearchProductFormButtons,
                                  // shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                  color: sh_white,

                                  onPressed: () => {

                                    setState(() {
                                      spinnerDelerList.clear();
                                      spinnerSelectDealer2.clear();
                                      isBlockDealers=true;



                                      if(MyMemberType=="Distributor")
                                      {
                                        getDealerList();
                                      }
                                      BlockedListVisible=true;
                                      CartListVisible=false;
                                      list2.clear();
                                      newBlockedListSelected.clear();
                                      list1.clear();
                                      newCartListSelected.clear();
                                      getBlockList();

                                      if(responseCodeBlock==200&&lengthofBlock==0)
                                      {
                                        setState(() {
                                          isBolckEmpty=true;

                                        });
                                        //showToastDialog(context, "No Block items found");
                                      }
                                    })
                                    //DisOrderHistory(backArrowVisible: false,SelectedValueForSearch:"Dealer").launch(context),
                                  },
                                  elevation: 0,
                                ),

                                decoration: BoxDecoration(
                                  color: sh_white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),

                                  ),

                                )
                            ),

                          ],
                        ),
                      ),

                    ):Container(),




                    //~~~~~~~~~~~~~~~~~~~~~~~List Blocked ~~~~~~~~~~~~~~~~~~~~
                    // spinnerSelectDealer2.isEmpty?Container(
                    //   child:Text("1"),
                    // ):Container(
                    //   child:Text("2"),
                    // ),

                    (val==2&&spinnerSelectDealer2.isEmpty)? Container():Visibility(
                      child:Container(
                        child:

                        isBolckEmpty ?Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text("Sorry, No Blocked Items found."),
                              Container(),
                            ],
                          ),
                        ): newBlockedList.length == 0 ? ShimmerCartList(): ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: newBlockedList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              //newBlockedList[index].product.collection.displayName.toString().replaceAll("Code.","");
                              var collectionName = newBlockedList[index].product.collection.displayName;

                              String colorCode = newBlockedList[index].product.colour==null?"":newBlockedList[index].product.colour.displayName==null?"":newBlockedList[index].product.colour.displayName;
                              //  String colorCode = newBlockedList[index].product.colour.displayName.toString().replaceAll("Code.","");
                              // double  price = newBlockedList[index].unitPrice;
                              double  price = newBlockedList[index].rateType.toString()=="RL"||newBlockedList[index].rateType.toString()=="CL"?newBlockedList[index].unitPrice:
                              double.parse(((newBlockedList[index].unitPrice-((newBlockedList[index].unitPrice *newBlockedList[index].discount)/100))).toStringAsFixed(2));

                              double   quantity  = double.parse(newBlockedList[index].orderQuantity.toStringAsFixed(0));

                              double ammount = price * quantity;
                              String blockedTimeStamp = newBlockedList[index].expires;
                              countdowntime = int.parse(newBlockedList[index].expires);
                              String batchNo = newBlockedList[index].batchNo;

                              String ImageUrl = newBlockedList[index].product.imageUrl;
                              //  var batchNo = newBlockedList[index].batchNo.name==null?"":newBlockedList[index].batchNo.name;

                              print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$batchNo");



                              DateTime date = DateTime.parse(blockedTimeStamp);
                              print(DateFormat('dd-MM-yyyy').format(date));
                              print("Time Stamp Result $date");

                              // var d12 = DateFormat('MM/dd/yyyy, HH:mm:ss a').format(date);
                              var d12 = DateFormat('HH:mm:ss').format(date);
                              print("Time In Secods with Date  $d12");

                              //Time Stamp Convert
                              //var newTime = new DateTime.fromMicrosecondsSinceEpoch(int.parse(blockedTimeStamp));
                              var newTime = new DateTime.fromMicrosecondsSinceEpoch(1639117198);
                              // DateTime.fromMicrosecondsSinceEpoch(int.parse(blockedTimeStamp).microsecondsSinceEpoch)
                              print("New Time Stamp >>>>>>  $newTime");

                              //
                              var t = readTimestamp(int.parse(blockedTimeStamp));
                              //countdowntime=startTimer(countdowntime);
                              print ("Time From readTimeStamp $countdowntime");


                              // startTimer(countdowntime).then((value)
                              // {
                              //
                              //
                              //   setState(() {
                              //     print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+value.toString());
                              //
                              //    // print("Change value of time stamp is "+blockedTimeStamp);
                              //   });
                              //
                              // });









                              ////////// Count Down Timmer in Demo Test Code



                              //1643859656

                              int endTime = DateTime.now().millisecondsSinceEpoch +
                                  Duration(seconds: 1643642839).inMilliseconds;




                              final birthday = DateTime(2022, 02, 3);

                              final date2 = DateTime.now();
                              final difference = birthday.difference(date2).inSeconds;


                              print("Calculated Difference is $difference");

                              //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                              int ts = int.parse(newBlockedList[index].expires);
                              //1643891832;
                              DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts*1000);
                              String datetime = tsdate.year.toString() + "," + tsdate.month.toString() + "," + tsdate.day.toString();
                              print("G Time ......$datetime");
                              final dateG = DateTime.now();
                              final differenceG = DateTime.fromMillisecondsSinceEpoch(int.parse(newBlockedList[index].expires)*1000).difference(dateG).inSeconds;
                              //final differenceG = tsdate.difference(dateG).inSeconds;
                              // final differenceG = DateTime(tsdate.year, tsdate.month, tsdate.day).difference(dateG).inSeconds;
                              DateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(newBlockedList[index].expires)*1000).year, DateTime.fromMillisecondsSinceEpoch(int.parse(newBlockedList[index].expires)*1000).month, DateTime.fromMillisecondsSinceEpoch(int.parse(newBlockedList[index].expires)*1000).day).difference(DateTime.now()).inSeconds;

                              print("Today Date time is "+dateG.toString());
                              print("Today Expire Date time is "+tsdate.toString());
                              print("Calculated Difference is G $differenceG");
                              //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


                              print("Expires Date is "+DateTime.parse("1643891832").toString());//Thursday, 3 February 2022 12:37:12


                              return  Container(
                                margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                                padding: EdgeInsets.only(right: 10,top: 10,bottom: 10, left: 10),
                                width: double.infinity,
                                child:
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        //~~~~~~~~~~~~~~~~CUstom Check Box Code
                                        // Theme(data: ThemeData(
                                        //   // checked color
                                        //     primarySwatch: kPrimaryColor,
                                        //     // border color
                                        //     unselectedWidgetColor:kPrimaryColor
                                        // ),
                                        //     child:  Checkbox(
                                        //
                                        //         value:  list1.contains(index) ? true :false,
                                        //         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        //
                                        //         onChanged: (value)
                                        //         {
                                        //           setState(() {
                                        //             if(list1.contains(index))
                                        //             {
                                        //               list1.remove(index);
                                        //             }
                                        //             else
                                        //             {
                                        //               list1.add(index);
                                        //
                                        //             }
                                        //
                                        //           });
                                        //         })),
                                        Container(
                                          child:GestureDetector(

                                            child: list2.contains(index) ? imgUp:imgDown,
                                            onTap: (){
                                              setState(() {
                                                selectedindex2=index;
                                                if(list2.contains(index))
                                                {
                                                  list2.remove(index);
                                                  bool isRemoveCart= newBlockedListSelected.remove(newBlockedList[index]);
                                                  print("On Remove Blocked is $isRemoveCart");
                                                }
                                                else
                                                {
                                                  list2.add(index);
                                                  newBlockedListSelected.add(newBlockedList[index]);
                                                  print("On Add Length of Block  Items "+newBlockedListSelected.length.toString());

                                                }

                                                //  print(img.toString()+"Show1");
                                              });

                                            },
                                          ),
                                          padding: EdgeInsets.all(2),


                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          width:50,//width * 0.3,
                                          height: 50,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                            child:ImageUrl!=null?Image.network(ImageUrl, fit: BoxFit.fill):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.fill),

                                          ),


                                        ),
                                        SizedBox(width: 10,),

                                        Container(
                                          width: (width/2)-66,
                                          // alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              //collectionName
                                              Text("$collectionName",style: TextStyle(fontWeight: FontWeight.bold,fontSize: textSizeMedium,color: sh_textColorSecondarylight),),
                                              SizedBox(height: 10,),
                                              Text(colorCode,style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),
                                              SizedBox(height: 10,),
                                              Text("$batchNo",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),
                                              SizedBox(height: 10,),



                                              Container(
                                                width: 100,
                                                height: 35,
                                                margin: EdgeInsets.only(left: 0),
                                                child: Container(
                                                  child:Container(
                                                      alignment: Alignment.center,
                                                      child: Text("Quantity : "+newBlockedList[index].orderQuantity.toStringAsFixed(2)+" SFT",style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeSMedium),)),
                                                  decoration: BoxDecoration(

                                                    //   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                                    //   borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  ),
                                                ),


                                                decoration: BoxDecoration(

                                                  // border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: (width/2)-66,

                                          alignment: Alignment.centerRight,
                                          child: Column(

                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                              InkWell(

                                                child: Container(
                                                    alignment: Alignment.centerRight,
                                                    child: Image.asset(ic_unlockcart_item,height: 20,width: 20,fit: BoxFit.fill,color: sh_colorPrimary,)),
                                                onTap: (){


                                                  FlagUnblockItems=true;
                                                  //  showAlertDialogUnblockToBlockSearchResult(context,newBlockedList[index],setState,index);
                                                  showAlertDialogConfirmUnBlock(context,newBlockedList[index],setState,index);



                                                },
                                              ),

                                              SizedBox(height: 10,),
                                              Container(
                                                alignment: Alignment.centerRight,
                                                child: Text(""+price.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),

                                              ),
                                              SizedBox(height: 5,),
                                              Container(
                                                alignment: Alignment.centerRight,

                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,

                                                      children: [
                                                        Text("Total ",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),

                                                        Text(""+(newBlockedList[index].orderQuantity*price).toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondarylight),),
                                                      ],
                                                    ),






                                                  ],
                                                ),

                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(),
                                                  (newBlockedList[index].rateType=="RL"||newBlockedList[index].rateType=="CL")? Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,

                                                    children: [
                                                      Text("Rate Type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
                                                      SizedBox(width: 5,),
                                                      Text(""+(newBlockedList[index].rateType),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
                                                      //Text(""+cartammount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),

                                                    ],
                                                  ):Container(),


                                                ],
                                              ),


                                            ],


                                          ),
                                        ),




                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      padding: EdgeInsets.all(5),
                                      child:
                                      Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    alignment: Alignment.centerRight,
                                                    child: Image.asset(ic_blockround,height: 20,width: 20,fit: BoxFit.fill,color: sh_colorPrimary,)),
                                                SizedBox(width: 5,),
                                                Container(
                                                  child: Text("Expires",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
                                                ),
                                                SizedBox(width: 5,),
                                                Container(


                                                  //child: Text("$t",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
                                                    child:  CountdownTimer(
                                                      textStyle: TextStyle(
                                                          fontSize: 14, color: sh_colorPrimary, fontWeight: FontWeight.bold),
                                                      onEnd: onEnd,


                                                      endTime:
                                                      DateTime.now().millisecondsSinceEpoch +
                                                          Duration(seconds: DateTime.fromMillisecondsSinceEpoch(int.parse(newBlockedList[index].expires)*1000).difference(dateG).inSeconds,
                                                          ).inMilliseconds,
                                                      //DateTime.parse(newBlockedList[index].expires).difference(DateTime.now()).inSeconds,
                                                      //countRemainsTime2(DateTime.now().millisecondsSinceEpoch.toString(), ""+newBlockedList[index].expires),
                                                      endWidget: Text(
                                                        "Deal has ended",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: sh_colorPrimary,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    )

                                                ),
                                              ],
                                            ),
                                            Container(),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color:sh_blockedBackGround,

                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                      ),

                                    ),

                                    // CountdownTimer(
                                    //   textStyle: TextStyle(
                                    //       fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                                    //   onEnd: onEnd,
                                    //   endTime: countRemainsTime2(DateTime.now().millisecondsSinceEpoch.toString(), ""+newBlockedList[index].expires)==0?0:countRemainsTime2(DateTime.now().millisecondsSinceEpoch.toString(), ""+newBlockedList[index].expires),
                                    //   endWidget: Text(
                                    //     "Deal has ended",
                                    //     style: TextStyle(
                                    //         fontSize: 14,
                                    //         color: Colors.red,
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                    // ),

                                  ],
                                ),


                                decoration: BoxDecoration(
                                  color: Colors.white,

                                  border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                              );

                            }),
                      ),
                      visible: BlockedListVisible,
                    ),
                    (val==2&&spinnerSelectDealer2.isEmpty)? Container():Visibility(
                      child:Container(

                        child:// isCartEmpty

                        //resCartList==200&&LenCartList==0

                        isCartLoad?ShimmerCartList():
                        newCartList.length == 0 ?     Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text("Sorry, No Cart Items found."),
                              Container(),

                            ],
                          ),
                        ):


                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: newCartList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {

                              String cartcollectionName = newCartList[index].product.collection.displayName.toString().replaceAll("Code.","")==null?"Not Available": newCartList[index].product.collection.displayName.toString().replaceAll("Code.","");
                              //   String cartcolorCode = newCartList[index].product.colour.displayName.toString().replaceAll("Code.","")==null?" ":newCartList[index].product.colour.displayName.toString().replaceAll("Code.","");
                              String cartcolorCode = newCartList[index].product.colour==null?"":newCartList[index].product.colour.displayName==null?"":newCartList[index].product.colour.displayName;
                              double  cartprice = newCartList[index].rateType.toString()=="RL"||newCartList[index].rateType.toString()=="CL"?newCartList[index].unitPrice
                                  :double.parse(((newCartList[index].unitPrice-((newCartList[index].unitPrice *newCartList[index].discount)/100))).toStringAsFixed(2));
                              double   cartquantity  = double.parse(newCartList[index].orderQuantity.toStringAsFixed(0));
                              double cartammount = (cartprice*cartquantity);
                              String ImageUrl = newCartList[index].product.imageUrl;
                              String RateType =newCartList[index].rateType.toString();


                              print("Cart Quanity $cartquantity");
                              print("Cart Price $cartprice");

                              print("Rate Type Cart in Zero position >>>>>>>>>>>>>>>>>>>>>>.. 0 "+newCartList[index].rateType.toString());








                              String bathNo = newCartList[index].batchNo;
                              print("Cart >>>>>>>>>>>>>>>>> $bathNo");

                              return Container(
                                margin: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                                padding: EdgeInsets.all(5),
                                width: double.infinity,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[



                                    InkWell(
                                      child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              list1.contains(index) ? imgUp:imgDown,
                                              SizedBox(width: 10,),
                                              Container(
                                                width:50,//width * 0.3,
                                                height: 50,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  child:ImageUrl!=null?Image.network(ImageUrl, fit: BoxFit.fill):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.fill),

                                                  // Image.asset(
                                                  //   "images/shophop/img/products" +
                                                  //       list[0].images[0].src,
                                                  //   fit: BoxFit.fill,
                                                  // ),
                                                ),
                                              ),




                                            ],
                                          )
                                      ),
                                      onTap: (){
                                        setState(() {
                                          selectedindex=index;
                                          if(list1.contains(index))
                                          {
                                            list1.remove(index);
                                            //  newCartListSelected.removeAt(index);
                                            bool isRemoveCart= newCartListSelected.remove(newCartList[index]);
                                            print("On Remove is $isRemoveCart");


                                            print("On Remove Length of Cart Items "+newCartListSelected.length.toString());
                                          }
                                          else
                                          {
                                            list1.add(index);
                                            newCartListSelected.add(newCartList[index]);
                                            print("On Add Length of Cart Items "+newCartListSelected.length.toString());



                                          }
                                        });
                                      },
                                    ),


                                    Container(
                                      width: (width-107),

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(

                                                child: Text(""+cartcollectionName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: textSizeMedium),),
                                                width: (width/3),
                                              ),

                                              InkWell(
                                                child: Container(
                                                    alignment: Alignment.centerRight,
                                                    child: Image.asset(ic_delete_item,height: 20,width: 20,fit: BoxFit.fill,color: sh_colorPrimary,)),
                                                onTap: (){


                                                  FlagDeleteCartItems=true;
                                                  showAlertDialogConfirmDelete(context,newCartList[index],setState,index);
                                                  //  showAlertDialogAddToCartSearchResult(context,newCartList[index],setState,index);


                                                },
                                              ),

                                            ],
                                          ),
                                          SizedBox(height: 10,),

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(""+cartcolorCode,style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
                                              Container(
                                                alignment: Alignment.centerRight,
                                                child: Text(""+cartprice.toString().toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),

                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: (width/2)-66,

                                                child:  Text("$bathNo",

                                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),
                                                ),
                                              ),

                                              Container(
                                                alignment: Alignment.centerRight,

                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,

                                                      children: [
                                                        Text("Total",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
                                                        SizedBox(width: 5,),
                                                        Text(""+(newCartList[index].orderQuantity*cartprice).toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
                                                        //Text(""+cartammount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),

                                                      ],
                                                    ),


                                                  ],
                                                ),

                                              ),

                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  // width: 80,
                                                  height: 35,
                                                  margin: EdgeInsets.only(left: 0),
                                                  child:  Container(
                                                    child:Container(
                                                        alignment: Alignment.center,
                                                        child: Text("Quantity : "+newCartList[index].orderQuantity.toStringAsFixed(2)+" SFT",style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeSMedium),)),
                                                    decoration: BoxDecoration(

                                                      // border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                                      // borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    ),
                                                  ),
                                                ),
                                                (newCartList[index].rateType=="RL"||newCartList[index].rateType=="CL")? Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,

                                                  children: [
                                                    Text("Rate Type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
                                                    SizedBox(width: 5,),
                                                    Text(""+(newCartList[index].rateType),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
                                                    //Text(""+cartammount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),

                                                  ],
                                                ):Container(),
                                                // Container(
                                                //   child: Row(
                                                //
                                                //
                                                //     children: [
                                                //       Text("SFT",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
                                                //      // Text("Rate Type :",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
                                                //     //  SizedBox(width: 5,),
                                                //     //  Text(""+RateType,style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          )


                                        ],
                                      ),
                                      margin: EdgeInsets.only(left: 10),
                                    ),

                                    // Container(
                                    //   // width: (width/2)-66,
                                    //   alignment: Alignment.centerRight,
                                    //   child: Column(
                                    //     children: [
                                    //       // InkWell(
                                    //       //   child: Container(
                                    //       //       alignment: Alignment.centerRight,
                                    //       //       child: Image.asset(ic_delete_item,height: 20,width: 20,fit: BoxFit.fill,)),
                                    //       //   onTap: (){
                                    //       //
                                    //       //
                                    //       //
                                    //       //     showAlertDialogAddToCartSearchResult(context,newCartList[index],setState,index);
                                    //       //
                                    //       //
                                    //       //   },
                                    //       // ),
                                    //
                                    //
                                    //       SizedBox(height: 10,),
                                    //       // Container(
                                    //       //   alignment: Alignment.centerRight,
                                    //       //   child: Text(""+cartprice.toString().toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
                                    //       //
                                    //       // ),
                                    //       SizedBox(height: 10,),
                                    //       // Container(
                                    //       //   alignment: Alignment.centerRight,
                                    //       //
                                    //       //   child: Row(
                                    //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //       //     children: [
                                    //       //       Container(),
                                    //       //       Row(
                                    //       //         mainAxisAlignment: MainAxisAlignment.start,
                                    //       //
                                    //       //         children: [
                                    //       //           Text("Total",style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_textColorSecondary),),
                                    //       //           SizedBox(width: 5,),
                                    //       //           Text(""+cartammount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: textSizeSMedium,color: sh_colorPrimary),),
                                    //       //         ],
                                    //       //       ),
                                    //       //
                                    //       //
                                    //       //     ],
                                    //       //   ),
                                    //       //
                                    //       // ),
                                    //
                                    //
                                    //     ],
                                    //   ),
                                    // ),




                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,

                                  border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                              );

                            }),
                      ),
                      visible: CartListVisible,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //For Select Dealer
                    // spinnerSelectDealer2.length==0?Container(
                    //   child: Container(
                    //     padding: EdgeInsets.only(left: 15,right: 10,top: 15,bottom: 15),
                    //     width: double.infinity,
                    //     child: text("Loading Dealers..",
                    //         fontSize: textSizeSmall,
                    //         fontFamily: fontRegular,
                    //         textColor: sh_textColorSecondary),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //
                    //       border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                    //       borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                    //     ),
                    //   ),
                    // ) :
                    // Container(
                    //   width: width,
                    //
                    //   margin: EdgeInsets.symmetric(horizontal: 15),
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   child: new DropdownButton<String>(
                    //     value: SelectedDealer2,
                    //     hint: new Text("Select Here"),
                    //     isExpanded: true,
                    //     icon: Icon(
                    //       Icons.arrow_drop_down,
                    //       color:
                    //       sh_textColorSecondary,
                    //       size: 25,
                    //     ),
                    //     iconSize: 24,
                    //     elevation: 16,
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 18,
                    //     ),
                    //     underline: Container(
                    //       height: 2,
                    //     ),
                    //     onChanged: (String value) {
                    //       setState(() {
                    //         SelectedDealer2 = value;
                    //
                    //         final index = spinnerDelerList.indexWhere((element) =>
                    //         element.name == SelectedDealer2);
                    //
                    //         print(">>>>>>Selected Dealer List Index $index");
                    //         spinnerDealerSelectes=spinnerDelerList[index];
                    //
                    //
                    //
                    //       });
                    //     },
                    //     items: spinnerSelectDealer2
                    //         .map<DropdownMenuItem<String>>(
                    //             (String value) {
                    //           return DropdownMenuItem<String>(
                    //             value: value,
                    //             child: text(value,
                    //                 fontSize: textSizeSmall,
                    //                 textColor: sh_textColorSecondary,
                    //                 fontFamily: fontRegular),
                    //           );
                    //         }).toList(),
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //
                    //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                    //     borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                    //   ),
                    //
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    (isDealersAvailable&&val==2)||val==1?     Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),

                      child: TextFormField(
                        minLines: 4,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        onChanged:(String Value)
                        {
                          print(Value);

                          setState(() {
                            RemarkValue=Value;

                            print("RemarkValue $RemarkValue");
                          });
                        },
                        decoration: InputDecoration(

                            filled: true,
                            fillColor: backgroundSearchProductFormInput,
                            focusColor: sh_editText_background_active,
                            hintText: sh_hint_Remark,
                            hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(round_border_form), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,

                        border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ):Container(),
                    SizedBox(
                      height: 10,
                    ),

                    //Next Button Hide
                    // newCartList.length!=0||newBlockedList.length!=0? Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 15),
                    //   // DistributorShipingDetails().launch(context),
                    //   child: Column(
                    //
                    //
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Align(
                    //         alignment: Alignment.centerLeft,
                    //         child:
                    //         Container(
                    //           width: 100,
                    //
                    //           child: MaterialButton(
                    //
                    //
                    //
                    //             child: Container(
                    //                 padding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                    //                 alignment: Alignment.center,
                    //                 child: text("Next", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white)),
                    //             textColor: sh_white,
                    //             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                    //             color: sh_colorPrimary,
                    //             onPressed: () => {
                    //
                    //
                    //               // SpinnerDealer spinnerDealerSelectes=null;
                    //               //   List<NewCartItesm> newCartListSelected=null;
                    //               //   String nameSeleted = spinnerDealerSelectes.name,
                    //               lengthSelectedList = newCartListSelected.length,
                    //               lengthSelectedListBlock = newBlockedListSelected.length,
                    //
                    //
                    //               print("Length Of Selected Cart Itmes before next $lengthSelectedList"),
                    //               print("Length Of Selected Block  Itmes before next $lengthSelectedList"),
                    //
                    //               print("Before Dealer Select Items  "+widget.SelectedValueForSearch),
                    //
                    //
                    //
                    //
                    //               if((lengthSelectedList==0&&lengthSelectedListBlock!=0)||(lengthSelectedListBlock==0&&lengthSelectedList!=0))
                    //                 {
                    //                   print("Able to Move on Shipping "),
                    //                   if(lengthSelectedList==0&&lengthSelectedListBlock==0)
                    //                     {
                    //                       print("Please Select Products"),
                    //                       showToastDialog(context,"Please Select Products"),
                    //                     }
                    //                   else
                    //                     {
                    //
                    //                       print("Lenght of Senfing Cart List Selected is "+newCartListSelected.length.toString()),
                    //                       // print("Slected Informations Dealers "+spinnerDealerSelectes.name+" Total Length  $lengthSelectedList"),
                    //
                    //
                    //
                    //                       DistributorShipingDetails(spinnerDealerSelectes: widget.spinnerDealerSelectes,newCartListSelected2: newCartListSelected,RemarkValue: RemarkValue,SelectedValueForSearch: widget.SelectedValueForSearch,newBlockListSelected2:newBlockedListSelected).launch(context),
                    //
                    //                     }
                    //                 }
                    //               else
                    //                 {
                    //
                    //                   if(lengthSelectedList==0&&lengthSelectedListBlock==0)
                    //                     {
                    //                       print("Not Able to Move on Shipping "),
                    //
                    //                       if(widget.SelectedValueForSearch=="Dealer")
                    //                         {
                    //                           print("Delar Value >>>>>>>>>>>>>>>>>>>>>>>"+widget.spinnerDealerSelectes.toString()),
                    //
                    //                           if(widget.spinnerDealerSelectes==null)
                    //                             {
                    //                               showToastDialog(context, "Please Select Dealer"),
                    //                             }
                    //                             else
                    //                               {
                    //                                 showToastDialog(context,"Please Select Products"),
                    //
                    //                               }
                    //                         }else
                    //                           {
                    //                             showToastDialog(context,"Please Select Products"),
                    //
                    //                           }
                    //                     }
                    //                   else
                    //                     {
                    //                       print("Not Able to Move on Shipping "),
                    //                       showToastDialog(context,
                    //                           "You can select items either from Cart or Blocked List"),
                    //                     }
                    //
                    //                 },
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
                    //             },
                    //
                    //             elevation: 0,
                    //           ),
                    //
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ):Container(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        endDrawer: MyDrwaer(),

        floatingActionButton: (isDealersAvailable&&val==2)||(val==1&&widget.isSelfStockDisable==false)|| widget.SelectedValueForSearch == "Dealer"?
        ((CartListVisible==true&&newCartList.length == 0)||(BlockedListVisible==true&&newBlockedList.length == 0))?Container(): FloatingActionButton.extended(
          onPressed: () {


            // SpinnerDealer spinnerDealerSelectes=null;
            //   List<NewCartItesm> newCartListSelected=null;
            //   String nameSeleted = spinnerDealerSelectes.name,
            lengthSelectedList = newCartListSelected.length;
            lengthSelectedListBlock = newBlockedListSelected.length;


            print("Length Of Selected Cart Itmes before next $lengthSelectedList");
            print("Length Of Selected Block  Itmes before next $lengthSelectedList");

            print("Before Dealer Select Items  "+widget.SelectedValueForSearch);




            if((lengthSelectedList==0&&lengthSelectedListBlock!=0)||(lengthSelectedListBlock==0&&lengthSelectedList!=0))
            {
              print("Able to Move on Shipping ");
              if(lengthSelectedList==0&&lengthSelectedListBlock==0)
              {
                print("Please Select Products");
                showToastDialog(context,"Please Select Products");
              }
              else
              {

                print("Lenght of Senfing Cart List Selected is "+newCartListSelected.length.toString());
                // print("Slected Informations Dealers "+spinnerDealerSelectes.name+" Total Length  $lengthSelectedList"),



                DistributorShipingDetails(spinnerDealerSelectes: widget.spinnerDealerSelectes,newCartListSelected2: newCartListSelected,RemarkValue: RemarkValue,SelectedValueForSearch: widget.SelectedValueForSearch,newBlockListSelected2:newBlockedListSelected).launch(context);

              }
            }
            else
            {

               if(lengthSelectedList==0&&lengthSelectedListBlock==0)
               {
                 print("Not Able to Move on Shipping ");

                 if(widget.SelectedValueForSearch=="Dealer")
                {
                   print("Delar Value >>>>>>>>>>>>>>>>>>>>>>>"+widget.spinnerDealerSelectes.toString());

                   if(widget.spinnerDealerSelectes==null)
                   {
                    showToastDialog(context, "Please Select Dealer");
                   }
                   else
                   {
                    showToastDialog(context,"Please Select Products");

                   }
                }else
                {
                  showToastDialog(context,"Please Select Products");

                }
              }
              else
              {
                print("Not Able to Move on Shipping ");
                showToastDialog(context,
                    "You can select items either from Cart or Blocked List");
              }

            };












          },
          label: const Text('Next'),
          icon: const Icon(Icons.arrow_forward),
          backgroundColor: sh_colorPrimary,
        ):Container(),
      ),
    );



  }


  showToastDialog(BuildContext context,String Message)
  {


    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
              child:
              Dialog(

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



              ),);
        });

  }


  showAlertDialogAddToCartSearchResult(BuildContext contex,BuildContext context1,NewCartItesm newCartItesm,StateSetter updateState,int index) {
    // Create button


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  Dialog(

              child: StatefulBuilder(


                builder: (BuildContext context, setState,)
                {
                  //Methode Call to Add To Cart
                  if(FlagDeleteCartItems)
                  {
                    deleteCartItems(newCartItesm.id,newCartItesm.productId,setState).then((value){

                      print("deleteCartItems>>>>>>>>>>>>>>>>>>>>"+value.toString());
                      if(value==200)
                      {
                        updateState(() {
                          //~~~~~~~~~~~~~~~un Select After Delete Items
                          list1.remove(index);
                          //  newCartListSelected.removeAt(index);
                          bool isRemoveCart= newCartListSelected.remove(newCartList[index]);



                          // newCartList.removeAt(index);
                          newCartList.remove(newCartList[index]);

                          FlagDeleteCartItems=false;
                          //isItemDeleted=true;

                          if(newCartList.length==0)
                          {
                            CartListVisible=false;

                            print("Cart List is Empty After Delete ");
                          }

                        });

                      }
                      else
                      {
                        updateState(() {
                          FlagDeleteCartItems=false;


                        });
                      }

                    });

                    print("Items deleted Once Time $FlagDeleteCartItems");

                  }
                  else{

                    print("Items not Deleted  Once Time $FlagDeleteCartItems");
                  }





                  return Container(
                    height: 250,
                    width:MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20,bottom: 20),

                    child:Container(


                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [


                                Container(
                                  child:


                                  isItemDeleted? Image.asset(ic_greencheck,height: 80,width: 80, fit: BoxFit.fill,):
                                  Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
                                  alignment: Alignment.topCenter,
                                ),

                              ],
                            ),
                            // Stack(
                            //   children: [
                            //     Container(
                            //       alignment: Alignment.centerLeft,
                            //       child:Image.asset(ic_notice_addtocart,height: 50,width: 50, fit: BoxFit.fill,),
                            //     ),
                            //     Container(
                            //       alignment: Alignment.center,
                            //       child:Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
                            //     ),
                            //   ],
                            // ),

                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 10),


                              child: isItemDeleted?Text("Item removed from cart",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),):
                              Column(
                                children: [
                                  Text("Your Item Deleting From  Cart",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Text(" please wait.....",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                      Container(),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,

                              child:isItemDeleted? IntrinsicWidth(
                                child:MaterialButton(

                                  padding: EdgeInsets.only(left: 15,right: 15,top: 13,bottom: 13),
                                  child: text("Close", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                  color: sh_colorPrimary,
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();

                                    Navigator.pop(context1, true);
                                    Navigator.pop(context);

                                  },
                                  // onPressed: () => {
                                  //  // Navigator.pop(context),
                                  //   SelectProductPlaceOrder().launch(context),
                                  // },
                                  elevation: 0,
                                ),
                              ):Container(),
                            ),

                          ],
                        )),



                  );
                },
              )



          );



        }).then((Exit){
      print(">>>>>>>>>>>>>>>>>>>>>>Dialog Closed ");

      setState(() {

        isItemDeleted=false;

        print(">>>>>>>>>>>>>>>>>>>>>>>Variable Update $isItemDeleted");
      });
    });
  }
  showAlertDialogUnblockToBlockSearchResult(BuildContext contex,BuildContext context1,NewBlockedItems newBlockedItems,StateSetter updateState,int index2) {
    // Create button


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  Dialog(

              child: StatefulBuilder(


                builder: (BuildContext context, setState,)
                {
                  //Methode Call to Unblock  To Cart
                  if(FlagUnblockItems)
                  {
                    unBlockListItem(newBlockedItems.id,newBlockedItems.productId,setState).then((value)
                    {
                      print("Response Code of Unblock Items is "+value.toString());
                      if(value==200)
                      {
                        updateState(() {

                          list2.remove(index2);
                          bool isRemoveCart= newBlockedListSelected.remove(newBlockedList[index2]);


                          newBlockedList.remove(newBlockedList[index2]);
                          FlagUnblockItems=false;

                          if(newBlockedList.length==0)
                          {
                            BlockedListVisible=false;

                            print("Block List is Empty After Delete ");
                          }

                        });
                      }
                      else
                      {
                        updateState(() {
                          FlagUnblockItems=false;

                        });
                      }
                    });

                  }






                  return Container(
                    height: 250,
                    width:MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20,bottom: 20),

                    child:Container(


                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [


                                Container(
                                  child:


                                  isItemBlocked? Image.asset(ic_greencheck,height: 80,width: 80, fit: BoxFit.fill,):
                                  Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
                                  alignment: Alignment.topCenter,
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: InkWell(
                                    child: Image.asset(ic_cross_dialog,height: 25,width: 25,
                                      color: sh_colorPrimary,),
                                    onTap: (){
                                      FocusScope.of(context).unfocus();

                                      Navigator.pop(context1, true);

                                      Navigator.pop(context, false);
                                    },
                                  ),
                                  alignment: Alignment.topRight,

                                ),
                              ],
                            ),
                            // Stack(
                            //   children: [
                            //     Container(
                            //       alignment: Alignment.centerLeft,
                            //       child:Image.asset(ic_notice_addtocart,height: 50,width: 50, fit: BoxFit.fill,),
                            //     ),
                            //     Container(
                            //       alignment: Alignment.center,
                            //       child:Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
                            //     ),
                            //   ],
                            // ),

                            Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 10),


                                child: isItemBlocked?Text("Item unblock from list",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),):
                                Column(
                                  children: [
                                    Text("Your Item unblocking From  Block items",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Text("please wait.....",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                        Container(),
                                      ],
                                    )
                                  ],

                                )
                            ),
                            Container(
                              alignment: Alignment.center,

                              child:isItemBlocked? IntrinsicWidth(
                                child:MaterialButton(

                                  padding: EdgeInsets.only(left: 15,right: 15,top: 13,bottom: 13),
                                  child: text("Close", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                  color: sh_colorPrimary,
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();

                                    Navigator.pop(context1, true);

                                    Navigator.pop(context);

                                  },
                                  // onPressed: () => {
                                  //  // Navigator.pop(context),
                                  //   SelectProductPlaceOrder().launch(context),
                                  // },
                                  elevation: 0,
                                ),
                              ):Container(),
                            ),

                          ],
                        )),



                  );
                },
              )



          );



        }).then((Exit){
      print(">>>>>>>>>>>>>>>>>>>>>>Dialog Closed ");

      setState(() {

        isItemBlocked=false;

        print(">>>>>>>>>>>>>>>>>>>>>>>Variable Update $isItemBlocked");
      });
    });
  }


  countRemainsTime2(String startTime, String endTime) {


    var current = DateTime.now();

    var end = DateTime.fromMillisecondsSinceEpoch(int.parse(endTime));

    print("Current Time Stamp "+DateTime.now().millisecondsSinceEpoch.toString());
    print("End value"+endTime);


    var difference = DateTime.parse(endTime).difference(DateTime.now()).inSeconds;
    print("Differnce is >>>>>>>>>>>>> $difference ");








    var countdowndiff = current.difference(end).inSeconds;

    print("Difference is "+countdowndiff.toString());


    var finalTimer = current.millisecondsSinceEpoch +
        Duration(seconds: int.parse(DateTime.parse(endTime).difference(DateTime.now()).inSeconds.toString())).inMilliseconds;

    // controller = CountdownTimerController(
    //     endTime: finalTimer, onEnd: onEnd, vsync: this);

    return Duration(seconds: int.parse(DateTime.parse(endTime).difference(DateTime.now()).inSeconds.toString())).inMilliseconds;
  }
  countRemainsTime(int endTime){
    var current = DateTime.now();
    var end = DateTime.fromMillisecondsSinceEpoch(endTime);
    var countdowndiff = end.difference(current).inSeconds;
    var finalTimer = current.millisecondsSinceEpoch + Duration(seconds: countdowndiff).inMilliseconds;
    //  controller = CountdownTimerController(endTime: finalTimer, onEnd: onEnd);
    print("finaltime==$countdowndiff");
    return finalTimer;
  }

  @override
  void dispose() {
    //  controller.dispose();
    super.dispose();
  }
  void onEnd() {
    print('onEnd');
    //controller.disposeTimer();
  }



  showAlertDialogConfirmDelete(BuildContext contex,NewCartItesm newCartItesm,StateSetter updateState,int index) {
    // set up the button

    Widget cancelButton =
    Container(
      color: sh_colorPrimary,
      child: TextButton(
        child: Text("yes",
         style: TextStyle(color: Colors.white),
        ),
       // textColor: Colors.white,
        // color: sh_colorPrimary,
        onPressed: () {
          //Navigator.pop(contex, true);
          //  showAlertDialogAddToCartSearchResult(context,newCartList[index],setState,index);



        },

      ),
    );
    Widget continueButton =
    Container(
      color: sh_colorPrimary,
      child: TextButton(
        child: Text("No",
        style: TextStyle(color: Colors.white),),
        // textColor: Colors.white,
        // color: sh_colorPrimary,
        onPressed: () async {
          // Navigator.pop(context, true);



        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Are you want to Delete "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text(" Are you sure you want to delete the selected item?"),
          actions: [

            Container(

              width: 80,
              height: 40,
              decoration: BoxDecoration(

                color: sh_colorPrimary,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextButton(
                child: Text("yes",
                 style: TextStyle(color: Colors.white),
                ),
                // textColor: Colors.white,
                // color: sh_colorPrimary,
                onPressed: () {
                  //Navigator.pop(contex, true);
                  showAlertDialogAddToCartSearchResult(context,context1,newCartList[index],setState,index);



                },

              ),
            ),
            SizedBox(width: 30,),

            Container(
             margin: EdgeInsets.only(right: 30),
              width: 80,
              height: 40,
              decoration: BoxDecoration(

                color: sh_colorPrimary,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextButton(
                child: Text("No",
                  style: TextStyle(color: Colors.white),
                ),
                // textColor: Colors.white,
                // color: sh_colorPrimary,
                onPressed: () async {
                  Navigator.pop(context1, true);



                },
              ),
            ),
          ],
        );;
      },
    );
  }
  showAlertDialogConfirmUnBlock(BuildContext contex,NewBlockedItems newBlockedItems,StateSetter updateState,int index2) {
    // set up the button

    Widget cancelButton =
    Container(
      color: sh_colorPrimary,
      child: TextButton(
        child: Text("yes",
         style: TextStyle(color: Colors.white
         ),
        ),
        // textColor: Colors.white,
        // color: sh_colorPrimary,
        onPressed: () {
          //Navigator.pop(contex, true);
          //  showAlertDialogAddToCartSearchResult(context,newCartList[index],setState,index);



        },

      ),
    );
    Widget continueButton =
    Container(
      color: sh_colorPrimary,
      child: TextButton(
        child: Text("No",
         style: TextStyle(color: Colors.white
         ),
        ),
        // textColor: Colors.white,
        // color: sh_colorPrimary,
        onPressed: () async {
          // Navigator.pop(context, true);



        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Unblock"),
      content: Text("Are you sure you want to unblock the selected item?"),
      actions: [

        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text("Unblock"),
          content: Text("Are you sure you want to unblock the selected item?"),
          actions: [

            Container(
              color: sh_colorPrimary,
              child: TextButton(
                child: Text("yes",
                 style: TextStyle(color: Colors.white),
                ),
                // textColor: Colors.white,
                // color: sh_colorPrimary,
                onPressed: () {
                  //Navigator.pop(contex, true);
                  showAlertDialogUnblockToBlockSearchResult(context,context1,newBlockedList[index2],setState,index2);

                  //  showAlertDialogAddToCartSearchResult(context,context1,newCartList[index],setState,index);



                },

              ),
            ),

            Container(
              color: sh_colorPrimary,
              child: TextButton(
                child: Text("No",
                 style: TextStyle(color: Colors.white),
                ),
                // textColor: Colors.white,
                //
                // color: sh_colorPrimary,
                onPressed: () async {
                  Navigator.pop(context1, true);



                },
              ),
            ),
          ],
        );;
      },
    );
  }



// Custom Alert Dialog

}