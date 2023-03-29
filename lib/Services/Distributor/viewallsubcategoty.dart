import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/Distributor/shproductdetails.dart';
import 'package:rosetta_fluter_app/main/utils/flutter_rating_bar.dart';
import 'package:rosetta_fluter_app/rosetta/models/Collection.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShAttribute.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';
import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';

import '../../rosetta/models/SearchProductsList.dart';
import '../../rosetta/models/SkipButtonApi.dart';
import '../../rosetta/models/SpinnerDealersList.dart';
import '../shimmer_list.dart';
import 'NewProductDetails.dart';
import 'SearchResultProductDetails.dart';



// ignore: must_be_immutable
class ShSubProductSctreen extends StatefulWidget {
  static String tag = '/ViewAllProductScreen';

  List<ShProduct> prodcuts;
  var title;
  var id ;


  ///// NEW DEAIL TEST
  String SelectedDealer2;
  String SelectedValueForSearch;
  //List<ShProduct> mProductModel = [];
  SpinnerSpinnerDealerList spinnerDealerSelectes;
  List<Inventory> listsearchProducts=[];

  ShSubProductSctreen({this.prodcuts, this.title,this.id,this.listsearchProducts,this.SelectedValueForSearch,this.SelectedDealer2, this.spinnerDealerSelectes});





  @override
  ShViewAllProductScreenState createState() {
    return ShViewAllProductScreenState();
  }
}

class ShViewAllProductScreenState extends State<ShSubProductSctreen> {
  var sortType = -1;
  List<ShProduct> mProductModel = [];
  ShAttributes mProductAttributeModel;


//// TEST NEW NEW NEW DETAIL PAGE
//  List<Inventory> listsearchProducts=[];
//   String SelectedValueForSearch;





  var isListViewSelected = false;
  var errorMsg = '';
  var scrollController = new ScrollController();
  bool isLoading = false;
  bool isLoadingMoreData = false;
  int page = 1;
  bool isLastPage = false;
  var primaryColor;
  List<Product> collection = null;
  var collectionName="";

  Future<List<Product>>  getCollection() async{

    var  uri = API_CMS_BASE_URL+'/api/webservices/getProductsByCategoryId';

    var map = new Map<String, dynamic>();
    // map['grant_type'] = 'password';
    // map['client_id'] = '3MVG9dZJodJWITSviqdj3EnW.LrZ81MbuGBqgIxxxdD6u7Mru2NOEs8bHFoFyNw_nVKPhlF2EzDbNYI0rphQL';
    // map['client_secret'] = '42E131F37E4E05313646E1ED1D3788D76192EBECA7486D15BDDB8408B9726B42';
    map['category_id'] = widget.id;




    http.Response response = await http.post(Uri.parse(uri), body: map,);

    var responcebody = response.body;
    var responseCode = response.statusCode;


    Collection.fromJson(json.decode(response.body)).data.products;


    print("Response Body of Form Data Api : $responcebody");
    print("Response code Form Data Api : $responseCode");

    if (200 == response.statusCode) {

      setState(() {
        collection =Collection.fromJson(json.decode(response.body)).data.products;
        collectionName=Collection.fromJson(json.decode(response.body)).data.title;

      });



      return Collection.fromJson(json.decode(response.body)).data.products;
    } else {
      return <Product>[];
    }

  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
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

  @override
  void initState() {
    super.initState();
    fetchData();
    getCollection();
    isVisibleSkipApi();


    var id1 =widget.id;

    print("Id of Selected Product is $id1");
  }

  fetchData() async {
    // var model = await loadAttributes();
    setState(() {
      // mProductAttributeModel = model;
      mProductModel.addAll(widget.prodcuts);
    });
  }



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;



    final gridView = Container(
      child:collection == null ? ShimmerList(): GridView.builder(
          itemCount: mProductModel.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(spacing_middle),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 11, crossAxisSpacing: spacing_middle, mainAxisSpacing: spacing_middle),
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {
                var productmodel=collection[index];
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                //     SearchResultProductDeatails(
                // id: widget.listsearchProducts[index].navId,MyPageTitle:""+widget.listsearchProducts[index].category.displayName,isnavId:true,listsearchProducts:widget.listsearchProducts,SelectedProductDetailt:widget.listsearchProducts[index],
                //     SelectedValueForSearch:widget.SelectedValueForSearch,SelectedDealer2:widget.SelectedDealer2,spinnerDealerSelectes: widget.spinnerDealerSelectes,collectionName:widget.listsearchProducts[index].collection.displayName)));

                NewShProductDetail(Collectionproduct : collection[index],id: collection[index].id,MyPageTitle:collectionName)));
              },
              child: Container(
                // child: Column(
                //   children: [
                //     Container(
                //       height: 150,
                //       width: 200,
                //       padding: EdgeInsets.all(1),
                //       decoration: BoxDecoration(border: Border.all(color: sh_view_color, width: 0.5)),
                //       child: Image.asset(
                //         "images/shophop/img/products" + mProductModel[index].images[0].src,
                //         fit: BoxFit.cover,
                //         width: double.infinity,
                //         height: double.infinity,
                //       ),
                //     ),
                //     SizedBox(height: 2),
                //     Row(
                //       children: <Widget>[
                //         Text(mProductModel[index].name.toString(),style: TextStyle(fontSize: 15),),
                //
                //
                //       ],
                //     ),
                //   ],
                // ),
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
                          child: Image.asset(
                            "images/shophop/img/products" + mProductModel[index].images[0].src,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(mProductModel[index].name.toString(),style: TextStyle(fontSize:20,color: Colors.white,fontWeight: FontWeight.bold),
                          ),


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
    );

    return   MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
    child:
      Scaffold(

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child:MyAppBar(false,collectionName,"",isVisibleSkip,true),
      ),


      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: <Widget>[

            Container(
              child:    collection == null ?ShimmerList():
              GridView.builder(
                  itemCount: collection.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(spacing_middle),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 11, crossAxisSpacing: spacing_middle, mainAxisSpacing: spacing_middle),
                  itemBuilder: (_, index) {
                    return InkWell(

                      onTap: () {
                        print("TTTTTTTTTTTTTTTTTT ");
                        print(widget.listsearchProducts);
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            // SearchResultProductDeatails(
                            //     id: widget.listsearchProducts[index].navId,MyPageTitle:""+widget.listsearchProducts[index].category.displayName,isnavId:true,listsearchProducts:widget.listsearchProducts,SelectedProductDetailt:widget.listsearchProducts[index],
                            //     SelectedValueForSearch:widget.SelectedValueForSearch,SelectedDealer2:widget.SelectedDealer2,spinnerDealerSelectes: widget.spinnerDealerSelectes,collectionName:widget.listsearchProducts[index].collection.displayName)));

                           NewShProductDetail(Collectionproduct:collection[index],MyPageTitle:collectionName ,isnavId:false)));


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
                                      collection[index].productCoverImage,
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
                                    child: Text(collection[index].name,style: TextStyle(fontSize:15,color: Colors.white,fontWeight: FontWeight.bold),
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
      endDrawer:MyDrwaer(),
    ),
    );
  }


}


