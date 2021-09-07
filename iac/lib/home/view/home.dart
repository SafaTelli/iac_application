import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iac/data/models/actus.dart';
import 'package:iac/data/models/event.dart';
import 'package:iac/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final events = [
    Event(title: "UI/UX WORKSHOP", date: "12/04/2021", place: "INSAT"),
    Event(title: "Flutter WORKSHOP", date: "12/04/2021", place: "INSAT"),
    Event(title: "UI/UX WORKSHOP", date: "12/04/2021", place: "INSAT"),
    Event(title: "UI/UX WORKSHOP", date: "12/04/2021", place: "INSAT"),
  ];
  final actus = [
    Actus(
        title: "UI/UX WORKSHOP",
        date: "12/04/2021",
        descr:
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat."),
    Actus(
        title: "UI/UX WORKSHOP",
        date: "12/04/2021",
        descr:
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(60.0)),
          child: Drawer(child: DrawaerPage()),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
                IconButton(
                    icon: Icon(Icons.menu, color: Color(0xff386641)),
                    onPressed: () => Scaffold.of(context).openDrawer()),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nos évènements',
                      style: TextStyle(
                          color: Color(0xff386641),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      'Voir tous',
                      style: TextStyle(
                        color: Color(0xff386641),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .35,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('events')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!.docs.map((doc) {
                          // ignore: lines_longer_than_80_chars
                          var string = DateTime.fromMicrosecondsSinceEpoch(
                                  doc['date'].microsecondsSinceEpoch)
                              .toString();
                          return Container(
                            width: 250,
                            height: 150,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10.0)),
                                      child: Image.network(
                                        doc['cover'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        string,
                                        style: TextStyle(
                                          color: Color(0xff386641),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        doc['title'].toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.place,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          doc['place'].toString(),
                                          style: TextStyle(
                                              color: Color(0xff386641)),
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nos Actualités',
                      style: TextStyle(
                          color: Color(0xff386641),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      'Voir tous',
                      style: TextStyle(
                        color: Color(0xff386641),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .35,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('actus')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView(
                        children: snapshot.data!.docs.map((doc) {
                          // ignore: lines_longer_than_80_chars
                          var string = DateTime.fromMicrosecondsSinceEpoch(
                                  doc['date'].microsecondsSinceEpoch)
                              .toString();
                          return Container(
                            width: 250,
                            height: MediaQuery.of(context).size.height * .55,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: AssetImage(
                                                  'images/logo.png')),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Le club',
                                                  style: TextStyle(
                                                      color: Color(0xff386641),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('Depuis 2 jours',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff707070)))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10.0)),
                                      child: Image.network(
                                        doc['cover'],
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        doc['desc'].toString(),
                                        style: TextStyle(
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
              /*  Container(
                height: MediaQuery.of(context).size.height * .65,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: actus.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 250,
                      height: MediaQuery.of(context).size.height * .55,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage('images/logo.png')),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Le club',
                                            style: TextStyle(
                                                color: Color(0xff386641),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('Depuis 2 jours',
                                              style: TextStyle(
                                                  color: Color(0xff707070)))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.0)),
                                child: Image.asset(
                                  'images/actus.png',
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  actus[index].descr,
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              )

              */
            ],
          ),
        ));
  }

  fetchData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('staff');
    collectionReference.snapshots().listen((snapshots) {
      setState(() {
        // print("data--");
        // print(snapshots.docs[0].data());
      });
    });
  }
}
