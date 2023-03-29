import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

import '../../rosetta/models/SkipButtonApi.dart';
import 'DisAprroveOrder.dart';
import 'DistributorOrderDetails.dart';
import 'NewDisOrderDetailsPage.dart';
import 'distributorShippingPage.dart';



class DisApproveOrder  extends StatefulWidget {
  static String tag = '/ShProfileFragment';

  @override
  ShWishlistFragmentState createState() => ShWishlistFragmentState();
}

class ShWishlistFragmentState extends State<DisApproveOrder> {

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
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
    isVisibleSkipApi();

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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    return  Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyAppBar(false,"","",isVisibleSkip,true),
                Container(
                  width: width,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),


                  color: backgroundSearchProductForm,
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(

                        child: SizedBox(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: (width/2)+30,
                                child:TextFormField(
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
                                        backgroundSearchProductFormButtons,
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
                                ),
                                decoration: BoxDecoration(

                                  border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                  borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                width: (width/2)-60,
                                padding: EdgeInsets.only(right: 10,left: 15),
                                child: new DropdownButton<String>(
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
                              ),
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
                                      Text("Start Date",style: TextStyle(fontSize: textSizeSmall,color: sh_textColorSecondary),),
                                      Image.asset(ic_calender_icon,height: 15,width: 15,),

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
                                    _selectDate(context);
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
                                      Text("End Date",style: TextStyle(fontSize: textSizeSmall,color: sh_textColorSecondary),),
                                      Image.asset(ic_calender_icon,height: 15,width: 15,),

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
                                    _selectDate(context);
                                  });
                                },
                              ),


                              SizedBox(width: 5,),

                              InkWell(
                                child: Image.asset(ic_search_round,height: 42,width: 42,fit: BoxFit.fill),
                                onTap: (){

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


                Container(

                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount:4,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 15),
                      itemBuilder: (context, index) {
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

                                Container(
                                  margin: EdgeInsets.only(left: 10,top: 10),

                                  child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,


                                    children: [
                                      Text("Products  :",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),
                                      Row(
                                        children: [
                                          Text("AT 20MM (2M),AT 25MM (2M),",style:TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                          Text("+2 More",style:TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),)
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
                                              child:index==0?
                                              Image.asset(ic_circularGreenCheckBox,height:20,width: 20,)
                                                  : index==1?Image.asset(ic_pending,height:20,width: 20,):
                                              index==2?Image.asset(ic_circularcancel,height:20,width: 20,):
                                              Image.asset(ic_autocompleted,height:20,width: 20,),
                                            ),
                                            margin: EdgeInsets.only(top: 8,),

                                          ),
                                          SizedBox(width: 10,),
                                          Container(

                                            child: index==0?Text("Approved",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,fontWeight: FontWeight.bold),):
                                            index==1?Text("Pending",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,fontWeight: FontWeight.bold),):
                                            index==2?Text("Cancel",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,fontWeight: FontWeight.bold),):
                                            Text("Auto Completed",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                            margin: EdgeInsets.only(top: 5),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: InkWell(
                                              child: Image.asset(ic_eyegrey,height:20,width: 20,),
                                              onTap: ()
                                              {

                                              },

                                            ),
                                          ),
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
                                                DistributorOrderDetails().launch(context),

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



                SizedBox(
                  height: 5,
                ),

              ],
            ),
          ),
        ),
      ),
      endDrawer: MyDrwaer(),
    );
  }




// Custom Alert Dialog

}