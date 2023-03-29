import 'package:flutter/material.dart';

  class DisOrderScreen extends StatefulWidget {
  const DisOrderScreen({Key key}) : super(key: key);

  @override
  State<DisOrderScreen> createState() => _DisOrderScreenState();
}

class _DisOrderScreenState extends State<DisOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child:  Column(

            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: Colors.blueAccent,
              ),

              Container(
                height:  410,
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                color: Colors.greenAccent,
                child : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        width: 200,
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                      Text("Date : "),
                                      Text("Status: In Progress")
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Dealer Name  "),
                                    Text("Order Number ")
                                  ],
                                ),
                                Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Dealer Contact"),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Quantity "),
                                    Text("View Details")
                                  ],
                                ),
                               Container(
                                 alignment: Alignment.centerLeft,
                                 child: Text("Total Values Gst Extra"),
                               ),
                            ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        width: 200,
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date : "),
                                Text("Status: In Progress")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Dealer Name  "),
                                Text("Order Number ")
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Dealer Contact"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Quantity "),
                                Text("View Details")
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Total Values Gst Extra"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(25),
                        width: 200,
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date : "),
                                Text("Status: In Progress")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Dealer Name  "),
                                Text("Order Number ")
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Dealer Contact"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Quantity "),
                                Text("View Details")
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Total Values Gst Extra"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),


            ],

          )
      ),
    );
  }
}
