import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/ApiHelper/ApiService.dart';
import 'package:rosetta_fluter_app/main/model/User.dart';
// import 'package:rosetta_fluter_app/integrations/utils/constants.dart';

import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/rosetta/models/SpinnerDealersList.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShFunction.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/session/SecureStorage.dart';

import '../rosetta/models/SkipButtonApi.dart';
import '../rosetta/models/Tenants.dart';
import 'Customer/CustomerDashboard.dart';

import 'Distributor/NewDistributorDashBoard.dart';
import 'SiginScreen.dart';
// import 'package:shop_hop/shopHop/screens/ShHomeScreen.dart';
// import 'package:shop_hop/shopHop/screens/ShSignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUpScreen.dart';


SharedPreferences prefs;

class LoginScreen extends StatefulWidget {
  static String tag = '/ShSignIn';

  @override
  ShSignInState createState() => ShSignInState();
}

class ShSignInState extends State<LoginScreen> {



  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  String selectedTenants="Select Location";
  List<String> spinnerSelectTenantsDetails = [];
  bool isNextButtonVisible=true;


  bool isVisibleSkip=false;

  bool isRGallery = false ;



  @override
  void initState() {

   // print("API_ROS_PROD__BASE_URL>>>>>>>>>>>>>>>>>>>>>>>>>"+API_ROS_PROD__BASE_URL);
    super.initState();


    isVisibleSkipApi();
    print("URL >>>>>>>>>>>>>>>>>>>>>>>>>>>  $API_ROS_PROD__BASE_URL");

    if(API_ROS_PROD__BASE_URL=="http://ros.rosettaproducts.com")
      {
        print("App >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Rosetta ");
        setState(() {
          isRGallery = false ;

        });
      }
    if(API_ROS_PROD__BASE_URL=="http://ros.r-gallery.in")
      {
        saveBaseUrl(API_ROS_PROD__BASE_URL);
        print("App >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> R Gallery  ");
        setState(() {
          isRGallery = true ;

        });
      }


    Future.delayed(Duration.zero, () {
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String cuurentTimeStamp  = formatter.format(now).toString();//2016-01-25
      print("myTimeStamp >>>>>>>>>>>>>>>>>>> "+prefs.getString("myTimeStamp").toString());
      print("cuurentTimeStamp >>>>>>>>>>>>>>>>>>> "+cuurentTimeStamp);
      bool isShowDialog = false;
      if(cuurentTimeStamp!=prefs.getString("myTimeStamp"))
      {
        prefs.setString("myTimeStamp", cuurentTimeStamp);

        myTimeStamp=cuurentTimeStamp;

        if(isRGallery)
        {
         // showToastDialogNoticeRGallery(context);
        }
        if(!isRGallery)
        {
         //  showToastDialogNotice(context);
        }

      }
      else
      {

      }
    });

  }



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


   /// EXCEPTION API TO TEST next  buton is not responsiv
  ///
  ///
  ///
  // getAllTenantsTesting() async
  // {
  //   print("getAllTenantsTesting >>>>>");
  //   //print("Get Tenants methode call >>>>>>>>>>>" + sendname +
  //      // API_ROS_PROD__BASE_URL_Tenants);
  //   String url = API_ROS_PROD__BASE_URL_Tenants + "/api/tenants?query=superadmin@aac.com";
  //
  //   final response = await http.get(Uri.parse(url));
  //
  //   print("Test Responce "+response.toString());
  //
  //
  // }

