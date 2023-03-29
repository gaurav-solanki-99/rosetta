import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/Customer/CustomerAccount.dart';
import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShCategory.dart';




import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShFunction.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';

import '../../rosetta/models/SkipButtonApi.dart';
import '../DistributorDealers/ViewDealers.dart';
import 'DisHomeScreen.dart';
import 'DisOrderHistory.dart';
import 'Photos.dart';
import 'SelectProductPlaceOrder.dart';
import 'package:http/http.dart' as http;

class NewDistributorDashboard extends StatefulWidget {
   int SelectedValue=0;


   NewDistributorDashboard(this.SelectedValue);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewDistributorDashboard> {

  int _pageIndex = 0;
  bool bottomVisible;


  DisHomeScreen dishomescreen=DisHomeScreen();


  Map<int, GlobalKey> navigatorKeys =
  {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey(),
    //sj
   // 3: GlobalKey(),


  };







  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  bool isVisibleSkip=false;
  String SelectedValueonHistory;
  List<Widget> children=[
    DisHomeScreen(
      child: Text('Home'),

    ),];
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

  getSessionData() async {
    print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String  userName = prefs.getString('UserName');
    String  mycompanyId = prefs.getString('companyId');
    String  mymemberId = prefs.getString('memberId');
    String  mymemberType = prefs.getString('memberType');
    if(mymemberType=="Distributor"){
      setState(() {
        SelectedValueonHistory="Self Stock";
      });

      print("History >>> Self Stock  ");
    }
    else
      {
        print("History >>> Dealer  ");
        setState(() {
          SelectedValueonHistory="Dealer";
        });
      }

    children = [
      DisHomeScreen(
        child: Text('Home'),
        navigatorKey: navigatorKeys[0],
      ),

      isVisibleSkip?null: DisOrderHistory(
          child: Text('Business'),
          navigatorKey: navigatorKeys[1],
          backArrowVisible: true,
          SelectedValueForSearch:prefs.getString('memberType')=="Distributor"?"Self Stock":"Dealer",
      ),
      //CustomerAccount
      Photos(
        child: Text('Technology'),
        navigatorKey: navigatorKeys[2],
      ),
      CustomerAccount(
        child: Text('Technology'),
        navigatorKey: navigatorKeys[3],
      ),

    ];
  }


  @override
  void initState() {
    super.initState();
     isExit=true;

    _pageIndex=widget.SelectedValue;

    getSessionData();
    isVisibleSkipApi();
    bottomVisible=true;
     getValue();
    //  widget.children = [
    //    DisHomeScreen(
    //     child: Text('Home'),
    //     navigatorKey: navigatorKeys[0],
    //   ),
    //
    //  isVisibleSkip?null: DisOrderHistory(
    //     child: Text('Business'),
    //     navigatorKey: navigatorKeys[1],
    //     backArrowVisible: true,
    //       SelectedValueForSearch:SelectedValueonHistory
    //   ),
    //    //CustomerAccount
    //    Photos(
    //     child: Text('Technology'),
    //     navigatorKey: navigatorKeys[2],
    //   ),
    //    CustomerAccount(
    //     child: Text('Technology'),
    //     navigatorKey: navigatorKeys[3],
    //   ),
    //
    // ];
  }



  bool canback = false;
  List<int> pagelistindex=[];

  Future<bool> _onWillPop() async {

    print("On Back Press >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> "+_pageIndex.toString()+"   "+pagelistindex.toString());

    if (canback == true ) {
      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }else{

      setState(() {

        if(_pageIndex==0 )
        {


          print("isExit >>>>>>> "+isExit.toString());


          if(!isExit)
            {


              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  NewDistributorDashboard(0)
                  ),
                      (Route)=>false
                // ModalRoute.withName("/ShHomeFragment")
              );

            }
         else  if(isExit)
            {

              _onBackPressed(context);


            }



        //  _onBackPressed(context);
        }
        else
          {
            if(pagelistindex.length==1 )
              {
                _pageIndex=0;
                pagelistindex.clear();
              }
             else
               {
                 for (var value in pagelistindex.reversed) {
                   print(" Back Press LOOp  $value ");
                   //
                   // if(_pageIndex==value)
                   //   {
                   //     print(" Back Press LOOp  $value true");
                   //   }
                   //   else
                   //     {
                   //       print(" Back Press LOOp  $value ");
                   //     }
                   _pageIndex=value.toInt();
                   // pagelistindex.indexOf(value)-1;
                   if(value==_pageIndex)
                     {
                       _pageIndex=pagelistindex[pagelistindex.indexOf(value)-1];
                       pagelistindex.remove(value);

                     }
                   if(value!=0)
                   {
                     pagelistindex.remove(value);
                     break;
                   }
               }





            }
          }








        // if(_pageIndex==3)
        //   {
        //
        //     print("**************** 3");
        //     _pageIndex=2;
        //   //  return;
        //   }
        // else if(_pageIndex==2)
        //   {
        //     print("**************** 2");
        //
        //     _pageIndex=1;
        //     //return;
        //   }
        // else if(_pageIndex==1)
        //   {
        //     print("**************** 1");
        //
        //     _pageIndex=0;
        //   }
        //   else if(_pageIndex==0)
        //     {
        //       print("**************** 0");
        //       //canback = true;
        //       _onBackPressed(context);
        //
        //     //  showAlertDialogExit(context);
        //
        //      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        //
        //
        //     }

      });
    }

