import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:rosetta_fluter_app/main/utils/AppColors.dart';

import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';

import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';

import 'DisAprroveOrder.dart';
import 'NewDisOrderDetailsPage.dart';



class DistributorOrderDetails  extends StatefulWidget {
  static String tag = '/ShProfileFragment';

  @override
  ShWishlistFragmentState createState() => ShWishlistFragmentState();
}

class ShWishlistFragmentState extends State<DistributorOrderDetails> {

  String dropdownValue = 'Add Customer and Shiping Details';


  String dropdownValue4 = 'Select Dealer(Optional)';

  List<String> spinnerItems4 = [
    'Select Dealer(Optional)',
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ];

  List<String> spinnerItems = [
    'Add Customer and Shiping Details',
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ];
  List<ShProduct> list = [];

  bool value = true;

  @override
  void initState() {
    super.initState();
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

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(


            child: Column(

              children: [
                MyAppBar(false,"Order Details","",false,true),

                Container(
                  padding: EdgeInsets.only(top: 15,bottom: 15),


                  color:backgroundSearchProductForm,
                  child:Column(
                    children: [

                      Container(
                        padding: EdgeInsets.only(left: 10,right: 5,top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(


                              child: Text("Johan Watson",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),
                            ),

                            Container(
                              child: Text("Sep 28, 2021",style: TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),


                            ) ,

                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 10,bottom: 10),
                        child: Text("+912358623",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
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
                                  child: Text("N6552620",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),

                            Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                            Column(
                              children: [
                                Container(
                                  child: Text("Total Qty",style:  TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                ) ,
                                SizedBox(height: 5,),
                                Container(
                                  child: Text("50",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                ) ,
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                            Column(
                              children: [
                                Container(
                                  child: Text("Total Value",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  child: Text("5652".toCurrencyFormat(),style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
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
                Container(

                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          child:  Container(

                            padding: EdgeInsets.only(right: 8,left: 8),
                            margin: EdgeInsets.all(5.0),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:50,//width * 0.3,
                                        height: 70,

                                        child:
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(5.0),
                                          child:Image.asset(
                                            "images/shophop/img/products" +
                                                list[index].images[0].src,
                                            fit: BoxFit.fill,
                                            width:50,//width * 0.3,
                                            height: 70,
                                          ),
                                        )




                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 12,top: 12,bottom: 2),
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(

                                                child :   Row(
                                                  children: [
                                                    Container(

                                                      child:   Text("LOTUS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 5,right: 5),
                                                      width: 1,
                                                      height: 10,
                                                      color: sh_textColorSecondarylight,
                                                    ),
                                                    Container(

                                                        child:Text("ADJ/201/2",style: TextStyle(fontSize: 14),)

                                                    ),

                                                  ],
                                                )
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              child: Text("Qty $index sqft",style: TextStyle(fontSize: 14,color: sh_colorPrimary,fontWeight: FontWeight.bold),),
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text("12000".toCurrencyFormat(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: sh_black),),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 5,right: 5),
                                                    width: 1,
                                                    height: 10,
                                                    color: sh_colorPrimary,
                                                  ),
                                                  Text("Total 24000",style: TextStyle(fontSize: 16,color: sh_colorPrimary,fontWeight: FontWeight.bold),),


                                                ],),
                                            ),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),

                                  Container(


                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,

                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: 45,),
                                            Container(

                                              child:
                                              InkWell(
                                                onTap: (){
                                                  showAlertStockDialog(context);
                                                },
                                                child:  Image.asset(ic_golden_eye,height:25,width: 25,),
                                              ),
                                              margin: EdgeInsets.only(top: 8,),

                                            ),
                                          ],

                                          ),

                                      index%2==0?  Container(

                                          child: TextButton(
                                            child: Text("Select Lot",
                                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
                                            style: ButtonStyle(
                                                padding:
                                                MaterialStateProperty.all<EdgeInsets>(
                                                    EdgeInsets.only(left: 10,right: 10)),
                                                backgroundColor: MaterialStateProperty.all(sh_colorPrimary),
                                                foregroundColor:
                                                MaterialStateProperty.all<Color>(

                                                    backgroundSearchProductFormButtons),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5.0),
                                                      side: BorderSide(color: backgroundSearchProductFormButtons,
                                                        width: 2,
                                                      ), ))), onPressed: () {

                                            _bottomSheetMore(context,index);
                                          },

                                            //showAlertDialog(context)
                                          ),
                                        ) :
                                      Container(

                                        child: TextButton(
                                          child: Text("Selected",
                                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
                                          style: ButtonStyle(
                                              padding:
                                              MaterialStateProperty.all<EdgeInsets>(
                                                  EdgeInsets.only(left: 10,right: 10)),
                                              backgroundColor: MaterialStateProperty.all(sh_light_green),
                                              foregroundColor:
                                              MaterialStateProperty.all<Color>(

                                                  sh_light_green),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    side: BorderSide(color: sh_light_green,
                                                      width: 0,
                                                    ), ))), onPressed: () {


                                        },

                                          //showAlertDialog(context)
                                        ),
                                      ),
                                      ],
                                    )


                                  ),


                                ],
                              ),
                            ),

                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,

                            border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),

                        );

                        // return Chats(mListings[index], index);
                      }),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),



              ],
            ),
          ),
        ),
      ),
      endDrawer:MyDrwaer(),
    );
  }




