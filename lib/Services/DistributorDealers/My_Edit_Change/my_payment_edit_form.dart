import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/DistributorDealers/Models/PaymentTermsData.dart';
import 'package:rosetta_fluter_app/rosetta/models/DealersDetails.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';
import 'package:http/http.dart' as http;
import '../../../main/utils/AppColors.dart';
import '../../../main/utils/AppWidget.dart';
import '../../../rosetta/models/AddDealerError.dart';
import '../../../rosetta/models/MasterData.dart';
import '../../../rosetta/utils/ShColors.dart';
import '../../../rosetta/utils/ShConstant.dart';
import '../../../rosetta/utils/ShFunction.dart';
import '../../../rosetta/utils/ShImages.dart';
import '../../Distributor/SelectProductPlaceOrder.dart';
import '../TaxInformationForm.dart';
import '../ViewDealers.dart';
import 'my_personaldeail_edit.dart';
import 'my_text_edit_form.dart';

//import 'ViewDealers.dart';
SharedPreferences prefs;

class MyPaymentTermsForm extends StatefulWidget {

  String dealer_type="";
  String dealerName="",contactPerson="",email="",password="",phone="",fax="",address="",address2="",state="",city="",postcode="";
  String  paymentTerms="",paymentMethod="",credit_limit="2000",overdueBalance="0";
  bool isEditDeler;
  DealersDetsils dealersDetsils;

  MyPaymentTermsForm(
      this.dealer_type,
      this.dealerName,
      this.contactPerson,
      this.email,
      this.password,
      this.phone,
      this.fax,
      this.address,
      this.address2,
      this.state,
      this.city,
      this.postcode,
      this.isEditDeler,
      this.dealersDetsils

      );

  @override
  _MyPaymentTermsFormState createState() => _MyPaymentTermsFormState();
}

class _MyPaymentTermsFormState extends State<MyPaymentTermsForm> {
  bool isPtermsSelected = false;
  bool isPMethodeSelected = false;
  var checkNetconnection=null;
  String MyToken;
  String MyUserName="";
  String MyCompanyId;
  String MyMemberId;
  String MyMemberType;
  String  Myparent_distributor_id;
  String  Myparent_distributor_nav_id;
  var newJsonData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<PaymentTerms> payment_term_list=[];
  List<String> spinnerAllPaymentTerms = [];
  String selected_PaymentTerms="PaymentTerms";


  List<PaymentMethod> payment_methode_list=[];
  List<String> spinnerAllPaymentMethod = [];
  String selected_PaymentMethod="Payment Method";


  String defaultPaymentTerms  = "";//spinnerAllPaymentTerms[1]

  @override
  void dispose() {
    super.dispose();
  }


