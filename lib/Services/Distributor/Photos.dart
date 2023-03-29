import 'dart:convert';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../rosetta/models/SkipButtonApi.dart';
import '../../rosetta/utils/ShColors.dart';
import '../../rosetta/utils/ShConstant.dart';
import '../../rosetta/utils/ShImages.dart';
import '../../rosetta/utils/ShWidget.dart';
import 'package:http/http.dart' as http;
class Photos extends StatefulWidget {

  Photos({this.navigatorKey, this.child,});


  final Widget child;
  final GlobalKey navigatorKey;

  @override
  PhotosState createState() => PhotosState();
}

class PhotosState extends State<Photos> {

  Directory _photoDir;
  String path="";

  String MyToken;
  String MyUserName="";
  String MyCompanyId;
  String MyMemberId;
  String MyMemberType;
  String  Myparent_distributor_id;
  String  Myparent_distributor_nav_id;

  bool isfolderavailable = false;


  Image imgUp =  Image.asset(ic_check,height: 15,width: 15,color: sh_colorPrimary,);
  Image imgDown =  Image.asset(ic_uncheck,height: 15,width: 15,color: sh_colorPrimary,);

  var list1 = [];
  var list2 = [];


  isCheckFolderavailable() async
  {

    String downloadpath;


    if(Platform.isIOS)
    {

      Directory directory = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getApplicationDocumentsDirectory();
      //await getApplicationSupportDirectory(); //FOR

      // Directory dir = await getApplicationDocumentsDirectory().;

      print("Ios Doirectory path  is  >>>>>>>>>>>>>>>>>>>>>>> "+directory.path);
      downloadpath=directory.path;









    }
    if(Platform.isAndroid)
    {
       downloadpath =  await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);

    }





    final path2= Directory(downloadpath+"/"+APP_FOLDER_NAME);
    if ((await path2.exists())){
      // TODO:
      print("Photos >>>>>>>exist");
      isfolderavailable = true;
    }else{
      // TODO:
      print("Photos >>>>>>>not exist");
      path2.create();

       setState(() {
         isfolderavailable = false;

       });
    }
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
   // getPermission();
   //   _photoDir = getFolderPath() as Directory;

    print("PDF PAge is Call >>>>>>>>>>>>>>>..  ");
    isCheckFolderavailable();
    getFolderPath();
    getSessionData();
    isVisibleSkipApi();


