import 'package:flutter/material.dart';
import 'package:iac/data/models/item_drawer.dart';
import 'package:iac/routing_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawaerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DrawerState();
  }
}

class DrawerState extends State<DrawaerPage> {
  //final items = ['ACTUALITES', 'CALENDRIER', 'STAFF', 'PARAMETRES', 'A propos'];
  final images = ['newspaper', 'calendar', 'staff', 'param', 'about'];
  final items = [
    ItemDrawer(name: 'ACTUALITES', image: 'newspaper', selected: true),
    ItemDrawer(name: 'CALENDRIER', image: 'calendar', selected: false),
    ItemDrawer(name: 'STAFF', image: 'staff', selected: false),
    ItemDrawer(name: 'PARAMETRES', image: 'param', selected: false),
    ItemDrawer(name: 'A PROPOS', image: 'about', selected: false)
  ];
  late String name = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringValuesSF("name").then((value) {
      setState(() {
        print("keyyyy" + value.toString());
        this.name = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffECF2ED),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('images/logo.png')),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 3),
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Se deconnecter',
                    style: TextStyle(
                        color: Color(0xff7B837D),
                        fontWeight: FontWeight.normal),
                  ),
                ],
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Row(
                      children: [
                        Image.asset(
                          'images/' + items[index].image + '.png',
                          height: 60,
                          width: 60,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              items[index].selected = true;
                            });
                            if (index == 2)
                              Navigator.pushNamed(context, StaffViewRoute);
                            else if (index == 1)
                              Navigator.pushNamed(context, CalendarViewRoute);
                            else if (index == 0)
                              Navigator.pushNamed(context, HomeViewRoute);
                            else if (index == 4)
                              Navigator.pushNamed(context, AboutViewRoute);
                          },
                          child: Text(
                            items[index].name,
                            style: TextStyle(
                              color: items[index].selected
                                  ? Color(0xff126426)
                                  : Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(3),
                      child: Image.asset('images/facebook.png'),
                    ),
                    Padding(
                        padding: EdgeInsets.all(3),
                        child: Image.asset('images/youtube.png')),
                    Padding(
                        padding: EdgeInsets.all(3),
                        child: Image.asset('images/instagram.png'))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    'Suivez nous sur ',
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<String> getStringValuesSF(String key) async {
    print("heeeere");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Return String
    // print("keyy" + prefs.toString());

    String stringValue = prefs.getString(key)!;
    //print("keyy" + stringValue);
    return stringValue;
  }
}
