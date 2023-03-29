import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:rosetta_fluter_app/main/utils/AppColors.dart';
import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/rosetta/models/AddToCartItems.dart';
import 'package:rosetta_fluter_app/rosetta/models/LortInventory.dart';
import 'package:rosetta_fluter_app/rosetta/models/NewCartItems.dart';
import 'package:rosetta_fluter_app/rosetta/models/SearchProductsList.dart';
import 'package:rosetta_fluter_app/rosetta/models/SpinnerDealersList.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:http/http.dart' as http;

import '../../rosetta/models/CoolingDown.dart';
import '../shimmer_list.dart';
import 'SelectProductPlaceOrder.dart';

import 'package:flutter/material.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';




class DisSelectedInventory extends StatefulWidget {


  DisSelectedInventory(
      this.selectQuantity,
      this.obj,
      this.isSengleSelected,
      this.SelectedValueForSearch,
      this.SelectedDealer2,
      this.spinnerDealerSelectes,this.selectedStcokindex,this.is_allow_cl,this.rateTypeDescriptions,this.plankSize,this.in_multipels,this.selectedStockSource,this.StockPointQuantity);


  String StockPointQuantity="";
  String selectedStockSource;

  String  selectQuantity;
  Inventory obj;
  bool isSengleSelected;
  String SelectedQuantity;
  String SelectedDealer2="Select Dealer";
  SpinnerSpinnerDealerList spinnerDealerSelectes;
  String SelectedValueForSearch;
  int selectedStcokindex;
  bool is_allow_cl;
  String rateTypeDescriptions;
  String plankSize="0",in_multipels="0";


  String   displayNameColor= "";








  @override
  _DisSelectedInventoryState createState() => _DisSelectedInventoryState();
}

class _DisSelectedInventoryState extends State<DisSelectedInventory> {


  bool isZeroFieldVisible=false;
  bool isSelfStockDisable = false;
  bool addDisable=false;
  bool blockDisable=false;




  bool isTextBoxisEmpty = false;



  List<int> isLotVisibleIndex=[];
  List<String> isHideBatch = [];

  bool  isMoreQuanityBox=false;
  bool  isMoreQuanitTile=false;

  var boxTileController = TextEditingController();





  bool isAutoChecked = true;
  var orderquantityType;

  bool isQuantityChoose=true;

  String MyToken;
  String MyUserName="";
  String MyCompanyId;
  String  MyMemberId;
  String MyMemberType;
  String  Myparent_distributor_id;
  String  Myparent_distributor_nav_id;

  String showLotQuantity="";
  double tileQuantityShow;
  double boxQuantityShow;

  bool isQuantityZero=false;










  bool checkboxvalue = false;
  Image imgUp =  Image.asset(ic_check,height: 20,width: 20,color: sh_colorPrimary,);
  Image imgDown =  Image.asset(ic_uncheck,height: 20,width: 20,color: sh_colorPrimary,);
  /*SvgPicture imgUp =  SvgPicture.asset(ic_svg_check,height: 15,width: 15,);
            SvgPicture imgDown =  SvgPicture.asset(ic_svg_uncheck,height: 15,width: 15,);*/

  var selectedindex;
  var list1 = [];

  var lsitToggleSelected=[];
  var listZeroQuantityVisible=[];

  bool isMorequantity=false;

  bool readOnlyText=true;


  String dropdownValue1 = 'Approve';
  List<String> spinnerItems1 = [
    'Approve',
    'Reject',

  ];
  double tempQuantity = 0;
  double onChangedQuantity=0;

  String newQuantitiy;





  var isSwitched = true;
  // bool toggleTextChange=true;
  var toggleText  = "RL";
  double totlaQuantitySelected = 0;
  int finaltotlaQuantitySelected = 0;
  double newValue=0;

  CartItem cartItemsSelected;
  List<CartItem> ListCartItemsSelected= [];

  String ratetypeString = "RL";
  // if(obj.price.allowCl)
  //   {
  //     ratetypeString = "CL";
  //   }
  // else
  //   {
  //     ratetypeString = "RL";
  //   }

  //Perameters to Add To Cart Api

  //int  onlineDiscountSelected=obj.price.onlineDiscount;



  TextEditingController _controller;
  TextEditingController _controllerCL;
  @override
  void initState() {

    print("Disselected Inventory Selected Value For search >>>>>>>>>>>>>>>>>>>>>>>>>>  "+widget.SelectedValueForSearch);
    //_controller = AnimationController(  vsync: this,
    //  duration: new Duration(milliseconds: 5000),)..repeat();
    isLotVisibleIndex.clear();
    list1.clear();
    super.initState();
    _controller = new TextEditingController
      (text: 'Enter Values');
    _controllerCL = new TextEditingController
      (text: '');



    widget.displayNameColor= widget.obj.colour!=null?widget.obj.colour.displayName:"";



    //print("Data From SelectedAutoSuggestStirng "+widget.SelectedAutoSuggestStirng + "Dealer Name "+widget.spinnerDealerSelectes.name+" Selected Quantity "+widget.SelectedQuantity+"Selected Value is  "+widget.SelectedValue);
    getSessionData();


    // print("Dealer  Name >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+widget.spinnerDealerSelectes.name);

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> is Allow Cl "+widget.is_allow_cl.toString());
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Rate Type Discriptions "+widget.rateTypeDescriptions);
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Plank Size "+widget.plankSize +"In Multiple Size "+widget.in_multipels);

    print("DisSelected Inventory >>>>>>>>>>>>>>>>>>>>>>>>>>  "+widget.SelectedValueForSearch);
  }


