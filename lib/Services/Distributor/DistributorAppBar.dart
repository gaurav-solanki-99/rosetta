import 'package:flutter/material.dart';
class DistributorAppBar extends StatefulWidget {
  const DistributorAppBar({Key key}) : super(key: key);

  @override
  State<DistributorAppBar> createState() => _DistributorAppBarState();
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(
    title: 'Log-out',
    icon: Icons.power_settings_new,
  ),
  CustomPopupMenu(
    title: 'View Card',
    icon: Icons.credit_card,
  ),

];
class _DistributorAppBarState extends State<DistributorAppBar> {

  CustomPopupMenu _selectedChoices = choices[0];
  void _select(CustomPopupMenu choice) {
    setState(() {
      _selectedChoices = choice;

      String title=_selectedChoices.title;
      print("Option Click $title");
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      color: Colors.blueAccent,
      height: 80,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () { /* Write listener code here */ },
                  child: Icon(
                    Icons.menu,
                      color: Colors.black,// add custom icons also
                  ),
                ),
                SizedBox(
                   width: MediaQuery.of(context).size.width/3,
                ),

                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                        onTap: () {},
                        child: Text(
                            "Welcome Distributor"
                        ),

                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: PopupMenuButton<CustomPopupMenu>(
                    child: Icon(
                      Icons.more_vert,
                    ),
                    elevation: 3.2,
                    onCanceled: () {
                      print('You have not chossed anything');
                    },
                    tooltip: 'This is tooltip',
                    onSelected: _select,
                    itemBuilder: (BuildContext context) {
                      return choices.map((CustomPopupMenu choice) {
                        return PopupMenuItem<CustomPopupMenu>(
                          value: choice,
                          child: Text(choice.title),
                        );
                      }).toList();
                    },
                  ),
                ),


              ],
         ),

    );





  }
}
class CustomPopupMenu {
  CustomPopupMenu({
     this.title,
     this.icon,
  });
  String title;
  IconData icon;



}