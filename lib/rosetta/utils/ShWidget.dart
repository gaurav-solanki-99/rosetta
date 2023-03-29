import 'dart:convert';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:rosetta_fluter_app/Services/Distributor/DisHomeScreen.dart';
import 'package:rosetta_fluter_app/Services/Distributor/SelectProductPlaceOrder.dart';
import 'package:rosetta_fluter_app/Services/Distributor/SerchResultProduct.dart';
import 'package:rosetta_fluter_app/Services/Distributor/viewallproductcategory.dart';
import 'package:rosetta_fluter_app/Services/Distributor/viewallsubcategoty.dart';
import 'package:rosetta_fluter_app/Services/loginScreen.dart';
import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/main/utils/dots_indicator/dots_indicator.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';
// import 'package:shop_hop/shopHop/screens/ShCartScreen.dart';
// import 'package:shop_hop/shopHop/screens/ShProductDetail.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';

import '../../Services/Customer/CustomerAccount.dart';
import '../../Services/Distributor/NewDistributorDashBoard.dart';
import '../../Services/Distributor/Photos.dart';
import '../../Services/DistributorDealers/My_Edit_Change/MY_HOME.dart';
import '../../Services/DistributorDealers/My_Edit_Change/my_personaldeail_edit.dart';
import '../../Services/DistributorDealers/ViewDealers.dart';
import '../models/DealersDetails.dart';
import '../models/SkipButtonApi.dart';
import 'ShConstant.dart';
import 'ShFunction.dart';
import 'ShStrings.dart';
import 'package:http/http.dart' as http;




var textFiledBorderStyle = OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(width: 0, color: sh_editText_background));

InputDecoration formFieldDecoration(String hintText) {
  return InputDecoration(
    labelText: hintText,
    focusColor: sh_colorPrimary,
    counterText: "",
    labelStyle: TextStyle(fontFamily: fontRegular, fontSize: textSizeMedium),
    contentPadding: new EdgeInsets.only(bottom: 2.0),
  );
}

// ignore: must_be_immutable

class MyAppBar extends StatelessWidget
{
   bool homeback;
   String title;
   String userName;
   bool isGuestUser;
   bool isEditButton;
   DealersDetsils dealersDetsils;

   MyAppBar(this.homeback,this.title,this.userName,this.isGuestUser, this.isEditButton);



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   //DealersDetsils dealersDetsils;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print("Username >>>>>>>>>>>>>>>>>>>>>>>. @@@@@@@2 "+userName);
    return AppBar(
      backgroundColor: sh_white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,

      iconTheme: IconThemeData(color: sh_textColorPrimary),
      actions: <Widget>[

        userName==""?Container():  Padding(
            padding: EdgeInsets.only(right: 10.0,top: 0.0),
            child: Container(
              width: 150,
              child: GestureDetector(
                  onTap: () {},
                  // child: Text("$userName",overflow: TextOverflow.ellipsis,fontSize: textSizeSMedium,textColor: Colors.black)
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)
                      //Text(userName.length==1?userName:userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)

                    ],
                  )
              ),
            )
        ),
       // EDIT BUTTON

        isEditButton?Container(): Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: ()  {
                // SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);
                //  MYHOME();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyPersonalDeatilsForm("1",true,null,dealersDetsils)));
               // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MYHOME()));
              },
              child: Icon(
                Icons.edit,
                color: secondColor,
                size: 26.0,
              ),
            )
        ),


       isGuestUser?Container(): Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: ()  {
               SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);
                // _pageIndex = 3;

                // Navigator.pop(context, false);
                // Navigator.pop(context);
                // await Navigator.of(context)
                //     .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart")));

               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart"),));
               //  Navigator.pushAndRemoveUntil(
               //      context,
               //      MaterialPageRoute( builder: (context) =>
               //          SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart")),
               //          (Route)=>false);

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
                //_scaffoldKey.currentState.openEndDrawer();

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

                      // Navigator.pop(context);
                      if(this.homeback)
                      {


                      }
                      else
                      {
                        Navigator.of(context).pop();

                      }

                    },
                  child:new Offstage(
                    offstage: homeback,
                    child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 26.0,
                      ),
                  ) ,
                    // child:Visibility(
                    //
                    // child :Icon(
                    //   Icons.arrow_back,
                    //   color: Colors.black,
                    //   size: 26.0,
                    // ),
                    //   maintainSize: true,
                    //   maintainAnimation: true,
                    //   maintainState: true,
                    //   visible: homeback,
                    //
                    // ),

              ),),
          SizedBox(width: 5,),
          Container(

              child: Text(title,style: TextStyle(color: sh_textColorPrimary,fontWeight: FontWeight.bold,fontSize: textSizeMedium),))






        ],
      ),
      elevation: 1,
    );
  }
}
class MyAppBar2 extends StatelessWidget
{
   bool homeback;
   String title;
   String userName;
   bool isGuestUser;



