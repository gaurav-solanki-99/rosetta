import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';

class CustomerAccount extends StatefulWidget {

  CustomerAccount({this.navigatorKey, this.child,});


  final Widget child;
  final GlobalKey navigatorKey;



  @override
  CustomerAccounts createState() => CustomerAccounts();
}

class CustomerAccounts extends State<CustomerAccount> {


  String MyuserName="",MymemberName="",MymemberType="",MymemberEmail="";



  @override
  void initState() {
    super.initState();

    getSessionData();

  }
  getSessionData() async
  {
    print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberName = prefs.getString('memberName');
    String  userName = prefs.getString('UserName');
    String  memberType = prefs.getString('memberType');
    String  memberEmail = prefs.getString('memberEmail');

    print(">>>>>>>>>>>Session Token $memberName  $userName $memberType $memberEmail");
    setState(() {
      MymemberName=memberName;
      MyuserName=userName;
      MymemberType=memberType;
      MymemberEmail=memberEmail;
    });


  }
  @override
  Widget build(BuildContext context) {
    return
      MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
        child:

        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child:MyAppBar(true,"",MyuserName,false,true),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(spacing_standard_new),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10, right: spacing_large,left: spacing_large),
                              child: Column(
                                children: <Widget>[
                                  Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    elevation: spacing_standard,
                                    margin: EdgeInsets.all(spacing_control),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Image.asset(ic_user), radius: 55),
                                    ),
                                  ),
                                  SizedBox(height: spacing_middle),

                                ],
                              )),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text("Name :"+MyuserName,style:  TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),),

                    decoration: BoxDecoration(
                      border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text("Member Name :"+MyuserName,style:  TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),),

                    decoration: BoxDecoration(
                      border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text("Member Type :"+MymemberType,style:  TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),),

                    decoration: BoxDecoration(
                      border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text("Email :"+MymemberEmail,style:  TextStyle(color: sh_textColorSecondary, fontFamily: fontRegular, fontSize: textSizeMedium),),

                    decoration: BoxDecoration(
                      border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  ///// THIS BUTTON IS NOT PRESENT IN LIVE UI NEED TO CHECK

                  MaterialButton(
                    padding: EdgeInsets.only(top: 12,bottom:12,left:12,right: 12),
                    minWidth:   double.infinity,

                    child: Text("Delete Account", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.white),),
                    textColor: sh_white,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                    color: Colors.red,
                    onPressed: () => {

                      showDeleteAccountDialog(context)


                    },
                  )

                ],
              ),
            ),
          ),
          endDrawer: MyDrwaer(),
        ),
      );



  }


  showDeleteAccountDialog(BuildContext context)
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
                      height: 170,


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
                                  Container(child:Text("Account Deleted !",style: TextStyle(fontSize: textSizeLargeMedium,fontWeight: FontWeight.bold,color: Colors.red,),)),
                                  Container(),
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              Container(child:Text("Your delete account request is under process our representative will contact you shortly",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),
                              //Container(child:Text("our representative will contact you shortly",style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold,color: Colors.black),)),


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


                                    child: Text("Close", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
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