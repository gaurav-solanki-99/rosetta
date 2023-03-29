import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:rosetta_fluter_app/main/utils/AppColors.dart';
import 'package:rosetta_fluter_app/rosetta/models/DealersPosDistributor.dart';
import 'package:rosetta_fluter_app/rosetta/models/OrderHistoryList.dart';
import 'package:rosetta_fluter_app/rosetta/models/PODetails.dart';

import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';

import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShFunction.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';

import '../../rosetta/models/AllDealerOrderHistory.dart';
import '../../rosetta/models/PoDetailsObjectDetailsDistributor.dart';
import 'DisAprroveOrder.dart';
import 'package:http/http.dart' as http;



class NewDistributorOrderDetails  extends StatefulWidget {
  static String tag = '/ShProfileFragment';

  int searchId ;
  PurchaseOrderHitory purchaseOrderHitory;
  SalesOrder dealerssalesOrders;

  String SelectedValueForSearch;
  bool isAllDealerofDitributor=false;
  SalesOrderAllDealer   salesOrderAllDealer;


  NewDistributorOrderDetails({this.searchId,this.purchaseOrderHitory,this.dealerssalesOrders,this.SelectedValueForSearch,this.isAllDealerofDitributor,this.salesOrderAllDealer});

  @override
  ShWishlistFragmentState createState() => ShWishlistFragmentState();
}

class ShWishlistFragmentState extends State<NewDistributorOrderDetails> {
  String dropdownValue = 'Add Customer and Shiping Details';

  List<String> spinnerItems = [
    'Add Customer and Shiping Details',
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ];
  List<ShProduct> list = [];

  var value = false;




  // Get Session & Api Portion
  var checkNetconnection=null;
  String MyToken;


  //Po Details
  PoDetailsObject poDetailsObject=null;
  PoDetailsObject2 poDetailsObject2=null;
  List<PurchaseLine> listPurchaseLisne=null;
  List<PurchaseLine2> listPurchaseLisne2=null;
  String MyMemberType;
  String MyUserName="";
  String  Myparent_distributor_id;
  String  Myparent_distributor_nav_id;



