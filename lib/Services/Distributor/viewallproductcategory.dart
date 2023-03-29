import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/Distributor/shproductdetails.dart';
import 'package:rosetta_fluter_app/Services/Distributor/viewallsubcategoty.dart';
import 'package:rosetta_fluter_app/main/utils/flutter_rating_bar.dart';
import 'package:rosetta_fluter_app/rosetta/models/Category.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShAttribute.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';
import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';

import '../shimmer_list.dart';



// ignore: must_be_immutable
class ShViewAllProductScreen extends StatefulWidget {
  static String tag = '/ViewAllProductScreen';
  //
  // List<ShProduct> prodcuts;
  // var title;
  //
  // ShViewAllProductScreen({this.prodcuts, this.title});

  @override
  ShViewAllProductScreenState createState() {
    return ShViewAllProductScreenState();
  }
}

class ShViewAllProductScreenState extends State<ShViewAllProductScreen> {


  List<Datum> category=null;



  Future<List<Datum>> getList() async {
    String url = API_CMS_BASE_URL+"/api/webservices/categories";
    try {
      final response = await http.get(Uri.parse(url));
      var reult = response.statusCode;
      print("Rsponse Code Of Category Api $reult");
      print(json.decode(response.body));


      if (200 == response.statusCode) {

        setState(() {
          category = CategoryCMS
              .fromJson(json.decode(response.body))
              .data;
        });



        return CategoryCMS
            .fromJson(json.decode(response.body))
            .data;
      } else {
        return <Datum>[];
      }
    } catch (e) {
      return <Datum>[];
    }
  }


  var sortType = -1;
  List<ShProduct> mProductModel = [];
  ShAttributes mProductAttributeModel;

  var isListViewSelected = false;
  var errorMsg = '';
  var scrollController = new ScrollController();
  bool isLoading = false;
  bool isLoadingMoreData = false;
  int page = 1;
  bool isLastPage = false;
  var primaryColor;

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getList();
    fetchData();
    getSessionData();
  }

  //
  String MyUserName="";
  getSessionData() async
  {
    print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String userName = prefs.getString('UserName');
    String mycompanyId = prefs.getString('companyId');
    String mymemberId = prefs.getString('memberId');

    print(
        ">>>>>>>>>>>Session Token $token  $userName $mycompanyId $mycompanyId");
    setState(() {

      MyUserName = userName;

    });
  }

  fetchData() async {
    // var model = await loadAttributes();
    setState(() {
      // mProductAttributeModel = model;
      //mProductModel.addAll(widget.prodcuts);
    });
  }

  void onListClick(which) {
    setState(() {
      if (which == 1) {
        isListViewSelected = true;
      } else if (which == 2) {
        isListViewSelected = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;


    return  MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp),

      child :Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child:MyAppBar(false,"Home",MyUserName,false,true),
      ),

      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: <Widget>[
            Container(
              child:    category == null ? ShimmerList() :
              GridView.builder(
                  itemCount: category.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(spacing_middle),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 11, crossAxisSpacing: spacing_middle, mainAxisSpacing: spacing_middle),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ShSubProductSctreen(prodcuts: mProductModel, title: sh_lbl_newest_product,id:  category[index].id)));

                      },
                      child: Container(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 9 / 11,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 0.5)),
                                    child:
                                    Image.network(
                                      category[index].sliderImage,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                    // Image.asset(
                                    //   "images/shophop/img/products" + newestProducts[index].images[0].src,
                                    //   fit: BoxFit.cover,
                                    //   width: double.infinity,
                                    //   height: double.infinity,
                                    // ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(category[index].title,style: TextStyle(fontSize:15,color: Colors.white,fontWeight: FontWeight.bold),
                                    ),
                                    decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1)),

                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 2),

                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      endDrawer: MyDrwaer(),
    ));
  }


}


