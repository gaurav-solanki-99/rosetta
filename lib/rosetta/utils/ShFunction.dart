import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/Distributor/SelectProductPlaceOrder.dart';
import 'package:rosetta_fluter_app/main/utils/AppColors.dart';
import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/rosetta/models/SkipButtonApi.dart';

import 'ShColors.dart';
import 'ShConstant.dart';
import 'ShImages.dart';

  Future<bool> isInternatAvailable() async {
  try {

    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet is now connected');
      return true;
    }
  } on SocketException catch (_) {
    print('Intert is not connected');

    return false;
  }
}

Future<bool> isInternatAvailable2(BuildContext context) async {
  try {

    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet is now connected');
      return true;
    }
  } on SocketException catch (_) {
    print('Intert is not connected');
    showAlertStockDialog(context);

    return false;
  }
}

showAlertStockDialog(BuildContext context)
{


  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(

            child: StatefulBuilder(

              builder: (BuildContext context, setState) => Container(
                height: 165,
                width:MediaQuery.of(context).size.width,
                color: sh_no_internet_background,
                padding: EdgeInsets.only(top: 20,bottom: 20),

                child: Column(
                  children: [
                    // Stack(
                    //   children: [
                    //
                    //
                    //     Container(
                    //       child:
                    //
                    //
                    //       Image.asset(ic_no_internet_gif,height: 150,width: 150, fit: BoxFit.fill,),
                    //       alignment: Alignment.topCenter,
                    //     ),
                    //
                    //   ],
                    // ),


                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,

                      height: 40,
                      child: Text("Whoops !",style: TextStyle(color: sh_black,fontSize: 18,fontWeight: FontWeight.bold),),
                    ),

                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,


                      child: Text("No Internet Connection",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,


                      child: Text("Check your Internet connection",style: TextStyle(color: sh_black,fontSize: 14,fontWeight: FontWeight.bold),),
                    ),


                    Container(
                      margin: EdgeInsets.only(top: 5),



                      color: sh_white,
                      child:   Container(
                        color: sh_no_internet_background,

                        child: MaterialButton(
                          padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),


                          child: Text("Exit", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
                          textColor: sh_white,
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                          color: sh_colorPrimary,
                          onPressed: () => {

                            //DisApproveOrder().launch(context),
                         //   Navigator.pop(context, false),
                            exit(0),


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
clearSession(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  prefs.remove('username');
  prefs.remove('password');
  prefs.remove('token');
  prefs.remove('activityflag');
  print("Clear Session Methode Called ");
}
showToastDialogGuestUser(BuildContext context,String Message)
{


  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(

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



        );
      });

}

// Guest User Testing

Future<bool> isGuestUserApi() async {
  var  response;
  String url = "https://laravel.cppatidar.com/rosetta/api/webservices/skip_button";
  try {
      response = await http.get(Uri.parse(url));
    var reult = response.statusCode;
    print("Rsponse Code Of Category Api $reult");
    print(json.decode(response.body));



    print("Response of isVisible Api is >>>>>>>>>>>>>   "+response.body);


     var isVisibleSkip= SkipButtonApi.fromJson(json.decode(response.body)).status;

      print("Result of Skip  isVisible layout >>>>>>>>>>>>   "+isVisibleSkip.toString());



  }
  catch(e)
  {

  }

   return SkipButtonApi.fromJson(json.decode(response.body)).status;

}




showAlertDialogBlocked(BuildContext context) {
  // Create button


  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                    child:Image.asset(ic_notice_blocked,height: 50,width: 50, fit: BoxFit.fill,),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,


                    child: Text("Your Order Now Blocked",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    alignment: Alignment.center,

                    child: IntrinsicWidth(
                      child: MaterialButton(

                        padding: EdgeInsets.only(left: 15,right: 15,top: 13,bottom: 13),
                        child: text("Go To Cart", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                        color: backgroundSearchProductFormButtons,
                        onPressed: () async => {
                          // Navigator.pop(context),
                          //
                          // await Navigator.of(context)
                          // .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder())),
                         // SelectProductPlaceOrder().launch(context),
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectProductPlaceOrder())),




                        },
                        elevation: 0,
                      ),
                    ),
                  ),

                ],
              )),
        );
      });
}
showAlertDialogAddToCart(BuildContext context) {
  // Create button


  showDialog(
      context: context,
      builder: (BuildContext context) {
        return  Dialog(

            child: StatefulBuilder(

              builder: (BuildContext context, setState) {

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


                          child: Text("Please wait,\nYour Order Add To  Cart.....",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          alignment: Alignment.center,

                          child: IntrinsicWidth(
                            child: MaterialButton(

                              padding: EdgeInsets.only(left: 15,right: 15,top: 13,bottom: 13),
                              child: text("Go To Cart", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                              color: backgroundSearchProductFormButtons,
                              onPressed: () async {
                                Navigator.pop(context);
                                await Navigator.of(context)
                                    .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder()));
                                setState((){});

                              },
                              // onPressed: () => {
                              //  // Navigator.pop(context),
                              //   SelectProductPlaceOrder().launch(context),
                              // },
                              elevation: 0,
                            ),
                          ),
                        ),

                      ],
                    )),



              );
                },
            )



        );



      });
}


// Time Stamp Convertor
String readTimestamp(int timestamp) {
  var now = new DateTime.now();
  var format = new DateFormat('HH:mm:ss');
  var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + 'DAY AGO';
    } else {
      time = diff.inDays.toString() + 'DAYS AGO';
    }
  }

  return time;
}



// gettting value from shared Prefrence
Future<String> getValueBaseUrl()
 async {
   SharedPreferences  prefs = await SharedPreferences.getInstance();

   return prefs.getString('SelectedTenantBaseURl');
}



saveValue(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('$key', "$value");

}

Future<String> getValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('$key');
  return stringValue;
}