   MyAppBar2(this.homeback,this.title,this.userName,this.isGuestUser);



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print("Username >>>>>>>>>>>>>>>>>>>>>>>. @@@@@@@2 "+userName);
    return AppBar(
      backgroundColor: sh_white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,

      iconTheme: IconThemeData(color: sh_textColorPrimary),
      actions: <Widget>[

        userName==""?Container():  Padding(
            padding: EdgeInsets.only(right: 10.0,top: 0.0),
            child: Container(
              width: 150,
              child: GestureDetector(
                  onTap: () {},
                  // child: Text("$userName",overflow: TextOverflow.ellipsis,fontSize: textSizeSMedium,textColor: Colors.black)
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)
                      //Text(userName.length==1?userName:userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)

                    ],
                  )
              ),
            )
        ),

       isGuestUser?Container(): Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);
                // _pageIndex = 3;


              },
              child: Icon(
                Icons.shopping_cart_outlined,
                color: sh_colorPrimary,
                size: 26.0,
              ),
            )
        ),
        Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
                //_scaffoldKey.currentState.openEndDrawer();

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

                      // Navigator.pop(context);
                      if(this.homeback)
                      {


                      }
                      else
                      {
                       // Navigator.of(context).pop();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(true)));

                      }

                    },
                  child:new Offstage(
                    offstage: homeback,
                    child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.black,
                        size: 26.0,
                      ),
                  ) ,
                    // child:Visibility(
                    //
                    // child :Icon(
                    //   Icons.arrow_back,
                    //   color: Colors.black,
                    //   size: 26.0,
                    // ),
                    //   maintainSize: true,
                    //   maintainAnimation: true,
                    //   maintainState: true,
                    //   visible: homeback,
                    //
                    // ),

              ),),
          SizedBox(width: 5,),
          Container(

              child: Text(title,style: TextStyle(color: sh_textColorPrimary,fontWeight: FontWeight.bold,fontSize: textSizeMedium),))






        ],
      ),
      elevation: 1,
    );
  }
}
class MyAppBar3 extends StatelessWidget
{
   bool homeback;
   String title;
   String userName;
   bool isGuestUser;
   bool isComeBack;



   MyAppBar3(this.homeback,this.title,this.userName,this.isGuestUser,this.isComeBack);



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    print("Username >>>>>>>>>>>>>>>>>>>>>>>. @@@@@@@2 "+userName);
    return AppBar(
      backgroundColor: sh_white,
      automaticallyImplyLeading: false,
      titleSpacing: 0,

      iconTheme: IconThemeData(color: sh_textColorPrimary),
      actions: <Widget>[

        userName==""?Container():  Padding(
            padding: EdgeInsets.only(right: 10.0,top: 0.0),
            child: Container(
              width: 150,
              child: GestureDetector(
                  onTap: () {},
                  // child: Text("$userName",overflow: TextOverflow.ellipsis,fontSize: textSizeSMedium,textColor: Colors.black)
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)
                      //Text(userName.length==1?userName:userName.split(" ")[0],overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: textSizeSMedium,color: Colors.black),)

                    ],
                  )
              ),
            )
        ),

       isGuestUser?Container(): Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);
                // _pageIndex = 3;


              },
              child: Icon(
                Icons.shopping_cart_outlined,
                color: sh_colorPrimary,
                size: 26.0,
              ),
            )
        ),
        Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
                //_scaffoldKey.currentState.openEndDrawer();

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

                      // Navigator.pop(context);
                      if(this.homeback)
                      {


                      }
                      else
                      {
                       // Navigator.of(context).pop();

                        if(isComeBack)
                          {
                            DisHomeScreen(
                              child: Text('Home'),
                              navigatorKey: GlobalKey(),
                            ).launch(context);
                            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewDistributorDashboard(0)));
                          }
                        else
                        {
                          Navigator.of(context).pop();
                        }



                       // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers()));

                      }

                    },
                  child:new Offstage(
                    offstage: homeback,
                    child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 26.0,
                      ),
                  ) ,
                    // child:Visibility(
                    //
                    // child :Icon(
                    //   Icons.arrow_back,
                    //   color: Colors.black,
                    //   size: 26.0,
                    // ),
                    //   maintainSize: true,
                    //   maintainAnimation: true,
                    //   maintainState: true,
                    //   visible: homeback,
                    //
                    // ),

              ),),
          SizedBox(width: 5,),
          Container(

              child: Text(title,style: TextStyle(color: sh_textColorPrimary,fontWeight: FontWeight.bold,fontSize: textSizeMedium),))






        ],
      ),
      elevation: 1,
    );
  }
}





