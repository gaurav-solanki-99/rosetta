import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/DistributorDealers/DealersDetails.dart';
import 'package:rosetta_fluter_app/Services/DistributorDealers/SelectDealerType.dart';
import 'package:rosetta_fluter_app/rosetta/models/SpinnerDealersList.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main/utils/AppColors.dart';
import '../../main/utils/AppWidget.dart';
import '../../rosetta/utils/ShColors.dart';
import '../../rosetta/utils/ShConstant.dart';
import '../../rosetta/utils/ShFunction.dart';
import '../../rosetta/utils/ShImages.dart';
import '../../rosetta/utils/ShWidget.dart';
import 'package:http/http.dart' as http;

import '../Distributor/DisHomeScreen.dart';
import '../Distributor/SelectProductPlaceOrder.dart';
import '../shimmer_list.dart';
import 'My_Edit_Change/my_dealer_details.dart';
import 'PersonalDeatilsForm.dart';


SharedPreferences prefs;




class ViewDealers extends StatefulWidget {

  bool isComeback = false;
   // ViewDealers({Key key}) : super(key: key);
   ViewDealers(this.isComeback);

  @override
  _ViewDealersState createState() => _ViewDealersState();
}

class _ViewDealersState extends State<ViewDealers> {
  var checkNetconnection = null;
  String MyToken;
  String MyUserName = "";
  String MyCompanyId;
  String MyMemberId;
  String MyMemberType;
  String Myparent_distributor_id;
  String Myparent_distributor_nav_id;
  String selectedTranspor = "Select Address";
  List<String> spinnerSelectTransporterDetails = ["Select Address", "1", "2"];
  List<SpinnerSpinnerDealerList> spinnerDelerList = [];
  List<SpinnerSpinnerDealerList> spinnerDelerLis2 =[];
  List<SpinnerSpinnerDealerList> spinnerDelerLisTemp =[];