    // print("Init State PHOTO DIR >>>>>>>>>>>>>>>>>>>>>>>>>>>>"+_photoDir.toString());
  }


  getSessionData() async
  {
    print("Get Session Methode Call");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String  userName = prefs.getString('UserName');
    String  mycompanyId = prefs.getString('companyId');
    String  mymemberId = prefs.getString('memberId');
    String  mymemberType = prefs.getString('memberType');
    String  parent_distributor_id ="0";
    String  parent_distributor_nav_id = "0";
    if(mymemberType!="Distributor")
    {

      parent_distributor_id = prefs.getString('parent_distributor_id');
      parent_distributor_nav_id = prefs.getString('parent_distributor_nav_id');

    }



    print("Home Page >>>>>>>>>>>Session Token $token  $userName $mycompanyId $mycompanyId $mymemberType");
    setState(() {
      MyToken=token;
      MyUserName=userName;
      MyCompanyId=mycompanyId;
      MyMemberId=mymemberId;
      MyMemberType=mymemberType;
      if(MyMemberType!="Distributor")
      {
        Myparent_distributor_id=parent_distributor_id;
        Myparent_distributor_nav_id=parent_distributor_nav_id;
        print("Home Page Session Data Myparent_distributor_id  $parent_distributor_id , Myparent_distributor_nav_id $parent_distributor_nav_id");
      }

    });


  }



  List<String> imageList;
  getFolderPath()  async   {
                  // ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)



       if(Platform.isAndroid)
         {

           path =  await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);

         }

         if(Platform.isIOS)
           {

             Directory directory = Platform.isAndroid
                 ? await getExternalStorageDirectory() //FOR ANDROID
                 : await getApplicationDocumentsDirectory();



                 path=directory.path;


           }
            setState(()  {

              print("Path My Device Folder >>>>>>>>>>>>>>>>>>>>>> $path  Directory "+Directory('$path').toString());
              String fullpath = ""+path+"/"+APP_FOLDER_NAME;
              print("fullpath >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $fullpath");
              _photoDir = Directory('$fullpath');


            });

       if(!Directory("${_photoDir.path}").existsSync())
         {
           print("File path Not Exist >>>>>>>>>>>>>..");
         }
       else
         {

           setState(() {
           isfolderavailable=true;
            });
           print("File path  Exist >>>>>>>>>>>>>..");
            imageList = _photoDir.listSync().map((item) => item.path).where((
               item) => item.endsWith(".pdf")).toList(growable: false).toList();

           print("Find Items lenght is >>>>>>>>>>>>>>> "+imageList.length.toString());

         }





  }



  Future<void> deleteFile(File file,int index) async {
    try {
      if (await file.exists()) {
        await file.delete();
        print("Delete PDf Your File is deleted Success fully ");
        setState(() {
         imageList.removeAt(index);
        //   imageList.remove(imageList[index]);
          // if(list2.contains(index)){
          //   list2.remove(index);
          // }

          //Navigator.pop(context, true);
        });







      }
    } catch (e) {
      print("Delete PDf Error "+e.toString());
      // Error in getting access to the file.
    }
  }




  showAlertDialogConfirmDelete(BuildContext contex,StateSetter updateState,int index) {
    // set up the button



    // set up the AlertDialog

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text(" Are you sure you want to delete the selected item?"),
          actions: [

            Container(
              color: sh_colorPrimary,
              child: TextButton(
                child: Text("yes",
                 style: TextStyle(color: Colors.white),
                ),
                // textColor: Colors.white,
                // color: sh_colorPrimary,
                onPressed: () {
                  //Navigator.pop(contex, true);

                  deleteFile(File(imageList[index]),index);



                },

              ),
            ),

            Container(
              color: sh_colorPrimary,
              child: TextButton(
                child: Text("No",
                 style: TextStyle( color: Colors.white),
                ),
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
  showAlertDialogConfirmDeleteALL(BuildContext contex,StateSetter updateState,int length) {
    // set up the button



    // set up the AlertDialog

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text(" Are you sure you want to delete the selected item?"),
          actions: [

            Container(
              color: sh_colorPrimary,
              child: TextButton(
                child: Text("yes",
                 style: TextStyle(color: Colors.white),
                ),
               // textColor: Colors.white,
                // color: sh_colorPrimary,
                onPressed: () {
                  //Navigator.pop(contex, true);

                  print("Length of Selected Value "+list2.length.toString());
                  print("Value of Selected Value "+list2.toString());

                  int i=0;
                  for( i;i<length;i++)
                    {

                      String name = imageList[list2[i]];

                      print("Name of Selected Pdf "+name);
                      print("Index of Selected Pdf "+list2[i].toString());
                    //  print("Value of Selected Pdf "+imageList[list2[i]]);

                      deleteFile(File(name),imageList.indexOf(name));

                      // setState(() {
                      //   if(list2.contains(list2[i]))
                      //     {
                      //       list2.remove(list2[i]);
                      //
                      //     }
                      // });





                    }

                  print("Lenght 1  >>>>>   "+length.toString());
                  print("Lenght 2  >>>>>   "+list2.length.toString());
                  if(list2.length==i)
                    {
                      updateState((){
                        list2.clear();
                      });


                      Navigator.pop(context, true);
                    }





                },

              ),
            ),

            Container(
              color: sh_colorPrimary,
              child: TextButton(
                child: Text("No"),
                //textColor: Colors.white,
                //color: sh_colorPrimary,
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






  /* Directory _photoDir = Directory(ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS));*/

  // Directory _photoDir = Directory('/storage/emulated/0/Download');
  // Directory _photoDir = Directory('$path');

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

  @override
  Widget build(BuildContext context)  {



          if(!isfolderavailable)
          {
            print("File path Not Exist >>>>>>>>>>>>>..");

            return
              MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
                  child:

              Scaffold(
                appBar:PreferredSize(
                      preferredSize: const Size.fromHeight(50),
                      child:MyAppBar(true,"",MyUserName,isVisibleSkip,true),
                      ),
                      body: Center(
                        child: Container(
                        padding: EdgeInsets.only(bottom: 60.0),
                              child: Text("Sorry, No PDF Where Found.", style: TextStyle(
                              fontSize: 18.0
                                   ),),
                          ),
                      ),
                      endDrawer: MyDrwaer(),
               ),
              );
          }

         else if (imageList.length > 0) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
              child:  Scaffold(
              appBar:PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child:MyAppBar(true,"", MyUserName,isVisibleSkip,true),
              ),
              body: Container(
                padding: EdgeInsets.only(bottom: 60.0),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),

                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    String imgPath = imageList[index].replaceAll(path+"/"+APP_FOLDER_NAME+"/", "");
                    return Container(
                      margin: EdgeInsets.all(5.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Container(
                                child:GestureDetector(

                                  child: list2.contains(index) ? imgUp:imgDown,
                                  onTap: (){
                                    setState(() {
                                      //selectedindex2=index;
                                      if(list2.contains(index))
                                      {
                                        list2.remove(index);
                                        // bool isRemoveCart= newBlockedListSelected.remove(newBlockedList[index]);
                                        // print("On Remove Blocked is $isRemoveCart");
                                      }
                                      else
                                      {
                                        list2.add(index);
                                        // newBlockedListSelected.add(newBlockedList[index]);
                                        //print("On Add Length of Block  Items "+newBlockedListSelected.length.toString());

                                      }

                                      //  print(img.toString()+"Show1");
                                    });

                                  },
                                ),



                              ),
                              Material(

                                elevation: 0.5,


                                child:

                                InkWell(
                                  onTap: () {
                                    openFile(imageList[index]);
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width-43,
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Image.asset(ic_pdf,height:25,width: 25,),
                                        SizedBox(width: 10,),
                                        Text(
                                            imgPath
                                        ),
                                      ],
                                    ),


                                  ),
                                  // child: Hero(
                                  //   tag: imgPath,
                                  //   child:Container(
                                  //     padding: EdgeInsets.all(10.0),
                                  //     child: Row(
                                  //       children: [
                                  //         Image.asset(ic_pdf,height:25,width: 25,),
                                  //         SizedBox(width: 10,),
                                  //         Text(
                                  //             imgPath
                                  //         ),
                                  //       ],
                                  //     ),
                                  //
                                  //
                                  //   ),
                                  // ),
                                ),
                              ),


                            ],
                          ),
                          // InkWell(
                          //   onTap: (){
                          //     // deleteFile(File(imageList[index]),index);
                          //
                          //     showAlertDialogConfirmDelete(context, setState, index);
                          //   },
                          //   child: Image.asset(ic_delete_item,height:25,width: 25,),
                          // )






                        ],
                      )


                    );
                  },
                  // staggeredTileBuilder: (i) =>
                  //     StaggeredTile.count(2, i.isEven ? 2 : 3),
                  // mainAxisSpacing: 8.0,
                  // crossAxisSpacing: 8.0,
                ),
              ),

                // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FloatingActionButton(
                  // isExtended: true,
                  child: Icon(Icons.delete,
                    color:Colors.white,),
                  backgroundColor: sh_colorPrimary,
                  onPressed: () {
                    setState(() {

                      if(list2.length==0)
                        {
                               showToastDialog(context,"Please select pdf ");
                        }
                      else
                        {
                              showAlertDialogConfirmDeleteALL(context, setState, list2.length);
                        }

                    });
                  },
                ),
              endDrawer: MyDrwaer(),
            ),
            );
          } else {
            return
              MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor:textWholeApp), // Large
    child:
              Scaffold(
              appBar:PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child:MyAppBar(true,"",MyUserName,isVisibleSkip,true),
              ),
              body: Center(
                child: Container(
                  padding: EdgeInsets.only(bottom: 60.0),
                  child: Text("Sorry, No PDF Where Found.", style: TextStyle(
                      fontSize: 18.0
                  ),),
                ),
              ),
              endDrawer: MyDrwaer(),
            ),
              );
          }


    // }
  }

  showToastDialog(BuildContext context,String Message)
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



            ),
          );
        });

  }
}