  getSessionData() async
  {
    print("Get Session Methode Call");
    prefs = await SharedPreferences.getInstance();


    if(widget.isEditDeler==false)
    {
      setAllData();
    }








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

        getAllDataMaster();

      }
      if(checkNetconnection!=null)
      {
        print("Please check your Internet Connection ");
        // showAlertStockDialog(context);
        //interNetPopup();
      }
    }
  }

  setAllData(){


    setState(() {

      widget.credit_limit =  prefs.getString("credit_limit");
      widget.overdueBalance =  prefs.getString("overdueBalance");
      selected_PaymentMethod=widget.paymentMethod;
      selected_PaymentTerms=widget.paymentTerms;


      print("paymentTerms   >>>>>>>>>>  "+widget.paymentTerms);







    });
  }



  bool isOverDueEdit =false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();







    if(widget.isEditDeler)
    {

      setState(()
      {
        isPMethodeSelected=true;


        print("G>>>>>>>>>>>>>>>>>>>>>>>"+widget.dealersDetsils.toString());
        widget.paymentMethod=widget.dealersDetsils.paymentMethod.key==null?"":widget.dealersDetsils.paymentMethod.key;
        widget.credit_limit=widget.credit_limit==null?"":widget.dealersDetsils.creditLimit.toString();
        widget.overdueBalance=widget.dealersDetsils.overdueBalance==null?"":widget.dealersDetsils.overdueBalance.toString();

        //  print("PAN Status >>>>>>>>>>>>>> "+widget.dealersDetsils.taxInformation.pan.status.toString());










        if(widget.dealersDetsils.paymentTerms.key!=null||widget.dealersDetsils.paymentTerms.key!="")
        {
          selected_PaymentTerms=widget.dealersDetsils.paymentTerms.key;
          widget.paymentTerms=widget.dealersDetsils.paymentTerms.key==null?"":widget.dealersDetsils.paymentTerms.key;

        }
        if(widget.dealersDetsils.paymentMethod.key!=null&&widget.dealersDetsils.paymentMethod.key!="")
        {
          selected_PaymentMethod=widget.dealersDetsils.paymentMethod.key;

        }

        if(widget.dealersDetsils.taxInformation.pan.status?.value.toString().isEmptyOrNull)
        {
          print("Pan Status null >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
        }
        else
        {
          print("Pan Status >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
        }


        //widget.dealersDetsils.fax.toString()



        if(widget.dealersDetsils.overdueBalance==0)
        {
          setState(() {

            isOverDueEdit=true;

          });
        }

        print("Selected Terms >>>>>>>>>>>>>>>>>>>>> "+selected_PaymentTerms);




      });
    }
    else
    {
      setState(() {
        isPMethodeSelected=false;
        print("**&&&&&");

      });
    }

    //print("Payment Term Form Dealer Name "+widget.dealerName+"  "+widget.contactPerson+""+widget.email+""+widget.password+""+widget.phone+""+widget.fax+""+widget.address+""+widget.address2+""+widget.state+""+widget.city+""+widget.postcode+"");
    getSessionData();






    print("Data of Payment Methode "+selected_PaymentMethod);
    print("Data of Payment Terms "+selected_PaymentTerms);
    var x = spinnerAllPaymentMethod.isNotEmpty?isPMethodeSelected? selected_PaymentMethod:widget.paymentMethod:selected_PaymentMethod;
    var y =spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms;
    print("Data of Payment Methode $x");
    print("Data of Payment Terms $y");




  }

  getAllDataMaster() async {

    print("Get All Data Master Api Call >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
    http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL+'/api/master'),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );
    var responcebody = response.body;
    var responseCode = response.statusCode;
    print("Response Body of Form Get All Data Master Api Call  Data Api : $responcebody");
    print("Response code Form Get All Data Master Api Call  Data Api : $responseCode");
    if(responseCode==200){


      setState(()
      {
        var data = json.decode(responcebody);


        var rest = data["payment_terms"] as List;
        payment_term_list = rest.map<PaymentTerms>((json) => PaymentTerms.fromJson(json)).toList();
        print("Shipping Methode List  Length >>>>>>>  "+payment_term_list.length.toString());
        getSpinnerAllPaymentTerms();



        var rest2 = data["payment_method"] as List;
        payment_methode_list = rest2.map<PaymentMethod>((json) => PaymentMethod.fromJson(json)).toList();
        print("Shipping Methode List  Length >>>>>>>  "+payment_methode_list.length.toString());
        getSpinnerAllPaymentMethodes();



      });












      // ignore: missing_return








    }
  }
  getSpinnerAllPaymentTerms () async {


    print("Get spinnerAllPaymentTerms  List Methode Call");

    String value = prefs.getString("paymentTerms");

    print("A Payment Terms >>>>>>>>>>>>>>>>>>>  "+value.toString());

    var length = payment_term_list.length;
    print(" Spinner spinnerAllPaymentTerms  lsi length is $length");

    for(int i=0;i<payment_term_list.length;i++)
    {
      var displayname;
      print(" Spinner Sates List  Loop is Called ");
      setState(() {


        if(i==0)
        {

          spinnerAllPaymentTerms.add("PaymentTerms");


          spinnerAllPaymentTerms.add(payment_term_list[i].key);
          displayname = spinnerAllPaymentTerms[i];

        }
        else
        {
          spinnerAllPaymentTerms.add(payment_term_list[i].key);
          displayname = spinnerAllPaymentTerms[i];
        }

        ///SelectedDealer2=spinnerSelectDealer2[0];
      });





      print(" Spinner Dealer List   Name $displayname");
    }





    if(prefs.getString("paymentTerms").isEmptyOrNull)
    {
      widget.paymentTerms = spinnerAllPaymentTerms[1];
    }
    else
    {
      widget.paymentTerms = prefs.getString("paymentTerms");
    }





    print("Length of Spinner All States length is "+spinnerAllPaymentTerms.length.toString()+"   "+ widget.paymentTerms);
  }
  getSpinnerAllPaymentMethodes () async {


    print("Get spinnerAllPaymentTerms  List Methode Call");

    var length = payment_methode_list.length;
    print(" Spinner spinnerAllPaymentTerms  lsi length is $length");

    for(int i=0;i<payment_methode_list.length;i++)
    {
      var displayname;
      print(" Spinner Sates List  Loop is Called ");
      setState(() {
        if(i==0)
        {

          spinnerAllPaymentMethod.add("Payment Method");

          spinnerAllPaymentMethod.add(payment_methode_list[i].key);
          displayname = spinnerAllPaymentMethod[i];


        }
        else
        {
          spinnerAllPaymentMethod.add(payment_methode_list[i].key);
          displayname = spinnerAllPaymentMethod[i];
        }

        ///SelectedDealer2=spinnerSelectDealer2[0];
      });


      print(" Spinner Dealer List   Name $displayname");
    }

    //widget.paymentMethod=spinnerAllPaymentMethod[1];


    if(prefs.getString("paymentTerms").isEmptyOrNull)
    {

      widget.paymentMethod=spinnerAllPaymentMethod[1];
    }
    else
    {
      widget.paymentMethod = prefs.getString("paymentMethod");
    }



    print("Length of Spinner All States length is "+spinnerAllPaymentMethod.length.toString()+"  "+widget.paymentMethod);
  }



  bool flagAddDealer =true;
  Future<int> addDealerMethode() async {

    print("Add Dealer  Api Call " );

    newJsonData = {
      "dealer_type": "1",
      "distributorId": 103,
      "companyId": 3,
      "name": "TestDlrG",
      "contact": "Haider",
      "address": "Clover Center",
      "address2": "Camp",
      "state": "MAH",
      "city": "Pune",
      "zipcode": "411001",
      "paymentTerms": "1 MONTH",
      "paymentMethod": "AS AGREED",
      "credit_limit": "50000",
      "phone": "8987889876",
      "email": "testdlrg1@test.com",
      "password": "passw0rd!",
      "fax": "",
      "tax_information": {
        "gst": {
          "customer_type": "Registered",
          "registration_type": "GSTIN",
          "number": "27ACEPH9757K1Z1"
        },
        "pan": {
          "number": "",
          "status": "",
          "reference_number": ""
        }
      },
      "overdue_balance": 0,
      "user": {
        "email": "testdlr88@test.com",
        "phone": "8917689819",
        "password": "passw0rd!"
      }
    };

    var res = await http.post(Uri.parse(API_ROS_PROD__BASE_URL +
        '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers'),
        body: jsonEncode(newJsonData),
        headers: {
          'Authorization': 'bearer $MyToken',
          'Content-Type': 'application/json'
        }
    );

    print("Add Dealer  Api Status Code " + res.statusCode.toString());


  }




  int responseCode=0;
  bool closedialog = true;
  Future<int> editDealerMethode() async {
    // closedialog = true;
    //responseCode=0;

    print("Edit  Dealer  Api Call "+widget.dealersDetsils.id.toString() );

    //  String gst_number = widget.number;



    var gstJosnData;
    widget.dealer_type=widget.dealersDetsils.dealerType.toString();

    // if(widget.dealer_type=="2")
    // {
    //   gstJosnData={
    //     "customer_type": "Unregistered",
    //     "registration_type": "GSTIN",
    //     "number": ""
    //   };
    // }
    // else
    // {
    //   gstJosnData=  {
    //     "customer_type": widget.dealersDetsils.dealerType,
    //     "registration_type": "GSTIN",
    //     "number": widget.dealersDetsils.taxInformation.gst.number//27ACEPH9757K1Z1
    //   };
    // }



    if ( widget.dealersDetsils.taxInformation.gst.customerType == "Unregistered") {
      gstJosnData = {
        "customer_type": "Unregistered",// widget.dealersDetsils.taxInformation.gst.customerType.value,//"Unregistered",
        "registration_type": "GSTIN",
        "number": widget.dealersDetsils.taxInformation.gst.number  //widget.customer_type=="Unregistered"?"":widget.dealersDetsils.taxInformation.gst.number //""
      };
    } else {
      gstJosnData = {
        "customer_type": widget.dealersDetsils.taxInformation.gst.customerType.value,
        "registration_type": "GSTIN",
        "number":widget.dealersDetsils.taxInformation.gst.number
        //27ACEPH9757K1Z1
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
      "fax": widget.dealersDetsils.fax,//"",
      "tax_information":
      {
       // "gst": gstJosnData,

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
          "number": widget.dealersDetsils.taxInformation.pan.number,
          "status": widget.dealersDetsils.taxInformation.pan.status?.value==null?"":widget.dealersDetsils.taxInformation.pan.status?.value,
          "reference_number": widget.dealersDetsils.taxInformation.pan.referenceNumber
        }
      },
      "overdue_balance": widget.dealersDetsils.overdueBalance,
      "user": {
        "email": widget.dealersDetsils.email,
        "phone": widget.dealersDetsils.phone,

      }
    };


    print("JSON OF Edit DELAER >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  $newJsonData");


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


      var error_message="";
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

           key :  _scaffoldKey ,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),

              child: AppBar(
                backgroundColor: sh_white,
                automaticallyImplyLeading: false,
                titleSpacing: 0,

                iconTheme: IconThemeData(color: sh_textColorPrimary),
                actions: <Widget>[
                  // Padding(
                  //     padding: EdgeInsets.only(right: 10.0),
                  //     child: GestureDetector(
                  //       onTap: ()  {
                  //         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  MyPersonalDeatilsForm('1', true , null , dealersDetsils))) ;
                  //       },
                  //       child: Icon(
                  //         Icons.edit,
                  //         color: secondColor,
                  //         size: 26.0,
                  //       ),
                  //     )
                  // ),

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
                      child:  InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) =>  //MyDealersDeatails(widget.spinnerDelerList[index].toString())));
                          // ViewDealers(true)));
                           Navigator.of(context).pop();
                      //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>  MyPersonalDeatilsForm('1', true , null , widget.dealersDetsils))) ;
                        },

                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.black,
                          size: 23.0,
                        ),

                        // child: Icon(
                        //   Icons.arrow_back,
                        //   color: Colors.black,
                        //   size: 26.0,
                        // ),
                      ) ,


                    ),
                    SizedBox(width: 5,),
                    Container(

                        child: Text("Payment Details Update",style: TextStyle(color: sh_textColorPrimary,fontWeight: FontWeight.bold,fontSize: textSizeMedium),))

                  ],
                ),
                elevation: 1,
              )
            // child:widget.isEditDeler?MyAppBar(false,"Payment Details Update","",false,true):
            // MyAppBar2(false,"Add Customer","",false),
          ),
          body: SingleChildScrollView(
            child: Container(


                child: Column(
                  children: [
                    widget.isEditDeler?
                    Container(
                        color: sh_ColorPrimary2,
                        padding: EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [


                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>  MyPersonalDeatilsForm('1', true , null , widget.dealersDetsils))) ;
                              },
                              child: Container(
                               // height: 14,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary,),
                                        SizedBox(width: 3,),
                                        Text("Personal Details",style: TextStyle(fontSize: 13.0,color:sh_textColorSecondarylight2, ),),
                                      ],
                                    ),
                                      SizedBox(height:15,),
                                    Container(
                                      width:width/3,
                                      height: 3,
                                      color:sh_textColorSecondarylight,
                                    ) ,

                                  ],
                                ),
                              ),
                            ),
                            Container(
                             // height: 14,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(ic_nextenable,height:13,width: 13,color: secondColor,),
                                      SizedBox(width: 3,),
                                      Text("Payment",style: TextStyle(fontSize: 13.0,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    width: width/3,
                                    height: 3,
                                    color:  sh_colorPrimary,
                                  ),

                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyTextInformationForm(
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    "",
                                    true,
                                    widget.dealersDetsils
                                )));


                              },

                              child: Container(
                              //  height: 14,
                                child: Column(
                                  children: [
                                    Row(
                                        children: [
                                          Image.asset(ic_nextdisable,height:13,width: 13,color: secondColor),
                                          SizedBox(width: 3,),
                                          Text("Tax Information",style: TextStyle(fontSize: 13.0,color:sh_textColorSecondarylight2, ),),
                                        ]
                                    ),

                                    SizedBox(height: 15,),
                                    Container(
                                      width:width/3,
                                      height: 3,
                                      color:sh_textColorSecondarylight,
                                    ) ,
                                  ],
                                ),
                              ),
                            ),


                          ],
                        )

                    )
                        :Container(
                        color: sh_ColorPrimary2,
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [


                            Row(
                              children: [
                                Image.asset(ic_nextenable,height:13,width: 13,color: secondColor,),
                                SizedBox(width: 3,),
                                Text("Personal Details",style: TextStyle(fontSize: 13.0,color:sh_textColorSecondarylight2, ),),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(ic_nextenable,height:13,width: 13,color: sh_colorPrimary,),
                                SizedBox(width: 3,),
                                Text("Payment",style: TextStyle(fontSize: 13.0,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),


                              ],
                            ),
                            Row(
                                children: [
                                  Image.asset(ic_nextdisable,height:13,width: 13,color: secondColor),
                                  SizedBox(width: 3,),
                                  Text("Tax Information",style: TextStyle(fontSize: 13.0,color:sh_textColorSecondarylight2, ),),
                                ]
                            ),


                          ],
                        )

                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width:width/3,
                          height: 3,
                          color:Colors.transparent,//sh_textColorSecondarylight,
                        ) ,
                        Container(
                          width: width/3,
                          height: 3,
                          color: Colors.transparent,// sh_colorPrimary,
                        ),
                        Container(
                          width: width/3,
                          height: 3,
                          color: Colors.transparent//sh_textColorSecondarylight,
                        )

                      ],
                    ),



                    Container(
                      height: height-150,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              SizedBox(height: 15,),
                              Text("Payment Terms"),
                              SizedBox(height: 10,),
                              Container(

                                padding: EdgeInsets.only(left: 15,right: 10),

                                child:  new DropdownButton<String>(
                                  value: selected_PaymentTerms,
                                  // value:widget.isEditDeler?selected_PaymentTerms:
                                  // spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms,
                                  hint: new Text("",


                                  ),
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color:
                                    sh_textColorSecondary,
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




                                      isPtermsSelected=true;

                                      selected_PaymentTerms = value;
                                      widget.paymentTerms=value;

                                      // widget.dealersDetsils.paymentTerms.key=value;
                                      // widget.dealersDetsils.paymentTerms.value=value;

                                      if(widget.isEditDeler)
                                      {
                                        print("***1");
                                        widget.dealersDetsils.paymentTerms.key=value;
                                        widget.dealersDetsils.paymentTerms.value=value;
                                      }



                                      prefs.setString("paymentTerms", widget.paymentTerms);



                                    });
                                  },
                                  items: spinnerAllPaymentTerms
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
                                  color: Colors.white,

                                  border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),

                              ),



                              SizedBox(height: 15,),
                              Text("Payment Methods"),
                              SizedBox(height: 10,),
                              // widget.isEditDeler&&widget.dealersDetsils.paymentTerms.key.isNotEmpty?
                              //
                              //
                              // Container(
                              //   width: width,
                              //   child:Text(widget.dealersDetsils.paymentMethod.key,style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),),
                              //   padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              //   decoration: BoxDecoration(
                              //     color: Colors.blue,
                              //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                              //     borderRadius: BorderRadius.all(Radius.circular(5)),
                              //   ),
                              //
                              //
                              //
                              //
                              // )

                              // widget.isEditDeler&&widget.dealersDetsils.paymentTerms.key.isNotEmpty?
                              //
                              // Container(
                              //
                              //
                              //   padding: EdgeInsets.only(left: 15,right: 10),
                              //
                              //   child:  new DropdownButton<String>(
                              //     //spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms,
                              //
                              //     value:
                              //     widget.isEditDeler?selected_PaymentMethod:
                              //     spinnerAllPaymentMethod.isNotEmpty?
                              //     isPMethodeSelected? selected_PaymentMethod:widget.paymentMethod
                              //
                              //         :selected_PaymentMethod,
                              //
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
                              //
                              //         isPMethodeSelected=true;
                              //         selected_PaymentMethod = value;
                              //         widget.paymentMethod=value;
                              //         if(widget.isEditDeler)
                              //         {
                              //           print("***1");
                              //           widget.dealersDetsils.paymentMethod.key=value;
                              //           widget.dealersDetsils.paymentMethod.value=value;
                              //         }
                              //         else
                              //         {
                              //           print("***1");
                              //         }
                              //
                              //         prefs.setString("paymentMethod", widget.paymentMethod);
                              //
                              //
                              //
                              //       });
                              //     },
                              //     items: spinnerAllPaymentMethod
                              //         .map<DropdownMenuItem<String>>(
                              //             (String value) {
                              //           return DropdownMenuItem<String>(
                              //             value: value,
                              //             child: text(value,
                              //                 fontSize: textSizeSmall,
                              //                 fontFamily: fontRegular,
                              //                 textColor: sh_textColorSecondary),
                              //           );
                              //         }).toList(),
                              //   ),
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //
                              //     border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                              //     borderRadius: BorderRadius.all(Radius.circular(5)),
                              //   ),
                              //
                              // )
                              // //  Container(
                              // //    width: width,
                              // //    //height: 2,
                              // // //   child:Text(widget.dealersDetsils.paymentMethod.key,style: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),),
                              // //    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              // //    decoration: BoxDecoration(
                              // //     // color: Colors.blue,
                              // //      border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                              // //      borderRadius: BorderRadius.all(Radius.circular(5)),
                              // //    ),
                              // //    child:  new DropdownButton<String>(
                              // //      //spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms,
                              // //
                              // //      value:widget.isEditDeler?selected_PaymentMethod:
                              // //      spinnerAllPaymentMethod.isNotEmpty?isPMethodeSelected? selected_PaymentMethod:widget.paymentMethod:selected_PaymentMethod,
                              // //
                              // //      hint: new Text("Select Here"),
                              // //      isExpanded: true,
                              // //      icon: Icon(
                              // //        Icons.arrow_drop_down,
                              // //        color:
                              // //        sh_textColorSecondary,
                              // //        size: 25,
                              // //      ),
                              // //      iconSize: 24,
                              // //      elevation: 16,
                              // //      style: TextStyle(
                              // //        color: Colors.black,
                              // //        fontSize: 18,
                              // //      ),
                              // //      underline: Container(
                              // //        height: 2,
                              // //      ),
                              // //      onChanged: (String value) {
                              // //        setState(() {
                              // //
                              // //          isPMethodeSelected=true;
                              // //          selected_PaymentMethod = value;
                              // //          widget.paymentMethod=value;
                              // //          if(widget.isEditDeler)
                              // //          {
                              // //            print("***1");
                              // //            widget.dealersDetsils.paymentMethod.key=value;
                              // //            widget.dealersDetsils.paymentMethod.value=value;
                              // //          }
                              // //          else
                              // //          {
                              // //            print("***1");
                              // //          }
                              // //
                              // //          prefs.setString("paymentMethod", widget.paymentMethod);
                              // //
                              // //
                              // //
                              // //        });
                              // //      },
                              // //      items: spinnerAllPaymentMethod
                              // //          .map<DropdownMenuItem<String>>(
                              // //              (String value) {
                              // //            return DropdownMenuItem<String>(
                              // //              value: value,
                              // //              child: text(value,
                              // //                  fontSize: textSizeSmall,
                              // //                  fontFamily: fontRegular,
                              // //                  textColor: sh_textColorSecondary),
                              // //            );
                              // //          }).toList(),
                              // //    ),
                              // //
                              //
                              //
                              // //   )
                              //     :


                              Container(


                                padding: EdgeInsets.only(left: 15,right: 10),

                                child:  new DropdownButton<String>(
                                  //spinnerAllPaymentTerms.isNotEmpty?isPtermsSelected? selected_PaymentTerms:widget.paymentTerms:selected_PaymentTerms,

                                  value:selected_PaymentMethod,//widget.isEditDeler?selected_PaymentMethod:widget.paymentMethod,
                                  //spinnerAllPaymentMethod.isNotEmpty?isPMethodeSelected? selected_PaymentMethod:widget.paymentMethod:selected_PaymentMethod,

                                  hint: new Text("",
                                   // style: TextStyle(
                                   //   color: Colors.transparent
                                   // ),
                                  ),
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color:
                                    sh_textColorSecondary,
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

                                      isPMethodeSelected=true;
                                      selected_PaymentMethod = value;
                                      widget.paymentMethod=value;

                                      print("TTTTTTTTTTTTTTTTTTTTT DDDDDDDDDDDDDDDDDDDDDDdddd");
                                      print(selected_PaymentMethod);
                                      print(widget.paymentMethod);
                                      print(spinnerAllPaymentMethod);
                                      print(value);
                                      if(widget.isEditDeler)
                                      {
                                        print("***1");
                                        widget.dealersDetsils.paymentMethod.key=value;
                                        widget.dealersDetsils.paymentMethod.value=value;
                                      }
                                      else
                                      {
                                        print("***1");
                                      }

                                      prefs.setString("paymentMethod", widget.paymentMethod);



                                    });
                                  },
                                  items: spinnerAllPaymentMethod
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
                                  color: Colors.white,

                                  border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),

                              ),


                              SizedBox(height: 15,),
                              Text("Credit Limit *"),
                              SizedBox(height: 10,),
                              Container(

                                //   width: 100,
                                child:
                                SizedBox(
                                    height: height_textFormfiled,
                                    child:
                                    TextFormField(
                                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                      initialValue: widget.isEditDeler?widget.dealersDetsils.creditLimit.toString():widget.credit_limit,

                                      autofocus: false,
                                      onChanged: (value){

                                        setState(() {
                                          widget.credit_limit=value;



                                          widget.dealersDetsils.creditLimit=value.toInt();

                                          prefs.setString("credit_limit", widget.credit_limit);


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
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                    )),
                                decoration: BoxDecoration(

                                  border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),

                              ),


                              SizedBox(height: 15,),
                              Text("Overdue Balance"),
                              SizedBox(height: 10,),
                              Container(

                                //   width: 100,
                                child:
                                SizedBox(
                                    height: height_textFormfiled,
                                    child:
                                    TextFormField(
                                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                      initialValue: widget.isEditDeler?widget.dealersDetsils.overdueBalance.toString(): widget.overdueBalance,
                                      //readOnly: widget.isEditDeler?(isOverDueEdit?false:true):false,
                                      // widget.isEditDeler,
                                      autofocus: false,
                                      onChanged: (value){
                                        setState(() {
                                          widget.overdueBalance=value;
                                          widget.dealersDetsils.overdueBalance=value.toInt();
                                          prefs.setString("overdueBalance", widget.overdueBalance);
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
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0))),
                                    )),
                                decoration: BoxDecoration(

                                  border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),

                              ),


                            ],
                          ),

                          widget.isEditDeler?
                          Column(
                            children: [
                              Container(
                                width: (width-35),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [

                                     InkWell(onTap: () async {

                                       if(widget.credit_limit.isEmpty)
                                       {


                                         showToastDialog(context, "Please Enter Credit Limit");
                                       }

                                       else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.credit_limit))
                                       {

                                         showToastDialog(context, "Please enter digits in credit limits ");

                                       }
                                       else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.overdueBalance)&&widget.overdueBalance.isNotEmpty)
                                       {

                                         showToastDialog(context, "Please enter digits in overdue balance ");

                                       }
                                       else
                                       {

                                         flagAddDealer=true;
                                         showAlertDialog(context);


                                       }

                                       //   addDealerMethode();
                                     },
                                         child: Container(
                                           width: width/2 - 25,

                                           padding: EdgeInsets.all(10.0),
                                           child: Text("SAVE", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
                                           decoration: BoxDecoration(
                                             color: sh_colorPrimary,
                                             borderRadius: BorderRadius.all(
                                               Radius.circular(5),

                                             ),

                                           ),

                                         )
                                     ),

                                     InkWell(onTap: () async {

                                       if(widget.credit_limit.isEmpty)
                                       {


                                         showToastDialog(context, "Please Enter Credit Limit");
                                       }

                                       else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.credit_limit))
                                       {

                                         showToastDialog(context, "Please enter digits in credit limits ");

                                       }
                                       else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.overdueBalance)&&widget.overdueBalance.isNotEmpty)
                                       {

                                         showToastDialog(context, "Please enter digits in overdue balance ");

                                       }
                                       else
                                       {

                                         flagAddDealer=true;
                                         editDealerMethode().then((value) {
                                           setState((){
                                             responseCode=value;
                                           });
                                         });
                                             Navigator.push(context, MaterialPageRoute(builder: (context) => MyTextInformationForm(
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               "",
                                               true,
                                               widget.dealersDetsils
                                             )));


                                         // showAlertDialog(context);


                                       }

                                       //   addDealerMethode();
                                     },
                                         child: Container(
                                           width: width/2 - 25,

                                           padding: EdgeInsets.all(10.0),
                                           child: Text("Next", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
                                           decoration: BoxDecoration(
                                             color: sh_colorPrimary,
                                             borderRadius: BorderRadius.all(
                                               Radius.circular(5),

                                             ),

                                           ),

                                         )
                                     )




                                   ],


                                ),
                              )
                            ],
                          )








                              : Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(onTap: (){
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDeatilsForm()));
                                  FocusScope.of(context).unfocus();
                                  Navigator.of(context).pop();
                                },
                                    child: Container(
                                      width: ((width/2)-20),
                                      padding: EdgeInsets.all(10.0),
                                      child: Text("Previous", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
                                      decoration: BoxDecoration(
                                        color: sh_textColorSecondary,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),

                                        ),

                                      ),
                                    )
                                ),
                                SizedBox(width: 10.0,),
                                InkWell(onTap: () async {

                                  if(widget.credit_limit.isEmpty)
                                  {


                                    showToastDialog(context, "Please Enter Credit Limit");
                                  }

                                  else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.credit_limit))
                                  {

                                    showToastDialog(context, "Please enter digits in credit limits ");

                                  }
                                  else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(widget.overdueBalance)&&widget.overdueBalance.isNotEmpty)
                                  {

                                    showToastDialog(context, "Please enter digits in overdue balance ");

                                  }
                                  else
                                  {

                                    //  prefs.setString("paymentTerms", widget.paymentTerms);
                                    //prefs.setString("paymentMethod", widget.paymentMethod);
                                    prefs.setString("credit_limit", widget.credit_limit);
                                    prefs.setString("overdueBalance", widget.overdueBalance);

                                    var credeitLimis1= widget.credit_limit;
                                    var overduebalance= widget.overdueBalance;


                                    widget.credit_limit="";
                                    widget.overdueBalance="";

                                    var obj =   await Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        TextInformationForm(
                                        widget.dealer_type,
                                        widget.dealerName,
                                        widget.contactPerson,
                                        widget.address,
                                        widget.address2,
                                        widget.state,
                                        widget.city,
                                        widget.paymentTerms,
                                        widget.paymentMethod,
                                        credeitLimis1,
                                        widget.phone,
                                        widget.email,
                                        widget.password,
                                        widget.fax,
                                        overduebalance,
                                        widget.email,
                                        widget.phone,
                                        widget.password,
                                        widget.postcode,
                                        false,
                                        null


                                    ))) ;




                                    PaymentTermsData obj2 = obj as PaymentTermsData;

                                    // print("PaymentTerms Recived Data >>>>>>>>>>>>>>>>>>>>>>>>>>>"+obj2.creditLimits);

                                    setState(() {




                                    });

                                  }

                                  //   addDealerMethode();
                                },
                                    child: Container(
                                      width: ((width/2)-20),
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