  List<String> spinnerSelectDealer2 = [];
  String SelectedDealer2 = "";
  SpinnerSpinnerDealerList spinnerDealerSelectes = null;
  SpinnerSpinnerDealerList selectedDeraler= null;
  bool isSelectedDealerVisible = false;
  String selected_dealer="";
  bool isFilterdDataNotAvailable= false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //isExit=true;
    getSessionData();
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
        getDealerList();
      }
      if (checkNetconnection != null) {
        print("Please check your Internet Connection ");
        // showAlertStockDialog(context);
        //interNetPopup();
      }
    }
  }


  Future<List<SpinnerSpinnerDealerList>> getDealerList() async {
    print("Get SpinnerDealer List Methode Call >>>>>>>>>>>>>>>>>> Home Screen");

    //?sort=&page=1&per_page=20

    http.Response response = await http.get(Uri.parse(API_ROS_PROD__BASE_URL +
        '/api/companies/$MyCompanyId/distributors/$MyMemberId/dealers'),
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );
    var responcebody = response.body;
    var responseCode = response.statusCode;
    print(
        "Response Body of Form SpinnerDealer List Methode   Data Api : $responcebody");
    print(
        "Response code Form SpinnerDealer List Methode  Data Api : $responseCode");

    // int inventoryLength =  newCartItesmFromJson(json.decode(response.body)).length;
    //
    // print("New Cart List Length >>>>>>>>>>>>>>> $inventoryLength");
    setState(() {
      //NewDealerList.fromJson(json.decode(str));
      // newCartItesmFromJson(response.body);
      spinnerDelerList = spinnerSpinnerDealerListFromJson((response.body)).reversed.toList();
      spinnerDelerLisTemp = spinnerSpinnerDealerListFromJson((response.body)).reversed.toList();

      if (responseCode == 200) {
        for (int i = 0; i < spinnerDelerList.length; i++) {
          // spinnerSelectCollectionDealer.add(SelectAutoSuggestDealer(spinnerDelerList[i].id, spinnerDelerList[i].name));
          //loop



        }

        getDelaerSpinnerList();
      }
    });


    int newinventoryLength = spinnerDelerList.length;
    print(
        "New SpinnerDealer List   Length >>>>>>>>>>>>>>> $newinventoryLength");
    // SpinnerSpinnerDealerList.fromJson(json.decode(response.body));
  }

  getDelaerSpinnerList() async {
    print("Get Spinner Dealer List Methode Call");

    var length = spinnerDelerList.length;
    print(" Spinner Dealer List   lsi length is $length");

    for (int i = 0; i < spinnerDelerList.length; i++) {
      var displayname;
    //  var emailtest;
      print(" Spinner Dealer List  Loop is Called ");
      setState(() {
        if (i == 0) {
          //spinnerSelectDealer2.add("Select Dealer");
          spinnerSelectDealer2.add("Self Stock");

          spinnerSelectDealer2.add(spinnerDelerList[i].name);
          // TttttESSSSSSSSSSSSSSSSSSSST
          //spinnerSelectDealer2.add(spinnerDelerList[i].userEmail);
        //  emailtest = spinnerSelectDealer2[i];

          displayname = spinnerSelectDealer2[i];
        }
        else {

          spinnerSelectDealer2.add(spinnerDelerList[i].name);
          displayname = spinnerSelectDealer2[i];

          // TESTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT

           //spinnerSelectDealer2.add(spinnerDelerList[i].userEmail);
         // emailtest = spinnerSelectDealer2[i];
        }

        SelectedDealer2 = spinnerSelectDealer2[0];
      });

      int lengthOFSpinnerLsit = spinnerSelectDealer2.length;
      print("List of Spinner List Lenght After $lengthOFSpinnerLsit");


      print(" Spinner Dealer List   Name $displayname");

     // print("EEEEEEEEEEEEEETTTTTTTTTTTTTTTTTT $emailtest ");
    }
  }


  _launchCaller(String number) async {
    var url = "tel:" + number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _Search()
  {
    spinnerDelerLis2.clear();
    print("Temp Dealr Lis  is "+spinnerDelerLisTemp.toString());
    spinnerDelerList=spinnerDelerLisTemp;
     int length = spinnerDelerList.length;
     String name = selected_dealer.toLowerCase();

     print("Searched Named "+name);
     for(int i=0;i<spinnerDelerList.length;i++)
       {
         String dealersNames = spinnerDelerList[i].name.toLowerCase();
         SpinnerSpinnerDealerList obj = spinnerDelerList[i];
         if(dealersNames.contains(name))
           {
             spinnerDelerLis2.add(obj);
             print("Find Named "+name);


           }
       }


     print("Filtered List  Named "+spinnerDelerLis2.length.toString()+"  "+spinnerDelerLis2.toString());

     if(spinnerDelerLis2.length==0)
       {
         print("Data Not Found ");
        // showToastDialog(context,"Dealer Not Found ");
         setState(() {

           isFilterdDataNotAvailable=true;
         });

       }
     else
       {
         setState(() {
           //spinnerDelerLisTemp=spinnerDelerList;
           spinnerDelerList=spinnerDelerLis2;
         });


       }




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
                                  padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),


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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: textWholeApp),
        // Large
        child: Scaffold(
          key: _scaffoldKey,
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
                              Scaffold.of(context).openEndDrawer();
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

                                  DisHomeScreen(
                                child: Text('Home'),
                                navigatorKey: GlobalKey(),
                              ).launch(context);
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

                            child: Text("My Dealers",style: TextStyle(color: sh_textColorPrimary,fontWeight: FontWeight.bold,fontSize: textSizeMedium),))

                      ],
                    ),
                    elevation: 1,
                  )
                //child: MyAppBar3(false, "My Dealers", "", false,widget.isComeback),
              ),
              body: SafeArea(
                child: SingleChildScrollView(

                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: double.infinity,
                        maxWidth: MediaQuery
                            .of(context)
                            .size
                            .width),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 0),
                          padding: EdgeInsets.only(
                              top: 10, left: 15, bottom: 10),
                          color: sh_ColorPrimary2,
                          child: Text("Search Dealer", style: TextStyle(
                              fontSize: 18.0,
                              color: sh_textColorPrimary,
                              fontWeight: FontWeight.bold),),
                        ),


                        Container(
                          color: sh_ColorPrimary2,
                          padding: EdgeInsets.only(
                              top: 0, left: 15, bottom: 10, right: 15),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              MyMemberType == "Distributor" ?    Container(
                               width: width - 78,
                            height: 40,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              textCapitalization:
                              TextCapitalization.words,
                              style: TextStyle(
                                  color: sh_textColorSecondary,
                                  fontFamily: fontRegular,
                                  fontSize: textSizeSMedium),
                              decoration: InputDecoration(
                                  filled: true,

                                  suffixIcon: IconButton(
                                      onPressed: _Search,
                                      icon:Icon(
                                        Icons.search,
                                        color:
                                        sh_colorPrimary,
                                        size: 20,
                                      )
                                  ),
                                  fillColor:
                                  backgroundSearchProductFormInput,
                                  focusColor:
                                  sh_editText_background_active,
                                  hintText: "Search Dealer",
                                  hintStyle: TextStyle(
                                      color: sh_textColorSecondary,
                                      fontFamily: fontRegular,
                                      fontSize: textSizeSmall),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      10.0, 15.0, 20.0, 15.0),
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

                              onChanged: ((value){
                                print("Selected Order Number is "+value);
                                selected_dealer = value;
                                if(value.isEmptyOrNull)
                                {
                                  setState(() {
                                    isFilterdDataNotAvailable=false;

                                    if(spinnerDelerLis2.isNotEmpty)
                                      {
                                        spinnerDelerList=spinnerDelerLisTemp;
                                        spinnerDelerLis2.clear();


                                      }


                                  });
                                }

                              }),
                            ),
                            decoration: BoxDecoration(

                              border: Border.all(color: sh_textColorSecondarylight,width: 1,),
                              borderRadius: BorderRadius.all(Radius.circular(round_border_form)),
                            ),
                          ) : Container(),
                              SizedBox(width: 10,),
                              Container(


                                child: InkWell(
                                  child: Image.asset(ic_plus, height: 35,
                                    width: 35,
                                    color: sh_colorPrimary,
                                    fit: BoxFit.fill,),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            SelectDealerType()));
                                  },
                                ),


                              ),
                            ],
                          ),
                        ),



                        isSelectedDealerVisible&&selectedDeraler!=null?Container(

                          margin: EdgeInsets.only(bottom: 0,
                              left: 15,
                              right: 15,
                              top: 15),

                          padding: EdgeInsets.all(10.0),


                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .start,
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children:
                            [

                              Text(""+selectedDeraler.name, style: TextStyle(
                                  fontSize: textSizeLargeMedium,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Text(""+selectedDeraler.navId, style: TextStyle(
                                  color: sh_colorPrimary,
                                  fontSize: textSizeMedium,
                                  fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.person, size: 15,
                                    color: sh_colorPrimary,),
                                  // Image.asset(ic_circularGreenCheckBox,height:15,width: 15,),
                                  SizedBox(width: 5,),
                                  Text(""+selectedDeraler.name, style: TextStyle(
                                    color: sh_textColorSecondarylight2,
                                    fontSize: textSizeSMedium,),),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Icon(Icons.email, size: 15,
                                        color: sh_colorPrimary,),

                                      // Image.asset(ic_circularGreenCheckBox,height:15,width: 15,),
                                      SizedBox(width: 5,),

                                      AutoSizeText(
                                        selectedDeraler.email.isEmptyOrNull ? "N/A" : selectedDeraler.email,
                                        maxLines: 1,
                                          style: TextStyle(
                                            color: sh_textColorSecondarylight2,
                                            fontSize: textSizeSMedium,),
                                      )
                                      // Text("" +
                                      //     (
                                      //         selectedDeraler.email.isEmptyOrNull ? "N/A" : selectedDeraler.email
                                      //        // selectedDeraler.userEmail.isEmptyOrNull ? "N/A" : selectedDeraler.userEmail
                                      //     ),
                                      //   style: TextStyle(
                                      //     color: sh_textColorSecondarylight2,
                                      //     fontSize: textSizeSMedium,),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Icon(Icons.phone, size: 15,
                                        color: sh_colorPrimary,),

                                      // Image.asset(ic_circularGreenCheckBox,height:15,width: 15,),
                                      SizedBox(width: 5,),
                                      InkWell(
                                        onTap: () {
                                          if (selectedDeraler.phone.isEmptyOrNull
                                          //selectedDeraler.userPhone.isEmptyOrNull
                                          ) {

                                          }
                                          else {
                                            _launchCaller(
                                                selectedDeraler.phone
                                             //   selectedDeraler.userPhone
                                            );
                                          }
                                        },
                                        child:
                                        AutoSizeText(
                                          selectedDeraler.phone.isEmptyOrNull ? "N/A" : "+91 " + selectedDeraler.phone,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: sh_textColorSecondarylight2,
                                            fontSize: textSizeSMedium,),
                                        )
                                        // Text(
                                        //   (
                                        //
                                        //       selectedDeraler.phone.isEmptyOrNull ? "N/A" : "+91 " + selectedDeraler.phone
                                        //       //  selectedDeraler.userPhone.isEmptyOrNull ? "N/A" : "+91 " + selectedDeraler.userPhone
                                        //   ),
                                        //   style: TextStyle(
                                        //     color: sh_textColorSecondarylight2,
                                        //     fontSize: textSizeSMedium,),),
                                      ),
                                    ],
                                  ),
                                ],
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
                        ):
                        isFilterdDataNotAvailable?Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Container(
                                 child: Text("No Data Available"),
                              ),
                              Container(),
                            ],
                          ),
                        ):Container(
                            child: spinnerDelerList.isNotEmpty ? ListView
                                .builder(

                                scrollDirection: Axis.vertical,
                                itemCount: spinnerDelerList.length,
                                // list.length,
                                //listsearchProducts
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,

                                itemBuilder: (context, index) {
                                  String name = spinnerDelerList[index].name;
                                  String companyName = spinnerDelerList[index]
                                      .company.name;
                                  String NavId = spinnerDelerList[index].navId;
                                  String user_email = spinnerDelerList[index].userEmail.isEmptyOrNull ? "N/A" : spinnerDelerList[index].userEmail;
                                  String user_email1 = spinnerDelerList[index].email.isEmptyOrNull ? "N/A" : spinnerDelerList[index].email;
                                 // String user_email = spinnerDelerList[index].userEmail.isEmptyOrNull ? "N/A" : spinnerDelerList[index].userEmail;
                                  String user_phone1 = spinnerDelerList[index].userPhone.toString() == null ? "N/A" : spinnerDelerList[index].userPhone.toString();
                                  String user_phone = spinnerDelerList[index].phone.toString() == null ? "N/A" : spinnerDelerList[index].phone.toString();
                                   print("TTTTTTTTTTTTTTTTTTttttttttt");
                                   print(user_phone);
                                  print(user_phone1);
                                  // print(user_email);
                                  // print(user_email1);
                                  return InkWell(
                                    onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context) => DealersDeatails(spinnerDelerList[index].id.toString())));
                                           // TEST
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyDealersDeatails(spinnerDelerList[index].id.toString())));
                                    },

                                    child :Container(



                                    margin: EdgeInsets.only(bottom: 0,
                                        left: 15,
                                        right: 15,
                                        top: 15),

                                    padding: EdgeInsets.all(10.0),


                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children:
                                      [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(

                                              child: Text("$name", style: TextStyle(
                                                  fontSize: textSizeLargeMedium,
                                                  color: Colors.black,

                                                  fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                                              width: (width/2)+15,
                                            ),

                                            InkWell(
                                              child: Icon(Icons.more_vert_sharp, color: sh_colorPrimary,),
                                              onTap: (){
                                              },
                                            )
                                          ],
                                        ),


                                        SizedBox(height: 10,),
                                        Text("$NavId", style: TextStyle(
                                            color: sh_colorPrimary,
                                            fontSize: textSizeMedium,
                                            fontWeight: FontWeight.bold),),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Icon(Icons.person, size: 15,
                                              color: sh_colorPrimary,),
                                            // Image.asset(ic_circularGreenCheckBox,height:15,width: 15,),
                                            SizedBox(width: 5,),
                                            Container(

                                              child: Text(""+spinnerDelerList[index].name, style: TextStyle(
                                                color: sh_textColorSecondarylight2,
                                                fontSize: textSizeSmall,),),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [Icon(Icons.email, size: 12, color: sh_colorPrimary,),

                                                // Image.asset(ic_circularGreenCheckBox,height:15,width: 15,),
                                                SizedBox(width: 3,),
                                                AutoSizeText(
                                                    user_email1.isEmptyOrNull ? "N/A" : user_email1,
                                                     maxLines: 2,
                                                    style: TextStyle(
                                                      color: sh_textColorSecondarylight2,
                                                     fontSize: textSizeSMedium,

                                                    ),
                                                )


                                                // Text("" +
                                                //     (user_email1.isEmptyOrNull ? "N/A" : user_email1
                                                //
                                                //         //    user_email.isEmptyOrNull ? "N/A" : user_email
                                                //     ),
                                                //   style: TextStyle(
                                                //     color: sh_textColorSecondarylight2,
                                                //     fontSize: textSizeSMedium,),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Icon(Icons.phone, size: 13,
                                                  color: sh_colorPrimary,),

                                                // Image.asset(ic_circularGreenCheckBox,height:15,width: 15,),
                                                SizedBox(width: 3,),
                                                InkWell(
                                                  onTap: () {
                                                    if (user_phone1.isEmptyOrNull) {

                                                    }
                                                    else {
                                                      _launchCaller(user_phone1);
                                                    }
                                                  },
                                                  child:


                                                  AutoSizeText(
                                                      user_phone1.isEmptyOrNull ? "N/A" : "+91 " + user_phone1,
                                                    maxLines: 1,
                                                      style: TextStyle(
                                                        color: sh_textColorSecondarylight2,
                                                        fontSize: textSizeSMedium,
                                                      )
                                                  )
                                                  // Text(
                                                  //   (
                                                  //   user_phone.isEmptyOrNull
                                                  //       ? "N/A"
                                                  //       : "+91 " + user_phone),
                                                  //   style: TextStyle(
                                                  //     color: sh_textColorSecondarylight2,
                                                  //     fontSize: textSizeSMedium,),),
                                                ),
                                              ],
                                            ),
                                          ],
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
                                  ));
                                }
                            ) :
                            ShimmerDisOrderHistory()
                        ),
                      ],
                    ),
                  ),

                ),
              ),
              endDrawer: MyDrwaer(),
            ));
  }

  Future<bool> _onWillPop() async {
    _onBackPressed(context);
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return
          MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaleFactor: textWholeApp), // Large
            child:

            WillPopScope(


              onWillPop: () async => false,
              child: AlertDialog(
                title: Text("Exit"),
                content: Text("Confirm Exit"),
                actions: [

                  Container(
                    color: Colors.red, //sh_colorPrimary,
                    child: TextButton(
                      child: Text("Yes",
                       style: TextStyle(color: Colors.white),
                      ),
                      // textColor: Colors.white,
                      //
                      // color: sh_colorPrimary,
                      onPressed: () async {
                        exit(0);
                      },
                    ),
                  ),
                  Container(
                    color: sh_colorPrimary,
                    child: TextButton(
                      child: Text("No",
                       style: TextStyle(color: Colors.white),
                      ),
                      // textColor: Colors.white,
                      //
                      // color: sh_colorPrimary,
                      onPressed: () async {
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}