  List<Tenants> lsiTenannts=[];
  getAllTenants(String sendname) async
  {
       print("EST TEST EST EST TES ERROR ERROR ERROR");
       print("NEXT BUTTTON IS CLICKED ");
      print("Get Tenants methode call >>>>>>>>>>>"+sendname+API_ROS_PROD__BASE_URL_Tenants);
   String url = API_ROS_PROD__BASE_URL_Tenants+"/api/tenants?query=$sendname";
   // String url = "http://rosdev.rosettaproducts.com/api/tenants?query=$sendname";
   //    String url = "http://ros.r-gallery.in/api/tenants?query=$sendname";

      try
      {
        final response = await http.get(Uri.parse(url));




        var reult = response.statusCode;

         print("Responsecode of getTenant Api "+response.statusCode.toString());
         print("Responsebody  of getTenant Api "+response.body);

          setState(() {


           lsiTenannts=  tenantsFromJson(response.body);
           //
           print("Length of Tenants is >>>>>>>>>>>"+lsiTenannts.length.toString());

            if(lsiTenannts.length==0)
              {
                isNextButtonVisible=true;
                showToastDialog(context, "User Not Found");
              }
            else
              {
                isNextButtonVisible=false;
              }
          });


          if(lsiTenannts.length==1)
            {

              setState(() {
                print("*******************Tenats 1 ***********************");
                selectedTenants=lsiTenannts[0].name;
                spinnerSelectTenantsDetails.add(
                    lsiTenannts[0].name);

                API_ROS_PROD__BASE_URL=lsiTenannts[0].url;

                saveBaseUrl(lsiTenannts[0].url);
              });

            }
          else {
            for(int i=0;i<lsiTenannts.length;i++)
            {
              String displayname;
              print(" Spinner Select Location List  Loop is Called ");
              setState(() {
                if(i==0)
                {

                  if(!spinnerSelectTenantsDetails.contains("Select Location"))
                    {
                      spinnerSelectTenantsDetails.add("Select Location");
                    }

                }

                if(!spinnerSelectTenantsDetails.contains(lsiTenannts[i].name))
                  {
                    spinnerSelectTenantsDetails.add(lsiTenannts[i].name);
                  }



                displayname = spinnerSelectTenantsDetails[i];
              });


              print(" Spinner Select Location List   Name $displayname");
            }
          }

      }
      catch(e)
        {
          /// HERE THROWS EXCEPTION OF NEXT BUTTON
           print("Exception of get Tenants Api "+e);

        }
  }




  //Dialog Context
  BuildContext dialogContext;


  //progress bar active
  bool _isInAsyncCall = false;


  // for check box
  var  value  = false;
  var isemailvalidate=false;
  var ispasswordvalidate=false;
  int loginResponseCode=0;
  bool statuslogin = false;


  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final SecureStorage secureStorage = SecureStorage();

  String email="";
  String password="";
  String token;
  String UserName;
  String activityflag="1";
  String companyId;
  String memberId;
  String memberEmail,memberType,memberName;
  String parent_distributor_id,parent_distributor_nav_id;
  bool AllowAddToCart = true;
  bool AllowtoBlock = true;
  bool AllowAdanceOrdering=true;


