

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/shimmer_list.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../../rosetta/models/DealersDetails.dart';
import '../../../rosetta/utils/ShColors.dart';
import '../../../rosetta/utils/ShConstant.dart';
import '../../../rosetta/utils/ShFunction.dart';
import '../../../rosetta/utils/ShWidget.dart';
import '../../Distributor/SelectProductPlaceOrder.dart';
import '../PaymentTermsForm.dart';
import '../PersonalDeatilsForm.dart';
import 'my_edit_appbar.dart';
import 'my_personaldeail_edit.dart';

SharedPreferences prefs;
class MyDealersDeatails extends StatefulWidget {
  String dealersId;
  MyDealersDeatails(this.dealersId);

  @override
  _MyDealersDeatailsState createState() => _MyDealersDeatailsState();
}

class _MyDealersDeatailsState extends State<MyDealersDeatails> {
  var checkNetconnection;
  String MyToken;
  String MyUserName = "";
  String MyCompanyId;
  String MyMemberId;
  String MyMemberType;
  String Myparent_distributor_id;
  String Myparent_distributor_nav_id;
  DealersDetsils dealersDetsils;
  String name="";
  String personal_Name="";
  String email="";
  String passwoard="";
  String phone="";
  String fax="";
  String address="";
  String paymentTerms="";
  String paymentMethods="";
  String creditLimits="";
  String overdueBalance="";
  String gstCusType="";
  String gstNumber="";
  String panNo="";
  String panRefernce="";

