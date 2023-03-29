import 'package:flutter/material.dart';

import 'DistributorAppBar.dart';

class DisContactScreen extends StatefulWidget {
  const DisContactScreen({Key key}) : super(key: key);

  @override
  State<DisContactScreen> createState() => _DisContactScreenState();
}

class _DisContactScreenState extends State<DisContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: [
           DistributorAppBar(),
           Center(child: Container(child: Text("ContactScreen"))),
         ],
       ),
    );
  }
}