  var checkNetconnection=null;
  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  save(String username,String password, String token, String activityflag,String UserName,String companyId,String memberId ) async {
    await  init();

    List<String> spinnerDelerListOnCart = [];
    List<String> spinnerDelerListOnOrder = [];

    prefs.setString('username', username);
    prefs.setString('password', password);
    prefs.setString('token', token);
    prefs.setString('activityflag', activityflag);
    prefs.setString('UserName', UserName);
    prefs.setString('companyId', companyId);
    prefs.setString('memberId', memberId);
    prefs.setString('memberName', memberName);
    prefs.setString('memberType', memberType);
    prefs.setString('memberEmail', memberEmail);
    prefs.setStringList('spinnerDelerListOnCart', spinnerDelerListOnCart);
    prefs.setStringList('spinnerDelerListOnOrder', spinnerDelerListOnOrder);
    prefs.setBool('AllowAddToCart', AllowAddToCart);
    prefs.setBool('AllowtoBlock', AllowtoBlock);
    prefs.setBool('AllowAdanceOrdering', AllowAdanceOrdering);

    if(memberType!="Distributor")
    {
      prefs.setString('parent_distributor_id', parent_distributor_id);
      prefs.setString('parent_distributor_nav_id', parent_distributor_nav_id);
    }






    String myusername = prefs.getString('username');
    String  mypassword = prefs.getString('password');
    String  mytoken = prefs.getString('token');
    String  myUserName = prefs.getString('UserName');
    String  mycompanyId = prefs.getString('companyId');
    String  mymemberId = prefs.getString('memberId');
    List<String> spinnerDelerListOnCart2 = prefs.getStringList('spinnerDelerListOnCart');
    List<String> spinnerDelerListOnOrder2 = prefs.getStringList('spinnerDelerListOnOrder');


    print(">>>>>>>>>>>>myusername  $myusername mypassword $mypassword myToken $mytoken UserName $myUserName CompanyId $mycompanyId MemberId $mymemberId");
    print(">>>>>>>>>>>>myusername parent_distributor_id  $parent_distributor_id parent_distributor_nav_id $parent_distributor_nav_id ");


    print("spinnerDelerListOnCart >>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+spinnerDelerListOnCart2.length.toString());
    print("spinnerDelerListOnOrder >>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+spinnerDelerListOnOrder2.length.toString());


  }

  saveBaseUrl(String tenantbaseUrl)
  async {
    await  init();

    prefs.setString('SelectedTenantBaseURl', tenantbaseUrl);
    print("From Shared prefrence base url "+ prefs.getString('SelectedTenantBaseURl'));







  }

  Future<int> sendData(String username,String password) async
  {

    print("Login Base URl >>>>>>>>>>>>>>>>>>"+API_ROS_PROD__BASE_URL);
    String url =API_ROS_PROD__BASE_URL+"/api/login";
    var res = await http.post(Uri.parse(url),body: jsonEncode({"email":"$username","password":"$password",}),
        headers: {"Content-Type":"application/json"});
    print(res.statusCode);
    print(res.body);
    var status = res.statusCode;
    print("<<<<<<<<<<<<<<<<<<<<< $status");

    if(status==200)
    {
      print("<<<<<<<<<<<<<<<<<<<<< 200");
    }
    else
    {
      Navigator.pop(dialogContext);

      print("<<<<<<<<<<<<<<<<<<<<< 400");
      showToastDialog(context,"Please check email and password");


      // Fluttertoast.showToast(
      //     msg: "Unable to login please check email and password",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     //    timeInSecForIos: 1,
      //     backgroundColor: Color(0xff2199c7),
      //     textColor: Colors.red,
      //     fontSize: 16.0);
    }

    setState(() {
      token= User.fromJson(json.decode(res.body)).token;
      // UserName =  User.fromJson(json.decode(res.body)).name;
      UserName =  User.fromJson(json.decode(res.body)).memberName;
      memberId=User.fromJson(json.decode(res.body)).memberId.toString();
      companyId=User.fromJson(json.decode(res.body)).companyId.toString();
      memberType=User.fromJson(json.decode(res.body)).memberType;
      memberName=User.fromJson(json.decode(res.body)).memberName;
      memberEmail=User.fromJson(json.decode(res.body)).email==null?"":User.fromJson(json.decode(res.body)).email;

      if(User.fromJson(json.decode(res.body)).allowAddToCart!=null)
        {
          AllowAddToCart=User.fromJson(json.decode(res.body)).allowAddToCart;
        }


      if(User.fromJson(json.decode(res.body)).allowBlock!=null)
        {
          AllowtoBlock=User.fromJson(json.decode(res.body)).allowBlock;
        }
      if(User.fromJson(json.decode(res.body)).allowAdvanceOrdering!=null)
        {
          AllowAdanceOrdering=User.fromJson(json.decode(res.body)).allowAdvanceOrdering;
        }



      print("Token in Login Response >>>>>>>>>>>>>>>>>    "+token);
      print("Allow to Add to Cart "+User.fromJson(json.decode(res.body)).allowAddToCart.toString());
      print("Allow to Block to Cart "+User.fromJson(json.decode(res.body)).allowBlock.toString());



      parent_distributor_id=User.fromJson(json.decode(res.body)).parentDistributorId.toString();
      parent_distributor_nav_id=User.fromJson(json.decode(res.body)).parentDistributorNavId.toString();

      print("parentDistributorNavId >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> get In Login Response $parent_distributor_id");


      if(memberType!="Distributor")
      {
        if(parent_distributor_id==""&&parent_distributor_id=="")
        {
          memberType="DUC";
        }
        else if(parent_distributor_id!=""&&parent_distributor_id!="")
        {
          memberType="DUD";
        }
      }




      print("***********************Welcome in App Type $memberType**********************");




      print("My  Token $token");
      if(status!=200)
      {
        print("Error Resoponse <<<<<<<<<<<<<<<<<<<<< $status  $token $UserName");

        _isInAsyncCall=false;
      }


    });




    var result = res.statusCode;

    print("Login Response is $result");


    return res.statusCode;




  }





  String SelectedTenantBaseURl;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(


      body:

        MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
    child:  ModalProgressHUD(
        child: Container(
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              SingleChildScrollView(


                child: Padding(
                  padding: const EdgeInsets.all(24.0),


                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                          false?isRGallery?  Container(


                      width:(MediaQuery.of(context).size.width)-50,



                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  //MOHARRAM
                                  //MOHARRAM HOLIDAY
                                  Container(child:Text("NOTICE !",style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: sh_colorPrimary,),)),
                                  Container(),
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              Container(child:Text("Dear R Gallery Associates,",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                              Container(child:Text("On account of Moharram, the Corporate Office & all Company Warehouses across INDIA would remain shut between 29th July to 7th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                              SizedBox(height: 15.0,),
                              Container(child:Text("All orders given during this time on the R Gallery App will be shipped after 8th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),


                            ],
                          ),





                        ],
                      ),



                    ):Container():Container(),
                          false?!isRGallery? Container(



                              width:(MediaQuery.of(context).size.width)-50,



                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          //MOHARRAM
                                          //MOHARRAM HOLIDAY
                                          Container(child:Text("NOTICE !",style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: sh_colorPrimary,),)),
                                          Container(),
                                        ],
                                      ),
                                      SizedBox(height: 15.0,),
                                      Container(child:Text("Dear Rosetta Associates,",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                                      Container(child:Text("On account of Moharram, the Corporate Office & all Company Warehouses across INDIA would remain shut between 29th July to 7th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                                      SizedBox(height: 15.0,),
                                      Container(child:Text("All orders given during this time on the Rosetta App will be shipped after 8th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),


                                    ],
                                  ),





                                ],
                              ),



                            ):Container():Container(),



                            isVisibleSkip? Container(

                              // alignment: Alignment.centerRight,
                              child: SizedBox(

                                // height: double.infinity,
                                // width:100,
                                child: InkWell(

                                  child:Text(
                                    'Skip',
                                    style: TextStyle(
                                      fontSize: textSizeLarge,
                                      color: sh_colorPrimary,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  //child: text("Skip", fontSize: textSizeSmall, fontFamily: fontMedium, textColor:sh_colorPrimary,),


                                  //  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                  onTap: () => {
                                    setState(() {
                                      if(isInternatAvailable() != null)
                                      {

                                        checkNetconnection = isInternatAvailable2(context);


                                        print("Internet is Connected in Login Screen $checkNetconnection");
                                      }





                                      if (true)
                                      {


                                        //_isInAsyncCall = true;
                                        // showProgressDialog(context);

                                        //formKey.currentState.save();
                                        //sendData("aziz@rosettaproducts.com","aziz@123")
                                        //sendData("9130029174","amazonseller@123")
                                        sendData("aziz@rosettaproducts.com","aziz@123").then((value){

                                          if(value==200)
                                          {

                                            print("You have Successfully Login ");
                                            save(email,password,token,activityflag,UserName,companyId,memberId);
                                            // Navigator.pop(context, false);
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewDistributorDashboard(0),));
                                          }
                                          // else
                                          // {
                                          //   print("Please Check Email & Password");
                                          //   _isInAsyncCall = false;
                                          // }
                                        });

                                      }


                                      print("Button Clicked");


                                    }),




                                  },
                                ),
                              ),
                            ):Container(),



                          ],
                        ),





                        Image.asset(
                          ic_app_icon_rosetta2,
                          width: 150,
                          height: 150,
                        ),

                        // Image.asset(
                        //   ic_app_icon_rosetta2,
                        //   width: 200,
                        //   height: 200,
                        // ),

                        SizedBox(
                          height: spacing_xlarge,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          controller: emailCont,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                          decoration: InputDecoration(
                            filled: true,
                            //errorText: isemailvalidate?"*Required":null,


                            fillColor: sh_editText_background,
                            focusColor: sh_editText_background_active,
                            hintText: sh_hint_Email,
                            hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),


                          ),
                          validator: (String value) {




                            if (value.isEmpty) {
                              return 'Email & Mobile no is required';
                            }
                            else
                            {
                              if(value.length<10)
                              {
                                return 'Please enter a valid mobile no';
                              }
                              else
                              {

                                if(value.length==10)
                                {

                                }
                                else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                              }
                            }

                            return null;
                          },
                          onChanged: (email){
                            print("User name is $email");
                            this.email=email;
                            this.isemailvalidate=false;
                             setState(() {
                               isNextButtonVisible=true;
                             });
                          },
                        ),

                        SizedBox(
                          height: spacing_standard_new,
                        ),

                        isNextButtonVisible&&isRGallery==false?    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(

                                  alignment: Alignment.centerRight,
                                  child: SizedBox(

                                    // height: double.infinity,
                                    width:100,
                                    child: MaterialButton(
                                      padding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                                      child: text("Next", fontSize: textSizeSmall, fontFamily: fontMedium, textColor: sh_white),
                                      textColor: sh_white,
                                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                      color: sh_colorPrimary,
                                      onPressed: () => {

                                      setState(() {
                                        selectedTenants="Select Location";

                                      password="";
                                      passwordCont.clear();
                                      lsiTenannts.clear();
                                      spinnerSelectTenantsDetails.clear();

                                      print("list of tenants length is"+lsiTenannts.toString());
                                      print("list of tenants2 length is"+spinnerSelectTenantsDetails.toString());


                                      }),
                                        setState(() {
                                          //getAllTenantsTesting();



                                          // isNextButtonVisible=false;
                                          isInternatAvailable2(context);



                                          // if(isInternatAvailable() != null)
                                          // {
                                          //
                                          //   checkNetconnection = isInternatAvailable2(context).then((value){
                                          //     print("Next Butto Internet >>> "+value.toString());
                                          //   });
                                          //
                                          //
                                          //   print("Internet is Connected in Login Screen "+checkNetconnection);
                                          // }

                                          lsiTenannts.clear();
                                          spinnerSelectTenantsDetails.clear();




                                         if(email=="")
                                           {
                                             showToastDialog(context, "Please enter Mobile or email");
                                             isNextButtonVisible=true;
                                           }
                                         else
                                           {

                                             getAllTenants(email);
                                           }




                                          // if (!formKey.currentState.validate()) {
                                          //   return;
                                          // }
                                          // else
                                          // {
                                          //
                                          //
                                          //   //_isInAsyncCall = true;
                                          //
                                          //
                                          //
                                          // }


                                         // print("Button Clicked");


                                        }),




                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                //SKip Buttons

                              ],
                            )

                          ],
                        ):Container(),

                        isNextButtonVisible&&isRGallery==false? SizedBox(
                          height: spacing_standard_new,
                        ):Container(),

                        isNextButtonVisible?Container():  lsiTenannts.isEmpty?Container():
                        Container(

                          height: 40,
                          padding: EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 10),
                          child:Theme(data: Theme.of(context).copyWith(
                            canvasColor: Colors.white,
                          ),
                            child:  new DropdownButton<String>(
                            value: selectedTenants,
                            dropdownColor: Colors.white,


                                    isExpanded: true,
                                  icon:spinnerSelectTenantsDetails.length!=1? Container(
                                      color: Colors.white,
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color:
                                        sh_textColorSecondary,
                                        size: 25,
                                      ),
                                    ):Container(),
                                    iconSize: 15,

                                    style: TextStyle(
                                      color: sh_textColorSecondary,
                                      fontSize: 18,
                                    ),
                                    underline: Container(
                                      height: 1,
                                    ),
                            onChanged: (String value) {
                              setState(() {

                                print("On Select Drop Down Value"+value);


                                selectedTenants = value;

                                setState(() {

                                  password="";
                                  passwordCont.clear();


                                });



                                if(value!="Select Location")
                                {
                                  final index = lsiTenannts.indexWhere((element) =>
                                  element.name == selectedTenants);

                                  print(">>>>>>Selected SelectedTenantBaseURl  List Index $index");
                                   SelectedTenantBaseURl   = lsiTenannts[index].url;
                                  API_ROS_PROD__BASE_URL=lsiTenannts[index].url;
                                  print("Selected SSelectedTenantBaseURl  Informations  $SelectedTenantBaseURl");


                                  saveBaseUrl(SelectedTenantBaseURl);
                                }








                              });
                            },
                            items: spinnerSelectTenantsDetails
                                .map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,


                                    child: Container(
                                      height: 50.0,
                                      width: double.infinity,
                                      color: Colors.white,

                                      child: Text(value,style: TextStyle(fontSize: textSizeMedium)
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            //sh_textColorSecondarylight
                            border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                            borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                          ),
                        ),
                        lsiTenannts.isEmpty?Container():    SizedBox(
                          height: spacing_standard_new,
                        ),

                         lsiTenannts.isEmpty?Container():isNextButtonVisible?Container():selectedTenants=="Select Location"?Container(): TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          obscureText: _obscureText,

                          style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                          controller: passwordCont,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: _toggle,
                              icon:_obscureText? Icon(Icons.visibility_off,size: 15,color: sh_textColorSecondary,):Icon(Icons.visibility,size: 15,color: sh_colorPrimary,),
                            ),
                            filled: true,
                            fillColor: sh_editText_background,
                            //errorText: ispasswordvalidate?"*Required":null,

                            focusColor: sh_editText_background_active,
                            hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
                            hintText: sh_hint_password,
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Password is required';
                            }
                          },
                          onChanged: (password){

                            this.password=password;
                            this.ispasswordvalidate=false;
                          },


                        ),
                         isRGallery?TextFormField(
                           keyboardType: TextInputType.text,
                           autofocus: false,
                           obscureText: _obscureText,

                           style: TextStyle(color: sh_textColorPrimary, fontFamily: fontRegular, fontSize: textSizeMedium),
                           controller: passwordCont,
                           textCapitalization: TextCapitalization.words,
                           decoration: InputDecoration(
                             suffixIcon: IconButton(
                               onPressed: _toggle,
                               icon:_obscureText? Icon(Icons.visibility_off,size: 15,color: sh_textColorSecondary,):Icon(Icons.visibility,size: 15,color: sh_colorPrimary,),
                             ),
                             filled: true,
                             fillColor: sh_editText_background,
                             //errorText: ispasswordvalidate?"*Required":null,

                             focusColor: sh_editText_background_active,
                             hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),
                             hintText: sh_hint_password,
                             contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0),),
                           ),
                           validator: (String value) {
                             if (value.isEmpty) {
                               return 'Password is required';
                             }
                           },
                           onChanged: (password){

                             this.password=password;
                             this.ispasswordvalidate=false;
                           },


                         ):Container(),



                        // ~~~~~~~~~~~~~~~~~~~~~~~Container for Check Box

                        // Container(
                        //   child: Row(
                        //     children: [
                        //
                        //       Checkbox(
                        //
                        //         activeColor: sh_colorPrimary,
                        //         value: this.value,
                        //         onChanged: ( value) {
                        //           setState(() {
                        //             this.value = value;
                        //           });
                        //         },
                        //       ),
                        //       Text(
                        //           "Remember Me"
                        //       ),
                        //
                        //       SizedBox(
                        //         width: 50,
                        //       ),
                        //       //  Text("Forgot Password ?",style: TextStyle(color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                        //
                        //     ],
                        //   ),
                        // ),
                        lsiTenannts.isEmpty?Container(): SizedBox(
                          height: spacing_xlarge,
                        ),


                        lsiTenannts.isEmpty?Container():   isNextButtonVisible?Container(): selectedTenants=="Select Location"?Container(): Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(

                                  alignment: Alignment.centerRight,
                                  child: SizedBox(

                                    // height: double.infinity,
                                    width:100,
                                    child: MaterialButton(
                                      padding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                                      child: text(sh_lbl_sign_in, fontSize: textSizeSmall, fontFamily: fontMedium, textColor: sh_white),
                                      textColor: sh_white,
                                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                      color: sh_colorPrimary,
                                      onPressed: () => {
                                        setState(() {
                                          if(isInternatAvailable() != null)
                                          {

                                            checkNetconnection = isInternatAvailable2(context);


                                            print("Internet is Connected in Login Screen $checkNetconnection");
                                          }





                                          if (!formKey.currentState.validate()) {
                                            return;
                                          }
                                          else
                                          {


                                            //_isInAsyncCall = true;
                                            showProgressDialog(context);

                                            formKey.currentState.save();
                                            sendData(email,password).then((value){

                                              if(value==200)
                                              {

                                                print("You have Successfully Login ");
                                                save(email,password,token,activityflag,UserName,companyId,memberId);
                                                Navigator.pop(context, false);
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewDistributorDashboard(0),));
                                              }
                                              // else
                                              // {
                                              //   print("Please Check Email & Password");
                                              //   _isInAsyncCall = false;
                                              // }
                                            });

                                          }


                                          print("Button Clicked");


                                        }),




                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                //SKip Buttons

                              ],
                            )

                          ],
                        ),
                        isRGallery?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10,left: 15),

                                  alignment: Alignment.centerRight,
                                  child: SizedBox(

                                    // height: double.infinity,
                                    width:100,
                                    child: MaterialButton(

                                      padding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),

                                      child: text(sh_lbl_sign_in, fontSize: textSizeSmall, fontFamily: fontMedium, textColor: sh_white),
                                      textColor: sh_white,
                                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                      color: sh_colorPrimary,
                                      onPressed: () => {
                                        setState(() {
                                          if(isInternatAvailable() != null)
                                          {

                                            checkNetconnection = isInternatAvailable2(context);


                                            print("Internet is Connected in Login Screen $checkNetconnection");
                                          }





                                          if (!formKey.currentState.validate()) {
                                            return;
                                          }
                                          else
                                          {


                                            //_isInAsyncCall = true;
                                            showProgressDialog(context);

                                            formKey.currentState.save();
                                            sendData(email,password).then((value){

                                              if(value==200)
                                              {

                                                print("You have Successfully Login ");
                                                save(email,password,token,activityflag,UserName,companyId,memberId);
                                                Navigator.pop(context, false);
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewDistributorDashboard(0),));
                                              }
                                              // else
                                              // {
                                              //   print("Please Check Email & Password");
                                              //   _isInAsyncCall = false;
                                              // }
                                            });

                                          }


                                          print("Button Clicked");


                                        }),




                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                //SKip Buttons

                              ],
                            )

                          ],
                        ):Container(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Container(
                                child: Row(
                                  children: [
                                    Text("Don't have an account?", ),
                                    InkWell(
                                      child:  Text(" SignUp here",style: TextStyle(color: sh_colorPrimary),),
                                      onTap: ((){

                                     //   Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));


                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SignUp()
                                            ),
                                                (Route)=>false
                                          // ModalRoute.withName("/ShHomeFragment")
                                        );


                                      }),

                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container()
                        ],
                      ),








                        SizedBox(height: spacing_standard_new),
                        SizedBox(
                          width: double.infinity,
                          height: 50,

                        )
                      ],
                    ),
                  ),


                ),
              )
            ],
          ),
        ),
        inAsyncCall: _isInAsyncCall,
        // demo of some additional parameters
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
        ),


    );
  }




  showProgressDialog(BuildContext context)
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
                  dialogContext = context;
                  return  Container(
                    height: 311,

                    width:MediaQuery.of(context).size.width,
                    color: sh_white,
                    padding: EdgeInsets.only(top: 20,bottom: 20),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          child: Text("Loding...",style: TextStyle(color: sh_black,fontSize: 18,fontWeight: FontWeight.bold),),
                        ),

                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,


                          child: Text("Please wait, While Authenticating",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
                        ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   width: MediaQuery.of(context).size.width,
                        //
                        //
                        //   child: Text("Check your Internet connection",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
                        // ),


                        Container(
                          margin: EdgeInsets.only(top: 5),



                          color: sh_white,
                          child:   Container(
                            color: sh_white,

                            child: MaterialButton(
                              padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),


                              child: Text("close", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
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
                    padding: EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Container(
                                child:Text("$Message",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                            Container(),
                          ],
                        ),

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




  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('username');
    String stringValuetoken = prefs.getString('token');
    print("username>>>>>>>>>>>>>>>>>>>>>>$stringValue");
    print("token>>>>>>>>>>>>>>>>>>>>>>$stringValuetoken");


    if(stringValue==null&&stringValuetoken==null)
    {
      Timer(Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  LoginScreen(),
                //CustomerDashboard(),

              )
          )
      );
    }
    else
    {
      Timer(Duration(seconds: 2),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
              //TestDart(),

              NewDistributorDashboard(0),
                //CustomerDashboard(),
              )
          )
      );
    }
    return stringValue;
  }

  showToastDialogNotice(BuildContext context)
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
                      height: 270,


                      width:MediaQuery.of(context).size.width,
                      color: sh_white,
                      padding: EdgeInsets.all(20),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  //MOHARRAM
                                  //MOHARRAM HOLIDAY
                                  Container(child:Text("NOTICE !",style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: sh_colorPrimary,),)),
                                  Container(),
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              Container(child:Text("Dear Rosetta Associates,",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                              Container(child:Text("On account of Moharram, the Corporate Office & all Company Warehouses across INDIA would remain shut between 29th July to 7th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                              SizedBox(height: 15.0,),
                              Container(child:Text("All orders given during this time on the Rosetta App will be shipped after 8th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),


                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Container(
                                margin: EdgeInsets.only(top: 5),



                                color: sh_white,
                                child:   Container(
                                  color: Colors.white,

                                  child: MaterialButton(
                                    padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),


                                    child: Text("OK", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
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
                              Container(),
                            ],
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
  showToastDialogNoticeRGallery(BuildContext context)
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
                      height: 270,


                      width:MediaQuery.of(context).size.width,
                      color: sh_white,
                      padding: EdgeInsets.all(20),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  //MOHARRAM
                                  //MOHARRAM HOLIDAY
                                  Container(child:Text("NOTICE !",style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: sh_colorPrimary,),)),
                                  Container(),
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              Container(child:Text("Dear R Gallery Associates,",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                              Container(child:Text("On account of Moharram, the Corporate Office & all Company Warehouses across INDIA would remain shut between 29th July to 7th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                              SizedBox(height: 15.0,),
                              Container(child:Text("All orders given during this time on the R Gallery App will be shipped after 8th August.",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),


                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Container(
                                margin: EdgeInsets.only(top: 5),



                                color: sh_white,
                                child:   Container(
                                  color: Colors.white,

                                  child: MaterialButton(
                                    padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),


                                    child: Text("OK", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
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
                              Container(),
                            ],
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