class ProductHorizontalList extends StatelessWidget {
  List<ShProduct> list = [];
  var isHorizontal = false;

  ProductHorizontalList(this.list, {this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: 250,

      child: Scrollbar(
       isAlwaysShown: true,
        child:  ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(right: spacing_standard_new),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: spacing_standard_new),
                width: width * 0.4,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShSubProductSctreen(prodcuts: list, title: sh_lbl_newest_product)));

                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ShProductDetail(product: list[index])));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(


                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset("images/shophop/img/products" + list[index].images[0].src, width: double.infinity, height: 200, fit: BoxFit.fill),

                          // child: Image(
                          //   image: NetworkImage(
                          //       'https://www.tutorialkart.com/img/hummingbird.png'),
                          // ),
                        ),
                      ),

                      Container(
                          margin: EdgeInsets.only(left: 0.0,top: 10.0),
                          child: text(list[index].name, maxLine: 2, textColor: sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeMedium)),


                    ],
                  ),
                ),
              );
            }),
      ),

    );
  }
}

Widget networkImage(String image, {double aWidth, double aHeight, var fit = BoxFit.fill}) {
  return Image.asset(image, width: aWidth, height: aHeight, fit: BoxFit.fill);
}

Widget checkbox(String title, bool boolValue) {
  return Row(
    children: <Widget>[
      Text(title),
      Checkbox(
        activeColor: sh_colorPrimary,
        value: boolValue,
        onChanged: (bool value) {
          boolValue = value;
        },
      )
    ],
  );
}

// ignore: must_be_immutable
class TopBar extends StatefulWidget {
  var titleName;

  TopBar({var this.titleName = ""});

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left, size: 45),
              onPressed: () {
                finish(context);
              },
            ),
            Center(child: text(widget.titleName, textColor: sh_textColorPrimary, fontSize: textSizeNormal, fontFamily: fontBold))
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HorizontalTab extends StatefulWidget {
  final List<String> images;
  var currentIndexPage = 0;

  HorizontalTab(this.images);

  @override
  State<StatefulWidget> createState() {
    return HorizontalTabState();
  }
}

class HorizontalTabState extends State<HorizontalTab> {
  //final VoidCallback loadMore;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 40;
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 2,
          // TODO Without NullSafety  snap list
          /*child: SnapList(
            padding: EdgeInsets.only(left: 16),
            sizeProvider: (index, data) => cardSize,
            separatorProvider: (index, data) => Size(12, 12),
            positionUpdate: (int index) {
              widget.currentIndexPage = index;
            },
            builder: (context, index, data) {
              return ClipRRect(
                borderRadius: new BorderRadius.circular(12.0),
                child: Image.network(
                  widget.images[index],
                  fit: BoxFit.fill,
                ),
              );
            },
            count: widget.images.length,
          ),*/
        ),
        DotsIndicator(
          dotsCount: 3,
          position: widget.currentIndexPage,
          decorator: DotsDecorator(
            color: sh_view_color,
            activeColor: sh_colorPrimary,
          ),
        )
      ],
    );
  }
}

