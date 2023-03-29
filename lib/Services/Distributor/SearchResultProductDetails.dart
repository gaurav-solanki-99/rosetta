import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rosetta_fluter_app/main.dart';
import 'package:rosetta_fluter_app/main/utils/AppColors.dart';
import 'package:rosetta_fluter_app/main/utils/AppWidget.dart';
import 'package:rosetta_fluter_app/main/utils/percent_indicator/linear_percent_indicator.dart';
import 'package:rosetta_fluter_app/main/utils/rating_bar.dart';
import 'package:rosetta_fluter_app/rosetta/models/Collection.dart';
import 'package:rosetta_fluter_app/rosetta/models/CollectionCategory.dart';
import 'package:rosetta_fluter_app/rosetta/models/PDFResponse.dart';
import 'package:rosetta_fluter_app/rosetta/models/SearchProductsList.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShProduct.dart';
import 'package:rosetta_fluter_app/rosetta/models/ShReview.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShColors.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShConstant.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShExtension.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShFunction.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShImages.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShStrings.dart';
import 'package:rosetta_fluter_app/rosetta/utils/ShWidget.dart';

import '../../main/utils/dots_indicator/src/dots_decorator.dart';
import '../../main/utils/dots_indicator/src/dots_indicator.dart';
import '../../rosetta/models/SkipButtonApi.dart';
import '../../rosetta/models/SpinnerDealersList.dart';
import 'DisSelectedInventory.dart';
import 'SelectProductPlaceOrder.dart';

class SearchResultProductDeatails  extends StatefulWidget {
  static String tag = '/ShProductDetail';
  ShProduct product;
  Product Collectionproduct;
  var productImage;
  var id;
  var MyPageTitle;
  bool isnavId=false;
  List<Inventory> listsearchProducts=[];
  Inventory SelectedProductDetailt;
  String SelectedValueForSearch;
  String SelectedDealer2;
  SpinnerSpinnerDealerList spinnerDealerSelectes;
  String rateTypeDescription="";
  String plankSize="0",in_multipels="0";
  String SelectedQuantity="0";
  String collectionName="";


  SearchResultProductDeatails(
      {this.Collectionproduct,
        this.id,
        this.MyPageTitle,
        this.isnavId,
        this.listsearchProducts,
        this.SelectedProductDetailt,
        this.SelectedValueForSearch,
        this.SelectedDealer2,
        this.spinnerDealerSelectes,
        this.rateTypeDescription,
        this.plankSize,
        this.in_multipels,
        this.SelectedQuantity,
        this.collectionName
      });


  @override
  _NewShProductDetailState createState() => _NewShProductDetailState();
}

class _NewShProductDetailState extends State<SearchResultProductDeatails>with TickerProviderStateMixin {

  var selectedBackGroundImage="http://52.221.47.8/public/templates/skin1/images/no_image.jpg";


  ScrollController _scrollController;
  bool _showBackToTopButton = false;
  int selectedStcokindex;
  String selectedStockSource;
  bool  FlagOnSelectedInventory=true;
  String slectedStockSourceQuantity;


  var Stocklist1 = [];
  Image imgUpstock =  Image.asset(ic_check,height: 20,width: 20,);
  Image imgDownstock =  Image.asset(ic_uncheck,height: 20,width: 20,);
  bool ischeckstock=false;

  String SelectedCategory="";


  var isSwitched = true;
  var toggleText  = "RL";
  double Newprice = 2500;
  double  TempNewPrice=0;

  var  value  = false;
  var ProductImageGet = "";
  var selectedColorCode="";
  var seletedNavID="";

  List<ProductColor> prodcutsColorList;
  var CoverImageURL="";
  ////// NEW
  String collectionName = "";
  int search_response_code;
  bool isgetCatergorryLoad = true ;

  //nw
  String PageTitle ="";
  List<ProductAttribute> productAttributes=[];

  List<String> lsitHeadings=[];
  List<String> listDescriptions=[];

  List<ProductCertificate>  listProductCertificate= [];
  List<String> banners=[];
  int positions=0;
  Future<List<ProductColor>> getCollectionCategory() async{
    setState(() {
      banners.clear();
    });

    // print("GetCollection Category Methode Called id "+widget.Collectionproduct.id.toString());
    var  uri;

    if(widget.isnavId)
    {
        print("HERE CMS CALLED TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTt");
      print("GetCollection Category Methode Called NAVID "+widget.id);
      uri = API_CMS_BASE_URL+"/api/webservices/getProductByNavId";

    }
    else
    {
      print("GetCollection Category Methode Called ROSS CMS "+widget.Collectionproduct.id);

      uri = API_CMS_BASE_URL+"/api/webservices/getProductById";

    }
    var map = new Map<String, dynamic>();

    if(widget.isnavId)
    {
      map['id'] = widget.id;
    }
    else
    {
      map['id'] = widget.Collectionproduct.id;

    }

    PageTitle=widget.MyPageTitle;
    SelectedCategory=PageTitle;
    //widget.Collectionproduct.name;

    http.Response response = await http.post(Uri.parse(uri), body: map,);
    var result = response.statusCode;
    var responseBody = response.body;
    print("Result OF Category Collection $result");
        print('CMS CMS CMS CMS TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
    print(response.body.length);

    print("Result OF Category Response Body  $responseBody");

    if(result==200)
    {

      setState(() {
        prodcutsColorList= CollectionCategory.fromJson(json.decode(response.body)).data.productColors;
        //CoverImageURL=prodcutsColorList[0].imagePath;
        //selectedColorCode=prodcutsColorList[0].productColorCode;
        productAttributes=CollectionCategory.fromJson(json.decode(response.body)).data.productAttributes;
        banners=prodcutsColorList[0].displayInConfigurator;

        if(!widget.isnavId)
          {
            if(banners.length!=0)
            {
              _getImageHeight(banners[0]);
            }
          }

        listProductCertificate=CollectionCategory.fromJson(json.decode(response.body)).data.productCertificates;
        print("Length of Product Attribute is "+productAttributes.length.toString());
        print("Length of Product Certificate is "+listProductCertificate.length.toString());
         print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
         print(prodcutsColorList.length);

        for(int i=0;i<prodcutsColorList.length;i++)
        {
          print(" NAv Id Product Colors Object "+prodcutsColorList[i].toString());
          print(" NAv Id Product Colors Object "+prodcutsColorList[i].displayInConfigurator.toString());
          if(prodcutsColorList[i].navId==widget.id.toString())
          {
            setState(() {
              banners=prodcutsColorList[i].displayInConfigurator;
              if(banners.length!=0)
              {
                _getImageHeight(banners[0]);
              }
              print("Nav id Length of Banners  "+banners.toString());
            });

          }
        }



        if(prodcutsColorList.length!=0)
              {
                for(int i=0;i<prodcutsColorList.length;i++)
                  {

                      if(widget.id==prodcutsColorList[i].navId)
                        {
                          print("*******************Selected Product Found on Cms");
                          print(prodcutsColorList[i].displayInConfigurator);
                          setState(() {

                            selectedBackGroundImage=prodcutsColorList[i].displayInConfigurator[0];

                          });



                        }

                  }
              }

        if(productAttributes.length!=0)
        {
          print("Technical Specifications  Found ");

          for(int i=0;i<productAttributes.length;i++)
          {
            setState(() {
              String attributeName = productAttributes[i].attributeName==""?"":productAttributes[i].attributeName;
              String attributeDescriptions  = productAttributes[i].value==""?"":productAttributes[i].value;
              lsitHeadings.add(attributeName);
              listDescriptions.add(attributeDescriptions);

            });

          }
        }
        else
        {
          print("Technical Specifications not Found ");
        }







      });
      return CollectionCategory.fromJson(json.decode(response.body)).data.productColors;
    }
    else
    {
      return <ProductColor>[];
    }





  }
  String  downloadPercontage="";
  String imgUrl = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
  String pdfCollectiveUrl ="https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  var dio = Dio();
  Future<String> download2(Dio dio, String url, String savePath,StateSetter updateState_bottom) async {
    //get pdf from link

    updateState_bottom(() {
      isSinglePDFDownload=false;

    });

    print("Save Path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.$savePath");

    try
    {


      var response = await dio.get(
        url,

        onReceiveProgress: ((received,total){
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
            updateState_bottom(() {
              downloadPercontage=(received / total * 100).toStringAsFixed(0);

              print("Download pdf Percentage is $downloadPercontage % ");
              if(downloadPercontage=="100")
              {



                isSinglePDFDownload=true;
                updateState_bottom(() {
                  isSinglePDFDownload=true;

                });
                print(">>>>>>>>>>>>>>>>>>.."+downloadPercontage);
                // Navigator.of(context, rootNavigator: true).pop();
                updateState_bottom((){
                  getPdfLinkresult=false;
                });

                // openFile(savePath);




                return downloadPercontage;
              }
            });
          }
        }),
        //showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      //write in download folder
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();


    }catch(e)
    {
      print(" Error >>>>>>>>>> $e");

      return e.toString();
    }


  }


  bool singlePdfCall = false;
  bool getPdfLinkresult=false;
  String siglePdfColorName="";

  Future<bool> getPdfLink(String itemCode) async{


    getPdfLinkresult=false;

    print("Single PDF Api Methode call $getPdfLinkresult  $itemCode");

    var  uri = API_CMS_BASE_URL+"/api/webservices/getProductPdfByColorCode";

    var map = new Map<String, dynamic>();

    map['product_color_code'] = "$itemCode";
    map['is_rgallery_app'] = pdfIconValue;
    //API_ROS_PROD__BASE_URL=="http://ros.rosettaproducts.com"?"0":"1";




    http.Response response = await http.post(Uri.parse(uri), body: map,);





    var responcebody = response.body;
    var responseCode = response.statusCode;




    print("Response Body of Form Data PDF  Api : $responcebody");
    print("Response code Form Data  PDF Api : $responseCode");

    if (200 == response.statusCode) {

      setState(() {

        getPdfLinkresult =PdfResponse.fromJson(json.decode(responcebody)).status;

        if(getPdfLinkresult)
        {
          String pdfUrl =PdfResponse.fromJson(json.decode(responcebody)).data;
          imgUrl=pdfUrl;
          print("Pdf Url is $pdfUrl");

        }
        else if(!getPdfLinkresult)
        {

          //Navigator.of(context, rootNavigator: true).pop();
          //showToastDialog(context, "This Pdf is Not available");

        }


      });



    } else {

    }
    return PdfResponse.fromJson(json.decode(responcebody)).status;
  }



  bool specificationsBool = true;




  // Rosss Product Details
  List<Inventory> listsearchProducts=[];
  int inventoryLength;
  Future<List<Inventory>> SearchProduct(String SuggestValue) async {






    print(">>>>>>>>>>>>....Form Data  "+SuggestValue );
    // print(">>>>>>>>>>>>....Form Data  "+SuggestValue + widget.SelectedDesign +widget.SelectedQuantity +  widget.SelectedMinPrice +  widget.SelectedmaxPrice +  "$dealerId");

    print("Search Result App is call $MyToken");

    String apiUrl="";

    String collectionsvar=widget.Collectionproduct.name;

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>. Api For Self stock ");
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>. Api For Self stock Category $SelectedCategory");
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>. Api For Self stock Collection  $collectionsvar");
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>. Api For Self stock Colour $selectedColorCode");


    apiUrl= API_ROS_PROD__BASE_URL+'/api/companies/$MyCompanyId/inventory?sort=&page=1&per_page=10&category=$SelectedCategory&collection=$collectionsvar&colour=$selectedColorCode&quantity=%253E1&distributor=$MyMemberId&cust_type=DISTRIBUTO&min_price=1&max_price=500';

    final response = await http.get(
      Uri.parse(apiUrl),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'bearer $MyToken',
      },
    );
    final responseJson = jsonDecode(response.body);


    var result = response.statusCode;
    var resultBody = response.body;

    print("Response Code Of Search Product  is  $result");
    print("Response Body  Of Search Product  is  $resultBody");








    print("SearchProductsList length is $inventoryLength");


    if(SearchProductsList.fromJson(json.decode(response.body)).inventory.length==0)
    {
      // Navigator.pop(context);
      print("Inventory not found ");

    }
    else
    {
      //Navigator.pop(context);
      // Navigator.pop(context,false);

    }





    return SearchProductsList.fromJson(json.decode(response.body)).inventory;

  }

