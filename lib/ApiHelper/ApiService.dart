// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:rosetta_fluter_app/rosetta/models/Category.dart';
//
// class LoginService
// {
//   static const String url ="http://dummy.restapiexample.com/api/v1/create";
//   static Future<int> sendData(String username,String password) async
//   {
//     var res = await http.post(Uri.parse(url),body: jsonEncode({"name":"$username","$password":"7987","age":"23"}),
//         headers: {"Content-Type":"text/plain"});
//     print(res.statusCode);
//     print(res.body);
//     return res.statusCode;
//
//   }
// }
//
// class LoginFormData
// {
//   static const uri = 'https://na57.salesforce.com/services/oauth2/token';
//
//   static Future<int> sendFormData() async
//   {
//     var map = new Map<String, dynamic>();
//     map['grant_type'] = 'password';
//     map['client_id'] = '3MVG9dZJodJWITSviqdj3EnW.LrZ81MbuGBqgIxxxdD6u7Mru2NOEs8bHFoFyNw_nVKPhlF2EzDbNYI0rphQL';
//     map['client_secret'] = '42E131F37E4E05313646E1ED1D3788D76192EBECA7486D15BDDB8408B9726B42';
//     map['username'] = 'example@mail.com.us';
//     map['password'] = 'ABC1234563Af88jesKxPLVirJRW8wXvj3D';
//
//     http.Response response = await http.post(Uri.parse(uri), body: map,);
//
//     var responcebody = response.body;
//     var responseCode = response.statusCode;
//
//
//     print("Response Body of Form Data Api : $responcebody");
//     print("Response code Form Data Api : $responseCode");
//
//   }
//
// // Future LoginUser(BuildContext context) async {
// //   var APIURL = Uri.parse('https://votivetech.in/courier/webservice/api/login');
// //   Map mapeddate = {
// //     'email': email,
// //     'password': password,
// //   };
// //   Response response = await post(APIURL,body:mapeddate);
// //   var data = jsonDecode(response.body);
// //   int status= data['status'];
// //   print("DATA: ${status}");
// //   if(status==1){
// //     List data1 = data['data'];
// //     print("DATA: ${data1}");
// //     for(var i = 0; i< data1.length; i++) {
// //       print(data1[i]['driver_id']);
// //       secureStorage.writeSecureData('driverid', data1[i]['driver_id']);
// //       secureStorage.writeSecureData('firstname', data1[i]['first_name']);
// //       secureStorage.writeSecureData('surname', data1[i]['surname']);
// //       secureStorage.writeSecureData('email', data1[i]['email']);
// //       secureStorage.writeSecureData('mobilenumber', data1[i]['mobile_number']);
// //       secureStorage.writeSecureData('address', data1[i]['address']);
// //       secureStorage.writeSecureData('city', data1[i]['city']);
// //       secureStorage.writeSecureData('postcode', data1[i]['post_code']);
// //       secureStorage.writeSecureData('status', data1[i]['status']);
// //     };
// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) {
// //           return GroceryHomePage();
// //         },
// //       ),
// //     );
// //     /*Route route = MaterialPageRoute(builder: (context) => GroceryHomePage());
// //     Navigator.pushReplacement(context, route);*/
// //   }else{
// //     Fluttertoast.showToast(
// //         msg: "Unable to login please check email and password",
// //         toastLength: Toast.LENGTH_LONG,
// //         gravity: ToastGravity.BOTTOM,
// //         //    timeInSecForIos: 1,
// //         backgroundColor: Color(0xff2199c7),
// //         textColor: Colors.red,
// //         fontSize: 16.0);
// //   }
// //
// // }
// }
//
// class GetCategory {
//
//   static const String url = "https://laravel.cppatidar.com/rosetta/api/webservices/categories";
//
//   static Future<List<Datum>> getList() async {
//     try {
//       final response = await http.get(Uri.parse(url));
//
//
//       if (200 == response.statusCode) {
//         final List<Datum> category = CategoryCMS
//             .fromJson(json.decode(response.body))
//             .data;
//         return category;
//       } else {
//         return <Datum>[];
//       }
//     } catch (e) {
//       return <Datum>[];
//     }
//   }
// }