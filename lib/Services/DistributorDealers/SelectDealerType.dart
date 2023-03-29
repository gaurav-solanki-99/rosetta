import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosetta_fluter_app/Services/DistributorDealers/PersonalDeatilsForm.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';

import '../../rosetta/utils/ShConstant.dart';
import '../../rosetta/utils/ShImages.dart';

class SelectDealerType extends StatefulWidget {
  const SelectDealerType({Key key}) : super(key: key);

  @override
  _SelectDealerTypeState createState() => _SelectDealerTypeState();
}

class _SelectDealerTypeState extends State<SelectDealerType> {


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
            child:MyAppBar(false,"Add Customer","",false,true),
          ),
          body: SafeArea(
            child: SingleChildScrollView(

              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight:double.infinity,
                    maxWidth:  MediaQuery.of(context).size.width),
                child: Stack(
                  children: [
                     Image.asset(ic_adddealerbg,height:height-100,width: width,fit:BoxFit.cover ,),



                    Container(
                  height: height-100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                       Container(),
                       Container(
                           child: Column(
                             children: [
                               Text("Select appropriate Customer Type",style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,),),
                              SizedBox(height: 20,),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(onTap: (){

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDeatilsForm("1",false, null,null)));

                                    },
                                      child: Container(
                                        width: ((width/2)-20)-50,
                                        padding: EdgeInsets.all(10.0),
                                      child: Text("Dealer", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
                                        decoration: BoxDecoration(
                                          color: sh_colorPrimary,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),

                                          ),

                                    ),
                                    )
                                    ),
                                    SizedBox(width: 10.0,),
                                    InkWell(onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDeatilsForm("2",false, null,null)));

                                    },
                                      child: Container(
                                        width: ((width/2)-20)+50,
                                        padding: EdgeInsets.all(10.0),
                                      child: Text("Retail Customer", textAlign: TextAlign.center,style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.white,),),
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
                              )
                             ],
                           ),
                       ),
                       Container(),
                    ],
                  ),
                ),
                  ],
                )
              ),
            ),
          ),
          endDrawer: MyDrwaer(),
        ));
  }
}