Widget ring(String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.0),
          border: Border.all(width: 16.0, color: sh_colorPrimary),
        ),
      ),
      SizedBox(height: 16),
      text(description, textColor: sh_textColorPrimary, fontSize: textSizeNormal, fontFamily: fontSemibold, isCentered: true, maxLine: 2)
    ],
  );
}

Widget shareIcon(String iconPath) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Image.asset(iconPath, width: 28, height: 28, fit: BoxFit.fill),
  );
}

class Slider extends StatelessWidget {
  final String file;

  Slider({Key key,  this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.asset(file, fit: BoxFit.fill),
      ),
    );
  }
}

class PinEntryTextField extends StatefulWidget {
  final String lastPin;
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  PinEntryTextField({this.lastPin, this.fields: 4, this.onSubmit, this.fieldWidth: 40.0, this.fontSize: 20.0, this.isTextObscure: false, this.showFieldAsBox: false}) : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
   List<String> _pin;
   List<FocusNode> _focusNodes;
   List<TextEditingController> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String>.filled(widget.fields, null, growable: false);
    _focusNodes = List<FocusNode>.filled(widget.fields, null, growable: false);
    _textControllers = List<TextEditingController>.filled(widget.fields, null, growable: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin.length; i++) {
            _pin[i] = widget.lastPin[i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, verticalDirection: VerticalDirection.down, children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach((TextEditingController tEditController) => tEditController.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i].text = widget.lastPin[i];
      }
    }

    _focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {}
    });

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
         keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontFamily: fontMedium, fontSize: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(counterText: "", border: widget.showFieldAsBox ? OutlineInputBorder(borderSide: BorderSide(width: 2.0)) : null),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i].unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i].unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}

Widget divider() {
  return Divider(
    height: 0.5,
    color: sh_view_color,
  );
}

Widget horizontalHeading(var title, {bool showViewAll = true, var callback}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: spacing_standard_new,
      right: spacing_standard_new,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // text("title", fontSize: textSizeLargeMedium, textColor: sh_textColorPrimary, fontFamily: fontBold),
        Text(title,style: TextStyle(fontSize: textSizeLargeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.bold ),),
        showViewAll
            ? GestureDetector(
                onTap: callback,
                child: Container(
                  padding: EdgeInsets.only(left: spacing_standard_new, top: spacing_control, bottom: spacing_control,right: 5),
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(sh_lbl_view_all,style: TextStyle(fontSize: textSizeMedium,color:sh_colorPrimary ,),),
                         Container(color: sh_colorPrimary, width: 55,height: 1, margin: EdgeInsets.only(top: 1),)


                      ],

                  )
                  //text(sh_lbl_view_all, textColor: sh_textColorSecondary, fontFamily: fontMedium),
                ),
              )
            : Container()
      ],
    ),
  );
}

Widget loadingWidgetMaker() {
  return Container(
    alignment: Alignment.center,
    child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: spacing_control,
        margin: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Container(
          width: 45,
          height: 45,
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        )),
  );
}

List<Widget> colorWidget(List<Attribute> attributes) {
  var maxWidget = 6;
  var currentIndex = 0;
  var color;
  List<Widget> list = [];

  attributes.forEach((attribute) {
    if (attribute.name == "Color") {
      color = attribute.options;
    }
  });
  if (color != null) {
    var totalColors = color.length;
    var flag = false;
    color.forEach((color) {
      if (currentIndex < maxWidget) {
        list.add(Container(
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.only(right: spacing_middle),
          decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: sh_textColorPrimary, width: 0.5), color: getColorFromHex(color)),
        ));
        currentIndex++;
      } else {
        if (!flag) list.add(Text('+ ${totalColors - maxWidget} more'));
        flag = true;
        return;
      }
    });
  }

  return list;
}

Widget cartIcon(context, cartCount) {
  return InkWell(
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.only(right: spacing_standard_new),
          padding: EdgeInsets.all(spacing_standard),
          child: SvgPicture.asset(
            sh_ic_cart,
          ),
        ),
        cartCount > 0
            ? Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: spacing_control),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: text(cartCount.toString(), textColor: sh_white, fontSize: textSizeSmall),
                ),
              )
            : Container()
      ],
    ),
    onTap: () {
      // ShCartScreen().launch(context);
    },
    radius: spacing_standard_new,
  );
}

