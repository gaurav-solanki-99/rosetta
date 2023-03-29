import 'dart:io';


// import 'Services/MyPdfFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Services/SplashScreen.dart';
import 'main/store/AppStore.dart';


AppStore appStore = AppStore();
void main() {


  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value){
    runApp(MainApp());
  });

}

class MainApp extends StatefulWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home:



      //MyPdfFile(),
      SplashScreen(),

    );
  }
}

