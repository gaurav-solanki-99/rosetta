import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/loginScreen.dart';
import 'package:rosetta_fluter_app/rosetta/models/AllStates.dart';

import '../main/utils/AppColors.dart';
import '../rosetta/MyClass/UppercaseTextFormat.dart';
import '../rosetta/models/AddDealerError.dart';
import '../rosetta/utils/ShColors.dart';
import '../rosetta/utils/ShConstant.dart';
import '../rosetta/utils/ShImages.dart';
import '../rosetta/utils/ShWidget.dart';

import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget
{
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool    isValidGst = true ;
  bool _obscureText = true;
  String dealerName="",contactPerson="",email="",password="",phone="",fax="",address="",address2="",state="",city="",postcode="",gstNumber="";
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
  // List<String> spinnerAllStatesList = [];


  String selectedStates="Select State";
  String stateCode;
  bool    isValidemail = true ;
  bool    isValidphone = true ;
  BuildContext dialogContext;

  List<String> stateCodesList = [
    'JK',
    'PUN' ,
    'CH' ,
    'CG' ,
    'ARP' ,
    'AS' ,
    'BIH' ,
    'GOA',
    'GUJ' ,
    'HR' ,
    'JHK' ,
    'KER' ,
    'MAN' ,
    'MP' ,
    'NAG' ,
    'ND',
    'ORI' ,
    'RAJ',
    'SIK' ,
    'TN',
    'UP' ,
    'WB' ,
    'KAR' ,
    'MAH',
    'MZ' ,
    'AN' ,

  ];

  List<String> stateNoList =
  [
    '01',
    '03',
    '04',
    '22',
    '12',
    '18',
    '10',
    '30',
    '24',
    '06',
    '20',
    '32',
    '14',
    '23',
    '13',
    '07',
    '21',
    '08',
    '11',
    '33',
    '09',
    '19',
    '29',
    '27',
    '15',
    '35',

  ];


  List<String> spinnerAllStatesList =  [
    'Jammu & Kashmir',
    'Punjab' ,
    'Chandigarh' ,
    'Chhattisgarh' ,
    'Arunachal Pradesh' ,
    'Assam' ,
    'Bihar' ,
    'GOA',
    'Gujarat' ,
    'Haryana' ,
    'Jharkhand' ,
    'Kerala' ,
    'Manipur' ,
    'Madhya Pradesh' ,
    'Nagaland' ,
    'New Delhi',
    'Orissa' ,
    'Rajasthan',
    'Sikkim' ,
    'Tamil Nadu',
    'Uttar Pradesh' ,
    'West Bengal' ,
    'Karnataka' ,
    'Maharashtra',
    'Mizoram' ,
    'Andaman  Nicobar' ,

  ];



  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  Future<int> sendData() async
  {
    print("SignUp Base URl >>>>>>>>>>>>>>>>>>" + API_ROS_PROD__BASE_URL);
    String url = API_ROS_PROD__BASE_URL + "/api/sign_up";
    var res = await http.post(Uri.parse(url),
        body: jsonEncode(
            {
              "name": dealerName,
              "business_name":contactPerson,
              "email":email,
              "phone":phone,
              "password":password,
              "receive_updates":true,
              "gst_no":gstNumber,
              "pan":fax,
              "street":address,
              "floor":"1st",
              "city":city,
              "state":state,
              "post_code":postcode
            }),
        headers: {"Content-Type": "application/json"});
    print(res.statusCode);
    print(res.body);
    var status = res.statusCode;
    print("Sign Up <<<<<<<<<<<<<<<<<<<<< $status "+res.body);

    if(res.statusCode!=200) {
      Map<String, dynamic> res2 = jsonDecode(res.body);
      print(res2.containsKey("country"));
      print("Json Keys " + res2.keys.toString());
      String myKey = res2.keys.toString();
      res2.keys.forEach((element) {
        print("Json Key Value  $element");
        var error_message = AddDealerError
            .fromJson(jsonDecode(res.body), element)
            .name[0];

         Navigator.of(context, rootNavigator: true).pop();

        showToastDialog(context, error_message);

        print("Error message is >>>>>>>>>>>>>>>  " + error_message.toString());
      });
    }

    if(res.statusCode==200)
      {
        Navigator.pop(context, false);
        showToastDialog2(context,"Sign up successfully !");




      }
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
        child:

        Scaffold(


          resizeToAvoidBottomInset: true,

          body: SafeArea(
               child: new Scrollbar(
                isAlwaysShown:true ,
                child:

             SingleChildScrollView(
                 child: Container(
                   child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                       children: [
                                         InkWell(
                                           child: Container(
                                             
                                             child: Icon(
                                               Icons.arrow_back,
                                               color: Colors.black,
                                               size: 26.0,
                                             ),
                                             margin: EdgeInsets.all(15.0),
                                           ),
                                           onTap: ((){
                                             //LoginScreen().launch(context);
                                             Navigator.pushAndRemoveUntil(
                                                 context,
                                                 MaterialPageRoute(
                                                     builder: (context) => LoginScreen()
                                                 ),
                                                     (Route)=>false
                                               // ModalRoute.withName("/ShHomeFragment")
                                             );
                                           }),
                                         )
                                       ],
                                    ),

                                    Image.asset(
                                      ic_app_icon_rosetta2,
                                      width: 130,
                                      height: 130,
                                    ),
                                SizedBox(height: 15,),

                                Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Container(),
                                  Text("Sign Up ",style: TextStyle(color: sh_colorPrimary, fontSize: 20, fontWeight: FontWeight.bold),),
                                  Container(),
                                ],),



                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 15.0),

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [




                                          SizedBox(height: 15,),
                                         Text("Name *"),
                                          SizedBox(height: 10,),
                                          Container(


                                            child: SizedBox(
                                                height: height_textFormfiled,
                                                child:

                                                TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  autofocus: false,
                                                  onChanged: (value){

                                                    setState(() {
                                                      dealerName=value;
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
                                                )),




                                            decoration: BoxDecoration(

                                              border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                            ),

                                          ),


                                          SizedBox(height: 15,),
                                          Text("Buisness Name *"),
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
                                                onChanged: (value){
                                                  setState(() {
                                                    contactPerson=value;
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
                                          Text("Email *"),
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
                                                  onChanged: (value){



                                                    setState(() {
                                                      email=value;
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
                                              isValidemail? sh_textColorSecondarylight:Colors.red,
                                                width: 1,),
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                            ),

                                          ),
                                          isValidemail?Container():Text("Email Invalid",style: TextStyle(color: Colors.red, fontFamily: fontRegular, fontSize: textSizeSmall),),


                                          SizedBox(height: 15,),
                                          Text("Password *"),
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
                                                  Text("Phone *"),
                                                  SizedBox(height: 10,),
                                                  Container(

                                                    width: (width/2)-25,
                                                    child: SizedBox(
                                                        height: height_textFormfiled,
                                                        child:
                                                        TextFormField(

                                                          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                          inputFormatters: [
                                                            new LengthLimitingTextInputFormatter(10),
                                                          ],
                                                          autofocus: false,
                                                          onChanged: (value){

                                                            setState(() {
                                                              phone=value.replaceAll(".", "");
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
                                                  Text("PAN No. "),
                                                  SizedBox(height: 10,),
                                                  Container(

                                                    width: (width/2)-25,
                                                    child:  SizedBox(
                                                        height: height_textFormfiled,
                                                        child:
                                                        TextFormField(


                                                          keyboardType: TextInputType.text,
                                                          inputFormatters: [
                                                            new LengthLimitingTextInputFormatter(10),
                                                            UpperCaseTextFormatter()
                                                          ],
                                                          autofocus: false,
                                                          onChanged: (value){

                                                            setState(() {
                                                              fax=value;
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
                                          Text("Address *",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.bold),),

                                          SizedBox(height: 15,),
                                          Text("Street *"),
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
                                                  onChanged: (value){

                                                    setState(() {
                                                      address=value;
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
                                          Text("Floor * "),
                                          SizedBox(height: 10,),
                                          Container(

                                            //   width: 100,
                                            child: SizedBox(
                                                height: height_textFormfiled,
                                                child:
                                                TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  autofocus: false,
                                                  onChanged: (value){
                                                    setState(() {
                                                      address2=value;
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
                                          Container(
                                            child:Autocomplete(

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
                                                    prefixIcon: Icon(Icons.search,color:sh_colorPrimary,size: 20,),
                                                    fillColor: backgroundSearchProductFormInput,
                                                    focusColor: sh_editText_background_active,

                                                    hintText: "Search States",
                                                    hintStyle: TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeSmall),
                                                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: sh_colorPrimary, width: 0.5)),
                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.transparent, style: BorderStyle.none, width: 0)

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
                                                  selectedStates = value;


                                                  print("Selected State Value is "+selectedStates.toString());


                                                  stateCode = stateCodesList[spinnerAllStatesList.indexOf(value)];
                                                  state=value;


                                                  //
                                                  // final index = AllStatesList.indexWhere((element) =>
                                                  // element.name == selectedStates);
                                                  // stateCode = AllStatesList[index].code;
                                                  // state=stateCode;



                                                  print("Selected State code is "+stateCode.toString());
                                                  print("Selected State  "+state.toString());







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
                                          Text("City *"),
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
                                                      onChanged: (value){
                                                        setState(() {
                                                          city=value;
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
                                          Text("Post code *"),
                                          SizedBox(height: 10,),
                                          Container(

                                            //   width: 100,
                                            child:  SizedBox(
                                                height: height_textFormfiled,
                                                child:
                                                TextFormField(
                                                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                  inputFormatters: [
                                                    new LengthLimitingTextInputFormatter(6),
                                                  ],
                                                  autofocus: false,
                                                  onChanged: (value){

                                                    setState(() {
                                                      postcode=value;
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
                                          Text("GST Number *"),
                                          SizedBox(height: 10,),
                                          Container(

                                            //   width: 100,
                                            child:
                                            SizedBox(
                                                height: height_textFormfiled,
                                                child:
                                                TextFormField(
                                                  keyboardType: TextInputType.text,
                                                  inputFormatters: [
                                                    new LengthLimitingTextInputFormatter(15),
                                                    UpperCaseTextFormatter()
                                                  ],
                                                  autofocus: false,
                                                  onChanged: (value){
                                                    setState(() {
                                                      //   widget.number=value;

                                                      gstNumber=value;

                                                      String gst_regex = "^[0-9]{2}[A-Z]{5}[0-9]{4}" + "[A-Z]{1}[1-9A-Z]{1}" + "Z[0-9A-Z]{1}";
                                                      if(!RegExp(gst_regex).hasMatch(gstNumber))
                                                      {
                                                        print("Please Enter valid GST Number");
                                                        // showToastDialog(context, "Please enter valid GST number");
                                                        setState(() {

                                                          isValidGst=false;
                                                        });

                                                      }
                                                      else
                                                      {
                                                        print("Selected State Code   >>>>>>>>>>>>>>>>>   "+stateCode);
                                                        if(stateCodesList.contains(stateCode))
                                                        {
                                                          int indexofStatecode =  stateCodesList.indexOf(stateCode);
                                                          String selectedSateNo = stateNoList[indexofStatecode];
                                                          print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
                                                          print("Selected State No Match with GST    >>>>>>>>>>>>>>>>>   $selectedSateNo  "+stateCode.startsWith(selectedSateNo).toString());




                                                          if(gstNumber.startsWith(selectedSateNo)==false)
                                                          {
                                                            // showToastDialog(context, "Please enter valid GST number with state");
                                                            setState(() {
                                                              isValidGst=false;
                                                            });

                                                          }
                                                          else
                                                          {
                                                            setState(() {
                                                              isValidGst=true;

                                                            });
                                                          }


                                                        }


                                                      }

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

                                              border: Border.all(color: isValidGst?sh_textColorSecondarylight:Colors.red,
                                                width: 1,),
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                            ),

                                          ),
                                          isValidGst?Container():Text("GST No. Invalid",style: TextStyle(color: Colors.red, fontFamily: fontRegular, fontSize: textSizeSmall),),


                                          SizedBox(height: 15,),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [


                                                InkWell(
                                                    onTap: ()
                                                    {


                                                      if(dealerName.isEmptyOrNull)
                                                      {
                                                        print("Please Enter Dealer Name");
                                                        showToastDialog(context,"Please Enter Name");

                                                      }
                                                      else if(contactPerson.isEmptyOrNull)
                                                      {
                                                        print("Please Enter Buisness Name");
                                                        showToastDialog(context,"Please enter Business Name");

                                                      }

                                                      else if(email.isEmpty)
                                                      {
                                                        showToastDialog(context,"Please enter Email");
                                                      }

                                                      else if (email.isNotEmpty&&!RegExp(
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                          .hasMatch(email)) {
                                                        showToastDialog(context, "Please enter a valid email ");

                                                      }
                                                      else  if(password.isEmpty)
                                                      {
                                                        showToastDialog(context, "Please Enter Password");
                                                      }
                                                      else if(password.length<8)
                                                      {
                                                        showToastDialog(context, "Password should be 8 digits");

                                                      }
                                                      else if(phone.isEmpty)
                                                      {
                                                        showToastDialog(context,"Please enter Phone");
                                                      }
                                                      else if(phone.isNotEmpty&&phone.length!=10)
                                                      {
                                                        showToastDialog(context, "Mobile no should be 10 Digits ");
                                                      }

                                                      else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(fax)&&fax.isNotEmpty)
                                                      {

                                                        showToastDialog(context, "PAN no is not valid ");

                                                      }
                                                      else if(fax.isNotEmpty&&fax.length!=10)
                                                      {
                                                        showToastDialog(context, "PAN no. should be 10 digits ");

                                                      }
                                                      else if(address.isEmptyOrNull){

                                                        showToastDialog(context, "Please enter Street ");

                                                      }else if(address2.isEmptyOrNull){

                                                        showToastDialog(context, "Please enter Floor ");

                                                      }
                                                      else if(state.isEmptyOrNull)
                                                      {
                                                        print("Please Select state");
                                                        showToastDialog(context,"Please Select State");
                                                      }
                                                      else if(city.isEmptyOrNull)
                                                      {
                                                        print("Please Select city");
                                                        showToastDialog(context,"Please enter City");
                                                      }else if(postcode.isEmptyOrNull)
                                                      {
                                                        print("Please Select postcode");
                                                        showToastDialog(context,"Please enter Post Code");
                                                      }
                                                      else if(postcode.isNotEmpty&&postcode.length<6)
                                                      {

                                                        print("Post Code should be 6 digits");
                                                        showToastDialog(context,"Post Code should be 6 digits");
                                                      }
                                                      else if(!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(postcode))
                                                      {

                                                        showToastDialog(context, "Special character  not allowed in post code ");

                                                      }

                                                     else if(gstNumber.isEmptyOrNull)
                                                      {
                                                        print("Please Enter Gst Number");
                                                        showToastDialog(context, "Please enter  GST number");

                                                      }
                                                     else
                                                      {
                                                        String gst_regex = "^[0-9]{2}[A-Z]{5}[0-9]{4}" + "[A-Z]{1}[1-9A-Z]{1}" + "Z[0-9A-Z]{1}";
                                                        if(!RegExp(gst_regex).hasMatch(gstNumber))
                                                        {
                                                          print("Please Enter valid GST Number");
                                                          showToastDialog(context, "Please enter valid GST number");

                                                        }
                                                        else
                                                        {
                                                          print("Selected State Code   >>>>>>>>>>>>>>>>>   "+stateCode);
                                                          if(stateCodesList.contains(stateCode))
                                                          {
                                                            int indexofStatecode =  stateCodesList.indexOf(stateCode);
                                                            String selectedSateNo = stateNoList[indexofStatecode];
                                                            print("Selected State No   >>>>>>>>>>>>>>>>>   $selectedSateNo");
                                                            print("Selected State No Match with GST    >>>>>>>>>>>>>>>>>   $selectedSateNo  "+stateCode.startsWith(selectedSateNo).toString());




                                                            if(gstNumber.startsWith(selectedSateNo)==false)
                                                            {
                                                              showToastDialog(context, "Please enter valid GST number with state");
                                                            }
                                                            else
                                                            {

                                                              showProgressDialog(context);
                                                              sendData().then((value){

                                                                print("Sign Up response "+value.toString());
                                                                if(value==200)
                                                                {

                                                                  print("Sign Up success fully ");


                                                                  Navigator.pop(context, false);
                                                                  showToastDialog(context,"Sign up successfully !");

                                                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => S(0),));
                                                                }
                                                                // else
                                                                //   {
                                                                //     Navigator.pop(dialogContext);
                                                                //
                                                                //     print("<<<<<<<<<<<<<<<<<<<<< 400");
                                                                //     showToastDialog(context,"Some thing went wrong ");
                                                                //   }


                                                              });
                                                              //Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentTermsForm(widget.dealer_type,dealerName,contactPerson,email,password,phone,fax,address,address2,state,city,postcode)));

                                                            }


                                                          }


                                                        }



                                                      }



                                                    },
                                                    child: Container(
                                                      width: (width-35),
                                                      padding: EdgeInsets.all(10.0),
                                                      child: Text("Sign Up", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
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
                                                  Text("Already have an account ?", ),
                                                  InkWell(
                                                    child:  Text(" Login",style: TextStyle(color: sh_colorPrimary),),
                                                    onTap: ((){

                                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

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

                                    SizedBox( height: 10,)

                                  ],
                                ),
                 ),


                   ),


          )),
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
  showToastDialog2(BuildContext context,String Message)
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


                                child: Text("Sign In", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
                                textColor: sh_white,
                                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                color: sh_colorPrimary,
                                onPressed: () => {

                                  //DisApproveOrder().launch(context),
                                  Navigator.pop(context, false),

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),)),


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
                        height: 320,

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


                              child: Text("Please wait, While Sign up",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
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
}