Widget headingText(String content) {
  return text(content, textColor: sh_textColorPrimary, fontFamily: fontMedium, fontSize: textSizeLargeMedium);
}


Widget interNetPopup ()
{
  print("Internet Popup is Active ");
  return Dialog(

      child: StatefulBuilder(

        builder: (BuildContext context, setState) => Container(
          height: 395,
          width:MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 20,bottom: 20),
          child: Column(
            children: [
              Stack(
                children: [


                  Container(
                    child:


                    Image.asset(ic_stock,height: 50,width: 50, fit: BoxFit.fill,),
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
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,

                height: 40,
                child: Text("Stocks Details",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      )
  );

}







class MyDrwaer extends StatefulWidget {
  //const MyDrwaer({Key? key}) : super(key: key);

  @override
  _MyDrwaerState createState() => _MyDrwaerState();
}

class _MyDrwaerState extends State<MyDrwaer> {

  String MymemberType="";

  @override
  void initState() {

    isVisibleSkipApi();
    getSessionData();

    super.initState();


  }

  getSessionData() async
  {
    print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String userName = prefs.getString('UserName');
    String mycompanyId = prefs.getString('companyId');
    String mymemberId = prefs.getString('memberId');
    String mymemberType = prefs.getString('memberType');
    String parent_distributor_id = "0";
    String parent_distributor_nav_id = "0";

    setState(() {
      MymemberType=mymemberType;
    });
  }


  bool isVisibleSkip=false;

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


  get newestProducts => null;
  String UserName = "";

  var _openResult = 'Unknown';
  openMyCatalogFolder()
  async {
    String path =  await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    String name ="Collective";
    var time = DateTime.now().microsecondsSinceEpoch;
    String fullPath = "$path/"+name+"$time.pdf";

    print("My PDf Locations $path");

    print("Open File Methode Call $path");
    var filePath = r''+path;

    final _result = await OpenFile.open(filePath);
    print(_result.message);

    setState(() {
      _openResult = "type=${_result.type}  message=${_result.message}";
    });
  }

  @override
  Widget build(BuildContext context) {

    getUserName();
    return  myDrawer2(context);
  }

  Widget myDrawer2(context)
  {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        elevation: 8,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: sh_white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 60, right: spacing_large,left: spacing_large),
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
                              Container(
                                  child: text("$UserName", textColor: sh_textColorPrimary, fontFamily: fontBold, fontSize: textSizeNormal))
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Container(
                //   color: sh_editText_background,
                //   padding: EdgeInsets.fromLTRB(0, spacing_standard, 0, spacing_standard),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       Expanded(
                //         child: InkWell(
                //           onTap: () {
                //             // ShOrderListScreen().launch(context);
                //           },
                //           child: Column(
                //             children: <Widget>[
                //               text("Total Order", textColor: sh_colorPrimary, fontFamily: fontMedium),
                //               SizedBox(height: spacing_control),
                //               text("15", textColor: sh_textColorPrimary, fontFamily: fontMedium),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: InkWell(
                //           onTap: () {
                //             Navigator.of(context).pop();
                //             // setState(() {
                //             //
                //             // });
                //           },
                //           child: Column(
                //             children: <Widget>[
                //               text("Pending Order", textColor: sh_colorPrimary, fontFamily: fontMedium),
                //               SizedBox(height: spacing_control),
                //               text("10", textColor: sh_textColorPrimary, fontFamily: fontMedium),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(height: 10),


                getDrawerItem(sh_side_icon1, sh_categories, callback: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShViewAllProductScreen()));




                }),
                MymemberType=="Distributor"? getDrawerItem(sh_side_icon_dealers, sh_viewDealers, callback: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDealers(false)));

                  isExit=false;

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewDealers(false)
                      ),
                      ModalRoute.withName("/ShHomeFragment")
                  );
                }):Container(),
                getDrawerItem(sh_side_icon2, sh_search_product, callback: () {

                // DisHomeScreen().launch(context);
                 //  Navigator.pushAndRemoveUntil(
                 //      context,
                 //      MaterialPageRoute(
                 //          builder: (context) =>  DisHomeScreen()
                 //      ),
                 //    (Route<dynamic> route) => false,//  ModalRoute.withName("/ShHomeFragment")
                 //  );

                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => NewDistributorDashboard(0)),
                  //       (Route<dynamic> route) => false,
                  // );

                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewDistributorDashboard(0),));
                  Navigator.pop(context, NewDistributorDashboard(0));
                  DisHomeScreen().launch(context);
                // Navigator.of(context).pushNamedAndRemoveUntil(NewDistributorDashboard(0), (Route<dynamic> route) => false);


                }),
                getDrawerItem(sh_side_icon3, sh_view_cart, callback: () {
                  // ShSettingsScreen().launch(context);
                 // SelectProductPlaceOrder().launch(context);


                  SelectProductPlaceOrder(SelectedValueForSearch:"Self Stock",isCartBlock:"Cart").launch(context);
                }),
                //
                isVisibleSkip == true?getDrawerItem(ic_contactus, "Login", callback: () {
                  LoginScreen().launch(context);
                  // openMyCatalogFolder();
                }) :  getDrawerItem(ic_contactus, "Profile", callback: () {
                  CustomerAccount().launch(context);
                 // openMyCatalogFolder();
                }),
                getDrawerItem(sh_side_icon4, sh_lbl_logOut, callback: () {

                  showAlertDialog(context);

                  // ShSettingsScreen().launch(context);
                }),





                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Image.asset(ic_app_icon_rosetta2, width: 150,height:150 ,fit: BoxFit.fill,),

                      text("V 1.27", textColor: sh_textColorPrimary, fontSize: textSizeSmall)
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
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



  clearSession(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    prefs.remove('username');
    prefs.remove('SelectedTenantBaseURl');
    prefs.remove('password');
    // prefs.remove('token');
    prefs.remove('activityflag');
    prefs.setString('token', "");
    prefs.setString("myTimeStamp","");
    print("Clear Session Methode Called ");





    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //     MaterialPageRoute(builder: (context) => LoginScreen()),);

    Navigator.of(context, rootNavigator:
    true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        LoginScreen()), (route) => false);


    //LoginScreen().launch(context);

  }







  showAlertDialog(BuildContext context) {
    // set up the button

    Widget cancelButton =
    Container(
      color: sh_colorPrimary,
      child: TextButton(
        child: Text("yes",
         style: TextStyle(color: Colors.white),
        ),
        //textColor: Colors.white, color: sh_colorPrimary,
        onPressed: () {
          clearSession(context);



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
       // textColor: Colors.white, color: sh_colorPrimary,
        onPressed: () async {
         // Navigator.pop(context, true);



        },
      ),
    );

    // set up the AlertDialog
    // AlertDialog alert = AlertDialog(
    //   title: Text("Log-out"),
    //   content: Text("Are you want to logout "),
    //   actions: [
    //
    //     cancelButton,
    //     continueButton,
    //   ],
    // );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large

            child: AlertDialog(
              title: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                      ),
                      Text("Log-out"),
                      Container(
                        width: 80,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Are you want to Logout ?")
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
                      width: 80,
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

                        onPressed: () {
                          clearSession(context);


                        },
                      ),
                    ),
                    Container(
                      // color: sh_colorPrimary,
                      height: 40,
                      width: 80,
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
                           Navigator.pop(context1, true);



                        },
                      ),
                    ),
                  ],
                )

              ],
            ),

         // child: AlertDialog(
        //   title: Text("Log-out"),
        //   content: Text("Confirm Logout "),
        //   actions: [
        //
        //     cancelButton,
        //     Container(
        //       color: sh_colorPrimary,
        //       child: TextButton(
        //       child: Text("No",
        //       style: TextStyle(color: Colors.white),
        //       ),
        // //textColor: Colors.white, color: sh_colorPrimary,
        // onPressed: () async {
        //  Navigator.pop(context1, true);
        //
        //
        //
        // },
        // ),
        //     ),
        //   ],
        // ),
          );
      },
    );
  }

  Future<void> getUserName() async {
  //  print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String  userName = prefs.getString('UserName');

   // print("UserName From Session In a Side Bar $userName");

    setState(() {


      UserName=userName;
    });

  }
}
