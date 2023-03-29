

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/main.dart';
import 'package:rosetta_fluter_app/rosetta/models/SpinnerDealersList.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';

import '../../main/utils/AppColors.dart';
import '../../main/utils/AppWidget.dart';
import '../../rosetta/models/AddDealerError.dart';
import '../../rosetta/models/AllStates.dart';
import '../../rosetta/models/DealersDetails.dart';
import '../../rosetta/utils/ShColors.dart';
import '../../rosetta/utils/ShConstant.dart';
import '../../rosetta/utils/ShFunction.dart';
import '../../rosetta/utils/ShImages.dart';
import 'PaymentTermsForm.dart';
import 'package:http/http.dart' as http;

import 'ViewDealers.dart';


SharedPreferences prefs;

class PersonalDeatilsForm extends StatefulWidget {
  String dealer_type;
  bool isEditDeler;
  SpinnerSpinnerDealerList selectDealer;
  DealersDetsils dealersDetsils;
  PersonalDeatilsForm(this.dealer_type,this.isEditDeler,this.selectDealer,this.dealersDetsils);

  @override
  _PersonalDeatilsFormState createState() => _PersonalDeatilsFormState();
}

class _PersonalDeatilsFormState extends State<PersonalDeatilsForm> {
  int val = 1;
  bool _obscureText = true;
  String dealerName="",contactPerson="",email="",password="",phone="",fax="",address="",address2="",state="",city="",postcode="";
  var checkNetconnection=null;
  String MyToken;
  String MyUserName="";
  String MyCompanyId;
  String MyMemberId;
  String MyMemberType;
  String  Myparent_distributor_id;
  String  Myparent_distributor_nav_id;
  var newJsonData;
  List<AllSates> AllStatesList = [];
  List<String> spinnerAllStatesList = [];
  String selectedStates="Select State";
  String stateCode;
  bool    isValidemail = true ;
  bool    isValidphone = true ;
  BuildContext dialogContext;
  String error_message="";
  ScrollController _scrollController;
  bool _showBackToTopButton = false;

  @override
  void dispose() {
    // _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _scrollToTop() {
    // _scrollController.animateTo(0,
    //     duration: Duration(seconds: 1), curve: Curves.linear);

    setState((){
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 500),
      );});
  }

