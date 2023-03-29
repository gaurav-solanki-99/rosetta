import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rosetta_fluter_app/Services/Distributor/viewallproductcategory.dart';
import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/main/utils/dots_indicator/dots_indicator.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShCategory.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';

class CustomerHome extends StatefulWidget {
  CustomerHome({this.navigatorKey, this.child});

  final Widget child;
  final GlobalKey navigatorKey;
  static String tag = '/ShHomeFragment';

  @override
  ShHomeFragmentState createState() => ShHomeFragmentState();
}

class ShHomeFragmentState extends State<CustomerHome> {
  List<ShCategory> list = [];
  List<String> banners = [];
  List<ShProduct> newestProducts = [];
  List<ShProduct> featuredProducts = [];
  var position = 0;
  var colors = [sh_cat_1, sh_cat_2, sh_cat_3, sh_cat_4, sh_cat_5];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    loadCategory().then((categories) {
      setState(() {
        list.clear();
        list.addAll(categories);
      });
    }).catchError((error) {
      toasty(context, error);
    });
    List<ShProduct> products = await loadProducts();
    List<ShProduct> featured = [];
    products.forEach((product) {
      if (product.featured) {
        featured.add(product);
      }
    });
    List<String> banner = [];
    for (var i = 1; i < 5; i++) {
      banner.add("images/shophop/img/products/banners/b" + i.toString() + ".jpg");
    }
    setState(() {
      newestProducts.clear();
      featuredProducts.clear();
      banners.clear();
      banners.addAll(banner);
      newestProducts.addAll(products);
      featuredProducts.addAll(featured);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width;

    return Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: (RouteSettings settings)
        {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context)
              {
                return Scaffold(
                  body: newestProducts.isNotEmpty
                      ? SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          MyAppBar(false,"Home","",false,true),
                          Container(
                            height: height * 0.55,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                PageView.builder(
                                  itemCount: banners.length,
                                  itemBuilder: (context, index) {
                                    return Image.asset(banners[index], width: width, height: height * 0.55, fit: BoxFit.cover);
                                  },
                                  onPageChanged: (index) {
                                    setState(() {
                                      position = index;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DotsIndicator(
                                    dotsCount: banners.length,
                                    position: position,
                                    decorator: DotsDecorator(
                                      color: sh_view_color,
                                      activeColor: sh_colorPrimary,
                                      size: const Size.square(7.0),
                                      activeSize: const Size.square(10.0),
                                      spacing: EdgeInsets.all(3),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          horizontalHeading(sh_lbl_newest_product, callback: () {
                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => ShViewAllProductScreen(prodcuts: newestProducts, title: sh_lbl_newest_product)));
                          }),
                          ProductHorizontalList(newestProducts),

                          horizontalHeading(sh_lbl_Featured, callback: () {
                           // Navigator.push(context, MaterialPageRoute(builder: (context) => ShViewAllProductScreen(prodcuts: featuredProducts, title: sh_lbl_Featured)));
                          }),
                          ProductHorizontalList(featuredProducts),

                        ],
                      ),
                    ),
                  )
                      : Container(),
                  endDrawer:MyDrwaer(),
                );
              }
          );
        }

    );



  }
}