  getSessionData() async
  {
    print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String  userName = prefs.getString('UserName');
    String  mycompanyId = prefs.getString('companyId');
    String  mymemberId = prefs.getString('memberId');
    String  mymemberType = prefs.getString('memberType');
    API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');

    bool isAllowAddtoCart = prefs.getBool("AllowAddToCart");
    bool isAllowtoBlock = prefs.getBool("AllowtoBlock");
    bool AllowAdanceOrdering = prefs.getBool("AllowAdanceOrdering");



    print("Allow Add to Cart values $isAllowAddtoCart");
    print("Allow Block to Cart values $isAllowtoBlock");
    setState(() {
      if(isAllowAddtoCart)
        {
       //   isSelfStockDisable=false;
        }
      else
        {
          //isSelfStockDisable=true;
        }


      print("isAllowAddtoCart >>>>>>>>>>>>>>>>>>>>>>>>>>>> $isAllowAddtoCart");
      print("isAllowtoBlock >>>>>>>>>>>>>>>>>>>>>>>>>>>> $isAllowtoBlock");

      if(isAllowAddtoCart)
      {
        isSelfStockDisable=false;
      }
       if(!isAllowAddtoCart)
      {
        setState(() {

          addDisable=true;
          print("Add Disable >>>>>>>>>>>>>>>>>>");
        });
      }
      if(!isAllowtoBlock)
      {
              setState(() {
                blockDisable=true;
                print("Block Disable >>>>>>>>>>>>>>>>>>");

              });
      }

      if(!isAllowAddtoCart||!isAllowtoBlock||!AllowAdanceOrdering)
      {
        isSelfStockDisable=true;
      }



      // if(!isAllowAddtoCart)
      //   {
      //     isSelfStockDisable=true;
      //   }

    });

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

      getSelectedInventory(widget.obj,widget.selectedStcokindex);





    }
  }





  //To call Methode All Inventory From Api Response
  bool isValueBlockedtoCart=false;
  bool FlagBlockItems=true;
  Future<int> BlockToCartItems(List<CartItem> NewListCartItems,StateSetter updateState2) async
  {
    print("Block Api Call $FlagBlockItems");
    print("Block Api Call $MyToken");
    // isValueAddedtoCart=false;

    String AddCartUrl;

    if(MyMemberType=="Distributor")
    {
      if(widget.SelectedValueForSearch=="Self Stock")
      {

        print("Self Stock is Selected For Block Cart");
        AddCartUrl=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/block_items';

      }
      else
      {  int id = widget.spinnerDealerSelectes.id;
      String name = widget.spinnerDealerSelectes.name;
      print("Add to Block  Api    Dealer  ID $id");

      print("Dealers Selected For Block  to Cart Api");

      AddCartUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$id/block_items';
      }
    }
    else
    {
      if(MyMemberType=="DUC")
      {
        print("DUC is Selected For Block Cart");
        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/block_items
        AddCartUrl=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/block_items';
      }
      else if(MyMemberType=="DUD")
      {
        print("DUD is Selected For Block Cart");
        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1687/block_items
        AddCartUrl=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/block_items';
      }

    }






    print("Block To Cart Items Methode Call ..");


    try{

      print("Block CartItmes List >>>>>>>>>>>>>>>>>>>."+NewListCartItems.toString());
      jsonData = jsonEncode(NewListCartItems);
      newJsonData = {
        "block_items":NewListCartItems
      };
      print("Block Josn From CartItems  List >>>>>>>>>>>>>>>>>>>. $newJsonData");

    }
    catch(Exception)
    {
      print("Block #############Exception $Exception");
    }



    var headers = {
      'Authorization': 'bearer $MyToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(AddCartUrl));
    // request.body = jsonData;
    //request.body = jsonData;
    request.body = jsonEncode(newJsonData);
    //'''{\n    "cart_items": [\n        {\n            "product_id": 596,\n            "batch_no": "32-15 I/PT056",\n            "order_quantity": "10",\n            "stock_point_code": "WAREHOUSE",\n            "stock_point_source": "StockPoint",\n            "rate_type": "CL",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0\n        },\n        {\n            "product_id": 596,\n            "batch_no": "33-15 I/PT056",\n            "order_quantity": "10",\n            "stock_point_code": "WAREHOUSE",\n            "stock_point_source": "StockPoint",\n            "rate_type": "CL",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0\n        }\n    ]\n}''';
    request.headers.addAll(headers);



   // http.StreamedResponse response = await request.send();//31 August




    var response = await http.post(Uri.parse(AddCartUrl),
        body: jsonEncode(newJsonData),
        headers: {
          'Authorization': 'bearer $MyToken',
          'Content-Type': 'application/json'
        }
    );

    int responseCode = response.statusCode;
    print("Block Responce code of Block  To Cart Api $responseCode");
    print("Block Responce Body of Block To Cart Api "+response.body.toString());

    if (response.statusCode == 412)
    {
     // print(await response.stream.bytesToString());
     // String  ErrorMessage = CooolingDown.fromJson(json.decode(await response.stream.bytesToString().toString())).error;
     // String  Until = CooolingDown.fromJson(json.decode(await response.stream.bytesToString().toString())).until;
      String  ErrorMessage = CooolingDown.fromJson(json.decode(response.body.toString())).error;
      String  Until = CooolingDown.fromJson(json.decode(response.body.toString())).until;

      print("Error Messages >>>>>>>>>>>>>>>>>>> $ErrorMessage");
      print("Until Messages >>>>>>>>>>>>>>>>>>> $Until");
      int  timeStamp=int.parse(Until);
      var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      var format = new DateFormat('E, d MMM yyyy HH:mm:ss a');

      print("convertdate======"+format.format(date2));
      Navigator.pop(context);
      ///showToastDialog(context, ErrorMessage+" "+format.format(date2));
      showToastDialogBlock(context, ErrorMessage+" "+format.format(date2));



    }


    //Response.fromStream(response)

    if (response.statusCode == 200) {
      print("Block  To Cart Successfulyy 200");
      updateState2(() {
        isValueBlockedtoCart=true;
        print("is Selected Added Cart $isValueAddedtoCart");
        return;
      });



    }
    else {
      print(response.reasonPhrase);
      var err = response.reasonPhrase;
      print("Block Some thing went wrong $err");
    }

    return response.statusCode;
  }






  var jsonData;
  var newJsonData;
  bool isValueAddedtoCart=false;


  bool FlagCartItems=false;
  Future<int>  AddToCartItems( List<CartItem> NewListCartItems,StateSetter updateState) async
  {

    print("Add To Cart Items Methode Call ..");
    String AddCartUrl;
    List<CartItem> NewListCartItems2=[];

    if(MyMemberType=="Distributor")
    {
      if(widget.SelectedValueForSearch=="Self Stock")
      {

        print("Self Stock is Selected For Add To Cart");
        AddCartUrl=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/cart_items';

      }
      else
      {  int id = widget.spinnerDealerSelectes.id;
      String name = widget.spinnerDealerSelectes.name;
      print("Add to Cart Api    Dealer  ID $id");

      print("Dealers Selected For Add to Cart Api");
      AddCartUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$id/cart_items';
      }
    }
    else
    {
      if(MyMemberType=="DUC")
      {
        print("DUC  is Selected For Add To Cart");
        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1970/cart_items
        AddCartUrl=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/cart_items';
      }
      else if(MyMemberType=="DUD")
      {
        print("DUC is Selected For Add To Cart");
        //http://rosdev.rosettaproducts.com/api/companies/3/dealers/1997/cart_items
        AddCartUrl=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/dealers/$MyMemberId/cart_items';
      }
    }





    try{






      print("CartItmes List >>>>>>>>>>>>>>>>>>>."+NewListCartItems.toString());
      print("CartItmes List2 >>>>>>>>>>>>>>>>>>>."+NewListCartItems2.toString());
      jsonData = jsonEncode(NewListCartItems);
      newJsonData = {
        "cart_items":NewListCartItems
      };
      print("Josn From CartItems  List >>>>>>>>>>>>>>>>>>>. $jsonData");

    }
    catch(Exception)
    {
      print("#############Exception $Exception");
    }



    var headers = {
      'Authorization': 'bearer $MyToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(AddCartUrl));
    // request.body = jsonData;
    //request.body = jsonData;
    request.body = jsonEncode(newJsonData);
    //'''{\n    "cart_items": [\n        {\n            "product_id": 596,\n            "batch_no": "32-15 I/PT056",\n            "order_quantity": "10",\n            "stock_point_code": "WAREHOUSE",\n            "stock_point_source": "StockPoint",\n            "rate_type": "CL",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0\n        },\n        {\n            "product_id": 596,\n            "batch_no": "33-15 I/PT056",\n            "order_quantity": "10",\n            "stock_point_code": "WAREHOUSE",\n            "stock_point_source": "StockPoint",\n            "rate_type": "CL",\n            "unit_price": 94.6,\n            "discount": 0,\n            "onlineDiscount": 0\n        }\n    ]\n}''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    int responseCode = response.statusCode;
    print("Responce code of Add To Cart Api $responseCode");

    if (response.statusCode == 200) {
      print("Add To Cart Successfulyy 200");
      updateState(() {
        isValueAddedtoCart=true;
        FlagCartItems=false;
      });


      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
      var err = response.reasonPhrase;
      print("Some thing went wrong $err");
    }

    return response.statusCode;
  }



  List<LotInventory> lotInventory=[];
  bool isInventoryNotAvailable = false;

  String SelectedBatchNo = "";


  ///
  String SelectedDeopName="";
  bool  FlagOnSelectedInventory=true;
  getSelectedInventory(Inventory obj,int selectId)
  async {
    isInventoryNotAvailable=false;

    int Product_Id = obj.id;//596

    String stockSource=widget.selectedStockSource;



    int stock_point_id=selectId;


    print("Getget Selected Inventory   Methode Call >>>>>>>>>>>>>>>>>> $stock_point_id  Product Id $Product_Id  MemeberId  $MyMemberId StockSource $stockSource MemeberType $MyMemberType  valueForSerch "+widget.SelectedValueForSearch);
    String StockApiURL="";

    if(MyMemberType=="Distributor")
    {
     // if(widget.SelectedDealer2=="Self Stock")
      if(widget.SelectedValueForSearch=="Self Stock")
      {

        print("Self Stock is Selected For Inventory");
        StockApiURL=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory/$Product_Id?cust_type=DISTRIBUTO&distributor=$MyMemberId&stock_point_id=$stock_point_id&stock_point_source=$stockSource';

      }
      else
      {
        int id = widget.spinnerDealerSelectes.id;
        String name = widget.spinnerDealerSelectes.name;
        print("Specif Inventory    Dealer  ID $id");

        print("Dealers Selected ForSpecific Inventory  Api");
        //http://rosdev.rosettaproducts.com/api/companies/3/distributors/4/inventory/663?cust_type=DEALER&dealer=1687&stock_point_id=1&stock_point_source=StockPoint
        StockApiURL=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$MyMemberId/inventory/$Product_Id?cust_type=DEALER&dealer=$id&stock_point_id=$stock_point_id&stock_point_source=$stockSource';
        // StockApiURL='http://rosdev.rosettaproducts.com/api/companies/$MyCompanyId/inventory/$Product_Id?cust_type=DISTRIBUTO&dealer=$id&stock_point_id=$stock_point_id&stock_point_source=StockPoint';
      }

    }
    else
    {
      if(MyMemberType=="DUC")
      {
        print("DUC is Selected For Inventory");
        //http://rosdev.rosettaproducts.com/api/companies/3/inventory/1349?cust_type=DEALER&dealer=1970&stock_point_id=1&stock_point_source=StockPoint
        StockApiURL=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory/$Product_Id?cust_type=DEALER&dealer=$MyMemberId&stock_point_id=$stock_point_id&stock_point_source=$stockSource';
      }
      else if(MyMemberType=="DUD")
      {
        print("DUD Stock is Selected For Inventory");
        //http://rosdev.rosettaproducts.com/api/companies/3/distributors/4/inventory/1349?cust_type=DEALER&dealer=1687
        StockApiURL=API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/distributors/$Myparent_distributor_id/inventory/$Product_Id?cust_type=DEALER&dealer=$MyMemberId&stock_point_id=$stock_point_id&stock_point_source=$stockSource';
      }

    }





    http.Response response = await http.get(Uri.parse(StockApiURL),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );
    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form get Selected Inventory    Data Api : $responcebody");
    print("Response code Form get Selected Inventory   Data Api : $responseCode");





    if (response.statusCode==200) {



      setState(() {


        //Find Nearest  Value


        int j=0;

        // List<LotInventory> Temp_lotInventory=lotInventoryFromJson(response.body);
        // print("Real Inventory Lenght is "+Temp_lotInventory.length.toString());
        // for(int i=0;i<Temp_lotInventory.length;i++)
        //   {
        //     if(Temp_lotInventory[i].remainingQuantity<=50)
        //       {
        //         lotInventory.add(Temp_lotInventory[i]);
        //         j++;
        //       }
        //
        //     print("Lot quantity is "+Temp_lotInventory[i].remainingQuantity.toString());
        //
        //   }

        // if(lotInventory.length!=Temp_lotInventory.length)
        //   {
        //     for(int k=0;k<=Temp_lotInventory.length;k++)
        //       {
        //         if(!Temp_lotInventory.contains(lotInventory[k]))
        //           {
        //             lotInventory[j]=Temp_lotInventory[k];
        //             j++;
        //
        //           }
        //       }
        //   }



        // print(">>>>>Inventory Lenght is "+lotInventory.length.toString());












        lotInventory= lotInventoryFromJson(response.body);


        if(lotInventory.length!=0) {


          arrangeListNearestValue(lotInventory);
          // list1 = new List(lotInventory.length);
          //
          // print("Length of lotInventory list is "+lotInventory.length.toString());
          // print("Length of checkbox  list is "+list1.length.toString());
          // print("Length of checkbox  ListCartItemsSelected is "+ListCartItemsSelected.length.toString());
          // SelectedDeopName = lotInventory[0].locationName;
          //
          // print("Selected  DepoName     $SelectedDeopName ");



          ////////////////for nearest value



          ////////////

        }
        else
        {
          setState(() {
            isInventoryNotAvailable=true;

          });
        }




      });





    }


  }
  bool isReverseList=false;
  arrangeListNearestValue(List<LotInventory> lotInventory2)
  {


    setState(() {

      //lotInventory.clear();
    });

    List<LotInventory> lotInventoryTemp=[];
    List<LotInventory> lotInventoeyRemaining=[];
    int quantity = int.parse(widget.selectQuantity);
    print("Selected Quantity for Filteres is $quantity");


    print("Arrange List Nearest Value Call ");
    int count=0;

    for(int i=0;i<lotInventory2.length;i++)
    {


      if(lotInventory2[i].remainingQuantity>=quantity)
      {
        lotInventoryTemp.add(lotInventory2[i]);
        print("Quantity Nearest Value "+lotInventory2[i].remainingQuantity.truncateToDouble().toStringAsFixed(0));
        count++;
      }
      else
      {
        lotInventoeyRemaining.add(lotInventory2[i]);
        print("Remaining Nearest Value "+lotInventory2[i].remainingQuantity.truncateToDouble().toStringAsFixed(0));

      }
    }

    int lenghtOfOldList = lotInventory2.length;
    int lengthofFilterdList = lotInventoryTemp.length;
    int lengthofRemainingList = lotInventoeyRemaining.length;


    print("Length  Old List is $lenghtOfOldList");
    print("Length  Filtered  List is $lengthofFilterdList");
    print("Length  Remaining  List is $lengthofRemainingList");
    print("Remainin items is $count");

    if(lengthofFilterdList==0)
      {
        print("*********Decreasing Order *********************");
        setState(() {

          isReverseList=true;
        });

      }
    else
      {
        print("*********Increasing Order *********************");
        setState(() {

          isReverseList=false;
        });

      }


    // Increasing Order Code For Filterd List
    for (int i = 0; i < lotInventoryTemp.length; i++)
    {
      for (int j = i + 1; j < lotInventoryTemp.length; j++)
      {
        var tmp = null;
        if (lotInventoryTemp[i].remainingQuantity >
            lotInventoryTemp[j].remainingQuantity) {
          tmp = lotInventoryTemp[i];
          lotInventoryTemp[i] = lotInventoryTemp[j];
          lotInventoryTemp[j] = tmp;
          // setState(() {
          //   widget.listsearchProducts.add(tmp);
          // });

        }
      }
    }




    for(int j=0;j<lotInventoeyRemaining.length;j++)
    {
      lotInventoryTemp.add(lotInventoeyRemaining[j]);

    }

    print("Final Length  Filtered  List is "+lotInventoeyRemaining.length.toString());

    setState(() {


      // if(isReverseList)
      //   {
      //     lotInventory=lotInventoryTemp.reversed;
      //     list1 = new List(lotInventoryTemp.reversed.length);
      //   }
      // else
      //   {
      //     lotInventory=lotInventoryTemp;
      //     list1 = new List(lotInventory.length);
      //   }


      lotInventory=lotInventoryTemp;
      list1 = new List(lotInventory.length);

      print("Length of lotInventory list is "+lotInventory.length.toString());

      print("Length of checkbox  list is "+list1.length.toString());
      print("Length of checkbox  ListCartItemsSelected is "+ListCartItemsSelected.length.toString());
      SelectedDeopName = lotInventory[0].locationName;
      //StockPointQuantity=lotInventory[0].remainingQuantity.truncate().toStringAsFixed(0);




      print("Selected  DepoName     $SelectedDeopName "+lotInventory[0].remainingQuantity.toString());

    });


  }




bool isDecimalValueonTextBox=false;
  bool isNumericUsingRegularExpression(String string) {
    final numericRegex =
    RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }


  @override
  Widget build(BuildContext context) {




    int  productIdSelected=widget.obj.id;
    String  batchNoSelected;
    String  orderQuantitySelected;
    String stockPointCodeSelected;
    String stockPointSourceSelected;
    String rateTypeSelected=ratetypeString;
    double unitPriceSelected=widget.obj.price.unit;
    var cl_percentage=widget.obj.price.clPercent.toString()==null?0:widget.obj.price.clPercent==null?0:widget.obj.price.clPercent;
    double tempUnitPrice=widget.obj.price.unit;
    double  discountSelected=double.parse(widget.obj.price.discount.toString());
    //obj.price.discount;
    int  onlineDiscountSelected=0;

    double cutLenggthPrice=0;

    print("CL percentage >>>>>>>>>>>>>>>>>>>>>>>    $unitPriceSelected $cl_percentage");


   // // double cl_price=0;
   //  if(cl_percentage.toString()!=null)
   //    {
   //      print("CL percentage >>>>>>>>>>>>>>>>>>>>>>>    $unitPriceSelected "+cl_percentage.toString());
   //      // cl_price =   unitPriceSelected+((unitPriceSelected*cl_percentage)/100);
   //    }





    print("CL percentage >>>>>>>>>>>>>>>>>>>>>>>    $unitPriceSelected "+cl_percentage.toString());



    return
      MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
                child:
                Scaffold(


                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child:MyAppBar(false,"",MyUserName,false,true),

                  ),

                  body: SafeArea(
                    child:SingleChildScrollView(
                      child:
                          Stack(
                            children: [




                              Container(
                        height: MediaQuery.of(context).size.height-((MediaQuery.of(context).size.height*0.1)+16),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [



                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: backgroundSearchProductForm,
                                  padding: EdgeInsets.all(15),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [




                                      Row(
                                        children: [
                                          Text("Required Quantity : ",style:  TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          Text( widget.selectQuantity +"  "+widget.obj.baseUnitOfMeasure,style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,))
                                        ],
                                      ),
                                      SizedBox(height: 10,),

                                      Container(

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(widget.obj.collection.displayName==null?"":widget.obj.collection.displayName, style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                                // idget.listsearchProducts[index].colour!=null?widget.listsearchProducts[index].colour.displayName:""
                                                Text("("+widget.displayNameColor+")",style: TextStyle(fontSize: 15,color: Colors.black,),),
                                              ],
                                            ),

                                            Container(
                                                child: Text("Available",style: TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),)
                                            ),
                                          ],

                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Container(
                                        child:Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(left: 0,right: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Column(
                                                    children: [
                                                      Container(
                                                        child: Text("Price",style:  TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                                      ) ,
                                                      SizedBox(height: 5,),
                                                      Container(
                                                        child: Text(unitPriceSelected.toString()+"".toCurrencyFormat(),style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                                      ) ,
                                                    ],
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                  ),


                                                  Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        child: Text("Block",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Container(
                                                        child: Text(widget.obj.blocked.truncateToDouble().toStringAsFixed(0)+""+widget.obj.baseUnitOfMeasure,style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                                      ),
                                                    ],
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                  ),
                                                  Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        child: Text("Stock",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Container(
                                                        //widget.obj.inventory.truncateToDouble().toStringAsFixed(0)
                                                        child: Text(widget.StockPointQuantity+""+widget.obj.baseUnitOfMeasure,style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                                      ),
                                                    ],
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                  ),




                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                ),

                                widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece"? Container(
                                  color: sh_colorPrimary,
                                  padding: EdgeInsets.all(10),

                                  child: Column(
                                    children: [
                                      Text("THIS PRODUCT CAN BE ORDERD IN "+widget.rateTypeDescriptions+"."+widget.rateTypeDescriptions+" SIZE IS "+widget.plankSize+" SFT. "+"1 BOX CONTAINS "+(double.parse(widget.in_multipels)/double.parse(widget.plankSize)).toStringAsFixed(0)+" "+widget.rateTypeDescriptions+" OR "+widget.in_multipels+"SFT",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
                                      // Text("1 BOX CONTAINS "+(double.parse(widget.in_multipels)/double.parse(widget.plankSize)).truncateToDouble().toStringAsFixed(0)+widget.rateTypeDescriptions+" OR "+widget.in_multipels+"SFT",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),

                                    ],
                                  ),
                                ):Container(),
                                widget.rateTypeDescriptions=="BOX/Piece" ? Container(
                                  color: sh_colorPrimary,
                                  padding: EdgeInsets.all(10),

                                  child: Column(
                                    children: [
                                      Text("THIS PRODUCT CAN BE ORDERED IN BOXES. ",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
                                      Text("1 BOX CONTAINS "+widget.in_multipels+" "+widget.obj.baseUnitOfMeasure,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),

                                    ],
                                  ),
                                ) : Container(),
                                lotInventory.length==0?Container():  Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 15,top: 15,right: 15),
                                  child: Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        // widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece"
                                        Text("Select Lot ($SelectedDeopName)",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                                        Text(""+widget.rateTypeDescriptions=="BOX/Piece"?"BOX":widget.rateTypeDescriptions=="Tile/Piece"?"Tile":widget.rateTypeDescriptions=="Plank/Piece"?"Plank":widget.rateTypeDescriptions=="Piece"?"Piece":"SFT",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),

                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),

                            Container(
                              height: MediaQuery.of(context).size.height*0.6,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(

                              height: (((MediaQuery.of(context).size.height))*.5)-10,
                              //color: Colors.red,





                              child:  isInventoryNotAvailable?Container(
                                height: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Text("Sorry, Data Not found."),
                                    Container(),

                                  ],
                                ),
                              ):lotInventory.length==0?Container(

                                child: ShimmerInventoryList(),
                              ):

                              Scrollbar(
                                child:  ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: isReverseList?lotInventory.length:lotInventory.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {

                                      listZeroQuantityVisible.add(-1);

                                      String batchNo="";
                                      double lotQuantity=0;
                                      bool toggleTextChange=true;

                                      batchNo = lotInventory[index].lotNo;
                                      SelectedBatchNo=lotInventory[index].lotNo;

                                      lotQuantity = lotInventory[index].remainingQuantity;
                                      var  ShowlotQuantity = lotInventory[index].remainingQuantity.toStringAsFixed(2);
                                     //GM9 var  ShowlotQuantity = lotInventory[index].remainingQuantity.truncateToDouble().toStringAsFixed(0);
                                      showLotQuantity=lotInventory[index].remainingQuantity.truncateToDouble().toStringAsFixed(2);
                                      _controllerCL.text="";
                                      // =
                                      // new TextEditingController
                                      //   (text: "CL");
                                      // _controller = new TextEditingController
                                      //   (text: showLotQuantity);




                                      // to Stroe on Changed in a Input Filed treat as total quantiy


                                      double tileQuantity= index==0?double.parse(widget.selectQuantity):lotInventory[index].remainingQuantity;
                                      tileQuantityShow= (lotInventory[index].remainingQuantity/double.parse(widget.plankSize))*double.parse(widget.plankSize);





                                      double quanittyOnBoxPices2 = index==0? double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels):
                                      double.parse(lotInventory[index].remainingQuantity.truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels);
                                      // print("In Multiples On Box "+double.parse(widget.in_multipels).toString());
                                      // print("In quanittyOnBoxPices On Box "+quanittyOnBoxPices.truncateToDouble().toStringAsFixed(0));
                                      // orderquantityType=(double.parse(widget.in_multipels)*double.parse(quanittyOnBoxPices.truncateToDouble().toStringAsFixed(0))).toString();
                                      boxQuantityShow=  double.parse(lotInventory[index].remainingQuantity.toString());
                                      //boxQuantityShow= (double.parse(widget.in_multipels)*double.parse(quanittyOnBoxPices2.truncateToDouble().toStringAsFixed(0)));





                                      //Auto Select Batch

                                      if(widget.rateTypeDescriptions=="BOX/Piece")
                                      {
                                        if((double.parse(lotInventory[index].remainingQuantity.toString())/double.parse(widget.in_multipels)).truncateToDouble().toStringAsFixed(0)=="0")
                                        {
                                          print("Zero BOX Found ");

                                          isLotVisibleIndex.add(index);


                                        }
                                      }
                                      if(widget.rateTypeDescriptions=="Tile/Piece")
                                      {
                                        if((double.parse(lotInventory[index].remainingQuantity.toString())/double.parse(widget.plankSize)).truncateToDouble().toStringAsFixed(0)=="0")
                                        {
                                          print("Zero Tile Found ");

                                          isLotVisibleIndex.add(index);

                                        }
                                      }

                                      if(widget.rateTypeDescriptions=="Plank/Piece")
                                      {
                                        if((double.parse(lotInventory[index].remainingQuantity.toString())/double.parse(widget.plankSize)).truncateToDouble().toStringAsFixed(0)=="0")
                                        {
                                          print("Zero Plank Found ");

                                          isLotVisibleIndex.add(index);

                                        }
                                      }

                                      if(isAutoChecked)
                                      {
                                        if(lotInventory[0]==lotInventory[index]&&!isLotVisibleIndex.contains(index))
                                        {

                                          print("Auto Select Methode Call  >>>>>>>>>");

                                          print("Add index From Check $index");


                                          isAutoChecked=false;




                                          // list1.add(index);
                                          list1[index]=index;

                                          //finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.toStringAsFixed(0))+int.parse(lotQuantity.toStringAsFixed(0));
                                          print("Add  Total Lot Quantitiy  $lotQuantity");


                                          print("Temporary Add  Total Lot Quantitiy  $tempQuantity");


                                          //Logic To Add Cart Items in List

                                          batchNoSelected=lotInventory[index].lotNo;
                                          orderQuantitySelected="$finaltotlaQuantitySelected";
                                          stockPointCodeSelected=lotInventory[index].locationCode;
                                          stockPointSourceSelected=lotInventory[index].locationSource;




                                          // initialValue:widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece"?(lotInventory[index].remainingQuantity/double.parse(widget.plankSize)).toStringAsFixed(0):(lotInventory[index].remainingQuantity/double.parse(widget.in_multipels)).toStringAsFixed(0)),




                                          if(widget.rateTypeDescriptions=="RL/CL")
                                          {


                                            if(double.parse(widget.selectQuantity)<double.parse(orderquantityType=lotInventory[index].remainingQuantity.toString()))
                                            {

                                              print("Auto Selected Statment 1");
                                              isQuantityChoose=false;

                                              toggleTextChange=true;
                                              lsitToggleSelected.add(index);
                                              orderquantityType=widget.selectQuantity;
                                              isQuantityChoose=true;

                                              isQuantityZero=false;
                                              rateTypeSelected="CL";
                                              print("Auto Selected Rate Type is CL  >>>>>>>>>>>>>>>>>>>>>>>>> is $rateTypeSelected");
                                              double cutLenggthPrice2  =unitPriceSelected+((unitPriceSelected*cl_percentage)/100);

                                              //(unitPriceSelected+((unitPriceSelected*cl_percentage)/100)).toString()
                                                  //unitPriceSelected+ ((unitPriceSelected*12)/100);


                                                print("cutLenggthPrice2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+cutLenggthPrice2.toString());
                                                unitPriceSelected=cutLenggthPrice2;

                                              // print("cutLenggthPrice2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+cutLenggthPrice2.toString());
                                              // unitPriceSelected=cutLenggthPrice2;

                                            }
                                            else
                                            {

                                              print("Auto Selected Statment 2");
                                              orderquantityType=lotInventory[index].remainingQuantity.toString();

                                              rateTypeSelected="RL";
                                              print("Auto Selected Rate Type is RL  >>>>>>>>>>>>>>>>>>>>>>>>> is $rateTypeSelected");
                                            }
                                            print("Auto Select  is Selected isQuantityChoose "+widget.selectQuantity.toString());
                                            print("Auto Select  is Selected RateType  "+rateTypeSelected);




                                            print("RL/CL Added >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $orderquantityType");
                                          }
                                          else  if(widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece")
                                          {

                                            print("Auto Selected Statment 3");




                                      orderquantityType=
                                      (int.parse(
                                        ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).ceil().toString()=="0"?"0":
                                            ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).round()>int.parse((int.parse(tileQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).toStringAsFixed(0))?//"A":"B":
                                            int.parse((int.parse(tileQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).ceil().toString()).toString():
                                            ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).ceil().toString())*double.parse(widget.plankSize)).toString();



                                            // double quanittyOnPlankTile  =
                                            // ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).round()> double.parse((double.parse(tileQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).truncateToDouble().toStringAsFixed(0))?
                                            //  double.parse((double.parse(tileQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).truncateToDouble().toStringAsFixed(0)):
                                            // ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize));
                                            //
                                            //
                                            //
                                            // orderquantityType=quanittyOnPlankTile.round().toString()=="0"?"0":
                                            // (double.parse(widget.plankSize)*double.parse(quanittyOnPlankTile.truncateToDouble().toStringAsFixed(0))).toString()=="0"?
                                            // (1*double.parse(widget.plankSize)).round()>lotInventory[index].remainingQuantity?
                                            // lotInventory[index].remainingQuantity.toString():(1*double.parse(widget.plankSize)).ceil().toString():
                                            // (double.parse(widget.plankSize)*double.parse(quanittyOnPlankTile.ceil().toString())).toString();


                                            print("In Plank On Box "+double.parse(widget.plankSize).toString());
                                           // print("In quanitty Plank On Box "+quanittyOnPlankTile.ceil().toString());

                                            //  orderquantityType=widget.selectQuantity;
                                            print(widget.rateTypeDescriptions+"Auto Added Added >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $orderquantityType   ");

                                          }
                                          else if(widget.rateTypeDescriptions=="BOX/Piece")
                                          {


                                                          print("Auto Selected Statment 4");
                                                          listZeroQuantityVisible.add(index);
                                                          print("In Multiples On Box "+double.parse(widget.in_multipels).toString());

                                                          // orderquantityType=widget.selectQuantity;
                                                          orderquantityType= (int.parse(
                                                          (double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).ceil().toString()=="0"?"0":
                                                          (double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).round()>int.parse((int.parse(boxQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).toStringAsFixed(0))?
                                                          int.parse((int.parse(boxQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).ceil().toString()).toString():
                                                          ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).ceil().toString())*double.parse(widget.in_multipels)).toString();


                                                          if(orderquantityType=="0")
                                                            {}
                                                          print(widget.rateTypeDescriptions+"Auto  Added >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $orderquantityType");




                                          }
                                          else
                                          {
                                            print("Auto Selected Statment 5");
                                            orderquantityType=widget.selectQuantity;
                                          }



                                          cartItemsSelected  = CartItem(
                                              productId:productIdSelected,
                                              batchNo:batchNoSelected,
                                              orderQuantity:orderquantityType,

                                              // orderQuantity:orderQuantitySelected,
                                              stockPointCode:stockPointCodeSelected,
                                              stockPointSource:stockPointSourceSelected,
                                              rateType:widget.rateTypeDescriptions=="RL/CL"?rateTypeSelected:widget.rateTypeDescriptions,
                                              unitPrice:unitPriceSelected,
                                              discount:discountSelected,
                                              onlineDiscount:onlineDiscountSelected);


                                          if(ListCartItemsSelected.contains(cartItemsSelected))
                                          {
                                            print("multiple Entry Error >>>>>>>>>>>>>>>>>>>>>>>> On Check Box ");
                                          }
                                          else
                                          {
                                            ListCartItemsSelected.add(cartItemsSelected);
                                            print("Success Fully Add items On Check Box ");


                                          }


                                          // ListCartItemsSelected[index]=cartItemsSelected;


                                        }

                                      }










                                        if(isLotVisibleIndex.contains(index))
                                          {
                                            String batchNo = lotInventory[index].lotNo;
                                            print("Hide Auto Selected Batch No >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $batchNo");
                                            isHideBatch.add(batchNo);




                                          }




                                      return isLotVisibleIndex.contains(index)?Container():
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 14,right: 14),
                                        margin: EdgeInsets.only(top: 10,bottom: 10),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            InkWell(
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(


                                                    child:list1[index]==index ? imgUp:imgDown,


                                                  ),
                                                  //Batch No //Quantityt
                                                  Container(

                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [

                                                              Container(

                                                                child: Row(
                                                                  children: [
                                                                    Text("Batch No : ",style: TextStyle(fontSize: 14),),
                                                                    Text("$batchNo",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece"?Container(
                                                          child:  Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [

                                                                Container(

                                                                  child: Row(
                                                                    children: [
                                                                      Text("Quantity : ",style: TextStyle(fontSize: 14),),
                                                                      Text(tileQuantityShow.toStringAsFixed(2),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                                      //GM9 Text(tileQuantityShow.truncateToDouble().toStringAsFixed(0),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                                      Text(" "+widget.obj.baseUnitOfMeasure,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                                                                      SizedBox(width: 5,),
                                                                      Text(""+widget.rateTypeDescriptions=="BOX/Piece"?"BOX":widget.rateTypeDescriptions=="Tile/Piece"?"Tile":widget.rateTypeDescriptions=="Plank/Piece"?"Plank":widget.rateTypeDescriptions=="Piece"?"Piece":"SFT",style: TextStyle(fontSize: 15,color: Colors.black,),),
                                                                      Text(" : "+double.parse((double.parse(tileQuantityShow.toString())/double.parse(widget.plankSize)).toString()).toStringAsFixed(0),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                                      //GM9 Text(" : "+int.parse((int.parse(tileQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).ceil().toString()).toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),


                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                        ):Container(),
                                                        widget.rateTypeDescriptions=="BOX/Piece"?Container(
                                                          child:  Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [

                                                                Container(

                                                                  child: Row(
                                                                    children: [
                                                                      Text("Quantity : ",style: TextStyle(fontSize: 14),),
                                                                      Text(boxQuantityShow.toStringAsFixed(2),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                                      Text(" "+widget.obj.baseUnitOfMeasure,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),

                                                                      SizedBox(width: 5,),
                                                                      Text(""+widget.rateTypeDescriptions=="BOX/Piece"?"BOX":widget.rateTypeDescriptions=="Tile/Piece"?"Tile":widget.rateTypeDescriptions=="Plank/Piece"?"Plank":widget.rateTypeDescriptions=="Piece"?"Piece":"SFT",style: TextStyle(fontSize: 15,color: Colors.black,),),
                                                                      Text(" : "+(double.parse(lotInventory[index].remainingQuantity.toString())/double.parse(widget.in_multipels)).toStringAsFixed(0),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),//truncateToDouble().toStringAsFixed(0)


                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                        ):Container(),
                                                        SizedBox(height: 5,),


                                                        widget.rateTypeDescriptions=="Piece"?  Row(
                                                          children: [

                                                            Text("Batch Qty : ",style: TextStyle(fontSize: 14),),
                                                            Text("$ShowlotQuantity" ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                          ],
                                                        ):Container(),
                                                        Visibility(
                                                          child: Container(

                                                            child:

                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Container(


                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                  child:Text(lsitToggleSelected.contains(index)?"CL":"RL",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                                                                              ),

                                                                              Container(
                                                                                  height: 20,
                                                                                  width: 50,
                                                                                  child:    Switch(

                                                                                    onChanged:list1.contains(index)?
                                                                                        (value){
                                                                                      setState(() {
                                                                                        isSwitched=value;
                                                                                        if(value)
                                                                                        {

                                                                                          print("CL is Selected ");

                                                                                          isQuantityChoose=false;

                                                                                          toggleTextChange=true;
                                                                                          lsitToggleSelected.add(index);
                                                                                          //orderquantityType="0";
                                                                                          isQuantityChoose=true;

                                                                                          isQuantityZero=true;
                                                                                          print("CL is Selected isQuantityChoose $isQuantityZero");



                                                                                        }
                                                                                        else{


                                                                                          print("RL  is Selected ");



                                                                                          //toggleText="CL";
                                                                                          unitPriceSelected;

                                                                                          setState(() {

                                                                                            isQuantityZero=false;

                                                                                            orderquantityType=lotInventory[index].remainingQuantity.toString();



                                                                                            showLotQuantity=lotInventory[index].remainingQuantity.truncateToDouble().toStringAsFixed(0);
                                                                                            _controller = new TextEditingController
                                                                                              (text: '$widget.showLotQuantity');

                                                                                          });
                                                                                          //  print("RL price is >>>>>>>>>>>>>>>>. $showLotQuantity ");






                                                                                          // unitPriceSelected=unitPriceSelected+ ((unitPriceSelected*12)/100);

                                                                                          // print("Cutlength Price is  $unitPriceSelected ");

                                                                                          toggleTextChange=false;
                                                                                          lsitToggleSelected.remove(index);
                                                                                          //list1.removeAt(list1[index]);

                                                                                          list1[index]=-1;

                                                                                          ListCartItemsSelected.removeWhere((item) => item.batchNo == lotInventory[index].lotNo);

                                                                                          // ListCartItemsSelected[index]=null;
                                                                                          //ListCartItemsSelected.remove(ListCartItemsSelected[index]);


                                                                                        }

                                                                                      });
                                                                                    }:null,
                                                                                    value: lsitToggleSelected.contains(index),
                                                                                    activeColor: sh_track_green,
                                                                                    activeTrackColor: sh_more_infoHeading_background,
                                                                                    inactiveThumbColor: sh_track_yellow,
                                                                                    inactiveTrackColor: sh_more_infoHeading_background,
                                                                                  )
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),



                                                                      Text("Batch Qty : ",style: TextStyle(fontSize: 14),),
                                                                      Text("$ShowlotQuantity SFT",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),



                                                                    ],
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                          visible: widget.is_allow_cl,
                                                        ),

                                                        SizedBox(height: 5,),
                                                        Visibility(
                                                          child: Row(
                                                            children: [
                                                              Text("CL Price : ",style: TextStyle(fontSize: 14),),
                                                              // unitPriceSelected+ ((unitPriceSelected*12)/100);
                                                              Text((widget.obj.price.unit+((widget.obj.price.unit*(widget.obj.price.clPercent.toString()==null?0:widget.obj.price.clPercent==null?0:widget.obj.price.clPercent))/100)).toStringAsFixed(2),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                             // Text((unitPriceSelected+((unitPriceSelected*cl_percentage)/100)).toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                            ],
                                                          ),
                                                          visible: lsitToggleSelected.contains(index),
                                                        ),



                                                      ],
                                                    ),
                                                    margin: EdgeInsets.only(left: 10),
                                                  ),
                                                ],
                                              ),
                                              onTap: ()
                                              {
                                                setState((){
                                                  selectedindex=index;
                                                  // if(list1.contains(index))
                                                  if(list1[index]==index)
                                                  {


                                                      isZeroFieldVisible=true;
                                                    //  listZeroQuantityVisible.removeAt(index);
                                                      listZeroQuantityVisible.add(-1);
                                                      print("listZeroQuantityVisible>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+listZeroQuantityVisible.contains(index).toString());



                                                    print("Items un check >> ");

                                                    print("Remove index From Check $index");


                                                    // Toggel Change
                                                    toggleTextChange=false;
                                                    lsitToggleSelected.remove(index);


                                                    //list1.removeAt(list1[index]);

                                                    list1[index]=-1;

                                                    ListCartItemsSelected.removeWhere((item) => item == lotInventory[index]);

                                                    // ListCartItemsSelected[index]=null;


                                                    //  ListCartItemsSelected.remove(ListCartItemsSelected[index]);


                                                    ListCartItemsSelected.removeWhere((element) => element.batchNo == lotInventory[index].lotNo);






                                                    //  ListCartItemsSelected.removeAt(index);



                                                    //finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.toStringAsFixed(0))-int.parse(lotQuantity.toStringAsFixed(0)));
                                                    print("Delete  Total Lot Quantitiy  $lotQuantity");

                                                    print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");


                                                    finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.truncateToDouble().toStringAsFixed(0))-int.parse(lotQuantity.truncateToDouble().toStringAsFixed(0));
                                                    print("Delete  Total Lot Quantitiy  $lotQuantity");

                                                    print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");
                                                    tempQuantity=0;


                                                    //Logic To Remove  Cart Items in List

                                                  }
                                                  else
                                                  {
                                                    print("Items check >> ");


                                                      isZeroFieldVisible=true;

                                                      listZeroQuantityVisible.add(index);
                                                      print("listZeroQuantityVisible>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+listZeroQuantityVisible.contains(index).toString());


                                                    print("Add index From Check $index");


                                                    // list1.add(index);
                                                    list1[index]=index;

                                                    //finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.toStringAsFixed(0))+int.parse(lotQuantity.toStringAsFixed(0));
                                                    print("Add  Total Lot Quantitiy  $lotQuantity");


                                                    print("Temporary Add  Total Lot Quantitiy  $tempQuantity");


                                                    //Logic To Add Cart Items in List

                                                    batchNoSelected=lotInventory[index].lotNo;
                                                    orderQuantitySelected="$finaltotlaQuantitySelected";
                                                    stockPointCodeSelected=lotInventory[index].locationCode;
                                                    stockPointSourceSelected=lotInventory[index].locationSource;




                                                    // initialValue:widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece"?(lotInventory[index].remainingQuantity/double.parse(widget.plankSize)).toStringAsFixed(0):(lotInventory[index].remainingQuantity/double.parse(widget.in_multipels)).toStringAsFixed(0)),




                                                    if(widget.rateTypeDescriptions=="RL/CL")
                                                    {


                                                      orderquantityType=lotInventory[index].remainingQuantity.toString();
                                                      print("RL/CL Added >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $orderquantityType");
                                                    }
                                                    else  if(widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece")
                                                    {
                                                      double quanittyOnPlankTile  = double.parse(lotInventory[index].remainingQuantity.toString())/double.parse(widget.plankSize);

                                                      orderquantityType=(double.parse(widget.plankSize)*double.parse(quanittyOnPlankTile.toString())).toString();
                                                      print("In Plank On Box "+double.parse(widget.plankSize).toString());
                                                      print("In quanitty Plank On Box "+quanittyOnPlankTile.truncateToDouble().toStringAsFixed(0));
                                                      print(widget.rateTypeDescriptions+"Added >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   $quanittyOnPlankTile  $orderquantityType");

                                                    }
                                                    else if(widget.rateTypeDescriptions=="BOX/Piece")
                                                    {
                                                      double quanittyOnBoxPices = double.parse(lotInventory[index].remainingQuantity.toString())/double.parse(widget.in_multipels);
                                                      print("In Multiples On Box "+double.parse(widget.in_multipels).toString());
                                                      print("In quanittyOnBoxPices On Box "+quanittyOnBoxPices.truncateToDouble().toStringAsFixed(0));
                                                      orderquantityType=(double.parse(widget.in_multipels)*double.parse(quanittyOnBoxPices.truncateToDouble().toStringAsFixed(2))).toString();

                                                      print(widget.rateTypeDescriptions+" Added >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $orderquantityType");

                                                    }



                                                    cartItemsSelected  = CartItem(
                                                        productId:productIdSelected,
                                                        batchNo:batchNoSelected,
                                                        orderQuantity:orderquantityType,

                                                        // orderQuantity:orderQuantitySelected,
                                                        stockPointCode:stockPointCodeSelected,
                                                        stockPointSource:stockPointSourceSelected,
                                                        rateType:widget.rateTypeDescriptions=="RL/CL"?rateTypeSelected:widget.rateTypeDescriptions,
                                                        unitPrice:unitPriceSelected,
                                                        discount:discountSelected,
                                                        onlineDiscount:onlineDiscountSelected);


                                                    if(ListCartItemsSelected.contains(cartItemsSelected))
                                                    {
                                                      print("multiple Entry Error >>>>>>>>>>>>>>>>>>>>>>>> On Check Box ");
                                                    }
                                                    else
                                                    {
                                                      ListCartItemsSelected.add(cartItemsSelected);
                                                      print("Success Fully Add items On Check Box ");


                                                    }


                                                    // ListCartItemsSelected[index]=cartItemsSelected;


                                                  }
                                                });

                                              },
                                            ),



                                            widget.rateTypeDescriptions=="Piece"?
                                            Container(
                                              width :60,
                                              height: 30,
                                              child:  TextFormField(


                                                //  controller: lsitToggleSelected.contains(index)?_controllerCL:TextEditingController(text: showLotQuantity),
                                                key: Key(showLotQuantity),
                                                // initialValue: widget.initialValue),
                                                // initialValue:showLotQuantity,
                                                initialValue:index==0?""+widget.selectQuantity:lotInventory[index].remainingQuantity.truncateToDouble().toStringAsFixed(0),
                                                //  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                autofocus: false,

                                                readOnly: list1[index]!=index,
                                                //!lsitToggleSelected.contains(index),
                                                textCapitalization: TextCapitalization.words,
                                                style: TextStyle(
                                                    color: sh_colorPrimary,
                                                    fontFamily: fontRegular,
                                                    fontSize: textSizeSmall),

                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: backgroundSearchProductFormInput,
                                                    focusColor: sh_editText_background_active,

                                                    hintStyle: TextStyle(
                                                        color: sh_textColorSecondary,
                                                        fontFamily: fontRegular,
                                                        fontSize: textSizeSmall),
                                                    contentPadding:
                                                    EdgeInsets.only(left: 12,right: 10),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(round_border_form),
                                                        borderSide: BorderSide(
                                                            color: sh_black, width: 0.5)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(round_border_form),
                                                        borderSide: BorderSide(
                                                            color: sh_black,

                                                            width: 0.5))),
                                                onChanged: (total)
                                                {




                                                  print(">>>>>>>>>>>>>>>.."+total);

                                                  setState(() {

                                                    if(total!="")
                                                    {
                                                      print("Cl Text Some Text Here ");
                                                      isQuantityChoose=true;
                                                      isQuantityZero=false;

                                                    }
                                                    else
                                                    {
                                                      print("Cl Text  Remove All Text ");
                                                      isQuantityZero=true;

                                                    }


                                                    print("CL Controller change Value is "+_controllerCL.text);
                                                    _controllerCL.addListener(() {
                                                      _controllerCL.text=total;
                                                      print("CL Value From Controller is "+total);
                                                    });

                                                  });


                                                  if(double.parse(total)<=double.parse(lotQuantity.toStringAsFixed(0)))
                                                  {
                                                    setState(() {


                                                      isMorequantity=false;

                                                    });
                                                    print(">>>>>>>>>>>>>>>Quantity in range $isMorequantity ");

                                                  }
                                                  else
                                                  {
                                                    setState(() {

                                                      isMorequantity=true;



                                                      showToastDialog(context, "Entered Qty is more than available in the Lot");
                                                      print("Remove index From Check $index");

                                                      toggleTextChange=false;
                                                      lsitToggleSelected.remove(index);
                                                      //list1.removeAt(list1[index]);





                                                      list1[index]=-1;
                                                      ListCartItemsSelected.removeWhere((item) => item == lotInventory[index]);
                                                      ListCartItemsSelected.remove(ListCartItemsSelected[index]);
                                                      print("Delete  Total Lot Quantitiy  $lotQuantity");
                                                      print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");
                                                      finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.truncateToDouble().toStringAsFixed(0))-int.parse(lotQuantity.truncateToDouble().toStringAsFixed(0));
                                                      print("Delete  Total Lot Quantitiy  $lotQuantity");
                                                      print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");
                                                      tempQuantity=0;




                                                      //
                                                      // toggleTextChange=true;
                                                      // lsitToggleSelected.add(index);





                                                    });
                                                    print(">>>>>>>>>>>>>>>Quantity More than given quantity $isMorequantity ");
                                                  }


                                                  print("Unit price of toggle "+unitPriceSelected.toString());



                                                  cutLenggthPrice = unitPriceSelected+((unitPriceSelected*cl_percentage)/100);
                                                      //unitPriceSelected+ ((unitPriceSelected*12)/100);

                                                  print("Cut Length Price is "+cutLenggthPrice.toString());




                                                  print("Batch No of CutLength Product is "+batchNo);
                                                  print("CutLength Price Of Total Qantity  "+  (cutLenggthPrice*double.parse(total)).toString());



                                                  final selectedIndexCl = ListCartItemsSelected.indexWhere((element) =>
                                                  element.batchNo == batchNo);

                                                  print("Selected Batch No index is "+selectedIndexCl.toString());




                                                  CartItem cartItemsSelected=ListCartItemsSelected[selectedIndexCl];




                                                  int Cl_ProductId  =  cartItemsSelected.productId;
                                                  String Cl_BatchNo=  cartItemsSelected.batchNo;
                                                  String Cl_OrderQuantity = total;
                                                  String Cl_StockPointCode  =cartItemsSelected.stockPointCode;
                                                  String Cl_StockPointSourceCode  = cartItemsSelected.stockPointSource;
                                                  String Cl_RateType = cartItemsSelected.rateType;
                                                  double Cl_unitPrice =  cartItemsSelected.unitPrice;
                                                  // String Cl_RateType = "CL";
                                                  // double Cl_unitPrice =  cutLenggthPrice;
                                                  double Cl_discount  = cartItemsSelected.discount;
                                                  String  Cl_onlineDiscount  =  cartItemsSelected.onlineDiscount.toString();



                                                  //   CartItem updatecartItemsSelected=cartItemsSelected;
                                                  CartItem updatecartItemsSelected=CartItem(
                                                      productId:Cl_ProductId,
                                                      batchNo:Cl_BatchNo,
                                                      orderQuantity:Cl_OrderQuantity,
                                                      stockPointCode:Cl_StockPointCode,
                                                      stockPointSource:Cl_StockPointSourceCode,
                                                      rateType:Cl_RateType,
                                                      unitPrice:Cl_unitPrice,
                                                      discount:Cl_discount,
                                                      onlineDiscount:int.parse(Cl_onlineDiscount));

                                                  print("Pieces_OrderQuantity>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$Cl_OrderQuantity");

                                                  if(ListCartItemsSelected.contains(ListCartItemsSelected[selectedIndexCl]))
                                                  {
                                                    if(Cl_OrderQuantity=="0")
                                                    {
                                                      print("Zero Quantity is not process >>>>>>>>>>>>>>>>>>> ");
                                                      isQuantityZero=true;
                                                    }
                                                    else
                                                    {
                                                      isQuantityZero=false;
                                                      ListCartItemsSelected[selectedIndexCl]=updatecartItemsSelected;
                                                    }

                                                  }

                                                  print("Length of Selected CartItemsSelected On Cl "+ListCartItemsSelected.length.toString());







                                                },
                                              ),

                                            )
                                                :lsitToggleSelected.contains(index)?  Container(
                                              width :60,
                                              height: 30,
                                              child:  TextFormField(


                                                //  controller: lsitToggleSelected.contains(index)?_controllerCL:TextEditingController(text: showLotQuantity),
                                                key: Key(showLotQuantity),
                                                // initialValue: widget.initialValue),
                                                // initialValue:showLotQuantity,
                                                //initialValue:index==0?""+widget.selectQuantity:showLotQuantity,
                                                initialValue:index==0?isQuantityZero?"0":widget.selectQuantity:"0",
                                                //  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                autofocus: false,

                                                readOnly: !lsitToggleSelected.contains(index),
                                                textCapitalization: TextCapitalization.words,
                                                style: TextStyle(
                                                    color: sh_colorPrimary,
                                                    fontFamily: fontRegular,
                                                    fontSize: textSizeSmall),

                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: backgroundSearchProductFormInput,
                                                    focusColor: sh_editText_background_active,

                                                    hintStyle: TextStyle(
                                                        color: sh_textColorSecondary,
                                                        fontFamily: fontRegular,
                                                        fontSize: textSizeSmall),
                                                    contentPadding:
                                                    EdgeInsets.only(left: 12,right: 10),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(round_border_form),
                                                        borderSide: BorderSide(
                                                            color: sh_black, width: 0.5)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(round_border_form),
                                                        borderSide: BorderSide(
                                                            color: sh_black,

                                                            width: 0.5))),
                                                onChanged: (total)
                                                {




                                                  print(">>>>>>>>>>>>>>>.."+total);

                                                  setState(() {

                                                    if(total!="")
                                                    {
                                                      print("Cl Text Some Text Here ");
                                                      isQuantityChoose=true;
                                                      isQuantityZero=false;

                                                    }
                                                    else
                                                    {
                                                      print("Cl Text  Remove All Text ");
                                                      isQuantityZero=true;

                                                    }


                                                    print("CL Controller change Value is "+_controllerCL.text);
                                                    _controllerCL.addListener(() {
                                                      _controllerCL.text=total;
                                                      print("CL Value From Controller is "+total);
                                                    });

                                                  });


                                                  if(double.parse(total)<=int.parse(lotQuantity.truncateToDouble().toStringAsFixed(0)))
                                                  {
                                                    setState(() {


                                                      isMorequantity=false;

                                                    });
                                                    print(">>>>>>>>>>>>>>>Quantity in range $isMorequantity ");

                                                  }
                                                  else
                                                  {
                                                    setState(() {

                                                      isMorequantity=true;



                                                      showToastDialog(context, "Please Enter valid Quantity 1");
                                                      print("Remove index From Check $index");

                                                      toggleTextChange=false;
                                                      lsitToggleSelected.remove(index);
                                                      //list1.removeAt(list1[index]);





                                                      list1[index]=-1;
                                                      ListCartItemsSelected.removeWhere((item) => item == lotInventory[index]);
                                                      ListCartItemsSelected.remove(ListCartItemsSelected[index]);
                                                      print("Delete  Total Lot Quantitiy  $lotQuantity");
                                                      print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");
                                                      finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.truncateToDouble().toStringAsFixed(0))-int.parse(lotQuantity.truncateToDouble().toStringAsFixed(0));
                                                      print("Delete  Total Lot Quantitiy  $lotQuantity");
                                                      print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");
                                                      tempQuantity=0;




                                                      //
                                                      // toggleTextChange=true;
                                                      // lsitToggleSelected.add(index);





                                                    });
                                                    print(">>>>>>>>>>>>>>>Quantity More than given quantity $isMorequantity ");
                                                  }


                                                  print("Unit price of toggle "+unitPriceSelected.toString());



                                                  cutLenggthPrice = unitPriceSelected+((unitPriceSelected*cl_percentage)/100);
                                                      //unitPriceSelected+ ((unitPriceSelected*12)/100);

                                                  print("Cut Length Price is "+cutLenggthPrice.toString());




                                                  print("Batch No of CutLength Product is "+batchNo);
                                                  print("CutLength Price Of Total Qantity  "+  (cutLenggthPrice*double.parse(total)).toString());



                                                  final selectedIndexCl = ListCartItemsSelected.indexWhere((element) =>
                                                  element.batchNo == batchNo);

                                                  print("Selected Batch No index is "+selectedIndexCl.toString());




                                                  CartItem cartItemsSelected=ListCartItemsSelected[selectedIndexCl];




                                                  int Cl_ProductId  =  cartItemsSelected.productId;
                                                  String Cl_BatchNo=  cartItemsSelected.batchNo;
                                                  String Cl_OrderQuantity = total;
                                                  String Cl_StockPointCode  =cartItemsSelected.stockPointCode;
                                                  String Cl_StockPointSourceCode  = cartItemsSelected.stockPointSource;
                                                  String Cl_RateType = "CL";
                                                  double Cl_unitPrice =  cutLenggthPrice;
                                                  double Cl_discount  = cartItemsSelected.discount;
                                                  String  Cl_onlineDiscount  =  cartItemsSelected.onlineDiscount.toString();



                                                  //   CartItem updatecartItemsSelected=cartItemsSelected;
                                                  CartItem updatecartItemsSelected=CartItem(
                                                      productId:Cl_ProductId,
                                                      batchNo:Cl_BatchNo,
                                                      orderQuantity:Cl_OrderQuantity,
                                                      stockPointCode:Cl_StockPointCode,
                                                      stockPointSource:Cl_StockPointSourceCode,
                                                      rateType:Cl_RateType,
                                                      unitPrice:Cl_unitPrice,
                                                      discount:Cl_discount,
                                                      onlineDiscount:int.parse(Cl_onlineDiscount));

                                                  print("Cl_OrderQuantity>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$Cl_OrderQuantity");

                                                  if(ListCartItemsSelected.contains(ListCartItemsSelected[selectedIndexCl]))
                                                  {
                                                    if(Cl_OrderQuantity=="0")
                                                    {
                                                      print("Zero Quantity is not process >>>>>>>>>>>>>>>>>>> ");
                                                      isQuantityZero=true;
                                                    }
                                                    else
                                                    {
                                                      isQuantityZero=false;
                                                      ListCartItemsSelected[selectedIndexCl]=updatecartItemsSelected;
                                                    }

                                                  }

                                                  print("Length of Selected CartItemsSelected On Cl "+ListCartItemsSelected.length.toString());







                                                },
                                              ),

                                            ):
                                            widget.rateTypeDescriptions=="RL/CL"?   Container(
                                              width :60,
                                              height: 30,

                                              child:  TextFormField(

                                                //  controller: lsitToggleSelected.contains(index)?_controllerCL:TextEditingController(text: showLotQuantity),
                                                // key: Key(showLotQuantity),
                                                // initialValue: widget.initialValue),
                                                initialValue:lotInventory[index].remainingQuantity.toStringAsFixed(2),
                                                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                autofocus: false,

                                                readOnly: !lsitToggleSelected.contains(index),
                                                textCapitalization: TextCapitalization.words,
                                                style: TextStyle(
                                                    color: sh_textColorPrimary,
                                                    fontFamily: fontRegular,
                                                    fontSize: textSizeSmall),

                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: backgroundSearchProductFormInput,
                                                    focusColor: sh_editText_background_active,
                                                    hintText: "0",
                                                    hintStyle: TextStyle(
                                                        color: sh_textColorSecondary,
                                                        fontFamily: fontRegular,
                                                        fontSize: textSizeSmall),
                                                    contentPadding:
                                                    EdgeInsets.only(left: 12,right: 10),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(round_border_form),
                                                        borderSide: BorderSide(
                                                            color: sh_black, width: 0.5)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(round_border_form),
                                                        borderSide: BorderSide(
                                                            color: sh_black,

                                                            width: 0.5))),
                                                onChanged: (total)
                                                {},
                                              ),

                                            ):





                                          //Tile Pices Boxes
                                            Container(
                                              width :60,
                                              height: 30,
                                              //TILE  PICES BOX
                                              child:  TextFormField(



                                                initialValue:
                                                (widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece"?
                                                index==0?
                                                //""+widget.selectQuantity:

                                                ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).ceil().toString()=="0"?"0":
                                                ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).round()>int.parse((int.parse(tileQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).toStringAsFixed(0))?//"A":"B":
                                                                int.parse((int.parse(tileQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).ceil().toString()).toString():
                                                               ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).ceil().toString():
                                                ( double.parse(lotInventory[index].remainingQuantity.toString())/double.parse(widget.plankSize)).toStringAsFixed(0):
                                                //GM9 ( double.parse(lotInventory[index].remainingQuantity.truncateToDouble().toStringAsFixed(0))/double.parse(widget.plankSize)).ceil().toString():


                                                index==0?
                                                //""+widget.selectQuantity:

                                                (double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).ceil().toString()=="0"?"0":
                                                (double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).round()>int.parse((int.parse(boxQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).toStringAsFixed(0))?
                                                                              int.parse((int.parse(boxQuantityShow.truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).ceil().toString()).toString():
                                                                             ( double.parse(double.parse(widget.selectQuantity).truncateToDouble().toStringAsFixed(0))/double.parse(widget.in_multipels)).ceil().toString():
                                                (double.parse(lotInventory[index].remainingQuantity.toString())/double.parse(widget.in_multipels)).toStringAsFixed(0)),

                                                 keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),

                                                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                autofocus: false,
                                                // controller: boxTileController,

                                                readOnly:list1[index]==index?false:true,

                                                textCapitalization: TextCapitalization.words,
                                                style: TextStyle(
                                                    color: sh_textColorPrimary,
                                                    fontFamily: fontRegular,
                                                    fontSize: textSizeSmall),

                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: backgroundSearchProductFormInput,
                                                    focusColor: sh_editText_background_active,
                                                    // hintText: "0",
                                                    hintStyle: TextStyle(
                                                        color: sh_textColorSecondary,
                                                        fontFamily: fontRegular,
                                                        fontSize: textSizeSmall),
                                                    contentPadding:
                                                    EdgeInsets.only(left: 12,right: 10),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(round_border_form),
                                                        borderSide: BorderSide(
                                                            color: sh_black, width: 0.5)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(round_border_form),
                                                        borderSide: BorderSide(
                                                            color: sh_black,

                                                            width: 0.5))),
                                                onChanged: (total)
                                      {
                                      print(">>>>>>>>>>>>>>>.."+total);
                                     // if(isNumericUsingRegularExpression(total))

                                      if(int.tryParse(total)!=null)
                                      {
                                        setState(() {
                                          isDecimalValueonTextBox=false;
                                        });
                                      print("isNumericUsingRegularExpression>>>>>>>>>>>>>>>.."+isNumericUsingRegularExpression(total).toString());


                                      // selector.runtimeType == int
                                      //  if(int.parse(total).runtimeType!=int)
                                      //    {
                                      //      showToastDialog(context, "Please Enter Interger Value");
                                      //    }


                                      if(total=="")
                                      {
                                      isTextBoxisEmpty=true;
                                      }
                                      else
                                      {
                                      isTextBoxisEmpty=false;
                                      }


                                      setState(() {

                                      tileQuantityShow= (double.parse(total))*double.parse(widget.plankSize);
                                      print("tileQuantityShow>>>>>>>>>>>>>>>>>>>>>>>>$tileQuantityShow");
                                      });

                                      setState(() {


                                      print("CL Controller change Value is "+_controllerCL.text);
                                      _controllerCL.addListener(() {
                                      _controllerCL.text=total;
                                      print("CL Value From Controller is "+total);
                                      });

                                      });


                                      if(widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece")
                                      {
                                      print("Please Enter valid Quantity Tile $total");


                                      double tileQuantityShow2= double.parse(lotInventory[index].remainingQuantity.toString());
                                      double actualQuanitiy2= tileQuantityShow2/double.parse(widget.plankSize);


                                      print("Please Enter valid Quantity Box $total   Quanityt : $tileQuantityShow2   "+actualQuanitiy2.toString());

                                      //print("1st Condition "+int.parse(total).toString());
                                      // print("2nd Condition "+int.parse(actualQuanitiy2.toStringAsFixed(0)).toString());
                                      //print("2nd Condition "+int.parse(actualQuanitiy2.truncateToDouble().toStringAsFixed(0)).toString());

                                      if(int.parse(total)>int.parse(actualQuanitiy2.truncateToDouble().toStringAsFixed(0)))
                                      {

                                      setState(() {
                                      isMoreQuanitTile=true;

                                      });


                                      print("Condition 1");


                                      }
                                      else
                                      {

                                      setState(() {

                                      isMoreQuanitTile=false;
                                      });


                                      print("Condition 2");
                                      }


                                      }
                                      else
                                      {


                                      double boxQuantityShow2= double.parse(lotInventory[index].remainingQuantity.truncateToDouble().toStringAsFixed(0));
                                      double actualQuanitiy= boxQuantityShow2/double.parse(widget.in_multipels);

                                      print("Please Enter valid Quantity Box $total   Quanityt : $boxQuantityShow2   "+actualQuanitiy.round().toString());

                                      if(int.parse(total)>int.parse(actualQuanitiy.round().toString()))
                                      {
                                      setState(() {
                                      isMoreQuanityBox=true;
                                      });


                                      }
                                      else
                                      {
                                      isMoreQuanityBox=false;
                                      }


                                      }


                                      // if(int.parse(total)<=int.parse(lotQuantity.truncateToDouble().toStringAsFixed(0)))
                                      if(!isMoreQuanityBox&&!isMoreQuanitTile)
                                      {


                                      setState(() {


                                      isMorequantity=false;

                                      });
                                      print(">>>>>>>>>>>>>>>Quantity in range $isMorequantity ");

                                      }
                                      else
                                      {
                                      setState(() {

                                      isMorequantity=true;

                                      if(isMoreQuanityBox)
                                      {
                                      showToastDialog(context, "Please Enter valid BOX Quantity ");

                                      setState(() {

                                      boxTileController.text="0";
                                      });
                                      }
                                      if(isMoreQuanitTile)
                                      {
                                      showToastDialog(context, "Please Enter valid Tile Quantity ");

                                      setState(() {

                                      boxTileController.text="0";
                                      });
                                      }


                                      print("Remove index From Check $index");


                                      list1[index]=-1;
                                      ListCartItemsSelected.removeWhere((item) => item == lotInventory[index]);
                                      ListCartItemsSelected.remove(ListCartItemsSelected[index]);
                                      print("Delete  Total Lot Quantitiy  $lotQuantity");
                                      print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");
                                      finaltotlaQuantitySelected=int.parse(finaltotlaQuantitySelected.truncateToDouble().toStringAsFixed(0))-int.parse(lotQuantity.truncateToDouble().toStringAsFixed(0));
                                      print("Delete  Total Lot Quantitiy  $lotQuantity");
                                      print("Temporary Delete  Total Lot Quantitiy  $tempQuantity");
                                      tempQuantity=0;


                                      // toggleTextChange=true;
                                      // lsitToggleSelected.add(index);


                                      });
                                      print(">>>>>>>>>>>>>>>Quantity More than given quantity $isMorequantity ");
                                      }


                                      print("Unit price of toggle "+unitPriceSelected.toString());


                                      cutLenggthPrice = unitPriceSelected+((unitPriceSelected*cl_percentage)/100);
                                      //unitPriceSelected+ ((unitPriceSelected*12)/100);

                                      print("Cut Length Price is "+cutLenggthPrice.toString());


                                      print("Batch No of CutLength Product is "+batchNo);
                                      print("CutLength Price Of Total Qantity  "+ (cutLenggthPrice*double.parse(total)).toString());


                                      final selectedIndexCl = ListCartItemsSelected.indexWhere((element) =>
                                      element.batchNo == batchNo);

                                      print("Selected Batch No index is "+selectedIndexCl.toString());


                                      CartItem cartItemsSelected=ListCartItemsSelected[selectedIndexCl];


                                      int Cl_ProductId = cartItemsSelected.productId;
                                      String Cl_BatchNo= cartItemsSelected.batchNo;
                                      String Cl_OrderQuantity = total;
                                      String Cl_StockPointCode =cartItemsSelected.stockPointCode;
                                      String Cl_StockPointSourceCode = cartItemsSelected.stockPointSource;
                                      String Cl_RateType =widget.rateTypeDescriptions;
                                      double Cl_unitPrice = cutLenggthPrice;
                                      double Cl_discount = cartItemsSelected.discount;
                                      String Cl_onlineDiscount = cartItemsSelected.onlineDiscount.toString();


                                      String orderquantityType2="";
                                      print("On Changed Text >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+widget.rateTypeDescriptions);
                                      if(widget.rateTypeDescriptions=="Tile/Piece"||widget.rateTypeDescriptions=="Plank/Piece")
                                      {

                                      orderquantityType2=(double.parse(widget.plankSize)*double.parse(total)).toString();

                                      }
                                      else if(widget.rateTypeDescriptions=="BOX/Piece")
                                      {
                                      orderquantityType2=(double.parse(widget.in_multipels)*double.parse(total)).toString();

                                      }


                                      //   CartItem updatecartItemsSelected=cartItemsSelected;
                                      CartItem updatecartItemsSelected=CartItem(
                                      productId:Cl_ProductId,
                                      batchNo:Cl_BatchNo,
                                      orderQuantity:orderquantityType2,
                                      stockPointCode:Cl_StockPointCode,
                                      stockPointSource:Cl_StockPointSourceCode,
                                      rateType:Cl_RateType,
                                      unitPrice:Cl_unitPrice,
                                      discount:Cl_discount,
                                      onlineDiscount:int.parse(Cl_onlineDiscount));

                                      print(widget.rateTypeDescriptions+" Quantity>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $Cl_OrderQuantity $orderquantityType2");

                                      if(ListCartItemsSelected.contains(ListCartItemsSelected[selectedIndexCl]))
                                      {
                                      if(Cl_OrderQuantity=="0")
                                      {
                                      print("Zero Quantity is not process >>>>>>>>>>>>>>>>>>> ");
                                      isQuantityZero=true;
                                      }
                                      else
                                      {
                                      isQuantityZero=false;
                                      ListCartItemsSelected[selectedIndexCl]=updatecartItemsSelected;
                                      }

                                      }

                                      print("Length of Selected CartItemsSelected On Cl "+ListCartItemsSelected.length.toString());
                                      }
                                      else
                                        {
                                          setState(() {
                                            isDecimalValueonTextBox=true;
                                          });
                                          showToastDialog(context, "Please use integer value");

                                        }

                                                },
                                              ),

                                            ),





                                          ],
                                        ),
                                      );
                                      // return Chats(mListings[index], index);
                                    }),
                              ),


                            ),

                                ],
                              )
                            ),

                          ],
                        ),
                      ),







                              //isSelfStockDisable&&widget.SelectedValueForSearch=="Self Stock"?Container():
                              lotInventory.length==0||(addDisable&&blockDisable&&widget.SelectedValueForSearch=="Self Stock")?Container():   Container(
                                height: MediaQuery.of(context).size.height-((MediaQuery.of(context).size.height*0.1)+16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(),
                                    Container(
                                margin: EdgeInsets.only(top: 5,bottom: 0),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                height: MediaQuery.of(context).size.height*0.1,//70

                                color: sh_colorPrimary,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children:[
                                      //addDisable//blockDisable


                                      addDisable&&widget.SelectedValueForSearch=="Self Stock"?Container(width: (MediaQuery.of(context).size.width/2)*0.5,):Container(
                                        width:(MediaQuery.of(context).size.width/2)-10,
                                        margin:blockDisable? EdgeInsets.only(left: (MediaQuery.of(context).size.width/2)*0.5): EdgeInsets.only(left: 0),
                                        child: MaterialButton(

                                          // padding:  EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                                          padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),

                                          child: Text("ADD",  style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          textColor: sh_colorPrimary,
                                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                          color: sh_white,
                                          onPressed: () => {



                                            if(false)
                                              {
                                                showToastDialog(context, "You don't have permission to add to cart")
                                              }
                                            else
                                              {

                                                if(ListCartItemsSelected.isNotEmpty)
                                                  {


                                                    print("isQuantityZero >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$isQuantityZero"),

                                                    if(isTextBoxisEmpty)
                                                      {
                                                        showToastDialog(context, "Zero Quantity does not Added to Cart "),
                                                      }
                                                    else if((isQuantityZero||orderquantityType=="0"))
                                                      {



                                                        showToastDialog(context, "Zero Quantity is not Added to Cart "),
                                                        print("Zero Quantity is not Added to Cart >>>>>>>   $isQuantityZero  $orderquantityType ")


                                                      }
                                                    else if(isMoreQuanityBox)
                                                        {
                                                          showToastDialog(context, "Box quantity does not Match"),
                                                        }
                                                      else if(isMoreQuanitTile)
                                                          {
                                                            showToastDialog(context, "Tile quantity does not Match"),
                                                          }
                                                        else if(isDecimalValueonTextBox)
                                                            {
                                                              showToastDialog(context, "Quantity  should be in numberic value"),
                                                            }
                                                          else
                                                            {


                                                              FlagCartItems = true,
                                                              showAlertDialogAddToCartSearchResult(
                                                                  context, ListCartItemsSelected,
                                                                  setState, widget.obj),
                                                              // AddToCartItems(ListCartItemsSelected),
                                                            }

                                                  }
                                                else
                                                  {
                                                    //Show Dialog To
                                                    print("Please select Batch"),
                                                    showToastDialog(context, "Please select Batch"),
                                                  },


                                              },








                                          },

                                        ),
                                      ),
                                    //  SizedBox(width: 4,),


                                      blockDisable&&widget.SelectedValueForSearch=="Self Stock"?Container(
                                   width: (MediaQuery.of(context).size.width/2)*0.4,): Container(
                                        width:(MediaQuery.of(context).size.width/2)-10,
                                        margin: EdgeInsets.only(left: 0),
                                        child: MaterialButton(

                                          padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
                                          child: Text("Block",  style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          textColor: sh_colorPrimary,
                                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                          color: sh_white,
                                          onPressed: () => {
                                            if(false)
                                              {
                                                showToastDialog(context, "You don't have permission to Block")
                                              }
                                            else
                                            {
                                              if(ListCartItemsSelected.isNotEmpty)
                                                {
                                                  // showAlertDialogBlocked(context),
                                                  //  BlockToCartItems(ListCartItemsSelected,setState),
                                                  if(isQuantityZero||orderquantityType=="0")
                                                    {
                                                      showToastDialog(context, "Zero Quantity is not Blocked to Cart "),
                                                    }
                                                  else if(isMoreQuanityBox)
                                                    {
                                                      showToastDialog(context, "Box quantity does not Match"),
                                                    }
                                                  else if(isMoreQuanitTile)
                                                      {
                                                        showToastDialog(context, "Tile quantity does not Match"),
                                                      }
                                                    else
                                                      {
                                                        FlagBlockItems = true,
                                                        showAlertDialogBlockToCartSearchResult(
                                                            context, ListCartItemsSelected)
                                                      }

                                                }
                                              else
                                                {
                                                  //Show Dialog To
                                                  print("Please select Batch"),
                                                  showToastDialog(context," Please select Batch"),
                                                },
                                            }




                                          },

                                        ),
                                      ),



                                    ]
                                ),





                              ),
                                  ],
                                ),
                              )
                            ],
                          )
                    ),

                  ),
                  endDrawer: MyDrwaer(),
                ),
      );




  }



  showAlertDialogAddToCartSearchResult(BuildContext context, List<CartItem> ListCartItemsSelected,StateSetter updateState_bottom,Inventory obj) {
    // Create button


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
          child:

            Dialog(

              child: StatefulBuilder(


                builder: (BuildContext context, setState)
                {
                  //Methode Call to Add To Cart
                  if(FlagCartItems)
                  {
                    AddToCartItems(ListCartItemsSelected,setState).then((value) {

                      if(value==200)
                      {
                        updateState_bottom(() async {
                          FlagCartItems=false;


                          // Locally Manage of Dealer List on Selections
                          //widget.spinnerDealerSelectes.name
                          int  selectedDealerId = widget.spinnerDealerSelectes.id;

                          List<String> spinnerDelerListOnCart = [];
                          //  spinnerDelerListOnCart.add(""+selectedDealerId.toString());
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          List<String> spinnerDelerListOnCart2 = prefs.getStringList('spinnerDelerListOnCart');

                          if(!spinnerDelerListOnCart2.contains(selectedDealerId.toString()))
                          {
                            spinnerDelerListOnCart2.add(selectedDealerId.toString());

                          }
                          prefs.setStringList('spinnerDelerListOnCart', spinnerDelerListOnCart2);
                          print("On Add spinnerDelerListOnCart >>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+spinnerDelerListOnCart2.length.toString());






                        });


                      }
                      else
                      {
                        updateState_bottom((){
                          FlagCartItems=false;
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


                                  isValueAddedtoCart? Image.asset(ic_greencheck,height: 60,width: 60, fit: BoxFit.fill,):
                                  Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
                                  alignment: Alignment.topCenter,
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: InkWell(
                                    child: Image.asset(ic_cross_dialog,height: 25,width: 25,
                                      color: sh_colorPrimary,),
                                    onTap: (){
                                      Navigator.pop(context, false);
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
                              padding: EdgeInsets.symmetric(horizontal: 10),


                              child: isValueAddedtoCart?Text("Items added successfully",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),):

                              Column(
                                children: [
                                  Text("Please wait, while we add your",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Text(" items to the cart.....",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                      Container(),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,

                              child:isValueAddedtoCart? IntrinsicWidth(
                                child:MaterialButton(

                                  padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
                                  child: text("Go To Cart", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                  color: sh_colorPrimary,
                                  onPressed: () async {

                                    print("Send Selected Value For Cart Page "+widget.SelectedValueForSearch);
                                    //                                                    SearchProductResult(value,SelectedAutoSuggestStirng,spinnerDealerSelectes,SelectedQuantity,this.SingleSelectedCategory,SelectedDealer2,SelectedMinPrice,SelectedmaxPrice,SelectedValue,spinnerDelerList,spinnerSelectDealer2).launch(context);
                                    Navigator.pop(context, false);
                                    Navigator.pop(context);
                                    await Navigator.of(context)
                                        .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder(SelectedDealer2:widget.SelectedDealer2,spinnerDealerSelectes:widget.spinnerDealerSelectes,SelectedValueForSearch:widget.SelectedValueForSearch,isCartBlock:"Cart")));
                                    setState((){});

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



          ),
          );



        }).then((Exit){

      setState(() {


        isValueAddedtoCart=false;
        print(">>>>>>>>>>>>>>>>>>>>>>>Variable isValueAddedtoCart Update $isValueAddedtoCart");



      });

      updateState_bottom((){
        // lotInventory.clear();
        // int lotInventoryLength =     lotInventory.length;
        // print("Lot Inventory Length After close Dialog $lotInventoryLength");
        // getSelectedInventory(updateState_bottom,obj,selectedStcokindex);
        // list1.clear();


      });

    });
  }
  showAlertDialogBlockToCartSearchResult(BuildContext context, List<CartItem> ListCartItemsSelected) {
    // Create button


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
          child:


            Dialog(

              child: StatefulBuilder(


                builder: (BuildContext context, setState) {
                  //Methode Call to Add To Cart
                  if(FlagBlockItems){
                    print("Flag Block Up");
                    BlockToCartItems(ListCartItemsSelected,setState).then((value){
                      if(value==200)
                      {
                        FlagBlockItems=false;
                      }
                      else
                      {
                        FlagBlockItems=false;
                      }
                    });

                  }
                  else{
                    print("Flag Block Down");
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


                                  isValueBlockedtoCart? Image.asset(ic_greencheck,height: 60,width: 60, fit: BoxFit.fill,):
                                  Image.asset(ic_notice_addtocart,height: 100,width: 100, fit: BoxFit.fill,),
                                  alignment: Alignment.topCenter,
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: InkWell(
                                    child: Image.asset(ic_cross_dialog,height: 25,width: 25,
                                      color: sh_colorPrimary,),
                                    onTap: (){
                                      Navigator.pop(context, false);
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


                              child: isValueBlockedtoCart?
                              Column(
                                children: [
                                  Text("Item added to Blocked List  ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Text("successfully.",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                      Container(),
                                    ],
                                  ),

                                ],
                              ):
                              Column(
                                children: [
                                  Text("Your items are being added ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Text(" in BLOCKED List.....",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                      Container(),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,

                              child:isValueBlockedtoCart? IntrinsicWidth(
                                child:MaterialButton(

                                  padding: EdgeInsets.only(left: 15,right: 15,top: 13,bottom: 13),
                                  child: text("Go To Cart", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                  color: sh_colorPrimary,
                                  onPressed: () async {
                                    Navigator.pop(context, false);
                                    Navigator.pop(context);
                                    await Navigator.of(context)
                                        .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder(SelectedDealer2:widget.SelectedDealer2,spinnerDealerSelectes:widget.spinnerDealerSelectes,SelectedValueForSearch:widget.SelectedValueForSearch,isCartBlock:"Block")));
                                    setState((){});

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



          ),
          );



        }).then((Exit) {


      setState(() {
        isValueBlockedtoCart=false;
        print(">>>>>>>>>>>>>>>>>>>>>>>Variable isValueBlockedtoCart Update $isValueBlockedtoCart");
      });




    });
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
              child: Dialog(

              child: StatefulBuilder(

                builder: (BuildContext context, setState){

                  return  Container(
                    height: 121,

                    width:MediaQuery.of(context).size.width,
                    color: sh_white,
                    padding: EdgeInsets.only(top: 20,bottom: 20,left: 10),

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



          ),
            );
        });

  }
  showToastDialogBlock(BuildContext context,String Message)
  {


    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
              child: Dialog(

              child: StatefulBuilder(

                builder: (BuildContext context, setState){

                  return  Container(
                    height: 121,

                    width:MediaQuery.of(context).size.width,
                    color: sh_white,
                    padding: EdgeInsets.only(top: 20,bottom: 20,left: 10),

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


                              child: Text("Close", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
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



          ),
            );
        });

  }
}