  // Get Session Data
  getSessionData() async
  {
    print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String  userName = prefs.getString('UserName');
    API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');

    String  mymemberType = prefs.getString('memberType');

    String  parent_distributor_id ="0";
    String  parent_distributor_nav_id = "0";
    if(mymemberType!="Distributor")
    {

      parent_distributor_id = prefs.getString('parent_distributor_id');
      parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');

    }
    print(">>>>>>>>>>>Session Token $token");
    setState(() {
      MyToken=token;
      MyUserName=userName;
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

      if (widget.SelectedValueForSearch == "Dealer")
      {
        print("Dealer is Selected From Order History Page");
        getPoDetails(widget.searchId);
      }
      else
        {
          getPoDetails(widget.searchId);

        }



      checkNetconnection = isInternatAvailable();
      print("Response od internet Menthode $checkNetconnection");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$checkNetconnection.");
      if(checkNetconnection!=null)
      {




      }
      if(checkNetconnection!=null)
      {
        print("Please check your Internet Connection ");
        // showAlertStockDialog(context);
        //interNetPopup();
      }
    }
  }


  String DealerName="",contactNo="",orderNumber="",totalQuantity="",totalValue="";
  var ShowDatetime;
  int timeStamp;
  List<Po> pos;
  String status="";
  String allPoss="";
  String twoposs="";
  String address="";
  String siNumber="";

  @override
  void initState() {
    super.initState();
    fetchData();
    getSessionData();

    var id = widget.searchId;
    print("Perameter Id $id");


    if (widget.SelectedValueForSearch == "Dealer")
    {
              print("Dealer is Selected From Order History Page");

              if(widget.isAllDealerofDitributor)
                {
                  DealerName= widget.salesOrderAllDealer.dealerName==null?"":widget.salesOrderAllDealer.dealerName;

                  //purchaseOrderHitoryList[index].dealerName.toString()==""?"":purchaseOrderHitoryList[index].dealerName.toString();
                  timeStamp=int.parse(widget.salesOrderAllDealer.createdAt);
                  var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
                  ShowDatetime=DateFormat.yMMMMd().format(date2);
                  print("sj======$ShowDatetime");
                  contactNo="";
                  orderNumber=widget.salesOrderAllDealer.number;
                  totalQuantity="";
                  totalValue=widget.salesOrderAllDealer.amount.toString();
                  // pos =widget.dealerssalesOrders.soNumbers;
                  status=widget.salesOrderAllDealer.status;

                }
               else
                 {

                   DealerName= widget.dealerssalesOrders.dealerName==null?"":widget.dealerssalesOrders.dealerName;

                   //purchaseOrderHitoryList[index].dealerName.toString()==""?"":purchaseOrderHitoryList[index].dealerName.toString();
                   timeStamp=int.parse(widget.dealerssalesOrders.createdAt);
                   var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
                   ShowDatetime=DateFormat.yMMMMd().format(date2);
                   print("sj======$ShowDatetime");
                   contactNo="";
                   orderNumber=widget.dealerssalesOrders.number;
                   totalQuantity="";
                   totalValue=widget.dealerssalesOrders.amount.toString();
                   // pos =widget.dealerssalesOrders.soNumbers;
                   status=widget.dealerssalesOrders.status;

                 }









              // for(int i=0;i<pos.length;i++)
              // {
              //   if(i<=2)
              //   {
              //     twoposs=twoposs+pos[i].soNumber+",";
              //   }
              //
              //   allPoss=allPoss+pos[i].soNumber+",";
              // }
              //

    }
    else
      {
        print("Self  is Selected From Order History Page");

        DealerName= widget.purchaseOrderHitory.dealerName==null?"":widget.purchaseOrderHitory.dealerName;

        //purchaseOrderHitoryList[index].dealerName.toString()==""?"":purchaseOrderHitoryList[index].dealerName.toString();
        timeStamp=int.parse(widget.purchaseOrderHitory.createdAt);
        var date2 = new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
        ShowDatetime=DateFormat.yMMMMd().format(date2);
        print("sj======$ShowDatetime");
        contactNo="";
        orderNumber=widget.purchaseOrderHitory.number;
        totalQuantity="";
        totalValue=widget.purchaseOrderHitory.amount.toString();
        pos =widget.purchaseOrderHitory.pos;
        status=widget.purchaseOrderHitory.status;










        for(int i=0;i<pos.length;i++)
        {
          if(i<=2)
          {
            twoposs=twoposs+pos[i].soNumber+" ";
          }

          allPoss=allPoss+pos[i].soNumber+" ";
        }

      }










  }


  Future<void> getPoDetails(int searchId) async
  {
    print("Get Po Details Methode Call $searchId");

    http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/purchase_orders/$searchId'),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );
    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form Get Po Details Methode Call Data Api : $responcebody");
    print("Response code Form Get Po Details Methode Call Methode  Data Api : $responseCode");

    if(responseCode==200)
    {
      setState(() {

        if(MyMemberType=="Distributor")
          {
            poDetailsObject2=  PoDetailsObjectDetailsDistributor.fromJson(json.decode(response.body)).po;
            listPurchaseLisne2= poDetailsObject2.purchaseLines;

            DealerName=poDetailsObject2.customer.name;
            contactNo=poDetailsObject2.customer.phone==null?"":poDetailsObject2.customer.phone;

            address=poDetailsObject2.address.address==null?"":poDetailsObject2.address.address;

             siNumber=  poDetailsObject2.navInvoiceNumber==null?"":poDetailsObject2.navInvoiceNumber;


          }
        else
          {
            poDetailsObject=  PoDetailsObjectDetails.fromJson(json.decode(response.body)).po;
            listPurchaseLisne= poDetailsObject.purchaseLines;

            DealerName=poDetailsObject.customer.name;
            contactNo=poDetailsObject.customer.phone==null?"":poDetailsObject.customer.phone;

            address=poDetailsObject.address.address==null?"":poDetailsObject.address.address;
            //poDetailsObject.customer.address==null?"":poDetailsObject.customer.address;
          }












      });

    }




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

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    return
      MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
    child:

      Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyAppBar(false,"",MyUserName,false,true),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 15,top: 15),
                  child: Text(
                    "Order Details",
                    style: TextStyle(
                        fontSize: textSizeMedium,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),


                Container(
                  margin: EdgeInsets.all(5),
                  // height: 160,
                  color:backgroundSearchProductForm,
                  child: Column(
                    children: [

                      Container(
                        padding: EdgeInsets.only(left: 10,right: 5,top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                         // userName.length==1?userName:userName.split(" ")[0]
                              child: Text(DealerName.length==1?DealerName:DealerName.split(" ")[0],style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),


                            Container(
                              padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                              child: Text(""+status,style: TextStyle(fontSize: 10),),
                              decoration: BoxDecoration(
                                  color: sh_itemText_background,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),

                                  ),
                                  border: Border.all(
                                    color: sh_colorPrimary,
                                  )
                              ),
                            )

                          ],
                        ),
                      ),


                      Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,bottom: 10,top: 2),
                                child: Text(""+contactNo,style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(ic_calender_icon,height: 15,width: 15,color: sh_colorPrimary,),
                                  SizedBox(width: 5.0),
                                  Text("$ShowDatetime",style: TextStyle(fontSize: 12),),
                                ],
                              ),

                            ],
                          )

                      ) ,
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,


                                children: [
                                  Text("Order Number",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text(""+orderNumber,style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            // Container(
                            //   child:  Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text("Total Qty",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),),
                            //       SizedBox(height: 5,),
                            //       Text(""+totalQuantity,style: TextStyle(fontWeight: FontWeight.bold),),
                            //     ],
                            //   ),

                            //  ) ,
                            Container(
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Value",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text(""+totalValue,style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ),

                            )

                          ],
                        ),
                      ),

                      widget.SelectedValueForSearch == "Dealer"?Container():Container(
                        margin: EdgeInsets.only(left: 10,top: 10),

                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,


                          children: [
                            Text("SO Number  :",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),),
                            SizedBox(width: 10.0,),
                            Text(""+twoposs),
                            // Text("+2 More",style: TextStyle(color: sh_colorPrimary),)
                          ],
                        ),
                      ),
                      widget.SelectedValueForSearch == "Dealer"?Container():Container(

                        margin: EdgeInsets.only(left: 10,top: 10),

                        child: siNumber==""?Container(): Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,


                          children: [
                            Text("SI Number  :",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),),
                            SizedBox(width: 10.0,),
                            Text(""+siNumber),
                            // Text("+2 More",style: TextStyle(color: sh_colorPrimary),)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),

                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,


                          children: [
                            Text("Address  :",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),),
                            SizedBox(width: 10.0,),
                            Container(
                              width: (width/2),

                               child: Text(address)),
                            // Text("+2 More",style: TextStyle(color: sh_colorPrimary),)
                          ],
                        ),
                      ),






                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),


                MyMemberType!="Distributor"?listPurchaseLisne==null?Container(
                  child: Text("Please Wait.."),
                ):  Container(

                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listPurchaseLisne.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      itemBuilder: (context, index) {
                        String PoCollection=  listPurchaseLisne[index].product.collection.displayName;
                        String PoCategory=  listPurchaseLisne[index].product.category.displayName;
                        String PoColor=  listPurchaseLisne[index].product.colour.displayName;
                        String PoAmount = listPurchaseLisne[index].amount.toString();
                        String PoQuanittiy=   listPurchaseLisne[index].quantity.toString();

                        String PoUnitPrice =listPurchaseLisne[index].unitPrice.toStringAsFixed(2);
                        double PoTotalAmount = listPurchaseLisne[index].amount;
                        String ImageUrl=listPurchaseLisne[index].product.imageUrl;

                        String discountper = listPurchaseLisne[index].discount==null?"0":listPurchaseLisne[index].discount.toString();
                        double doublePrice = double.parse( listPurchaseLisne[index].unitPrice.toStringAsFixed(2));
                        double discountedPrice = doublePrice-(doublePrice*double.parse(discountper)/100);


                        return Container(
                          //color:sh_itemText_background,
                          //sh_itemText_background,

                          //height: 70,//90
                          margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                          padding: EdgeInsets.only(top: 5,bottom: 5),

                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[

                              Container(
                                width:55,//width * 0.3,//40
                                height: 55,//60
                                child:ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: ImageUrl!=null?Image.network(ImageUrl, fit: BoxFit.fill):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.fill),

                                ),
                                margin: EdgeInsets.only(left: 5),


                              ),


                              Container(
                                margin: EdgeInsets.only(top: 5,left: 10),//top8
                                width: width-95,//70

                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [

                                        Container(

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children :[
                                              Text(""+PoCategory,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),


                                              // Text("("+PoCollection+")", overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),

                                            ],
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Unit Price : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                                            Text(""+discountedPrice.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),


                                          ],
                                        ),


                                      ],

                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(

                                            child: Row(

                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("QTY. ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),//18
                                                Text(double.parse(PoQuanittiy).toStringAsFixed(2)+" sqft",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: sh_colorPrimary),),
                                              ],
                                            ),
                                            //width: width/2,
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("RRP : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: sh_textColorSecondary),),
                                              Stack(
                                                children: [
                                                  Container(

                                                    child: Image.asset(ic_redline,width: 40,),
                                                    margin: EdgeInsets.only(top: 5),
                                                  ),
                                                  Text(PoUnitPrice.toCurrencyFormat(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: sh_textColorSecondary),),

                                                ],
                                              )
                                            ],
                                          ),
                                        ]

                                    ),

                                    // Row(
                                    //
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   children: [
                                    //     Text("QTY.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    //     Text(double.parse(PoQuanittiy).toStringAsFixed(2)+" sqft",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),),
                                    //
                                    //
                                    //
                                    //
                                    //   ],
                                    // ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width:(width-95)/2,
                                          child: Text(
                                            PoCollection+"("+PoColor+")",
                                            overflow: TextOverflow.ellipsis,
                                            style: new TextStyle(
                                                fontSize: 10,fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),


                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Total : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                                            Text(PoTotalAmount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: sh_colorPrimary),),
                                          ],
                                        )


                                      ],
                                    ),



                                  ],
                                ),
                              ),









                            ],
                          ),
                          decoration: BoxDecoration(
                            color: sh_itemText_background,

                            border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),

                        );
                        // return Chats(mListings[index], index);
                      }),
                ):listPurchaseLisne2==null?Container(
                  child: Text("Please Wait.."),
                ):  Container(

                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: listPurchaseLisne2.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      itemBuilder: (context, index) {
                        String PoCollection=  listPurchaseLisne2[index].product.collection.displayName;
                        String PoCategory=  listPurchaseLisne2[index].product.category.displayName;
                        String PoColor=  listPurchaseLisne2[index].product.colour.displayName;
                        String PoAmount = listPurchaseLisne2[index].amount.toString();
                        String PoQuanittiy=   listPurchaseLisne2[index].quantity.toString();

                        String PoUnitPrice =listPurchaseLisne2[index].unitPrice.toStringAsFixed(2);
                        double PoTotalAmount = listPurchaseLisne2[index].amount;
                        String ImageUrl=listPurchaseLisne2[index].product.imageUrl;

                        String discountper = listPurchaseLisne2[index].discount==null?"0":listPurchaseLisne2[index].discount.toString();
                        double doublePrice = double.parse( listPurchaseLisne2[index].unitPrice.toStringAsFixed(2));
                        double discountedPrice =doublePrice-(doublePrice*double.parse(discountper)/100);
                        return Container(
                          //color:sh_itemText_background,
                          //sh_itemText_background,

                          //height: 70,//90
                          margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                          padding: EdgeInsets.only(top: 5,bottom: 5),

                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[

                              Container(
                                width:55,//width * 0.3,//40
                                height: 55,//60
                                child:ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: ImageUrl!=null?Image.network(ImageUrl, fit: BoxFit.fill):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.fill),

                                ),
                                margin: EdgeInsets.only(left: 5),


                              ),


                              Container(
                                margin: EdgeInsets.only(top: 5,left: 10),//top8
                                width: width-95,//70

                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [

                                        Container(

                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children :[
                                              Text(""+PoCategory,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),


                                              // Text("("+PoCollection+")", overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),

                                            ],
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Unit Price : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                                            Text(""+discountedPrice.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),


                                          ],
                                        ),


                                      ],

                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(

                                            child: Row(

                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("QTY. ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),//18
                                                Text(double.parse(PoQuanittiy).toStringAsFixed(2)+" sqft",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: sh_colorPrimary),),
                                              ],
                                            ),
                                            //width: width/2,
                                          ),
                                          Row(

                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("RRP : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: sh_textColorSecondary),),
                                              Stack(
                                                children: [
                                                  Container(

                                                    child: Image.asset(ic_redline,width: 40,),
                                                    margin: EdgeInsets.only(top: 5),
                                                  ),
                                                  Text(PoUnitPrice.toCurrencyFormat(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: sh_textColorSecondary),),

                                                ],
                                              )
                                            ],
                                          ),
                                        ]

                                    ),

                                    // Row(
                                    //
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   children: [
                                    //     Text("QTY.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                    //     Text(double.parse(PoQuanittiy).toStringAsFixed(2)+" sqft",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),),
                                    //
                                    //
                                    //
                                    //
                                    //   ],
                                    // ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width:(width-95)/2,
                                          child:  Text(
                                            PoCollection+"("+PoColor+")",
                                            overflow: TextOverflow.ellipsis,
                                            style: new TextStyle(
                                                fontSize: 10,fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),


                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Total : ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                                            Text(PoTotalAmount.toStringAsFixed(2).toCurrencyFormat(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: sh_colorPrimary),),
                                          ],
                                        )


                                      ],
                                    ),



                                  ],
                                ),
                              ),









                            ],
                          ),
                          decoration: BoxDecoration(
                            color: sh_itemText_background,

                            border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),

                        );


                        // return Container(
                        //   color: sh_itemText_background,
                        //
                        //   height: 90,
                        //   margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                        //   child:  Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     // crossAxisAlignment: CrossAxisAlignment.stretch,
                        //     children: <Widget>[
                        //
                        //       Container(
                        //         width:40,//width * 0.3,
                        //         height: 60,
                        //         child:ImageUrl!=null?Image.network(ImageUrl, fit: BoxFit.fill):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.fill),
                        //
                        //       ),
                        //       Container(
                        //         margin: EdgeInsets.only(top: 8,left: 10),
                        //         width: width-70,
                        //
                        //         child: Column(
                        //           mainAxisAlignment:
                        //           MainAxisAlignment.start,
                        //           crossAxisAlignment:
                        //           CrossAxisAlignment.start,
                        //           children: [
                        //             SizedBox(height: 5),
                        //             Row(
                        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //
                        //               children: [
                        //
                        //                 Row(
                        //                   mainAxisAlignment: MainAxisAlignment.start,
                        //                   children :[
                        //                     Text(""+PoCategory,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                        //                     SizedBox(width: 5),
                        //                     Text("("+PoCollection+")",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                        //
                        //                   ],
                        //                 ),
                        //                 Text("Price : "+PoUnitPrice,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //
                        //               ],
                        //
                        //             ),
                        //             SizedBox(height: 3),
                        //             Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Row(
                        //                       mainAxisAlignment: MainAxisAlignment.start,
                        //                       children :[
                        //                         Text("("+PoColor+")",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12),),
                        //
                        //                       ]
                        //                   ),
                        //                   Text("Total  : "+PoTotalAmount.toStringAsFixed(2),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //                 ]
                        //
                        //             ),
                        //
                        //             Row(
                        //
                        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 Text(double.parse(PoQuanittiy).toStringAsFixed(2)+" sqft",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12),),
                        //
                        //
                        //
                        //
                        //               ],
                        //             ),
                        //             Row(
                        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 Text("Discount % : "+discountper,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //                 Text("Dis. Price : "+discountedPrice.toStringAsFixed(2),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        //
                        //               ],
                        //             ),
                        //
                        //
                        //
                        //
                        //           ],
                        //         ),
                        //       ),
                        //
                        //
                        //
                        //
                        //
                        //
                        //
                        //
                        //
                        //     ],
                        //   ),
                        //
                        // );
                        // return Chats(mListings[index], index);
                      }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [


                          Text("Total Order Value   ",style: TextStyle(fontWeight: FontWeight.normal, color: sh_textColorSecondary,fontSize: 18),),
                          Text(""+totalValue.toCurrencyFormat(),style: TextStyle(fontWeight: FontWeight.bold,color: sh_colorPrimary,fontSize: 18),),

                        ],
                      )
                    ],
                  ),
                ),


                SizedBox(height: 40,),
                Container(
                  margin: EdgeInsets.only(left: 15),

                  child : Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(ic_process1,height: 50,width: 50,),

                        ],
                      ),
                      Container(

                        color: status=="Approved"|| status=="Partially Shipped"||status=="Completed"||status=="Shipped"||status=="Complete"?sh_colorPrimary:sh_textColorSecondary,
                        width: (width-270)/5,
                        height: 2,
                      ),
                      Column(
                        children: [
                        status=="Approved"|| status=="Partially Shipped"||status=="Completed"||status=="Shipped"||status=="Complete"?Image.asset(ic_process2B,height: 50,width: 50,):Image.asset(ic_process2,height: 50,width: 50,),

                        ],
                      ),
                      Container(

                        color: status=="Partially Shipped"|| status=="Completed"|| status=="Shipped"||status=="Complete"?sh_colorPrimary:sh_textColorSecondary,
                        width: (width-270)/5,
                        height: 2,
                      ),
                      Column(
                        children: [
                          status=="Partially Shipped"|| status=="Completed"|| status=="Shipped"||status=="Complete"?Image.asset(ic_process3B,height: 50,width: 50,):Image.asset(ic_process3,height: 50,width: 50,),

                        ],
                      ),
                      Container(

                        color:   status=="Completed"||status=="Shipped"||status=="Complete"?sh_colorPrimary:sh_textColorSecondary,
                        width: (width-270)/5,
                        height: 2,
                      ),
                      Column(
                        children: [
                          status=="Completed"||status=="Shipped"||status=="Complete"? Image.asset(ic_process4B,height: 50,width: 50,):Image.asset(ic_process4,height: 50,width: 50,),

                        ],
                      ),
                      Container(

                        color:  status=="Completed"||status=="Shipped"||status=="Complete"?sh_colorPrimary:sh_textColorSecondary,
                        width: (width-270)/5,
                        height: 2,
                      ),
                      Column(
                        children: [
                        status=="Completed"||status=="Complete"?Image.asset(ic_process5B,height: 50,width: 50,):Image.asset(ic_process5,height: 50,width: 50,),

                        ],
                      ),




                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Container(

                  margin: EdgeInsets.only(left: 15),
                  child : Row(
                    children: [
                      Column(
                        children: [

                          Container(
                              width: 50,
                              child: Text("Order Placed",style: TextStyle(color: sh_black,fontSize: 10),))
                        ],
                      ),
                      Container(


                        width: (width-270)/5,
                        height: 2,
                      ),
                      Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(left: 10),
                              width: 50,

                              child: Text("Order Confirmed",style: TextStyle(color: sh_black,fontSize: 10,),))
                        ],
                      ),
                      Container(


                        width: (width-270)/5,
                        height: 2,
                      ),
                      Column(
                        children: [

                          Container(
                              width: 50,
                              child: Text("Partially shipped",style: TextStyle(color: sh_black,fontSize: 10),))
                        ],
                      ),
                      Container(


                        width: (width-270)/5,
                        height: 2,
                      ),
                      Column(
                        children: [

                          Container(
                              width: 50,
                              child: Text("shipped",style: TextStyle(color: sh_black,fontSize: 10),))
                        ],
                      ),
                      Container(


                        width: (width-290)/5,
                        height: 2,
                      ),
                      Column(
                        children: [

                          Container(
                              width: 50,
                              child: Text("Completed",style: TextStyle(color: sh_black,fontSize: 10),)),

                        ],
                      ),




                    ],
                  ),
                ),




              ],



            ),
          ),
        ),
      ),
      endDrawer: MyDrwaer(),
    ),
      );
  }




// Custom Alert Dialog









}