// Custom Alert Dialog

  showAlertStockDialog(BuildContext context)
  {


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(

              child: StatefulBuilder(

                builder: (BuildContext context, setState) => Container(
                  height: 395,
                  width:MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 20,bottom: 20),

                  child: Column(
                    children: [
                      Stack(
                        children: [


                          Container(
                            child:


                            Image.asset(ic_stock,height: 50,width: 50, fit: BoxFit.fill,),
                            alignment: Alignment.topCenter,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 15),
                            child: InkWell(
                                child: Image.asset(ic_cross_dialog,height: 25,width: 25,
                                color: sh_colorPrimary,),
                              onTap: (){
                                Navigator.pop(context, false);
                              },
                            ),
                            alignment: Alignment.topRight,

                          ),
                        ],
                      ),


                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,

                        height: 40,
                        child: Text("Stocks Details",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                      ),



                      Container(
                        margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                        height: 200,
                        child:   ListView.builder(

                            scrollDirection: Axis.vertical,
                            itemCount: 3,

                            shrinkWrap: true,

                            itemBuilder: (context, index) {
                              return Container(
                                  padding: EdgeInsets.only(left: 5,right: 5,),

                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              child: Image.asset(ic_uncheck,height: 15,width: 15,),
                                            alignment: Alignment.topCenter,
                                          ),
                                          Container(

                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(

                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,

                                                    children: [
                                                      index==0 ? Text("Mumbai",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),):
                                                      index==1 ? Text("Pune",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),):
                                                      Text("Gujrat",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                                                    ],
                                                  ),
                                                  width: (MediaQuery.of(context).size.width/3)-37,
                                                  alignment: Alignment.centerLeft,
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: [
                                                          Text("Available",style: TextStyle(color: Colors.black,),),
                                                          SizedBox(height: 5,),
                                                          Text("2000 Sqft",style: TextStyle(color: Colors.green),)
                                                        ],
                                                      ),
                                                       width: (MediaQuery.of(context).size.width/2)-68,
                                                      alignment: Alignment.centerLeft,
                                                    ),

                                                    Container(

                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Blocked",style: TextStyle(color: Colors.black,),),
                                                          SizedBox(height: 5,),
                                                          Text("2000 Sqft",style: TextStyle(color: Colors.red),)
                                                        ],
                                                      ),
                                                      width:(MediaQuery.of(context).size.width/2)-68,
                                                      alignment: Alignment.centerRight,

                                                    ),
                                                  ],
                                                ),


                                              ],
                                            ),
                                            margin: EdgeInsets.only(left: 10),
                                          ),
                                        ],
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(top: 10,bottom: 10),
                                        height: 1,
                                        color:sh_textColorVerticleLine,
                                      ),

                                    ],
                                  )


                              );
                              // return Chats(mListings[index], index);
                            }),


                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),



                        color: sh_white,
                        child:   Container(

                          child: MaterialButton(
                            padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),


                            child: Text("Save", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
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



                ),
              )



          );
        });
  }


  _bottomSheetMore(context, int selectQuantity) {
    showModalBottomSheet(


      isScrollControlled: true,
      context: context,

      builder: (BuildContext context) {
        return BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            bool checkboxvalue = false;
            Image imgUp =  Image.asset(ic_check,height: 15,width: 15,);
            Image imgDown =  Image.asset(ic_uncheck,height: 15,width: 15,);
            /*SvgPicture imgUp =  SvgPicture.asset(ic_svg_check,height: 15,width: 15,);
            SvgPicture imgDown =  SvgPicture.asset(ic_svg_uncheck,height: 15,width: 15,);*/

            var selectedindex;
            var list1 = [];

            String dropdownValue1 = 'Approve';
            List<String> spinnerItems1 = [
              'Approve',
              'Reject',

            ];

            return StatefulBuilder(
              builder: (BuildContext context, setState) =>
              Container(

                height: MediaQuery.of(context).size.height * 0.75,


                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    Container(
                      color: backgroundSearchProductForm,



                      padding: EdgeInsets.all(15),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 0,top: 0),
                              child: Text("Mumbai",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),)),
                          SizedBox(height: 10,),
                          Row(children: [
                            Container(
                              alignment: Alignment.centerLeft,

                              width:MediaQuery.of(context).size.width-140,


                              child:  TextFormField(
                                initialValue: "$selectQuantity",
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                textCapitalization: TextCapitalization.words,

                                style: TextStyle(
                                    color: sh_textColorPrimary,
                                    fontFamily: fontRegular,
                                    fontSize: textSizeSMedium),

                                       decoration: InputDecoration(
                                    filled: true,
                                    fillColor: backgroundSearchProductFormInput,
                                    focusColor: sh_editText_background_active,
                                    hintText: "Quantity",

                                    hintStyle: TextStyle(
                                        color: sh_textColorSecondary,
                                        fontFamily: fontRegular,
                                        fontSize: textSizeSmall),
                                    contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 15.0),
                                    //EdgeInsets.only(left: 10,right: 10),
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
                              ),

                            ),
                            SizedBox(width: 10,),
                            Container(
                              width: 100,
                              child: MaterialButton(
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                                    alignment: Alignment.center,
                                    child: text(sh_lbl_search, fontSize: textSizeMedium, fontFamily: fontMedium, textColor: Colors.white)),
                                textColor: sh_white,
                                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                color: sh_colorPrimary,
                                onPressed: () => {

                                  //  SearchProductResult().launch(context),

                                },
                                elevation: 0,
                              ),

                            ),
                          ],),
                          SizedBox(height: 10,),

                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("SATURN", style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                    Text("Carpet(4520)",style: TextStyle(fontSize: 15,color: Colors.black,),),
                                  ],
                                ),

                                Container(
                                    child: Text("Available",style: TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),)
                                ),
                              ],

                            ),
                          ),
                          SizedBox(height: 10,),
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
                                            child: Text("Unit",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            child: Text("Rolls",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                          ),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),

                                      Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                      Column(
                                        children: [
                                          Container(
                                            child: Text("Size",style:  TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          ) ,
                                          SizedBox(height: 5,),
                                          Container(
                                            child: Text("200sqft",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                          ) ,
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),
                                      Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                      Column(
                                        children: [
                                          Container(
                                            child: Text("Total",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            child: Text("5986".toCurrencyFormat(),style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
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
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 15,top: 15),
                        child: Text("Select Lot",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)),
                    Container(



                      child:   ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 15,right: 15),
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: [

                                      InkWell(
                                        child:Row(
                                          children: [
                                            list1.contains(index) ? imgUp:imgDown,
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
                                                              Text("Adj | jan20 | 2",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Container(

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(


                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text("Qty : ",style: TextStyle(fontSize: 14),),
                                                              Text("85 sqft",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
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
                                            if(list1.contains(index))
                                            {
                                              list1.remove(index);
                                            }
                                            else
                                            {
                                              list1.add(index);

                                            }
                                          });
                                        },
                                      ),


                                      //Batch No //Quantityt


                                    ],
                                  ),

                                  //TextField
                                  Container(
                                    width :60,
                                    height: 30,
                                    child:  TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      autofocus: false,
                                      textCapitalization: TextCapitalization.words,
                                      style: TextStyle(
                                          color: sh_textColorPrimary,
                                          fontFamily: fontRegular,
                                          fontSize: textSizeSmall),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: backgroundSearchProductFormInput,
                                          focusColor: sh_editText_background_active,
                                          hintText: "10",
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
                                    ),

                                  ),




                                ],
                              ),
                            );
                            // return Chats(mListings[index], index);
                          }),


                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      height: 70,

                      color: sh_colorPrimary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[

                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width:MediaQuery.of(context).size.width*0.6,
                                  padding: EdgeInsets.only(left: 15,right: 10),
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  child:   new DropdownButton<String>(
                                    value: dropdownValue1,
                                    hint: new Text("Select Here"),
                                    isExpanded: true,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color:
                                      sh_textColorSecondary,
                                      size: 25,
                                    ),
                                    iconSize: 20,
                                    elevation: 16,
                                    itemHeight: null,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    underline: Container(
                                      height: 2,
                                    ),
                                    onChanged: (String value) {
                                      setState(() {
                                        dropdownValue1 = value;
                                      });
                                    },
                                    items: spinnerItems1
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: text(value,
                                                fontSize: textSizeMedium,
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
                                ),
                                SizedBox(width: 5,),
                                Container(
                                  width:100,
                                  margin: EdgeInsets.only(left: 0),
                                  child: MaterialButton(

                                    padding:  EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                                    child: Text("Next",  style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                    textColor: sh_colorPrimary,
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                    color: sh_white,
                                    onPressed: () => {

                                    //dropdownValue1 = 'Approve';

                                      if(dropdownValue1=="Approve")
                                        {
                                          showAlertApproveOrder(context,"Approved"),
                                        }
                                     else  if(dropdownValue1=="Reject")
                                        {
                                          showAlertApproveOrder(context,"Rejected"),
                                        }


                                    },

                                  ),
                                ),


                              ],

                            ),
                          ),
                        ]
                      ),




                    ),

                  ],
                ),



              ),
            );
          },
        );
      },




    );
  }


  showAlertBlock(BuildContext context) {
    // Create button
    Widget okButton =
    TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message."),
      actions: [
        okButton,
      ],
    );


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(

            child: Container(
              height: 280,
              padding: EdgeInsets.only(top: 15),


              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Container(
                    child:Image.asset(ic_transporter,height: 50,width: 50, fit: BoxFit.fill,),
                  ),

                  Container(
                    width: 225,
                    margin: EdgeInsets.only(top: 20,),
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: new DropdownButton<String>(
                      value: dropdownValue4,
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
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String value) {
                        setState(() {
                          dropdownValue4 = value;
                        });
                      },
                      items: spinnerItems4
                          .map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: text(value,
                                  fontSize: textSizeSmall,
                                  fontFamily: fontRegular,
                                  textColor: sh_colorPrimary),
                            );
                          }).toList(),
                    ),
                    decoration: BoxDecoration(

                      border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                      borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15,right: 25,top: 15),

                    child: Container(

                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Text("Save Dealer", style: TextStyle(fontSize: textSizeSMedium,),),
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




            ),
          );
        });
  }
  showAlertApproveOrder(BuildContext context,String value) {
    // Create button


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  Dialog(

              child: StatefulBuilder(

                builder: (BuildContext context, setState) => Container(
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


                                Image.asset(ic_greencheck,height: 100,width: 100, fit: BoxFit.fill,),
                                alignment: Alignment.topCenter,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: InkWell(
                                  child: Image.asset(ic_cross_dialog,height: 25,width: 25,
                                    color: sh_colorPrimary,),
                                  onTap: (){
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


                            child: Text("$value Order Successfully",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                          ),
                          // Container(
                          //   alignment: Alignment.center,
                          //
                          //   child: IntrinsicWidth(
                          //     child: MaterialButton(
                          //
                          //       padding: EdgeInsets.only(left: 15,right: 15,top: 13,bottom: 13),
                          //       child: text("Go To Cart", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                          //       textColor: Colors.white,
                          //       shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                          //       color: backgroundSearchProductFormButtons,
                          //       onPressed: () async {
                          //         Navigator.pop(context);
                          //         await Navigator.of(context)
                          //             .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder()));
                          //         setState((){});
                          //
                          //       },
                          //       // onPressed: () => {
                          //       //  // Navigator.pop(context),
                          //       //   SelectProductPlaceOrder().launch(context),
                          //       // },
                          //       elevation: 0,
                          //     ),
                          //   ),
                          // ),

                        ],
                      )),



                ),
              )



          );



        });
  }
}