    Timer(Duration(seconds: 2), () {
      // setState(() {
      //  // canback = false;
      // });
    });
    //canback = true;
  }


  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
        child:

          WillPopScope(


          onWillPop: () async => false,
          child: AlertDialog(
            title: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                    ),
                    Text("Exit"),
                   Container(
                     width: 100,
                   )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              Text("Are You want to Exit ?")
              ],
            ),
            // content: Container(
            //     margin: EdgeInsets.only(left: 60),
            //
            //     child: Text("Confirm Exit QQQ")),
            actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Container(
                       width: 90,
                       height: 40,
                       decoration: BoxDecoration(

                         color: sh_colorPrimary,
                         shape: BoxShape.rectangle,
                         borderRadius: BorderRadius.circular(25),
                       ),

                       child: TextButton(
                         child: Text("Yes",
                           style: TextStyle(color: Colors.white),
                         ),
                         // textColor: Colors.white,
                         // color: sh_colorPrimary,
                         onPressed: () async {
                           exit(0);



                         },
                       ),
                     ),
                     Container(
                       // color: sh_colorPrimary,
                       height: 40,
                       width: 90,
                       decoration: BoxDecoration(

                         color: sh_colorPrimary,
                         shape: BoxShape.rectangle,
                         borderRadius: BorderRadius.circular(25),
                       ),

                       child: TextButton(
                         child: Text("No",
                           style: TextStyle(color: Colors.white),
                         ),
                         // textColor: Colors.white,
                         // color: sh_colorPrimary,
                         onPressed: () async {
                           Navigator.pop(context, true);



                         },
                       ),
                     ),
                   ],
                )
              // Container(
              //    width: 100,
              //   decoration: BoxDecoration(
              //
              //     color: sh_colorPrimary,
              //     shape: BoxShape.rectangle,
              //     borderRadius: BorderRadius.circular(25),
              //   ),
              //
              //   child: TextButton(
              //     child: Text("Yes",
              //      style: TextStyle(color: Colors.white),
              //     ),
              //     // textColor: Colors.white,
              //    // color: sh_colorPrimary,
              //     onPressed: () async {
              //     exit(0);
              //
              //
              //
              //     },
              //   ),
              // ),
              // Container(
              //  // color: sh_colorPrimary,
              //
              //   width: 100,
              //   decoration: BoxDecoration(
              //
              //     color: sh_colorPrimary,
              //     shape: BoxShape.rectangle,
              //     borderRadius: BorderRadius.circular(25),
              //   ),
              //
              //   child: TextButton(
              //     child: Text("No",
              //      style: TextStyle(color: Colors.white),
              //     ),
              //     // textColor: Colors.white,
              //     // color: sh_colorPrimary,
              //     onPressed: () async {
              //       Navigator.pop(context, true);
              //
              //
              //
              //     },
              //   ),
              // ),
            ],
          ),
        ),
          );
      },
    );
  }
  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,


          body: SafeArea(
            child: WillPopScope(
              onWillPop: () async {

               // return !await Navigator.maybePop(navigatorKeys[_pageIndex].currentState.context);
              },
              child:children[_pageIndex],

              // IndexedStack(
              //   index: _pageIndex,
              //   children: widget.children,
              // ),
            ),
          ),

          bottomNavigationBar: Container(

              decoration: BoxDecoration(


                borderRadius: BorderRadius.only(topLeft: Radius.elliptical(90, 20),topRight: Radius.elliptical(90, 20)),


                image: DecorationImage(image: AssetImage('images/shophop/bg_bottom_bar.png'), fit: BoxFit.fill),


              ),
              child:
              Visibility(
                child:  BottomNavigationBar(


                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  selectedItemColor: sh_colorPrimary,



                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(ic_home_item)),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(ic_order)),
                      label: "Order",
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(ic_pdfs)),
                      label: "Catalogs",
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(ic_contactus)),
                      label: "Profile",
                    ),


                  ],
                  currentIndex: _pageIndex,
                  onTap: (int index) {
                    setState(
                          () {
                        _pageIndex = index;
                        print(">>>>>>>>>Bottom Item Clicked $index");
                        pagelistindex.add(index);

                        if(index==0) {
                          // if(navigatorKeys[0].currentState!=null)
                          //   {
                          //     Navigator.maybePop(navigatorKeys[0].currentState.context);
                          //   }


                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewDistributorDashboard(0)
                              ),
                                  (Route)=>false
                            // ModalRoute.withName("/ShHomeFragment")
                          );
                            // DisHomeScreen().launch(context);

                        }

                        // if(index==2)
                        //   {
                        //     Navigator.of(context).push(new MaterialPageRoute(builder: (context) =>  Photos(child: Text('Technology'), navigatorKey: navigatorKeys[2],),));
                        //   }

                        if(index==1)
                        {
                          isInternatAvailable2(context);
                          if(isVisibleSkip)
                          {
                            showToastDialogGuestUser(context, "Please Login ");

                          }

                        }



                      },
                    );
                  },
                ),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: bottomVisible,
              )
          ),

        ),
        onWillPop: _onWillPop);



  }

  Widget getDrawerItem(String icon, String name, {VoidCallback callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
        color: sh_white,
        padding: EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          children: <Widget>[
            icon != null ? Image.asset(icon, width: 20, height: 20) : Container(width: 20),
            SizedBox(width: 20),
            text(name, textColor: sh_textColorPrimary, fontSize: textSizeMedium, fontFamily: fontMedium)
          ],
        ),
      ),
    );
  }
  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('activityflag');
    print("username>>>>>>>>>>>>>>>>>>>>>>$stringValue");
    if(stringValue==null){
      setState(() {
        bottomVisible=false;
        print("value1>>>>>>>>>>>>>>>>>>>>>>$stringValue");
      });
    }
    else{
      setState(() {
        bottomVisible=true;
        print("value2>>>>>>>>>>>>>>>>>>>>>>$stringValue");
      });

    }

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

  showAlertDialogExit(BuildContext context) {
    // set up the button

    Widget cancelButton =
    Container(
      color: sh_colorPrimary,
      child: TextButton(
        child: Text("yes",
         style: TextStyle(color: Colors.white),
        ),
        // textColor: Colors.white,
        // color: sh_colorPrimary,
        onPressed: () {

          SystemChannels.platform.invokeMethod('SystemNavigator.pop');


        },

      ),
    );
    Widget continueButton =
    Container(
      color: sh_colorPrimary,
      child: TextButton(
        child: Text("No",
         style: TextStyle(color: Colors.white),
        ),
        // textColor: Colors.white,
        // color: sh_colorPrimary,
        onPressed: () async {
          // Navigator.pop(context, true);



        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exit"),
      content: Text("Are you want to Exit "),
      actions: [

        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text("Exit"),
          content: Text("Are you want to Exit "),
          actions: [

            cancelButton,
            Container(
              color: sh_colorPrimary,
              child: TextButton(
                child: Text("No"),
                // textColor: Colors.white,
                // color: sh_colorPrimary,
                onPressed: () async {
                  Navigator.pop(context1, true);



                },
              ),
            ),
          ],
        );;
      },
    );
  }
 



}