  // NEW CHANGE
  String state_code = "";
  String state = "" ;
  String city = "" ;
  String Post_code = "" ;
  bool isDetailsLoad=false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  getDealerDetails(String dealerId) async {
    print("Dealers Details >>>>>>>>>>>>>>>>>>>>>>>>>>>> ");

    //?sort=&page=1&per_page=20

    http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL + '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers/$dealerId'),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );
    var responcebody = response.body;
    var responseCode = response.statusCode;

    print("Response Code >>>>>>>>>>>>>>>>>>>>> $responseCode");
    print("Response Body >>>>>>>>>>>>>>>>>>>>> $responcebody");
    print("LLLLLLLLLLLLLLLLLLLLLL");
    print(responcebody.length);

    if(responseCode==200)
    {
      dealersDetsils =DealersDetsils.fromJson(json.decode(responcebody));


      setState(() {
        name=dealersDetsils.name;
        personal_Name=dealersDetsils.contact;
        email=dealersDetsils.email;
        passwoard="";
        phone=dealersDetsils.phone;
        fax=dealersDetsils.fax.toString();
        address=dealersDetsils.address;

        paymentTerms=dealersDetsils.paymentTerms.key;
        paymentMethods=dealersDetsils.paymentMethod.key;
        creditLimits=dealersDetsils.creditLimit.toString();
        overdueBalance=dealersDetsils.overdueBalance.toString();
        gstCusType=dealersDetsils.taxInformation.gst.customerType.key;
        gstNumber=dealersDetsils.taxInformation.gst.number.toString();
        panNo=dealersDetsils.taxInformation.pan.number.toString();
        panRefernce=dealersDetsils.taxInformation.pan.referenceNumber.toString();
        state = dealersDetsils.state.name.toString();
        Post_code = dealersDetsils.zipcode.toString();
        print("State Details "+dealersDetsils.name);
        print("State Details 2"+state);
        print("PPPPPPPPPPPPPPPPPPPPPPPPP");
        print(panNo);
        print(Post_code);


        // NEW CHANGES
        // state_code =  dealersDetsils.state_code.toString();
        city =  dealersDetsils.city;

        print("NEW STATE TEST +++++++++++++++++++"+state);
        print(dealersDetsils.state.toString());
        // if(dealersDetsils.taxInformation.pan.number!=null)
        //  {
        //    print("Dealer Pan Details >>>>>>>>>>>>>>>>>>>>> Number "+dealersDetsils.taxInformation.pan.number.toString());
        //  }
        // if(dealersDetsils.taxInformation.pan.status.value!=null)
        //  {
        //    print("Dealer Pan Details >>>>>>>>>>>>>>>>>>>>> Status  "+dealersDetsils.taxInformation.pan.status.value.toString());
        //  }
        // if(dealersDetsils.taxInformation.pan.referenceNumber!=null)
        //  {
        //    print("Dealer Pan Details >>>>>>>>>>>>>>>>>>>>>  Refrence "+dealersDetsils.taxInformation.pan.referenceNumber.toString());
        //  }

      });
    }

    setState(() {
      isDetailsLoad=false;

    });
  }

  getSessionData() async
  {
    print("Get Session Methode Call");
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String userName = prefs.getString('UserName');
    String mycompanyId = prefs.getString('companyId');
    String mymemberId = prefs.getString('memberId');
    String mymemberType = prefs.getString('memberType');
    API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');

    String parent_distributor_id = "0";
    String parent_distributor_nav_id = "0";
    if (mymemberType != "Distributor") {
      parent_distributor_id = prefs.getString('parent_distributor_id');
      parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');
    }

    print(
        ">>>>>>>>>>>Session Token $token  $userName $mycompanyId $mymemberId");
    print(">>>>>>>>>>>Session Token $token");
    setState(() {
      MyToken = token;
      MyUserName = userName;
      MyCompanyId = mycompanyId;
      MyMemberId = mymemberId;
      MyMemberType = mymemberType;
      if (MyMemberType != "Distributor") {
        Myparent_distributor_id = parent_distributor_id;
        Myparent_distributor_nav_id = parent_distributor_nav_id;
        print(
            "DisSelected Inventory  Page Session Data Myparent_distributor_id  $parent_distributor_id , Myparent_distributor_nav_id $parent_distributor_nav_id");
      }
    });

    if (token.isNotEmpty) {
      print(">>>>>>>>>>>>>>>>>>Token is Not Empty>>>>>>>>>>>>>>>>>>>");


      checkNetconnection = isInternatAvailable();
      print("Response od internet Menthode $checkNetconnection");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$checkNetconnection.");
      if (checkNetconnection != null) {
        setState(() {
          isDetailsLoad=true;
        });
        getDealerDetails(widget.dealersId);
      }
      if (checkNetconnection != null) {
        print("Please check your Internet Connection ");
        // showAlertStockDialog(context);
        //interNetPopup();
      }
    }
  }
  @override
  void initState() {


    getSessionData();
    //GGGGGGGGGGGGGGGG

  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    // isback = false;
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
        child:

        Scaffold(

         key:  _scaffoldKey ,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
          //  child:MyAppBar(false,"MY Profile","",false,false)//MyAppBar(false,"Profile","",false),
          child: AppBar(
            backgroundColor: sh_white,
            automaticallyImplyLeading: false,
            titleSpacing: 0,

            iconTheme: IconThemeData(color: sh_textColorPrimary),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child:  isDetailsLoad?Container(
                      margin: EdgeInsets.only(top: 10),
                      child: SmallBoxShimmer()): InkWell(
                    onTap: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  MyPersonalDeatilsForm('1', true , null , dealersDetsils))) ;
                    },
                    child: Icon(
                      Icons.edit,
                      color: secondColor,
                      size: 26.0,
                    ),
                  )
              ),

              Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: ()  {
                      SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);

                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: secondColor,//isrosetta?sh_colorPrimary:sh_colorPrimary2,
                      size: 26.0,
                    ),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => openEndDrawer() ));
                      Scaffold.of(context).openDrawer();
                     // Scaffold.of(context).openEndDrawer();
                      _scaffoldKey.currentState.openEndDrawer();

                      // _pageIndex = 3;


                    },
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 26.0,
                    ),
                  )
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child:  GestureDetector(
                    onTap: () {
                        Navigator.of(context).pop();
                        },

                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 26.0,
                      ),
                    ) ,


                  ),
                SizedBox(width: 5,),
                Container(

                    child: Text("Profile",style: TextStyle(color: sh_textColorPrimary,fontWeight: FontWeight.bold,fontSize: textSizeMedium),))

              ],
            ),
            elevation: 1,
          )
          ) ,

          body: SafeArea(
            child: SingleChildScrollView(

              child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight:double.infinity,
                      maxWidth:  MediaQuery.of(context).size.width),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(

                          margin: EdgeInsets.all(10.0),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Personal Details", style: TextStyle(
                                        fontSize: textSizeLargeMedium,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),

                                    // isDetailsLoad?SmallBoxShimmer(): InkWell(
                                    //   child: Icon(Icons.edit, color: sh_colorPrimary,),
                                    //   onTap: (){
                                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDeatilsForm("1",true,null,dealersDetsils)));
                                    //   },
                                    // )
                                  ],
                                ),
                                color: sh_ColorPrimary2,
                              ),

                              Container(
                                padding: EdgeInsets.all(10.0),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Firm Name",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer():Text(
                                          name.isEmptyOrNull?"N/A":name,
                                          style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Person Name",
                                          style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer():Text(

                                          personal_Name.isEmptyOrNull?"N/A":personal_Name
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Email",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer(): Text( email.isEmptyOrNull?"N/A":email
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),

                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Phone",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer(): Text(
                                          phone.isEmptyOrNull?"N/A":phone
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Fax",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer(): Text(
                                          fax.isEmptyOrNull?"N/A":fax
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Address",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),

                                        isDetailsLoad?TextShimmer():FittedBox(
                                          fit: BoxFit.fitWidth,

                                          child: Row(
                                            children: [
                                              AutoSizeText(

                                                address.isEmptyOrNull? "N/A"  : address +" , " //+state+" , "+city
                                                ,
                                                maxLines: 2,
                                                //  maxFontSize: textSizeLargeMedium,
                                                // minFontSize:  textSizeMedium ,

                                                style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),
                                              ),


                                              AutoSizeText(

                                                state.isEmptyOrNull?""  : state +" , " //+state+" , "+city
                                                ,
                                                maxLines: 2,
                                                //  maxFontSize: textSizeLargeMedium,
                                                // minFontSize:  textSizeMedium ,

                                                style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                              AutoSizeText(

                                                city.isEmptyOrNull?""  : city +" , " //+state+" , "+city
                                                ,
                                                maxLines: 2,
                                                //  maxFontSize: textSizeLargeMedium,
                                                // minFontSize:  textSizeMedium ,

                                                style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                              AutoSizeText(

                                                Post_code.isEmptyOrNull?""  : Post_code //+" , "+state+" , "+city
                                                ,
                                                maxLines: 2,
                                                //  maxFontSize: textSizeLargeMedium,
                                                // minFontSize:  textSizeMedium ,

                                                style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),


                                            ],
                                          ),

                                        ),
                                        // isDetailsLoad?TextShimmer():Text(
                                        //   address.isEmptyOrNull?"N/A":address
                                        //   ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),

                                  ],
                                ),
                              ),







                            ],
                          ),


                          decoration: BoxDecoration(

                            color: sh_itemText_background,
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)),
                            boxShadow: [
                              BoxShadow(
                                color: sh_textColorEelevation,
                                spreadRadius: 1,
                                blurRadius: 0.5,

                                offset: Offset(0, 0), //

                                // shadow direction: bottom right
                              )
                            ],
                          ),

                          // decoration: BoxDecoration(
                          //   color: sh_itemText_background,
                          //
                          //   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                          //   borderRadius: BorderRadius.all(Radius.circular(5)),
                          // ),
                        ),
                      //  SizedBox(height: 0,),
                        Container(

                          margin: EdgeInsets.all(10.0),





                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Payment", style: TextStyle(
                                        fontSize: textSizeLargeMedium,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),

                                    // isDetailsLoad?SmallBoxShimmer(): InkWell(
                                    //   child: Icon(Icons.edit, color: sh_colorPrimary,),
                                    //   onTap: (){
                                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentTermsForm(
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         "",
                                    //         true,
                                    //         dealersDetsils
                                    //
                                    //
                                    //     )));
                                    //     // Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDeatilsForm("1",true,spinnerDelerList[index])));
                                    //   },
                                    // )
                                  ],
                                ),
                                color: sh_ColorPrimary2,
                              ),

                              Container(
                                padding: EdgeInsets.all(10.0),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Payment Terms",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer(): Text(
                                          paymentTerms.isEmptyOrNull?"N/A":paymentTerms
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Payment Methods",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer(): Text(
                                          paymentMethods.isEmptyOrNull?"N/A":paymentMethods
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Credit  Limits",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer():Text(
                                          creditLimits.isEmptyOrNull?"N/A":creditLimits
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Overdue Balance",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer(): Text(
                                          overdueBalance.isEmptyOrNull?"N/A":overdueBalance
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                  ],
                                ),
                              ),







                            ],
                          ),


                          decoration: BoxDecoration(

                            color: sh_itemText_background,
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)),
                            boxShadow: [
                              BoxShadow(
                                color: sh_textColorEelevation,
                                spreadRadius: 1,
                                blurRadius: 0.5,

                                offset: Offset(0, 0), //

                                // shadow direction: bottom right
                              )
                            ],
                          ),

                          // decoration: BoxDecoration(
                          //   color: sh_itemText_background,
                          //
                          //   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                          //   borderRadius: BorderRadius.all(Radius.circular(5)),
                          // ),
                        ),
                       // SizedBox(height: 15,),
                        Container(

                          margin: EdgeInsets.all(10.0),





                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Tax Information", style: TextStyle(
                                        fontSize: textSizeLargeMedium,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                    // OLD
                                    // isDetailsLoad?SmallBoxShimmer():  InkWell(
                                    //   child: Icon(Icons.edit, color: sh_colorPrimary,),
                                    //   onTap: (){
                                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => TextInformationForm(
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       "",
                                    //       true,
                                    //       dealersDetsils
                                    //     )));
                                    //     // Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDeatilsForm("1",true,spinnerDelerList[index])));
                                    //   },
                                    // )
                                  ],
                                ),
                                color: sh_ColorPrimary2,
                              ),

                              Container(
                                padding: EdgeInsets.all(10.0),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("GST Customer Type",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer(): Text(
                                          gstCusType.isEmptyOrNull?"N/A":gstCusType
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("GST Number",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer():Text(
                                          gstNumber.isEmptyOrNull?"N/A":gstNumber
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("P.A.N. No.",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer(): Text(
                                          panNo.isEmptyOrNull?"N/A":panNo
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("P.A.N Reference No.",style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.w300,color: Colors.black),),
                                        isDetailsLoad?TextShimmer():Text(
                                          panRefernce.isEmptyOrNull?"N/A":panRefernce
                                          ,style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.black),),

                                      ],
                                    ),
                                  ],
                                ),
                              ),







                            ],
                          ),


                          decoration: BoxDecoration(

                            color: sh_itemText_background,
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)),
                            boxShadow: [
                              BoxShadow(
                                color: sh_textColorEelevation,
                                spreadRadius: 1,
                                blurRadius: 0.5,

                                offset: Offset(0, 0), //

                                // shadow direction: bottom right
                              )
                            ],
                          ),

                          // decoration: BoxDecoration(
                          //   color: sh_itemText_background,
                          //
                          //   border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                          //   borderRadius: BorderRadius.all(Radius.circular(5)),
                          // ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ),
          endDrawer: MyDrwaer(),
        ));
  }


}
