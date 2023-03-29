// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:ext_storage/ext_storage.dart';
//
//
//
//
//
//
//
//
// class MyPdfFile extends StatefulWidget {
//   const MyPdfFile({Key key}) : super(key: key);
//
//   @override
//   _MyPdfFileState createState() => _MyPdfFileState();
// }
//
// class _MyPdfFileState extends State<MyPdfFile> {
//
//
//   final imgUrl = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
//
//   var dio = Dio();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Download Pdf File"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RaisedButton(
//               child: Text("Download",
//                 style: TextStyle(fontSize: 25, color: Colors.black),),
//               onPressed: () async {
//                 String path =
//                 await ExtStorage.getExternalStoragePublicDirectory(
//                     ExtStorage.DIRECTORY_DOWNLOADS);
//                 String fullPath = "$path/rosetta.pdf";
//
//                 print("External Storage Path >>>>>>>>>>>>>>>>>$fullPath");
//
//                 download2(dio, imgUrl, fullPath);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     getPermission();
//   }
//
//   void getPermission() async {
//     print(">>>>>>>>Get Permission");
//     await Permission.storage;
//   }
//   Future download2(Dio dio, String url, String savePath) async {
//     //get pdf from link
//
//     try
//     {
//       Response response = await dio.get(
//         url,
//         onReceiveProgress: showDownloadProgress,
//         //Received data with List<int>
//         options: Options(
//             responseType: ResponseType.bytes,
//             followRedirects: false,
//             validateStatus: (status) {
//               return status < 500;
//             }),
//       );
//
//       //write in download folder
//       File file = File(savePath);
//       var raf = file.openSync(mode: FileMode.write);
//       raf.writeFromSync(response.data);
//       await raf.close();
//
//
//     }catch(e)
//     {
//       print(" Error >>>>>>>>>> $e");
//     }
//
//   }
//
//
//   void showDownloadProgress(received,total)
//   {
//     if (total != -1) {
//       print((received / total * 100).toStringAsFixed(0) + "%");
//     }
//
//   }
// }
//
//
//
//
//
//
