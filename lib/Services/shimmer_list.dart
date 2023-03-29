import 'package:flutter/material.dart';

import 'Shimmer.dart';



class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SafeArea(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9 / 11, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;


          print(time);

          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[350],
                child: ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width - 150;
    double containerHeight = 15;

    return  Container(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 9 / 11,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.all(1),
                 color: Colors.grey,
                ),


              ],
            ),
          ),
          SizedBox(height: 2),

        ],
      ),
    );


  }
}



class ShimmerCartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SafeArea(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        itemCount: 3,

        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;


          print(time);

          return  Container(
            margin: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[



                InkWell(
                  child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          SizedBox(width: 10,),
                          Container(
                            width:50,//width * 0.3,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child:Shimmer.fromColors(
                                highlightColor: Colors.white,
                                baseColor: Colors.grey[350],
                                child: ShimmerLayout(),
                                period: Duration(milliseconds: time),
                                )
                            ),
                          ),
                        ],
                      ),
                  ),
                  onTap: (){

                  },
                ),




                SizedBox(width: 10,),

                Container(
                  width: (MediaQuery.of(context).size.width/2)-66,
                  // alignment: Alignment.centerLeft,
                  child:Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: Colors.grey[350],
                        child: ShimmerLayout(),
                        period: Duration(milliseconds: time),
                        ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width/2)-66,
                  alignment: Alignment.centerRight,
                  child: Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey[350],
                      child: ShimmerLayout(),
                      period: Duration(milliseconds: time),
                      )
                ),




              ],
            ),
          );




        },
      ),



    );
  }
}



class ShimmerInventoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SafeArea(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        itemCount: 10,

        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;


          print(time);

          return  Container(
            margin: EdgeInsets.only(top: 5,bottom: 5,left: 0,right: 0),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[



                InkWell(
                  child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          SizedBox(width: 10,),
                          Container(
                            width:20,//width * 0.3,
                            height: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child:Shimmer.fromColors(
                                highlightColor: Colors.white,
                                baseColor: Colors.grey[350],
                                child: ShimmerLayout(),
                                period: Duration(milliseconds: time),
                                )
                            ),
                          ),
                        ],
                      ),
                  ),
                  onTap: (){

                  },
                ),




                SizedBox(width: 10,),

                Column(

                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width-80),
                      // alignment: Alignment.centerLeft,
                      child:Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: Colors.grey[350],
                        child:  Container(
                          // width: double.infinity,
                          // height: double.infinity,
                          height: 50,
                          padding: EdgeInsets.all(1),
                          color: Colors.grey,
                        ),
                        period: Duration(milliseconds: time),
                      ),
                    ),
                  ],
                ),






              ],
            ),
          );




        },
      ),



    );
  }
}
class TextShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SafeArea(
      child:  Container(
        width: (MediaQuery.of(context).size.width-80),
        height: 10,
        // alignment: Alignment.centerLeft,
        child:Shimmer.fromColors(
          highlightColor: Colors.white,
          baseColor: Colors.grey[350],
          child:  Container(
            // width: double.infinity,
            // height: double.infinity,
            height: 50,
            padding: EdgeInsets.all(1),
            color: Colors.grey,
          ),
          period: Duration(milliseconds: time),
        ),
      ),



    );
  }
}
class SmallBoxShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SafeArea(
      child:
      Container(
        width:20,//width * 0.3,
        height: 20,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child:Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.grey[350],
              child: ShimmerLayout(),
              period: Duration(milliseconds: time),
            )
        ),
      ),
      // child:  Container(
      //   width: 20,
      //
      //   //height: 2,
      //   // alignment: Alignment.centerLeft,
      //   child:Shimmer.fromColors(
      //     highlightColor: Colors.white,
      //     baseColor: Colors.grey[350],
      //     child:  Container(
      //       // width: double.infinity,
      //       // height: double.infinity,
      //      // height: 10,
      //       padding: EdgeInsets.all(1),
      //       color: Colors.grey,
      //     ),
      //     period: Duration(milliseconds: time),
      //   ),
      // ),



    );
  }
}



class ShimmerDisOrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SafeArea(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        itemCount: 10,

        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;


          print(time);

          return  Container(
            margin: EdgeInsets.only(top: 5,bottom: 5,left: 0,right: 0),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[



                InkWell(
                  child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          SizedBox(width: 10,),
                          Container(
                            width:MediaQuery.of(context).size.width-60,//width * 0.3,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child:Shimmer.fromColors(
                                highlightColor: Colors.white,
                                baseColor: Colors.grey[350],
                                child: ShimmerLayout(),
                                period: Duration(milliseconds: time),
                                )
                            ),
                          ),
                        ],
                      ),
                  ),
                  onTap: (){

                  },
                ),




                SizedBox(width: 10,),








              ],
            ),
          );




        },
      ),



    );
  }
}