//// EDIT PROPERTIES
  bool isAddressEdit = false;
  bool isFaxEdit = false ;
  bool iscontactPersonEdit=false;
  bool isdealerNameEdit=false;
  bool isPhoneEdit=false;
  bool isStateEdit=false;
  bool isCityEdit=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    if(widget.isEditDeler)
    {

      setState(()
      {

        dealerName=widget.dealersDetsils.name==null?"":widget.dealersDetsils.name;
        contactPerson=widget.dealersDetsils.contact==null?"":widget.dealersDetsils.contact;
        email=widget.dealersDetsils.email==null?"":widget.dealersDetsils.email;
        // password=widget.dealersDetsils.;
        phone=widget.dealersDetsils.phone==null?"":widget.dealersDetsils.phone;
        fax=widget.dealersDetsils.fax==null?"":widget.dealersDetsils.fax;
        address=widget.dealersDetsils.address==null?"":widget.dealersDetsils.address;
        address2=widget.dealersDetsils.address2==null?"":widget.dealersDetsils.address2;
        state=widget.dealersDetsils.state.name==null?"":widget.dealersDetsils.state.name;
        city=widget.dealersDetsils==null?"":widget.dealersDetsils.city;
        postcode=widget.dealersDetsils.zipcode==null?"":widget.dealersDetsils.zipcode;
        val=widget.dealersDetsils.dealerType;


        //  1)widget.isEditDeler?(widget.dealersDetsils.fax.toString()
        // widget.isEditDeler?(widget.dealersDetsils.address2.toString()

        if(widget.dealersDetsils.fax.toString().isEmptyOrNull)
        {
          isFaxEdit=true;

        }

        if(widget.dealersDetsils.contact.isEmptyOrNull)
        {
          iscontactPersonEdit=true;

        }
        if(widget.dealersDetsils.address2.toString().isEmptyOrNull)
        {
          isAddressEdit=true;

        }
      });
    }

    print("Personal Dealtials Form "+widget.selectDealer.toString()+""+widget.isEditDeler.toString());


    getSessionData();

    //  _scrollController= ScrollController(initialScrollOffset: 50.0);



  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  getSessionData() async
  {
    print("Get Session Methode Call");
    prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String  userName = prefs.getString('UserName');
    String  mycompanyId = prefs.getString('companyId');
    String  mymemberId = prefs.getString('memberId');
    String  mymemberType = prefs.getString('memberType');
    API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');

    String  parent_distributor_id ="0";
    String  parent_distributor_nav_id = "0";
    if(mymemberType!="Distributor")
    {

      parent_distributor_id = prefs.getString('parent_distributor_id');
      parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');

    }

    print(">>>>>>>>>>>Session Token $token  $userName $mycompanyId $mymemberId");
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
      print(">>>>>>>>>>>>>>>>>>Token is Not Empty>>>>>>>>>>>>>>>>>>>");




      checkNetconnection = isInternatAvailable();
      print("Response od internet Menthode $checkNetconnection");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$checkNetconnection.");
      if(checkNetconnection!=null)
      {
        getAllList();



      }
      if(checkNetconnection!=null)
      {
        print("Please check your Internet Connection ");
        // showAlertStockDialog(context);
        //interNetPopup();
      }
    }
  }





  Future<List<SpinnerSpinnerDealerList>> getAllList() async {
    print("Get All States Api  List Methode Call >>>>>>>>>>>>>>>>>>");

    http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/companies/3/states'),//?sort=&page=1&per_page=20
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );
    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form ALL States  List Methode   Data Api : $responcebody");
    print("Response code Form ALL States  List Methode  Data Api : $responseCode");


    setState(() {


      if(responseCode==200)
      {
        AllStatesList= allSatesFromJson((response.body));
        getSpinnerAllSates();
      }



    });


    int newinventoryLength =  AllStatesList.length;
    print("All States is  Length >>>>>>>>>>>>>>> $newinventoryLength");
  }




  getSpinnerAllSates () async {


    print("Get Spinner All States   List Methode Call");

    var length = AllStatesList.length;
    print(" Spinner Sates List   lsi length is $length");

    for(int i=0;i<AllStatesList.length;i++)
    {
      var displayname;
      print(" Spinner Sates List  Loop is Called ");
      setState(() {
        if(i==0)
        {
          spinnerAllStatesList.add("Select State");

          spinnerAllStatesList.add(AllStatesList[i].name);
          displayname = spinnerAllStatesList[i];
        }
        else
        {
          spinnerAllStatesList.add(AllStatesList[i].name);
          displayname = spinnerAllStatesList[i];
        }

        ///SelectedDealer2=spinnerSelectDealer2[0];
      });


      print(" Spinner Dealer List   Name $displayname");
    }


    print("Length of Spinner All States length is "+spinnerAllStatesList.length.toString());






  }

  int responseCode=0;
  bool flagAddDealer=true;
  bool closedialog = true;
  Future<int> editDealerMethode() async {
    // closedialog = true;
    //responseCode=0;

    print("Edit  Dealer  Api Call "+widget.dealersDetsils.id.toString() );

    //  String gst_number = widget.number;



    var gstJosnData;
    widget.dealer_type=widget.dealersDetsils.dealerType.toString();

    if(widget.dealer_type=="2")
    {
      gstJosnData={
        "customer_type": "Unregistered",
        "registration_type": "GSTIN",
        "number": ""
      };
    }
    else
    {
      gstJosnData=  {
        "customer_type": widget.dealersDetsils.taxInformation.gst.customerType.key,
        "registration_type": "GSTIN",
        "number": widget.dealersDetsils.taxInformation.gst.number//27ACEPH9757K1Z1
      };
    }





    newJsonData = {
      "dealer_type": widget.dealersDetsils.dealerType,
      "distributorId": MyMemberId,
      "companyId": MyCompanyId,
      "name": widget.dealersDetsils.name,
      "contact": widget.dealersDetsils.contact,
      "address": widget.dealersDetsils.address,
      "address2": widget.dealersDetsils.address2,
      "state": widget.dealersDetsils.state.code,
      "city": widget.dealersDetsils.city,
      "zipcode":widget.dealersDetsils.zipcode,
      "paymentTerms": widget.dealersDetsils.paymentTerms.key,
      "paymentMethod": widget.dealersDetsils.paymentMethod.key,
      "credit_limit": widget.dealersDetsils.creditLimit,
      "phone": widget.dealersDetsils.phone,
      "email": widget.dealersDetsils.email,
      "fax": widget.dealersDetsils.fax,
      "tax_information":
      {
        "gst": gstJosnData,

        // {
        //   "customer_type": "Unregistered",
        //   "registration_type": "GSTIN",
        //   "number": ""
        // },
        // "gst": {
        //   "customer_type": widget.customer_type,
        //   "registration_type": "GSTIN",
        //   "number": widget.customer_type=="Unregisterd"?"":widget.number//27ACEPH9757K1Z1
        // },
        "pan": {
          "number": "",
          "status": "",
          "reference_number": ""
        }
      },
      "overdue_balance": widget.dealersDetsils.overdueBalance,
      "user": {
        "email": widget.dealersDetsils.email,
        "phone": widget.dealersDetsils.phone,

      }
    };


    print("JSON OF Edit DELAER >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  $newJsonData");

    print(MyCompanyId+MyMemberId+ widget.dealersDetsils.id.toString());

    //http://rosdev.rosettaproducts.com/api/companies/3/distributors/103/dealers/2315
    var res = await http.put(Uri.parse(API_ROS_PROD__BASE_URL +
        '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers/'+widget.dealersDetsils.id.toString()),
        body: jsonEncode(newJsonData),
        headers: {
          'Authorization': 'bearer $MyToken',
          'Content-Type': 'application/json'
        }
    );

    print("Edit  Dealer  Api Status Code " + res.statusCode.toString());
    print("Edit Dealer  Api Status bODY " + res.body.toString());

    // final parsedJson = jsonDecode(res.body);
    // print('${parsedJson.runtimeType} : $parsedJson');



    if(res.statusCode!=200) {

      setState(() {

        // closedialog = false;
      });
      Map<String, dynamic> res2 = jsonDecode(res.body);
      print(res2.containsKey("country"));
      print("Json Keys " + res2.keys.toString());
      String myKey = res2.keys.toString();


      //var error_message="";
      res2.keys.forEach((element) {
        print("Json Key Value  $element");
        error_message =error_message+'\n'+ AddDealerError
            .fromJson(jsonDecode(res.body), element).name[0];


        // Navigator.of(context, rootNavigator: true).pop();



        print("Error message is >>>>>>>>>>>>>>>  " + error_message.toString());
      });

      if(error_message.isNotEmpty)
      {


        error_message_add_dealer=error_message;
        prefs.setString('error_message', error_message);


        Navigator.of(context, rootNavigator: true).pop();


        Navigator.of(context).pop();
        Navigator.of(context).pop(error_message);
        //showToastDialog2(context, error_message.replaceAll(".", " "));
      }
    }





    print(">>>>>>Josn Object key "+jsonEncode(res.body));








    setState(() {

      //responseCode=res.statusCode;


    });

    if(res.statusCode==200)
    {
      // prefs.setString("paymentTerms","");
      // prefs.setString("paymentMethod","");
      // prefs.setString("credit_limit","2000");
      // prefs.setString("overdueBalance","0");
      // prefs.setString("gst","");
      // prefs.setString("reference_number_pan","");
      // prefs.setString("number_pan","");
      // prefs.setString("customer_type","");
      // prefs.setString("status_pan","");


    }

    return res.statusCode;


  }

  showAlertDialog(BuildContext context) {
    // Create button


    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(

              builder: (BuildContext context, setState)
              {
                isInternatAvailable2(context);

                //Order Placed Api Methode Call

                if(flagAddDealer){

                  setState((){
                    flagAddDealer=false;

                  });

                  editDealerMethode().then((value) {
                    setState((){
                      responseCode=value;
                    });
                  });
                }





                return  MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
                  child:

                  WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child:  AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)), //this right here
                      content: Container(
                          height: 200,

                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              Container(
                                child:responseCode==200?Image.asset(ic_greencheck,height: 50,width: 50, fit: BoxFit.fill,):
                                Image.asset(ic_form_preloader_gif,height: 50,width: 50, fit: BoxFit.fill,),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,


                                child:responseCode==200?

                                Container(child:
                                Column(
                                  children: [
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Container(),
                                    //     Text("Update!",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                    //     Container()
                                    //
                                    //   ],
                                    // ) ,



                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Text(
                                          widget.dealersDetsils.dealerType==1?  "Dealer information successfully":"Retailer information successfully",
                                          style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                        Container()

                                      ],
                                    ) ,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Text("updated.",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                        Container()

                                      ],
                                    ) ,

                                  ],
                                ),):

                                Text("Please wait",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                              ),
                              true?Container(
                                alignment: Alignment.center,

                                child: MaterialButton(

                                  padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
                                  child: text("Close", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                  color: sh_colorPrimary,
                                  onPressed: () async => {
                                    Navigator.pop(context,false),


                                    if(responseCode==200)
                                      {
                                        // Navigator.pop(context, false),
                                        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewDealers(true))),//28
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false))),//29jun
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers())),

                                        //  Navigator.pop(context,false),


                                      }
                                    else
                                      {
                                        //      Navigator.pop(context),
                                      }



                                    //   await Navigator.of(context)
                                    //   .push(new MaterialPageRoute(builder: (context) => NewDistributorDashboard())),
                                    // setState((){}),

                                    //
                                    // Navigator.of(context, rootNavigator:
                                    // true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                    //     NewDistributorDashboard()), (route) => false),


                                    //DisOrderHistory(backArrowVisible: true,
                                    //SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",).launch(context),


                                    //G MAy 25
                                    // await Navigator.of(context)
                                    // .push(new MaterialPageRoute(builder: (context) => DisOrderHistory(
                                    //   backArrowVisible: true,
                                    //   SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",
                                    // ))),







                                  },
                                  elevation: 0,
                                ),
                              ):Container(),

                            ],
                          )),
                    ),
                  ),);


              }
          );


        }).then((value){

      if(closedialog)
      {


        print("Add Dialog Close >>>>>>>>>>>>>>>>>>>>>>>>>>>.");

        FocusScope.of(context).unfocus();
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false)));
        //ViewDealers(false).launch(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ViewDealers(true)
            ),
                (Route)=>false
          // ModalRoute.withName("/ShHomeFragment")
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
        child:

        Scaffold(


          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child:widget.isEditDeler?MyAppBar(false,"Personal Deatils Update","",false,true):
            MyAppBar2(false,"Add Customer","",false),
          ),
          body: SafeArea(
            child: new Scrollbar(
                isAlwaysShown:true ,

                child:


                SingleChildScrollView(
                  controller: _scrollController,

                  child:  Container(

                      child: Column(
                        children: [
                          widget.isEditDeler?Container():    Container(
                              color: sh_ColorPrimary2,
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(
                                    children: [
                                      Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary,),
                                      SizedBox(width: 3,),
                                      Text("Personal Details",style: TextStyle(fontSize: 13.0,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(ic_nextdisable,height:13,width: 13,color: secondColor),
                                      SizedBox(width: 3,),
                                      Text("Payment",style: TextStyle(fontSize: 13.0,color:sh_textColorSecondarylight2,),),

                                    ],
                                  ),
                                  Row(
                                      children: [
                                        Image.asset(ic_nextdisable,height:13,width: 13,color: secondColor),
                                        SizedBox(width: 3,),
                                        Text("Tax Information",style: TextStyle(fontSize: 13.0,color:sh_textColorSecondarylight2,),),
                                      ]
                                  ),


                                ],
                              )

                          ),
                          widget.isEditDeler?Container():    Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: width/3,
                                height: 3,
                                color: sh_colorPrimary,
                              ) ,
                              Container(
                                width: width-(width/3),
                                height: 3,
                                color: sh_textColorSecondarylight,
                              )

                            ],
                          ),


                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                error_message.isEmpty?Container():    Container(

                                  child: Text("Note : "+error_message,style: TextStyle(color: Colors.red, fontSize: 15),),
                                  padding: EdgeInsets.all(5),
                                  width: width-35,

                                ),

                                widget.isEditDeler==false?Container():Row(

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text("Dealer"),
                                        leading: Radio(
                                          value: 1,

                                          groupValue: val,
                                          onChanged: (value) {
                                            setState(() {
                                              val=value;
                                              widget.dealersDetsils.dealerType=val;

                                            });
                                          },
                                          activeColor:sh_colorPrimary,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text("Retailer\nCustomer"),
                                        leading: Radio(

                                          value: 2,
                                          groupValue: val,
                                          onChanged: (value) {
                                            setState(() {
                                              val=value;
                                              widget.dealersDetsils.dealerType=val;






                                            });
                                          },
                                          activeColor: sh_colorPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                                SizedBox(height: 15,),
                                widget.dealer_type=="1"?Text("Firm Name *"):Text("Retail Cutomer Name *"),
                                SizedBox(height: 10,),


                                Container(


                                  child: SizedBox(
                                      height: height_textFormfiled,
                                      child:

                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        autofocus: false,
                                        // CHANGES
                                        readOnly:  widget.isEditDeler?(isdealerNameEdit?false:true):false,
                                        initialValue: dealerName,



                                        onChanged: (value){

                                          setState(() {
                                            dealerName=value;
                                            widget.dealersDetsils.name=value;
                                          });

                                        },

                                        textCapitalization: TextCapitalization.words,
                                        style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),

                                        decoration: InputDecoration(

                                            filled: true,
                                            fillColor: backgroundSearchProductFormInput,
                                            focusColor: sh_editText_background_active,
                                            hintText:"",
                                            hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                            // contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                      )


                                  ),




                                  decoration: BoxDecoration(

                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),

                                ),


                                SizedBox(height: 15,),
                                Text("Contact Person"),
                                SizedBox(height: 10,),
                                Container(

                                  //   width: 100,
                                  child:
                                  SizedBox(
                                    height: height_textFormfiled,
                                    child:
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      readOnly:  widget.isEditDeler?(iscontactPersonEdit?false:true):false,
                                      initialValue: contactPerson,
                                      onChanged: (value){
                                        setState(() {
                                          contactPerson=value;
                                          widget.dealersDetsils.contact=value;
                                        });


                                      },

                                      textCapitalization: TextCapitalization.words,
                                      style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                      decoration: InputDecoration(

                                          filled: true,
                                          fillColor: backgroundSearchProductFormInput,
                                          focusColor: sh_editText_background_active,
                                          hintText:"",
                                          hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                    ),),
                                  decoration: BoxDecoration(

                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),

                                ),


                                SizedBox(height: 15,),
                                Text("Email"),
                                SizedBox(height: 10,),
                                Container(

                                  //   width: 100,
                                  child:
                                  SizedBox(
                                      height: height_textFormfiled,
                                      child:
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        autofocus: false,
                                        initialValue: email,
                                        onChanged: (value){




                                          setState(() {
                                            email=value;
                                            widget.dealersDetsils.email=value;
                                          });


                                          if (email.isNotEmpty&&!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(email)) {
                                            // showToastDialog(context, "Please enter a valid email ");
                                            setState(() {
                                              isValidemail=false;
                                            });



                                          }
                                          else
                                          {
                                            setState(() {
                                              isValidemail=true;
                                            });

                                          }
                                        },

                                        //textCapitalization: TextCapitalization.words,
                                        style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                        decoration: InputDecoration(

                                            filled: true,
                                            fillColor: backgroundSearchProductFormInput,
                                            focusColor: sh_editText_background_active,
                                            hintText:"",
                                            hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                      )),
                                  decoration: BoxDecoration(

                                    border: Border.all(color:
                                    isValidemail? sh_textColorSecondarylight:Colors.red,
                                      width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),

                                ),
                                isValidemail?Container():Text("Email Invalid",style: TextStyle(color: Colors.red, fontFamily: fontRegular, fontSize: textSizeSmall),),

                                widget.isEditDeler?Container():  SizedBox(height: 15,),
                                widget.isEditDeler?Container():  Text("Password *"),
                                widget.isEditDeler?Container():   SizedBox(height: 10,),
                                widget.isEditDeler?Container():  Container(

                                  //   width: 100,
                                  child:
                                  SizedBox(
                                      height: height_textFormfiled,
                                      child:
                                      TextFormField(
                                        keyboardType: TextInputType.text,

                                        autofocus: false,
                                        obscureText: _obscureText,
                                        onChanged: (value){
                                          setState(() {
                                            password=value;
                                          });


                                        },

                                        textCapitalization: TextCapitalization.words,
                                        style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: _toggle,
                                              icon:_obscureText? Icon(Icons.visibility_off,size: 15,color: sh_textColorSecondary,):Icon(Icons.visibility,size: 15,color: sh_colorPrimary,),
                                            ),

                                            filled: true,
                                            fillColor: backgroundSearchProductFormInput,
                                            focusColor: sh_editText_background_active,
                                            hintText:"",
                                            hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                      )),
                                  decoration: BoxDecoration(

                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),

                                ),

                                SizedBox(height: 15,),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Phone"),
                                        SizedBox(height: 10,),
                                        Container(

                                          width: (width/2)-25,
                                          child: SizedBox(
                                              height: height_textFormfiled,
                                              child:
                                              TextFormField(

                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  new LengthLimitingTextInputFormatter(10),
                                                ],

                                                // keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                // inputFormatters: [
                                                //   new LengthLimitingTextInputFormatter(10),
                                                // ],
                                                autofocus: false,
                                                initialValue: phone,

                                                // CHANGES
                                                readOnly:  widget.isEditDeler?(isPhoneEdit?false:true):false,

                                                onChanged: (value){

                                                  setState(() {
                                                    phone=value.replaceAll(".", "");
                                                    widget.dealersDetsils.phone=phone;
                                                  });

                                                  if(phone.isNotEmpty&&phone.length!=10)
                                                  {
                                                    // showToastDialog(context, "Mobile no should be 10 Digits ");
                                                    setState(() {
                                                      isValidphone=false;

                                                    });

                                                  }
                                                  else
                                                  {
                                                    setState(() {
                                                      isValidphone=true;
                                                    });
                                                  }

                                                },

                                                textCapitalization: TextCapitalization.words,
                                                style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                                decoration: InputDecoration(

                                                    filled: true,
                                                    fillColor: backgroundSearchProductFormInput,
                                                    focusColor: sh_editText_background_active,
                                                    hintText:"",
                                                    hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                                    contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                              )),
                                          decoration: BoxDecoration(

                                            border: Border.all(color:
                                            isValidphone?sh_textColorSecondarylight:Colors.red,
                                              width: 1,),
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          ),

                                        ),
                                        isValidphone?Container():Text("Phone no Invalid",style: TextStyle(color: Colors.red, fontFamily: fontRegular, fontSize: textSizeSmall),),
                                      ],
                                    ),
                                    SizedBox(width: 10,),

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Fax"),
                                        SizedBox(height: 10,),
                                        Container(

                                          width: (width/2)-25,
                                          child:  SizedBox(
                                              height: height_textFormfiled,
                                              child:
                                              TextFormField(
                                                autofocus: false,

                                                // keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                // inputFormatters: [
                                                //   new LengthLimitingTextInputFormatter(20),
                                                // ],
                                                // readOnly: widget.isEditDeler?(isFaxEdit?false:true):false,
                                                keyboardType: TextInputType.text,
                                                initialValue: fax,
                                                onChanged: (value){

                                                  setState(() {
                                                    fax=value;
                                                    widget.dealersDetsils.fax=value;
                                                    print("Fax >>>>>>>> "+value);
                                                  });

                                                },

                                                textCapitalization: TextCapitalization.words,
                                                style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                                decoration: InputDecoration(

                                                    filled: true,
                                                    fillColor: backgroundSearchProductFormInput,
                                                    focusColor: sh_editText_background_active,
                                                    hintText:"",
                                                    hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                                    contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                              )),
                                          decoration: BoxDecoration(

                                            border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          ),

                                        ),
                                      ],
                                    )



                                  ],
                                ),

                                SizedBox(height: 15,),
                                Text("Address",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),

                                SizedBox(height: 15,),
                                Text("Address Line 1 *"),
                                SizedBox(height: 10,),
                                Container(

                                  //   width: 100,
                                  child:
                                  SizedBox(
                                      height: height_textFormfiled,
                                      child:
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        inputFormatters: <TextInputFormatter>[
                                          new LengthLimitingTextInputFormatter(50),
                                        ],
                                        autofocus: false,
                                        initialValue: address,
                                        // readOnly: widget.isEditDeler,
                                        onChanged: (value){

                                          setState(() {
                                            address=value;
                                            widget.dealersDetsils.address=address;
                                          });

                                        },

                                        textCapitalization: TextCapitalization.words,
                                        style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                        decoration: InputDecoration(

                                            filled: true,
                                            fillColor: backgroundSearchProductFormInput,
                                            focusColor: sh_editText_background_active,
                                            hintText:"",
                                            hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                      )),
                                  decoration: BoxDecoration(

                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),

                                ),

                                SizedBox(height: 15,),
                                Text("Address Line 2 "),
                                SizedBox(height: 10,),
                                Container(

                                  //   width: 100,
                                  child: SizedBox(
                                      height: height_textFormfiled,
                                      child:
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        autofocus: false,
                                        initialValue: address2,

                                        onChanged: (value){
                                          setState(() {
                                            address2=value;
                                            widget.dealersDetsils.address2=address2;
                                          });


                                        },

                                        textCapitalization: TextCapitalization.words,
                                        style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                        decoration: InputDecoration(

                                            filled: true,
                                            fillColor: backgroundSearchProductFormInput,
                                            focusColor: sh_editText_background_active,
                                            hintText:"",
                                            hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                      )),
                                  decoration: BoxDecoration(

                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),

                                ),


                                SizedBox(height: 15,),

                                Text("States *"),
                                SizedBox(height: 10,),
                                widget.isEditDeler ? Container(
                                  height: height_textFormfiled,
                                  child: TextFormField(

                                    initialValue: widget.dealersDetsils.state.name,

                                    decoration: InputDecoration(
                                      filled: true,

                                      fillColor: backgroundSearchProductFormInput,
                                      focusColor: sh_editText_background_active,


                                      hintText: "Search States",
                                      hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                      // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0)

                                      ),),
                                    // focusNode: focusNode,
                                    // CHANGES
                                    readOnly: widget.isEditDeler? (isStateEdit?false:true):false,

                                  ),

                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                ) :
                                Container(
                                  child:Autocomplete(
                                    initialValue:  widget.isEditDeler? TextEditingValue(text: widget.dealersDetsils.state.name):TextEditingValue(text: ""),

                                    optionsBuilder: (TextEditingValue value) {
                                      // When the field is empty
                                      if (value.text.isEmpty) {
                                        return [];
                                      }

                                      // The logic to find out which ones should appear
                                      return spinnerAllStatesList.where((suggestion) => suggestion.toString()
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

                                          prefixIcon:
                                          Icon(Icons.search,color:sh_colorPrimary,size: 20,),// widget.isEditDeler ? Container() : Icon(Icons.search,color:sh_colorPrimary,size: 20,),
                                          fillColor: backgroundSearchProductFormInput,
                                          focusColor: sh_editText_background_active,

                                          hintText: "Search States",
                                          hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0)

                                          ),),
                                        focusNode: focusNode,
                                        // CHANGES
                                        readOnly: widget.isEditDeler? (isStateEdit?false:true):false,
                                        onFieldSubmitted: (String value) {
                                          onFieldSubmitted();
                                          print('You just typed a new entry  $value');

                                        },
                                      );
                                    },

                                    onSelected: (value) {
                                      setState(() {
                                        selectedStates = value;


                                        print("Selected State Value is "+selectedStates.toString());



                                        final index = AllStatesList.indexWhere((element) =>
                                        element.name == selectedStates);
                                        stateCode = AllStatesList[index].code;
                                        state=stateCode;

                                        widget.dealersDetsils.state.name=AllStatesList[index].name;
                                        widget.dealersDetsils.state.code=AllStatesList[index].code;
                                        widget.dealersDetsils.state.country=AllStatesList[index].country.name;



                                        print("Selected State code is "+stateCode.toString());







                                      });
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),

                                ),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //       // Column(
                                //       //   mainAxisAlignment: MainAxisAlignment.start,
                                //       //   crossAxisAlignment: CrossAxisAlignment.start,
                                //       //   children: [
                                //       //     Text("State *"),
                                //       //     SizedBox(height: 10,),
                                //       //     Container(
                                //       //
                                //       //       width: (width/2)-25,
                                //       //       child:
                                //       //       SizedBox(
                                //       //         height: height_textFormfiled,
                                //       //         child:
                                //       //       TextFormField(
                                //       //         keyboardType: TextInputType.text,
                                //       //         autofocus: false,
                                //       //         onChanged: (value){
                                //       //
                                //       //           setState(() {
                                //       //             state=value;
                                //       //           });
                                //       //
                                //       //         },
                                //       //
                                //       //         textCapitalization: TextCapitalization.words,
                                //       //         style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                //       //         decoration: InputDecoration(
                                //       //
                                //       //             filled: true,
                                //       //             fillColor: backgroundSearchProductFormInput,
                                //       //             focusColor: sh_editText_background_active,
                                //       //             hintText:"",
                                //       //             hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                //       //             contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                //       //             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                //       //             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                //       //       )),
                                //       //       decoration: BoxDecoration(
                                //       //
                                //       //         border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                //       //         borderRadius: BorderRadius.all(Radius.circular(5)),
                                //       //       ),
                                //       //
                                //       //     ),
                                //       //
                                //       //   ],
                                //       // ),
                                //       SizedBox(width: 0,),
                                //
                                //       Column(
                                //         mainAxisAlignment: MainAxisAlignment.start,
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           Text("City"),
                                //           SizedBox(height: 10,),
                                //           Container(
                                //
                                //
                                //             child:
                                //             SizedBox(
                                //               height: height_textFormfiled,
                                //               child:
                                //               SizedBox(
                                //                   height: height_textFormfiled,
                                //                   child:
                                //             TextFormField(
                                //               keyboardType: TextInputType.text,
                                //               autofocus: false,
                                //               onChanged: (value){
                                //                 setState(() {
                                //                   city=value;
                                //                 });
                                //
                                //
                                //               },
                                //
                                //               textCapitalization: TextCapitalization.words,
                                //               style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                //               decoration: InputDecoration(
                                //
                                //                   filled: true,
                                //                   fillColor: backgroundSearchProductFormInput,
                                //                   focusColor: sh_editText_background_active,
                                //                   hintText:"",
                                //                   hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                //                   contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                //                   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                //                   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                //             ))),
                                //             decoration: BoxDecoration(
                                //
                                //               border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                //               borderRadius: BorderRadius.all(Radius.circular(5)),
                                //             ),
                                //
                                //           ),
                                //         ],
                                //       )
                                //
                                //
                                //
                                //   ],
                                // ),

                                SizedBox(height: 15,),
                                Text("City"),
                                SizedBox(height: 10,),
                                Container(


                                  child:
                                  SizedBox(
                                      height: height_textFormfiled,
                                      child:
                                      SizedBox(
                                          height: height_textFormfiled,
                                          child:
                                          TextFormField(
                                            keyboardType: TextInputType.text,
                                            autofocus: false,
                                            initialValue: city,
                                            readOnly: widget.isEditDeler?(isCityEdit?false:true):false,
                                            onChanged: (value){
                                              setState(() {
                                                city=value;
                                                widget.dealersDetsils.city = city;

                                              });


                                            },

                                            textCapitalization: TextCapitalization.words,
                                            style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                            decoration: InputDecoration(

                                                filled: true,
                                                fillColor: backgroundSearchProductFormInput,
                                                focusColor: sh_editText_background_active,
                                                hintText:"",
                                                hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                                contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                          ))),
                                  decoration: BoxDecoration(

                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),

                                ),




                                SizedBox(height: 15,),
                                Text("Post code"),
                                SizedBox(height: 10,),
                                Container
                                  (

                                  //   width: 100,
                                  child:  SizedBox(
                                      height: height_textFormfiled,
                                      child:
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly,
                                          new LengthLimitingTextInputFormatter(6),
                                        ],

                                        // keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                        // inputFormatters: [
                                        //   new LengthLimitingTextInputFormatter(6),
                                        // ],
                                        autofocus: false,
                                        initialValue:postcode,
                                        onChanged: (value){

                                          setState(() {
                                            postcode=value;
                                            widget.dealersDetsils.zipcode=postcode;

                                          });

                                        },

                                        textCapitalization: TextCapitalization.words,
                                        style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: backgroundSearchProductFormInput,
                                            focusColor: sh_editText_background_active,
                                            hintText:"",
                                            hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                      )),
                                  decoration: BoxDecoration(

                                    border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),

                                ),

                                // MERGE CODE OF PAYMENT DETAILS PAGE
                                // SizedBox(height: 15,),
                                //
                                // Container(),


                                SizedBox(height: 15,),
                                widget.isEditDeler?
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // InkWell(onTap: (){
                                      //
                                      // },
                                      //     child: Container(
                                      //       width: ((width/2)-20),
                                      //       padding: EdgeInsets.all(10.0),
                                      //       child: Text("Cancel", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.red,
                                      //         borderRadius: BorderRadius.all(
                                      //           Radius.circular(5),
                                      //
                                      //         ),
                                      //
                                      //       ),
                                      //     )
                                      // ),

                                      InkWell(
                                          onTap: ()
                                          async  {


                                            if(dealerName.isEmptyOrNull)
                                            {
                                              print("Please Enter Dealer Name");
                                              showToastDialog(context,"Please Enter Name");

                                            }

                                            else   if(email.isEmpty&&phone.isEmpty)
                                            {
                                              showToastDialog(context,"Please enter either email or phone no.");
                                            }

                                            else if (email.isNotEmpty&&!RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(email)) {
                                              showToastDialog(context, "Please enter a valid email ");

                                            }
                                            else if(phone.isNotEmpty&&(phone.length!=10||!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(phone)))
                                            {
                                              showToastDialog(context, "Phone no is invalid ");
                                            }


                                            else if(address.isEmptyOrNull){
                                              showToastDialog(context, "Please select address ");


                                            }
                                            else if(state.isEmptyOrNull)
                                            {
                                              print("Please Select State");
                                              showToastDialog(context,"Please Select State");
                                            }
                                            else if(postcode.isNotEmpty&&postcode.length<6)
                                            {

                                              print("Post Code should be 6 digits");
                                              showToastDialog(context,"Post Code should be 6 digits");
                                            }
                                            else if(postcode.isNotEmpty&&!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(postcode))
                                            {

                                              showToastDialog(context, "Please eneter digits in Post code ");

                                            }
                                            else
                                            {

                                              flagAddDealer=true;
                                              showAlertDialog(context);

                                            }


                                          },
                                          child: Container(
                                            width: (width-35),
                                            padding: EdgeInsets.all(10.0),
                                            child: Text("UPDATE", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
                                            decoration: BoxDecoration(
                                              color: sh_colorPrimary,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),

                                              ),

                                            ),

                                          )
                                      ),
                                    ],
                                  ),
                                ):
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // InkWell(onTap: (){
                                      //
                                      // },
                                      //     child: Container(
                                      //       width: ((width/2)-20),
                                      //       padding: EdgeInsets.all(10.0),
                                      //       child: Text("Cancel", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.red,
                                      //         borderRadius: BorderRadius.all(
                                      //           Radius.circular(5),
                                      //
                                      //         ),
                                      //
                                      //       ),
                                      //     )
                                      // ),

                                      InkWell(
                                          onTap: ()
                                          async  {


                                            if(dealerName.isEmptyOrNull)
                                            {
                                              print("Please Enter Dealer Name");
                                              showToastDialog(context,"Please Enter Name");

                                            }

                                            else   if(email.isEmpty&&phone.isEmpty)
                                            {
                                              showToastDialog(context,"Please enter either email or phone no.");
                                            }

                                            else if (email.isNotEmpty&&!RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(email)) {
                                              showToastDialog(context, "Please enter a valid email ");

                                            }
                                            else    if(password.isEmpty)
                                            {
                                              showToastDialog(context, "Please Enter Password");
                                            }
                                            else if(password.length<8)
                                            {
                                              showToastDialog(context, "Password should be 8 digits");

                                            }
                                            else if(phone.isNotEmpty&&(phone.length!=10||!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(phone)))
                                            {
                                              showToastDialog(context, "Phone no is invalid ");
                                            }


                                            else if(address.isEmptyOrNull){
                                              showToastDialog(context, "Please select address ");


                                            }
                                            else if(state.isEmptyOrNull)
                                            {
                                              print("Please Select State");
                                              showToastDialog(context,"Please Select State");
                                            }
                                            else if(postcode.isNotEmpty&&postcode.length<6)
                                            {

                                              print("Post Code should be 6 digits");
                                              showToastDialog(context,"Post Code should be 6 digits");
                                            }
                                            else if(postcode.isNotEmpty&&!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(postcode))
                                            {

                                              showToastDialog(context, "Please eneter digits in Post code ");

                                            }
                                            else
                                            {




                                              setState(() {
                                                prefs.setString("error_message","");
                                                error_message=prefs.getString("error_message");
                                              });
                                              String result =  await   Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentTermsForm(widget.dealer_type,dealerName,contactPerson,email,password,phone,fax,address,address2,state,city,postcode,false,null)));

                                              print("Result come from previous screen    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $result");

                                              setState(() {
                                                error_message=prefs.getString("error_message");
                                              });
                                              _scrollToTop();











                                            }


                                          },
                                          child: Container(
                                            width: (width-35),
                                            padding: EdgeInsets.all(10.0),
                                            child: Text("Next", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
                                            decoration: BoxDecoration(
                                              color: sh_colorPrimary,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),

                                              ),

                                            ),

                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 15,),

                              ],
                            ),
                          ),

                        ],
                      )
                  ),

                )),
          ),
          endDrawer: MyDrwaer(),
        ));
  }

  showToastDialog(BuildContext context,String Message)
  {


    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return   MediaQuery(
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



            ),
          );
        });

  }
}