  String MyToken;
  String MyUserName="";
  String MyCompanyId;
  String  MyMemberId;
  String CollectionproductName="";




  String sharedImageUrl;
  String sharedString;

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: ' $sharedString',
        linkUrl: '$sharedImageUrl',
        chooserTitle: 'Example Chooser Title');
  }
  bool isVisibleSkip=false;

  isVisibleSkipApi() async {
    String url = API_CMS_BASE_URL+"/api/webservices/skip_button";
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

  double height = 250;

  _getImageHeight(String url) {
    print("getImageHeight call >>>>>>>>>>>>> ");

    var myImage;
    double size;
    Image image = Image.network(url);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          myImage = image.image;
          setState(() {
            // imageSize = Size(myImage.width.toDouble(), myImage.height.toDouble());
            size = myImage.height.toDouble();
            height=size;


            print("Image Heigth >>>>>>>>>>>>>>>> "+myImage.width.toDouble().toString());
          });
        },
      ),
    );


  }
  List<Inventory> listsearchProducts2=[];
  int selected_ross_index=0;
  @override
  void initState() {
    super.initState();

    isVisibleSkipApi();
    print("Is Nav Id Present is >>>>>>>>>>>>>>>>>>>.."+widget.isnavId.toString());
    getSessionData();

    setState(() {

      if(widget.isnavId)
      {

      }
      else
      {

        String productName =  widget.Collectionproduct.name;
        String productid =  widget.Collectionproduct.id;
        print("Selected Product Name $productName");
        print("Selected Product Name $productid");
        CoverImageURL=widget.Collectionproduct.productCoverImage;

        CollectionproductName= widget.Collectionproduct.name;


      }


      getCollectionCategory();



      _scrollController = ScrollController()
        ..addListener(() {
          setState(() {
            if (_scrollController.offset >= 400) {
              _showBackToTopButton = true; // show the back-to-top button
            } else {
              _showBackToTopButton = false; // hide the back-to-top button
            }

            if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
              // Perform your task

              print("Page Scroll Bottom  >>>>>>>>>>>>>>>>>  ");
              setState(() {
                isScrollTop=false;

              });
            }
          });
        });



    });




    int i=0;
    for( i=0;i<widget.listsearchProducts.length;i++)
      {
        String  displayCollectionName= widget.listsearchProducts[i].collection!=null?widget.listsearchProducts[i].collection.displayName:"";

        if(widget.collectionName==displayCollectionName)
          {
            setState(() {

              listsearchProducts2.add(widget.listsearchProducts[i]);
            });

          }

        if(i==widget.listsearchProducts.length)
          {

            setState(() {

              widget.listsearchProducts=listsearchProducts2;
            });

          }

      }



  }


  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~OPen File Location Code
  var _openResult = 'Unknown';
  Future<void> openFile(String path) async {

    print("Open File Methode Call $path");
    var filePath = r''+path;

    final _result = await OpenFile.open(filePath);
    print(_result.message);

    setState(() {
      _openResult = "type=${_result.type}  message=${_result.message}";
    });
  }



  getSessionData() async
  {
    print("Get Session Methode Call");
    print("Detail result page +++++++++++++++++++++++++++++++++++++++++++++++ ");
    print("TST TEST TEST DEALER SEARCH DETAIL PAGE ");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String  userName = prefs.getString('UserName');
    String  mycompanyId = prefs.getString('companyId');
    String  mymemberId = prefs.getString('memberId');
    API_ROS_PROD__BASE_URL = prefs.getString('SelectedTenantBaseURl');

    print(">>>>>>>>>>>Session Token $token  $userName $mycompanyId $mycompanyId");

    print(">>>>>>>>>>>Session Token $token");
    setState(() {
      MyToken=token;
      MyUserName=userName;
      MyCompanyId=mycompanyId;
      MyMemberId=mymemberId;
    });

    if(token.isNotEmpty)
    {


    }
  }

  bool isSinglePDFDownload = false;

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  bool isScrollTop = true;
  void _scrollToTop() {
    setState(() {
      isScrollTop=true;
    });
    _scrollController.animateTo(((height-(height/2))+height*0.3),
        duration: Duration(seconds: 1), curve: Curves.linear);
  }
  void _scrollToDown() {


    _scrollController.animateTo(((height-(height/2))+height*0.3),
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return
      MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
        child:
        Scaffold(

          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child:MyAppBar(false,PageTitle,"",isVisibleSkip,true),
          ),
          body : SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,

              child:  Container(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Container(
                      height:height,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          banners.length==0?Container(): PageView.builder(
                            itemCount: banners.length,
                            itemBuilder: (context, index) {
                              return Image.network(banners[index], width: width,
                                  height: height,
                                  fit: BoxFit.cover);
                            },
                            onPageChanged: (index) {
                              setState(() {
                                positions = index;
                                _getImageHeight(banners[index]);
                              });
                            },
                          ),
                          banners.length==0?Container():Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DotsIndicator(
                              dotsCount: banners.length,
                              position: positions,
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

                    // Stack(children: [
                    //   Container(
                    //     color: Colors.red,
                    //     height: 250,
                    //
                    //     width: double.infinity,
                    //     child : PageView.builder(
                    //       itemCount: 1,
                    //       itemBuilder: (context, index) {
                    //         //"images/shophop/img/products" + widget.product.images[index].src,
                    //         return widget.SelectedProductDetailt.imageUrl!=null?Image.network(widget.SelectedProductDetailt.imageUrl, fit: BoxFit.cover):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.cover);
                    //
                    //       },
                    //
                    //     ),
                    //   ),
                    //
                    //  // Image.asset("images/room-1.png", fit: BoxFit.cover),
                    //   Image.network(selectedBackGroundImage, fit: BoxFit.fitWidth, width: width,),
                    // ],),



                    SizedBox(height: spacing_standard),

                  // All Details page
                     ////// TEST CONTAINER TEST TES TEST
                    Container(
                      // height: 240,

                      margin: EdgeInsets.only(bottom: 15,left: 15,right: 15),

                      padding: EdgeInsets.all(10.0),


                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Image and Color
                              InkWell(
                                child:  Container(
                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      SizedBox(height: 2,),
                                      Container(
                                        width: width * 0.30,//width * 0.3,
                                        height: 110,





                                      child:widget.SelectedProductDetailt.imageUrl!=null?Image.network(widget.SelectedProductDetailt.imageUrl, fit: BoxFit.fill):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.fill),





                                      ),


                                      Container(
                                        //  height: 26,
                                        // height: 26,
                                        width: width * 0.30,
                                        padding: EdgeInsets.only(top: 5),
                                        color: sh_textColorSecondarylight,
                                        child: Text(widget.SelectedProductDetailt.colour!=null?widget.SelectedProductDetailt.colour.displayName:"",
                                          textAlign: TextAlign.center,style: TextStyle(color: Colors.black,),),
                                      )
                                    ],

                                  ),
                                ),
                                onTap: ()
                                {




                                },
                              ),
                              Container(
                                height: 150,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Collection Name
                                    Row(


                                      children: [
                                        Container(

                                          child: Text(

                                            //list[index].name.toString(),
                                            widget.SelectedProductDetailt.collection.displayName,
                                            style: TextStyle(fontSize: textSizeLargeMedium,color: Colors.black,fontWeight: FontWeight.w500),
                                          ),
                                          width: (width-((width * 0.30)+60))-22,
                                        ),

                                      ],

                                    ),

                                    //Category Name
                                    Text(
                                     // "TEST",
                                      //"$NewCategoryName".replaceAll("Code.", ""),
                                      widget.SelectedProductDetailt.category.displayName,
                                      style: TextStyle(
                                          color: sh_textColorSecondary,
                                          fontSize: textSizeMedium,fontWeight: FontWeight.w400),
                                    ),
                                    Row(
                                      children: [
                                        Text(

                                          widget.SelectedProductDetailt.price.unit.toStringAsFixed(2),
                                          style: TextStyle(fontSize: textSizeLargeMedium,color:sh_colorPrimary,fontWeight: FontWeight.w500),
                                        ),

                                        // Text(
                                        //   "5665".toCurrencyFormat().toString(),
                                        //   style: TextStyle(color: sh_textColorSecondary, fontSize: textSizeLargeMedium, decoration: TextDecoration.lineThrough),
                                        // ),
                                      ],
                                    ),
                                    Container(
                                      // width: width-156,
                                      child: Row(

                                        children: [
                                          ( widget.SelectedProductDetailt.inventory!=0)? Image.asset(ic_circularGreenCheckBox,height:15,width: 15,):Image.asset(ic_circularcancel,height:15,width: 15,),

                                          Container(

                                            child:( widget.SelectedProductDetailt.inventory!=0)? Text(" Stock "+widget.SelectedProductDetailt.inventory.truncateToDouble().toStringAsFixed(0)+" Sqft",style: TextStyle(
                                                color: sh_textColorSecondary,
                                                fontSize: textSizeMedium,fontWeight: FontWeight.w500),):
                                            Text("",style: TextStyle(fontSize: 10,color:Colors.red,fontWeight: FontWeight.bold),


                                            ),


                                          ),


                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                    Container(
                                      // width: width-156,
                                      child: Row(

                                        children: [
                                          Image.asset(ic_block_red,height:15,width: 15,),

                                          Container(

                                              child:Text(" Block "+widget.SelectedProductDetailt.blocked.truncateToDouble().toStringAsFixed(0)+" Sqft",style: TextStyle(
                                                  color: sh_textColorSecondary,
                                                  fontSize: textSizeMedium,fontWeight: FontWeight.w500),)


                                          ),


                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,

                                      children: [


                                        //Download Icon
                                        InkWell(
                                          child: Image.asset(ic_download_round,height: 35,width: 35,),
                                          onTap: () async {

                                            if(widget.SelectedProductDetailt.colour!=null)
                                            {

                                              singlePdfCall=true;
                                              isSinglePDFDownload=false;
                                              siglePdfColorName=widget.SelectedProductDetailt.colour.displayName;
                                              print("siglePdfColorName>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $siglePdfColorName");

                                              showAlertDialogPDF(context,setState,siglePdfColorName.replaceAll(" ","_"));

                                              // _launchURLAppSinglePdf(displayNameColor);

                                            }
                                            else
                                            {
                                              showToastDialog(context, "Please Select Another One ");
                                            }







                                          },
                                        ),


                                        SizedBox(width: 3,),
                                        InkWell(
                                          child: Image.asset(ic_share_round,height: 35,width: 35,),
                                          onTap:(){





                                            String colorsend = widget.SelectedProductDetailt.colour==null?widget.SelectedProductDetailt.colour.displayName:"";
                                            print(widget.SelectedProductDetailt.colour.toString()!=null?widget.SelectedProductDetailt.colour.displayName:"");

                                            String string = widget.SelectedProductDetailt.colour.toString()!=null?widget.SelectedProductDetailt.colour.displayName.replaceAll(RegExp(' '), '%20'):"";
                                            print("2 On Share Button >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>."+string);



                                            sharedImageUrl=API_CMS_BASE_URL+"/api/webservices/shareProductPdfByColorCode/$string";
                                            sharedString="Please click on the link below to view our catalog";
                                            // sharedString="\nCategory : "+widget.SelectedProductDetailt.category.displayName+"\nCollection : "+widget.SelectedProductDetailt.collection.displayName.toString()+"\nColour :"+colorsend;

                                            share();

                                          } ,
                                        ),

                                        SizedBox(width: 3,),

                                        // For Select Lot
                                        Container(
                                          //NewQuantity==115.0
                                          child:(false)?
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,

                                            children: [
                                              //Download Icon
                                              InkWell(
                                                child: Image.asset(ic_circular_bucket,height: 35,width: 35,),
                                                onTap: (){
                                                  showAlertDialogAddToCart(context);
                                                },
                                              ),


                                              SizedBox(width: 10,),

                                              InkWell(
                                                child:  Image.asset(ic_block_red,height: 35,width: 35,),
                                                onTap: (){
                                                  showAlertDialogBlocked(context);
                                                },
                                              ),






                                            ],
                                          ):
                                          MaterialButton(
                                            elevation: 0,

                                            padding:  EdgeInsets.fromLTRB(12.0, 7.0, 12.0, 7.0),
                                            child: text("Select Lot", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: sh_white),
                                            textColor: sh_white,

                                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                                            color: sh_colorPrimary,
                                            onPressed: () => {

                                              if(widget.SelectedProductDetailt.colour!=null)
                                                {
                                                  showAlertStockDialog(context,widget.SelectedProductDetailt.stockPoints,widget.SelectedProductDetailt,widget.SelectedProductDetailt.inventory.toStringAsFixed(0),widget.SelectedProductDetailt.category.allowCl,widget.rateTypeDescription,widget.plankSize,widget.in_multipels),

                                                }
                                              else
                                                {
                                                  showToastDialog(context, "Please Select Another one "),
                                                },


                                            },
                                          ),

                                        ),






                                      ],
                                    ),


                                  ],
                                ),
                                margin: EdgeInsets.only(left: 10),
                              ),




                            ],
                          ),
                          SizedBox(height: 10,),
                          // Container(height: 1,color: sh_textColorVerticleLine,),
                          //   SizedBox(height: 10,),
                          // Container(
                          //   child: Flexible(
                          //     child :   Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //
                          //         Container(
                          //           //NewQuantity==115.0
                          //           child:(false)?
                          //           Row(
                          //             mainAxisAlignment: MainAxisAlignment.start,
                          //
                          //             children: [
                          //               //Download Icon
                          //               InkWell(
                          //                 child: Image.asset(ic_circular_bucket,height: 35,width: 35,),
                          //                 onTap: (){
                          //                   showAlertDialogAddToCart(context);
                          //                   },
                          //               ),
                          //
                          //
                          //               SizedBox(width: 10,),
                          //
                          //               InkWell(
                          //                 child:  Image.asset(ic_block_red,height: 35,width: 35,),
                          //                 onTap: (){
                          //                   showAlertDialogBlocked(context);
                          //                 },
                          //               ),
                          //
                          //
                          //
                          //
                          //
                          //
                          //             ],
                          //           ):MaterialButton(
                          //             elevation: 0,
                          //
                          //             padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
                          //             child: text("Select Lot", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: sh_white),
                          //             textColor: sh_white,
                          //
                          //             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                          //             color: sh_colorPrimary,
                          //             onPressed: () => {
                          //             showAlertStockDialog(context,listStockPoint,widget.listsearchProducts[index],widget.SelectedQuantity,widget.listsearchProducts[index].category.allowCl,rateTypeDescription,plankSize,in_multipels),
                          //
                          //            //   _bottomSheetMore(context,int.parse(widget.SelectedQuantity),widget.listsearchProducts[index],false),
                          //
                          //             },
                          //           ),
                          //
                          //         ),
                          //         SizedBox(width: 10,),
                          //        true?Container(): Container(
                          //
                          //           child:
                          //           MaterialButton(
                          //             elevation: 0,
                          //
                          //             padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
                          //             child: text("View In Studio", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: sh_white),
                          //             textColor: sh_white,
                          //
                          //             shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                          //             color: sh_colorPrimary,
                          //             onPressed: () => {
                          //               _launchURLApp(displayNameColor),
                          //               // ShHomeScreen().launch(context),
                          //
                          //
                          //             },
                          //           ),
                          //         ),
                          //         // InkWell(
                          //         //   child:  Container(
                          //         //     padding: EdgeInsets.only(left: 10,right: 10),
                          //         //     child: Container(
                          //         //       alignment: Alignment.center,
                          //         //       child: Text("Select Lot",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),
                          //         //       ),
                          //         //     ),
                          //         //
                          //         //     decoration: BoxDecoration(
                          //         //         color: sh_colorPrimary,
                          //         //         borderRadius: BorderRadius.all(Radius.circular(5.0))
                          //         //     ),
                          //         //
                          //         //   ),
                          //         //   onTap: (){
                          //         //
                          //         //
                          //         //     _bottomSheetMore(context);
                          //         //
                          //         //   },
                          //         // ),
                          //
                          //
                          //
                          //         // InkWell(
                          //         //   child:   Stack(
                          //         //     children: [
                          //         //
                          //         //
                          //         //       Container(
                          //         //         padding: EdgeInsets.only(left: 10,right: 10),
                          //         //
                          //         //
                          //         //
                          //         //
                          //         //         //width: (width * 0.3)+10,
                          //         //
                          //         //         child: Container(
                          //         //           margin: EdgeInsets.only(left: 15),
                          //         //
                          //         //
                          //         //
                          //         //           alignment: Alignment.center,
                          //         //           child: Text("View In Studio",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600,fontSize: 12),
                          //         //           ),
                          //         //         ),
                          //         //
                          //         //         decoration: BoxDecoration(
                          //         //             color: sh_colorPrimary,
                          //         //             borderRadius: BorderRadius.all(Radius.circular(5.0))
                          //         //         ),
                          //         //
                          //         //       ),
                          //         //       Container(
                          //         //           alignment: Alignment.centerLeft,
                          //         //           padding: EdgeInsets.only(left: 5),
                          //         //           child: Image.asset("images/studio.png",width:15,height:15,fit: BoxFit.fill,)),
                          //         //
                          //         //     ],
                          //         //   ),
                          //         //   onTap: (){
                          //         //
                          //         //   },
                          //         // ),
                          //
                          //
                          //
                          //       ],
                          //     ),
                          //   ),
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          // ),
                        ],
                      ),


                      decoration: BoxDecoration(

                        color: sh_itemText_background,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                    ),



                    Padding(
                      padding: EdgeInsets.only(left: 0,right: 0),
                      child: Column(
                        children: <Widget>[


                          widget.isnavId?Container():SizedBox(height: spacing_standard),
                          //Technical Specifications
                          InkWell(
                            child:  Container(

                              padding: EdgeInsets.all( 10.0),
                              alignment: Alignment.center,
                              color: sh_textColorSecondarylight,


                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Technical Specifications: ",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: textSizeNormal, fontFamily: fontSemibold),overflow: TextOverflow.ellipsis),
                                  specificationsBool?Image.asset(ic_uparrow,height: 20,width: 20,color: sh_colorPrimary,): Image.asset(ic_downarrow,height: 20,width: 20,color: sh_colorPrimary),

                                ],
                              ),

                            ) ,
                            onTap: (){
                              setState(() {

                                // if(specificationsBool)
                                // {
                                //   specificationsBool=false;
                                // }
                                // else
                                // {
                                //   specificationsBool=true;
                                //
                                // }
                              });
                            },
                          ),


                          //Technical Specifications Deatails
                          Visibility(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: (width/3)-14,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listDescriptions.length>=1?lsitHeadings[0]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary),),
                                              SizedBox(height: 5,),

                                              Text(listDescriptions.length>=1?listDescriptions[0]+"":"",style: TextStyle(fontSize: textSizeMedium,color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                                            ],


                                          ),

                                        ),
                                        Container(
                                          width: (width/3)-13,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listDescriptions.length>=2?lsitHeadings[1]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary),),
                                              SizedBox(height: 5,),
                                              Text(listDescriptions.length>=2?listDescriptions[1]+"":"",style: TextStyle(fontSize: textSizeMedium,color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: (width/3)-13,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listDescriptions.length>=3?lsitHeadings[2]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary)),
                                              SizedBox(height: 5,),
                                              Text(listDescriptions.length>=3?listDescriptions[2]+"":"",style: TextStyle(fontSize: textSizeMedium,color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                  ),
                                  Container(
                                    height: 1,
                                    color:sh_textColorSecondarylight,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: (width/3)-14,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listDescriptions.length>=4?lsitHeadings[3]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary)),
                                              SizedBox(height: 5,),
                                              Text(listDescriptions.length>=4?listDescriptions[3]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                                            ],


                                          ),

                                        ),
                                        Container(
                                          width: (width/3)-13,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listDescriptions.length>=5?lsitHeadings[4]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary)),
                                              SizedBox(height: 5,),
                                              Text(listDescriptions.length>=5?listDescriptions[4]+"":"",style: TextStyle(fontSize: textSizeMedium,color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: (width/3)-13,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listDescriptions.length>=6?lsitHeadings[5]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary)),
                                              SizedBox(height: 5,),
                                              Text(listDescriptions.length>=6?listDescriptions[5]+"":"",style: TextStyle(fontSize: textSizeMedium,color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                  ),
                                  Container(
                                    height: 1,
                                    color:sh_textColorSecondarylight,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: (width/3)-14,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listDescriptions.length>=7?lsitHeadings[6]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary)),
                                              SizedBox(height: 5,),
                                              Text(listDescriptions.length>=7?listDescriptions[6]+"":"",style: TextStyle(fontSize: textSizeMedium,color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                                            ],


                                          ),

                                        ),
                                        Container(
                                          width: (width/3)-13,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listDescriptions.length>=8?lsitHeadings[7]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary)),
                                              SizedBox(height: 5,),
                                              Text(listDescriptions.length>=8?listDescriptions[7]+"":"",style: TextStyle(fontSize: textSizeMedium,color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: (width/3)-13,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(listDescriptions.length>=9?lsitHeadings[8]+":":"",style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary)),
                                              SizedBox(height: 5,),
                                              Text(listDescriptions.length>=9?listDescriptions[8]+"":"",style: TextStyle(fontSize: textSizeMedium,color: sh_colorPrimary,fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                  ),

                                ],
                              ),


                            ),
                            visible: true,
                            //specificationsBool,
                          ),

                          Container(

                            padding: EdgeInsets.all( 10.0),
                            alignment: Alignment.center,
                            color: sh_textColorSecondarylight,


                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Downloads  ",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: textSizeNormal, fontFamily: fontSemibold),overflow: TextOverflow.ellipsis),
                                specificationsBool?Image.asset(ic_uparrow,height: 20,width: 20,color: sh_colorPrimary,): Image.asset(ic_downarrow,height: 20,width: 20,color: sh_colorPrimary,),

                              ],
                            ),

                          ) ,

                          ListView.builder(

                              scrollDirection: Axis.vertical,
                              itemCount: listProductCertificate.length,

                              shrinkWrap: true,

                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: ()
                                    async {
                                      singlePdfCall=true;
                                      isSinglePDFDownload=false;
                                      showAlertDialogCertificatePDF(context, setState, listProductCertificate[index].doc,listProductCertificate[index].title);
                                    },
                                    child:Container(
                                      padding: EdgeInsets.only( top: 10,left: 10,right: 10),
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start
                                        ,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(" "+listProductCertificate[index].title,textAlign: TextAlign.center, style: TextStyle(fontSize: textSizeMedium,color: sh_textColorSecondary),overflow: TextOverflow.ellipsis),
                                              Icon(Icons.download_sharp,color: sh_colorPrimary,)
                                            ],
                                          ),
                                          Container(
                                            height: 1,
                                            color:sh_textColorSecondarylight,
                                            margin: EdgeInsets.symmetric(vertical: 10),
                                          ),

                                        ],
                                      ),


                                    )


                                );
                                // return Chats(mListings[index], index);
                              }),



                          SizedBox(height: spacing_standard),
                          Container(
                            alignment: Alignment.centerLeft,
                            child:Text("Color Codes", style: TextStyle(fontSize: textSizeLargeMedium,color:sh_textColorPrimary,fontWeight: FontWeight.w400 ),),
                          ),
                          SizedBox(height: spacing_standard),

                          Container(
                            child: prodcutsColorList== null ? Container(child: CircularProgressIndicator()):GridView.builder(
                                itemCount: prodcutsColorList.length ,//listsearchProducts2.length,
                                //prodcutsColorList
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0.0),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    childAspectRatio: MediaQuery.of(context).size.width / ((MediaQuery.of(context).size.height / 1.5)),
                                    mainAxisSpacing: 0),
                                itemBuilder: (_, index) {


                                // String  displayCollectionName= listsearchProducts2[index].collection!=null?listsearchProducts2[index].collection.displayName:"";
                                 // return displayCollectionName==widget.collectionName?InkWell(
                                  return InkWell(
                                    onTap: () {
                                      setState(() {


                                        final index2 = listsearchProducts2.indexWhere((element) =>
                                       element.navId == prodcutsColorList[index].navId );

                                        selected_ross_index=index2;

                                        CoverImageURL=listsearchProducts2[index2].imageUrl;

                                        selectedColorCode=listsearchProducts2[index2].colour!=null?listsearchProducts2[index2].colour.displayName:"";
                                        widget.SelectedProductDetailt=listsearchProducts2[index2];

                                        widget.id=listsearchProducts2[index2].navId;

                                        getCollectionCategory();


                                        // final colorSelectedIndex = prodcutsColorList.indexWhere((element) => element.navId == listsearchProducts2[index].navId);
                                        //
                                        // print("Selected Color Index >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $colorSelectedIndex");






                                        _scrollToTop();

                                        //colour=
                                        //SearchProduct("colour="+selectedColorCode);

                                      });
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ShSubProductSctreen(prodcuts: newestProducts, title: sh_lbl_newest_product)));

                                      //  Navigator.push(context, MaterialPageRoute(builder: (context) => ShProductDetail(product: mProductModel[index])));
                                    },
                                    child: Container(


                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [


                                          Container(
                                            width: (width/3)-20,//width * 0.3,
                                            height: (width/3)-20,



                                            //"images/shophop/img/products" + widget.product.images[0].src
                                       /// prodcutsColorList[index].imagePath
                                            //child:listsearchProducts2[index].imageUrl!=null?Image.network(listsearchProducts2[index].imageUrl, fit: BoxFit.cover):Image.network("https://laravel.cppatidar.com/rosetta/public/templates/skin1/images/no_image.jpg", fit: BoxFit.cover),
                                       //    child: Image.network(  prodcutsColorList[index].imagePath)
                                            child:Image.network(prodcutsColorList[index].imagePath, fit: BoxFit.cover),

                                           // prodcutsColorList[index].imagePath  ,

                                          ),

                                          Container(
                                            width: (width/3)-20,
                                            padding: EdgeInsets.all( 5.0),
                                            alignment: Alignment.center,
                                            color: sh_textColorSecondarylight,
                                            child: prodcutsColorList[index].colour==null?Text(""):
                                            Text(prodcutsColorList[index].colour,textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: textSizeSMedium, fontFamily: fontSemibold),overflow: TextOverflow.ellipsis),
                                          )
                                          // Container(
                                          //   width: (width/3)-20,
                                          //   padding: EdgeInsets.all( 5.0),
                                          //   alignment: Alignment.center,
                                          //   color: sh_textColorSecondarylight,
                                          //   child:
                                          //     Text( prodcutsColorList[index].colour),
                                          //
                                          //   // Text(listsearchProducts2[index].colour!=null?listsearchProducts2[index].colour.displayName:"",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: textSizeSMedium, fontFamily: fontSemibold),overflow: TextOverflow.ellipsis),
                                          // )
                                        ],

                                      ),
                                    ),
                                  );
                                }),
                          ),

                          /////////////////////////////////////// TEST GRIDVIEW NEW












                          SizedBox(height: spacing_standard),

                          // gaurav allicons here
                        ],
                      ),
                    ),
                    SizedBox(height: 25),




                  ],
                ),
              ),
            ),
          ),
          endDrawer:MyDrwaer(),
          floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child:isScrollTop? Icon(Icons.arrow_circle_down, color:Colors.white,):new RotationTransition(
              turns: new AlwaysStoppedAnimation(180 / 360),
              child: Icon(Icons.arrow_circle_down, color:Colors.white,),
            ),






            backgroundColor: sh_colorPrimary,
            onPressed: () {

              setState(() {

                if(isScrollTop)
                {
                  _scrollToDown();
                }
                else
                {
                  _scrollToTop();
                }






              });
            },
          ),


        ),
      );
  }





  _bottomSheetMore(context, int selectQuantity) {
    showModalBottomSheet(


      isScrollControlled: true,
      context: context,


      builder: (BuildContext context) {
        var isSwitched = true;
        var toggleText  = "RL";
        return BottomSheet(
          onClosing: () {},
          builder: (BuildContext context) {
            bool checkboxvalue = false;
            Image imgUp =  Image.asset(ic_check,height: 15,width: 15,);
            Image imgDown =  Image.asset(ic_uncheck,height: 15,width: 15,);
            /*SvgPicture imgUp =  SvgPicture.asset(ic_svg_check,height: 15,width: 15,);
            SvgPicture imgDown =  SvgPicture.asset(ic_svg_uncheck,height: 15,width: 15,);*/

            var selectedindex;
            var list1 = [];

            String dropdownValue1 = 'Approve';
            List<String> spinnerItems1 = [
              'Approve',
              'Reject',

            ];

            return StatefulBuilder(
              builder: (BuildContext context, setState) =>
                  Container(

                    height:MediaQuery.of(context).size.height * 0.65,
                    //height:MediaQuery.of(context).size.height * 0.75,


                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: [
                        Container(
                          color: backgroundSearchProductForm,



                          padding: EdgeInsets.all(15),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(children: [
                                Container(
                                  alignment: Alignment.centerLeft,

                                  width:(MediaQuery.of(context).size.width/2)-20,


                                  child:  TextFormField(
                                    initialValue: "$selectQuantity",
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: false,
                                    textCapitalization: TextCapitalization.words,

                                    style: TextStyle(
                                        color: sh_textColorPrimary,
                                        fontFamily: fontRegular,
                                        fontSize: textSizeSMedium),

                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: backgroundSearchProductFormInput,
                                        focusColor: sh_editText_background_active,
                                        hintText: "Quantity",

                                        hintStyle: TextStyle(
                                            color: sh_textColorSecondary,
                                            fontFamily: fontRegular,
                                            fontSize: textSizeSmall),
                                        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 15.0),
                                        //EdgeInsets.only(left: 10,right: 10),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(round_border_form),
                                            borderSide: BorderSide(
                                                color: sh_black, width: 0.5)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(round_border_form),
                                            borderSide: BorderSide(
                                                color: sh_black,

                                                width: 0.5))),
                                  ),

                                ),
                                SizedBox(width: 10,),
                                Container(
                                  width: (MediaQuery.of(context).size.width/2)-20,
                                  child:  MaterialButton(
                                    child: Container(
                                        padding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                                        alignment: Alignment.center,
                                        child: text(sh_lbl_search, fontSize: textSizeMedium, fontFamily: fontMedium, textColor: Colors.white)),
                                    textColor: sh_white,
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                    color: sh_colorPrimary,
                                    onPressed: () => {

                                      //  SearchProductResult().launch(context),

                                    },
                                    elevation: 0,
                                  ),

                                ),
                              ],),
                              SizedBox(height: 10,),

                              Container(

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("SATURN", style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                        Text("Carpet(4520)",style: TextStyle(fontSize: 15,color: Colors.black,),),
                                      ],
                                    ),

                                    Container(
                                        child: Text("Available",style: TextStyle(color: sh_colorPrimary,fontSize: textSizeMedium,fontWeight: FontWeight.bold),)
                                    ),
                                  ],

                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                child:Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 0,right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(

                                            children: [
                                              Container(
                                                child: Text(toggleText,style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                              ),
                                              SizedBox(height: 5,),
                                              Container(
                                                  child:    Switch(
                                                    onChanged:(value){
                                                      setState(() {
                                                        isSwitched=value;
                                                        if(value)
                                                        {
                                                          toggleText="RL";
                                                        }
                                                        else{
                                                          toggleText="CL";
                                                        }

                                                      });
                                                    },
                                                    value: isSwitched,
                                                    activeColor: sh_track_green,
                                                    activeTrackColor: sh_more_infoHeading_background,
                                                    inactiveThumbColor: sh_track_yellow,
                                                    inactiveTrackColor: sh_more_infoHeading_background,
                                                  )
                                              ),
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          ),

                                          Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                          Column(
                                            children: [
                                              Container(
                                                child: Text("Price",style:  TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                              ) ,
                                              SizedBox(height: 5,),
                                              Container(
                                                child: Text("".toCurrencyFormat(),style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                              ) ,
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          ),
                                          Container(height: 40,width: 1,color: sh_textColorVerticleLine,),
                                          Column(
                                            children: [
                                              Container(
                                                child: Text("Total",style: TextStyle(color: Colors.black,fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                              ),
                                              SizedBox(height: 5,),
                                              Container(
                                                child: Text("200sqft",style: TextStyle(color: sh_textColorSecondarylight2,fontSize: textSizeMedium,),),
                                              ),
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          ),




                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),


                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 15,top: 15),
                            child: Text("Select Lot (Mumbai)",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)),
                        Container(



                          child:   ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: 4,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 15,right: 15),
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [


                                      InkWell(
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(


                                              child:list1.contains(index) ? imgUp:imgDown,


                                            ),
                                            //Batch No //Quantityt
                                            Container(

                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [

                                                        Container(

                                                          child: Row(
                                                            children: [
                                                              Text("Batch No : ",style: TextStyle(fontSize: 14),),
                                                              Text("Adj | jan20 | 2",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Container(

                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(


                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text("Qty : ",style: TextStyle(fontSize: 14),),
                                                              Text("85 sqft",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              margin: EdgeInsets.only(left: 10),
                                            ),
                                          ],
                                        ),
                                        onTap: ()
                                        {
                                          setState((){
                                            selectedindex=index;
                                            if(list1.contains(index))
                                            {
                                              list1.remove(index);
                                            }
                                            else
                                            {
                                              list1.add(index);

                                            }
                                          });

                                        },
                                      ),


                                      //TextField
                                      Container(
                                        width :60,
                                        height: 30,
                                        child:  TextFormField(
                                          keyboardType: TextInputType.emailAddress,
                                          autofocus: false,
                                          textCapitalization: TextCapitalization.words,
                                          style: TextStyle(
                                              color: sh_textColorPrimary,
                                              fontFamily: fontRegular,
                                              fontSize: textSizeSmall),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: backgroundSearchProductFormInput,
                                              focusColor: sh_editText_background_active,
                                              hintText: "10",
                                              hintStyle: TextStyle(
                                                  color: sh_textColorSecondary,
                                                  fontFamily: fontRegular,
                                                  fontSize: textSizeSmall),
                                              contentPadding:
                                              EdgeInsets.only(left: 12,right: 10),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(round_border_form),
                                                  borderSide: BorderSide(
                                                      color: sh_black, width: 0.5)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(round_border_form),
                                                  borderSide: BorderSide(
                                                      color: sh_black,

                                                      width: 0.5))),
                                        ),

                                      ),




                                    ],
                                  ),
                                );
                                // return Chats(mListings[index], index);
                              }),


                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 70,

                          color: sh_colorPrimary,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Total Qty", style: TextStyle(color: sh_white,fontSize: 15),),
                                      Text("40",style: TextStyle(fontSize: 15,color: sh_white,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),

                                Container(


                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [



                                      Container(
                                        width:(MediaQuery.of(context).size.width/3)-8,
                                        margin: EdgeInsets.only(left: 0),
                                        child: MaterialButton(

                                          padding:  EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                                          child: Text("ADD",  style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          textColor: sh_colorPrimary,
                                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                          color: sh_white,
                                          onPressed: () => {
                                            showAlertDialogAddToCart(context),


                                          },

                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Container(
                                        width:(MediaQuery.of(context).size.width/3)-8,
                                        margin: EdgeInsets.only(left: 0),
                                        child: MaterialButton(

                                          padding:  EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                                          child: Text("Block",  style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                          textColor: sh_colorPrimary,
                                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                          color: sh_white,
                                          onPressed: () => {
                                            showAlertDialogBlocked(context),

                                          },

                                        ),
                                      ),
                                      // Container(
                                      //   width:(MediaQuery.of(context).size.width/3)-8,
                                      //   margin: EdgeInsets.only(left: 0),
                                      //   child: MaterialButton(
                                      //
                                      //     padding:  EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
                                      //     child: Text("Next",  style: TextStyle(fontSize: textSizeMedium,fontWeight: FontWeight.bold),),
                                      //     textColor: sh_colorPrimary,
                                      //     shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                                      //     color: sh_white,
                                      //     onPressed: () => {
                                      //
                                      //       showAlertBlock(context),
                                      //
                                      //     },
                                      //
                                      //   ),
                                      // ),


                                    ],

                                  ),
                                ),
                              ]
                          ),




                        ),

                      ],
                    ),



                  ),
            );
          },
        );
         },




    );
  }

  showAlertDialogAddToCart(BuildContext context) {
    // Create button


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  Dialog(

              child: StatefulBuilder(

                builder: (BuildContext context, setState) => Container(
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


                            child: Text("Your Order Add To  Cart",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
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
                                  // await Navigator.of(context)
                                  //     .push(new MaterialPageRoute(builder: (context) => SelectProductPlaceOrder()));
                                  SelectProductPlaceOrder().launch(context);
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



                ),
              )



          );



        });
  }

  String openFullPath="";
  showAlertDialogPDF(BuildContext context, StateSetter updateState_bottom,String displayNameColor) {
    // Create button


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
          child:
            Dialog(

              child: StatefulBuilder(


                builder: (BuildContext context, setState)
                {
                  //Methode Call to Add To Cart



                  bool isProgress= false;


                  if(singlePdfCall)
                  {
                    print("Flag of Single Pdf is  >>>>>>>>>>>>>>>>>>>>>>>>> $getPdfLinkresult");

                    // getPdfLink(displayNameColor)
                    getPdfLink(widget.id).then((value) async {

                      print("Response code pdf Api is "+value.toString());
                      if(value==true)
                      {
                        if(getPdfLinkresult)
                        {
                          updateState_bottom((){
                            singlePdfCall=false;
                          });

                          ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    //              Directory directory = Platform.isAndroid
                    //                                       ? await getExternalStorageDirectory() //FOR ANDROID
                    //                                       : await getApplicationDocumentsDirectory();
                    //                                   //await getApplicationSupportDirectory(); //FOR
                    //
                    //                                   // Directory dir = await getApplicationDocumentsDirectory().;
                    //
                    //                                   print("Ios Doirectory path  is  >>>>>>>>>>>>>>>>>>>>>>> "+directory.path);
                    // //  String  path=directory.path;
                    //       String path =  await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
                    //       var time = DateTime.now().microsecondsSinceEpoch;


                          String path="";

                          if(Platform.isIOS)
                          {

                            Directory directory = Platform.isAndroid
                                ? await getExternalStorageDirectory() //FOR ANDROID
                                : await getApplicationDocumentsDirectory();
                            //await getApplicationSupportDirectory(); //FOR

                            // Directory dir = await getApplicationDocumentsDirectory().;

                            print("Ios Doirectory path  is  >>>>>>>>>>>>>>>>>>>>>>> "+directory.path);
                            path=directory.path;


                          }
                          if(Platform.isAndroid)
                          {
                            path =  await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);

                          }


                          //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                          final folderName= APP_FOLDER_NAME;
                          final path2= Directory("$path/$folderName");
                          if ((await path2.exists())){
                            // TODO:
                            print(">>>>>>>exist");
                            print("TEST TEST TEST TEST TEST TEST+++++++++++++++++++APP FOLDER NAME++++++++++++++++++++++++");
                          }else{
                            // TODO:
                            print(">>>>>>>not exist");
                            print("TEST TEST TEST TEST TEST TEST+++++++++++++++++++APP FOLDER NAME++++++++++++++++++++++++");
                            path2.create();
                          }
                          //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


                          final DateTime now = DateTime.now();
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          final String formatted = formatter.format(now);

                          final String formatted2 = DateFormat.yMMMMd().format(now);

                          print("Today date formate "+formatted2); //April 27, 2022


                          //27April2022
                          String newDate = displayNameColor+"_"+(formatted2.split(" ")[1]+formatted2.split(" ")[0]+formatted2.split(" ")[2]).replaceAll(",", "");
                          print("Requied Date Formate "+newDate);




                          pdfCount=pdfCount+1;

                          if(pdfTodayDate=="")
                          {
                            pdfTodayDate=newDate;
                          }
                          else
                          {
                            if(pdfTodayDate!=newDate)
                            {
                              pdfCount=0;
                              pdfCount=pdfCount+1;
                              pdfTodayDate=newDate;
                            }
                          }

                          String fullPath = "$path/$folderName/$newDate"+"_"+pdfCount.toString()+".pdf";
                          print("External Storage Path >>>>>>>>>>>>>>>>>$fullPath");
                          print("TEST TEST TEST TEST TEST TEST+++++++++++++++++++APP FOLDER NAME++++++++++++++++++++++++");

                          updateState_bottom(()
                          {
                            openFullPath=fullPath;
                          });




                          download2(dio, imgUrl, fullPath,setState).then((value)
                          {
                            //print("Result of Download Pdf Is "+value.toString());



                          });








                        }
                        else
                        {
                          updateState_bottom((){
                            singlePdfCall=false;

                          });
                        }







                      }
                    });


                  }



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

                                Container(
                                  child:


                                  isSinglePDFDownload?Image.asset(ic_greencheck,height: 80,width: 80, fit: BoxFit.fill,):Image.asset(ic_form_preloader_gif,height: 100,width: 100, fit: BoxFit.fill,),
                                  alignment: Alignment.topCenter,
                                ),

                              ],
                            ),

                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10),



                              child:  Column(
                                children: [
                                  isSinglePDFDownload?  Text("Successfully Pdf Download ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),)
                                      :Text("Please wait, while we download your PDF ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Container(),
                                  //     Text(" Success Fully Download pdf .....$downloadPercontage",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                  //     Container(),
                                  //   ],
                                  // ),
                                  //isSinglePDFDownload
                                  isSinglePDFDownload? Container(
                                    alignment: Alignment.center,

                                    child: IntrinsicWidth(
                                      child:MaterialButton(

                                        padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
                                        child: text("View", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                        color: backgroundSearchProductFormButtons,
                                        onPressed: () async {

                                          // print("Send Selected Value For Cart Page "+widget.SelectedValueForSearch);
                                          //                                                    SearchProductResult(value,SelectedAutoSuggestStirng,spinnerDealerSelectes,SelectedQuantity,this.SingleSelectedCategory,SelectedDealer2,SelectedMinPrice,SelectedmaxPrice,SelectedValue,spinnerDelerList,spinnerSelectDealer2).launch(context);
                                          // Navigator.pop(context, false);
                                          Navigator.pop(context);
                                          openFile(openFullPath);



                                        },
                                        // onPressed: () => {
                                        //  // Navigator.pop(context),
                                        //   SelectProductPlaceOrder().launch(context),
                                        // },
                                        elevation: 0,
                                      ),

                                    ),
                                  ):Container(),
                                ],
                              ),
                            ),


                          ],
                        )),



                  );
                },
              )



          ));



        }).then((Exit){

      setState(() {
        if(getPdfLinkresult)
        {
          //openFile(openFullPath);

        }


        print(">>>>>>>>>>>>>>>>>>>>>>>>>>Pdf Download Success Fully ");
        //showToastDialogPdf(context, "Pdf Downloaded  SuccessFully ");








      });

      updateState_bottom((){
        // lotInventory.clear();
        // int lotInventoryLength =     lotInventory.length;
        // print("Lot Inventory Length After close Dialog $lotInventoryLength");
        // getSelectedInventory(updateState_bottom,obj,selectedStcokindex);
        // list1.clear();


      });

    });
  }


  bool isOpenViewDetails=false;
  showAlertStockDialog(BuildContext context, List<StockPoint> listStockPoint,Inventory obj,String SelectedQuantityt,bool isAllowCl,String rateTypedescriptions,String plank,String multilple)
  {


    if(obj.stockPoints.length!=0)
    {
      print("Selected Object Value "+obj.id.toString()+"    Name "+obj.stockPoints[0].name.toString()+" Stcok Point ID "+obj.stockPoints[0].id.toString());

    }
    else
    {
      print("Stock Point Data Not Found ");
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(

              child: StatefulBuilder(

                builder: (BuildContext context, setState) {


                  return Container(
                    height: 395,
                    width:MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 20,bottom: 20),

                    child:


                    Column(
                      children: [
                        Stack(
                          children: [
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



                        Container(
                          margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                          height: 200,
                          child:   ListView.builder(

                              scrollDirection: Axis.vertical,
                              itemCount: obj.stockPoints.length,//listStockPoint.length,
                              //itemCount: listStockPoint.length,//listStockPoint.length,

                              shrinkWrap: true,


                              itemBuilder: (context, index) {

                                // double availabeQuantity = listStockPoint[index].inventory;
                                // double blockedQuantity =  listStockPoint[index].blocked;
                                // var nameStockPoint = listStockPoint[index].name;
                                double availabeQuantity =obj.stockPoints[index].inventory;
                                double blockedQuantity =  obj.stockPoints[index].blocked;
                                var nameStockPoint = obj.stockPoints[index].name;

                                print("Stcok Point Name in Stock Details   $nameStockPoint");


                                return availabeQuantity.toStringAsFixed(0)=="0"&&blockedQuantity.toStringAsFixed(0)=="0"?Container():Container(
                                  padding: EdgeInsets.only(left: 5,right: 5,),

                                  child:

                                  GestureDetector(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Stocklist1.contains(index)  ? imgUpstock:imgDownstock,//ischeckstock//Stocklist1.contains(index)


                                            Container(

                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(

                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,

                                                      children: [
                                                        Text(listStockPoint[index].name.toString()
                                                          ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                                                      ],
                                                    ),
                                                    width: (MediaQuery.of(context).size.width/3)-37,
                                                    alignment: Alignment.centerLeft,
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,

                                                          children: [
                                                            Text("Available",style: TextStyle(color: Colors.black,),),
                                                            SizedBox(height: 5,),
                                                            Text(availabeQuantity.truncateToDouble().toStringAsFixed(0)+" Sqft",style: TextStyle(color: Colors.green),)
                                                          ],
                                                        ),
                                                        width: (MediaQuery.of(context).size.width/2)-70,
                                                        alignment: Alignment.centerLeft,
                                                      ),

                                                      Container(

                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Blocked",style: TextStyle(color: Colors.black,),),
                                                            SizedBox(height: 5,),
                                                            Text(blockedQuantity.truncateToDouble().toStringAsFixed(0)+" Sqft",style: TextStyle(color: Colors.red),)
                                                          ],
                                                        ),
                                                        width:(MediaQuery.of(context).size.width/2)-70,
                                                        alignment: Alignment.centerRight,

                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),
                                              margin: EdgeInsets.only(left: 10),
                                            ),
                                          ],
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(top: 10,bottom: 10),
                                          height: 1,
                                          color:sh_textColorVerticleLine,
                                        ),

                                      ],
                                    ),//ischeckstock//Stocklist1.contains(index)
                                    onTap: (){
                                      setState(() {

                                        if(!Stocklist1.contains(index))
                                        {
                                          Stocklist1.clear();
                                          Stocklist1.add(index);
                                          selectedStcokindex=listStockPoint[index].id;
                                          selectedStockSource=listStockPoint[index].source;
                                          slectedStockSourceQuantity=listStockPoint[index].inventory.truncate().toStringAsFixed(0);




                                        }

                                        // else
                                        //   {
                                        //     Stocklist1.clear();
                                        //     Stocklist1.add(index);
                                        //     selectedStcokindex=listStockPoint[0].id;
                                        //   }

                                        print(" SelectedStcokindex    >>>>>>>>>>>>     $selectedStcokindex ");
                                        print(" SelectedStcok Source  >>>>>>>>>>>>     $selectedStockSource ");




                                        if(ischeckstock)
                                        {
                                          ischeckstock=false;
                                        }
                                        else
                                        {
                                          ischeckstock=true;
                                          isOpenViewDetails=true;

                                        }

                                        print("Stock Check Box >>>>>>>> $ischeckstock");


                                        //  print(img.toString()+"Show1");
                                      });

                                    },
                                  ),



                                );
                                // return Chats(mListings[index], index);
                              }),


                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),



                          color: sh_white,
                          child:   Container(

                            child: MaterialButton(
                              padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),


                              child: Text("View Details", style: TextStyle(fontSize: textSizeSMedium,fontWeight: FontWeight.bold),),
                              textColor: sh_white,
                              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
                              color: sh_colorPrimary,
                              onPressed: () => {

                                ischeckstock,
                                print("Is Checked Stock Poinr $ischeckstock"),
                                FlagOnSelectedInventory=true,
                                if(isOpenViewDetails)
                                  {

                                    DisSelectedInventory(
                                        widget.SelectedQuantity,
                                        obj,
                                        true,
                                        widget.SelectedValueForSearch,
                                        widget.SelectedDealer2,
                                        widget.spinnerDealerSelectes,selectedStcokindex,isAllowCl,rateTypedescriptions,plank,multilple,selectedStockSource,slectedStockSourceQuantity).launch(context),





                                    //  _bottomSheetMore(context,int.parse(widget.SelectedQuantity),obj,true,),

                                  }
                                else
                                  {
                                    showToastDialog(context,"Please Select Stock Point"),
                                    print("Please Select Any Stock "),

                                  }



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
        }).then((value){
      print("Methode Call Dialog Stcok Close ");
      setState(() {
        Stocklist1.clear();
        ischeckstock=false;
        isOpenViewDetails=false;
      });

    });
  }


  showToastDialog(BuildContext context,String Message)
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



          );
        });

  }

  showAlertDialogCertificatePDF(BuildContext context, StateSetter updateState_bottom,String displayNameColor,String fileName) {
    // Create button


    showDialog(
        context: context,
        builder: (BuildContext context) {
          return   MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
            child:

            Dialog(

                child: StatefulBuilder(


                  builder: (BuildContext context, updateState_bottom)
                  {
                    //Methode Call to Add To Cart

                    bool isProgress= false;


                    if(singlePdfCall)
                    {
                      print("Flag of Single Pdf is  >>>>>>>>>>>>>>>>>>>>>>>>> $getPdfLinkresult");

                      //getPdfLink(displayNameColor)
                      downloadPdfCertificater(displayNameColor, updateState_bottom,fileName);


                    }



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
                              Stack(
                                children: [


                                  Container(
                                    child:


                                    isSinglePDFDownload?Image.asset(ic_greencheck,height: 80,width: 80, fit: BoxFit.fill,):Image.asset(ic_form_preloader_gif,height: 100,width: 100, fit: BoxFit.fill,),
                                    alignment: Alignment.topCenter,
                                  ),

                                ],
                              ),

                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 10),



                                child:  Column(
                                  children: [
                                    isSinglePDFDownload?  Text("Successfully Certificate Download ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),)
                                        :Text("Please wait, while we download your Certificate ",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Container(),
                                    //     Text(" Success Fully Download pdf .....$downloadPercontage",style: TextStyle(color: sh_black,fontSize: 15,fontWeight: FontWeight.bold),),
                                    //     Container(),
                                    //   ],
                                    // ),
                                    //isSinglePDFDownload
                                    isSinglePDFDownload? Container(
                                      alignment: Alignment.center,

                                      child: IntrinsicWidth(
                                        child:MaterialButton(

                                          padding:  EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
                                          child: text("View", fontSize: textSizeSMedium, fontFamily: fontMedium, textColor: Colors.white),
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(round_border_form)),
                                          color: sh_colorPrimary,
                                          onPressed: () async {

                                            // print("Send Selected Value For Cart Page "+widget.SelectedValueForSearch);
                                            //                                                    SearchProductResult(value,SelectedAutoSuggestStirng,spinnerDealerSelectes,SelectedQuantity,this.SingleSelectedCategory,SelectedDealer2,SelectedMinPrice,SelectedmaxPrice,SelectedValue,spinnerDelerList,spinnerSelectDealer2).launch(context);
                                            // Navigator.pop(context, false);
                                            Navigator.pop(context);
                                            openFile(openFullPath);



                                          },
                                          // onPressed: () => {
                                          //  // Navigator.pop(context),
                                          //   SelectProductPlaceOrder().launch(context),
                                          // },
                                          elevation: 0,
                                        ),

                                      ),
                                    ):Container(),
                                  ],
                                ),
                              ),


                            ],
                          )),



                    );
                  },
                )



            ),);



        }).then((Exit){

      setState(() {
        if(getPdfLinkresult)
        {
          //openFile(openFullPath);

        }


        print(">>>>>>>>>>>>>>>>>>>>>>>>>>Pdf Download Success Fully ");
        //showToastDialogPdf(context, "Pdf Downloaded  SuccessFully ");








      });

      updateState_bottom((){
        // lotInventory.clear();
        // int lotInventoryLength =     lotInventory.length;
        // print("Lot Inventory Length After close Dialog $lotInventoryLength");
        // getSelectedInventory(updateState_bottom,obj,selectedStcokindex);
        // list1.clear();


      });
    });
  }

  downloadPdfCertificater(String pdfUrl, StateSetter updateState_bottom,String fileName) async
  {
    print("downloadPdfCertificater Call "+pdfUrl);
    if(true)
    {
      if(true)
      {

        singlePdfCall=false;




        ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ///
        String path="";

        if(Platform.isIOS)
        {

          Directory directory = Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
              : await getApplicationDocumentsDirectory();
          //await getApplicationSupportDirectory(); //FOR

          // Directory dir = await getApplicationDocumentsDirectory().;

          print("Ios Doirectory path  is  >>>>>>>>>>>>>>>>>>>>>>> "+directory.path);
          path=directory.path;









        }
        if(Platform.isAndroid)
        {
          path =  await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);

        }

        final DateTime now = DateTime.now();
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String formatted = formatter.format(now);

        final String formatted2 = DateFormat.yMMMMd().format(now);

        print("Today date formate "+formatted2); //April 27, 2022


        //27April2022
        String newDate = "$fileName"+"_"+listsearchProducts2[selected_ross_index].collection.displayName+"_"+(formatted2.split(" ")[1]+formatted2.split(" ")[0]+formatted2.split(" ")[2]).replaceAll(",", "");
       // String newDate = "Certificate"+"_"+(formatted2.split(" ")[1]+formatted2.split(" ")[0]+formatted2.split(" ")[2]).replaceAll(",", "");
        print("Requied Date Formate "+newDate);





        var time = DateTime.now().microsecondsSinceEpoch;

        //var date2 = new DateTime.fromMillisecondsSinceEpoch(time * 1000);
        // print("Time Covertor in Single PDF "+DateFormat.yMMMMd().format(t));

        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        final folderName= APP_FOLDER_NAME;
        final path2= Directory("$path/$folderName");
        if ((await path2.exists())){

          print(">>>>>>>exist");
        }else{
          print(">>>>>>>not exist");
          path2.create();
        }
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



        pdfCount=pdfCount+1;
        print("New Date Methode Call Count "+pdfCount.toString());

        if(pdfTodayDate=="")
        {
          pdfTodayDate=newDate;
        }
        else
        {
          if(pdfTodayDate!=newDate)
          {
            pdfCount=0;
            pdfCount=pdfCount+1;
            pdfTodayDate=newDate;

            print("New Date Methode Call Count");
          }
        }




        String fullPath = "$path/$folderName/$newDate"+"_"+pdfCount.toString()+(pdfUrl.split('/').last);
        // String fullPath = "$path/$folderName/$newDate"+"_"+pdfCount.toString()+".pdf";
        // String fullPath = "$path/$folderName/$displayNameColor-$time.pdf";
        // String fullPath = "$path/$time.pdf";

        print("External Storage Path >>>>>>>>>>>>>>>>>$fullPath");



        //Create App name Folder











        openFullPath=fullPath;





        download2(dio, pdfUrl, fullPath,updateState_bottom).then((value){

          //print("Result of Download Pdf Is "+value.toString());



        });








      }
      else
      {

        singlePdfCall=false;


      }







    }
  }
}
