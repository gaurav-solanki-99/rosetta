import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/Distributor/NewDistributorDashBoard.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:url_launcher/url_launcher.dart';
import '../rosetta/utils/ShConstant.dart';
import 'loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

 SharedPreferences prefs;



class SplashScreen   extends StatefulWidget {



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  @override
  void initState() {
    // TODO: implement initState\
    super.initState();
    getValue();
   // getPermission();
    // Timer(Duration(seconds: 3),
    //         ()=>Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder:
    //             (context) =>
    //             LoginScreen(),
    //           //DisApproveOrder()
    //             //SelectProductPlaceOrder(),
    //
    //            // NewDistributorDashboard(),
    //         )
    //     )
    // );
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    return  Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: sh_white,


        child: Container(
            alignment: Alignment.center,
            child :Image.asset(ic_app_icon_rosetta2,height: 200,width: 200,  ),

          // Rosetta
          //child :Image.asset(ic_app_icon_rosetta2,height: 250,width: 300,  ),


        ),
      ),
    );
  }

  fetch() async {




    String  username = prefs.getString('username') ?? '';
    print(">>>>>>>>>>>$username");


   // log("\n Int  - "\$"myInt"" \n double - $myDouble \n boolean - $myBool \n string - $myString \n stringlist - $myStringList");
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('username');
    String stringValuetoken = prefs.getString('token');
    String SelectedTenantBaseURl = prefs.getString('SelectedTenantBaseURl');
    // print("Splash SelectedTenantBaseURl >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+SelectedTenantBaseURl);
    if(SelectedTenantBaseURl!=null)
      {
        API_ROS_PROD__BASE_URL=SelectedTenantBaseURl;

      }



    print("username>>>>>>>>>>>>>>>>>>>>>>$stringValue");
    print("token>>>>>>>>>>>>>>>>>>>>>>$stringValuetoken");


    if(stringValuetoken.isEmptyOrNull)
      {
        Timer(Duration(seconds: 3),
                ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),))
        );
      }
    else
      {
        print("On Splash >>>>>>>>>>>>>>>>>>> myTimeStamp1 "+prefs.getString("myTimeStamp"));
        if(prefs.getString("myTimeStamp").isEmpty)
          {
            prefs.setString("myTimeStamp","");
          }
        print("On Splash >>>>>>>>>>>>>>>>>>> myTimeStamp2 "+prefs.getString("myTimeStamp"));

        Timer(Duration(seconds: 2),
                ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewDistributorDashboard(0),)
            )
        );
      }

  }

  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(APP_STORE_URL),
            ),
            TextButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(PLAY_STORE_URL),
            ),
            TextButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}

