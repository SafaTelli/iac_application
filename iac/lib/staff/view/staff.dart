import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iac/staff/cubit/cubit/staff_cubit.dart';
import 'package:iac/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StaffStatee();
  }
}

class StaffStatee extends State<StaffPage> {
  @override
  initState() {
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StaffCubit>(context).fetchStaff();

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
      body: BlocBuilder<StaffCubit, StaffState>(builder: (context, state) {
        if (state is StaffLoadingState)
          return CircularProgressIndicator();
        else {
          if (state is StaffHasDataState) {
            print('data**');
          }
          StaffHasDataState staffState = state as StaffHasDataState;
          print(staffState);
          var data = staffState.data;
          print('data==');
          print(data);

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(data[index].image)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(data[index].post)
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.mail, color: Color(0xff919293)),
                          onPressed: () {
                            launch('mailto:${data[index].email}');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.phone, color: Color(0xff919293)),
                          onPressed: () {
                            launch('tel:+${data[index].tel}');
                          },
                        )
                      ],
                    )
                  ],
                ),
              ));
            },
          );
        }
        ;
      }),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection("staff").snapshots(),
      //   builder: (context, snapshot) {
      //     return !snapshot.hasData
      //         ? Center(child: CircularProgressIndicator())
      //         : ListView.builder(
      //             itemCount: snapshot.data!.docs.length,
      //             itemBuilder: (context, index) {
      //               DocumentSnapshot data = snapshot.data!.docs[index];
      //               return Card(
      //                   child: Padding(
      //                 padding: EdgeInsets.all(10),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     CircleAvatar(
      //                         radius: 25,
      //                         backgroundColor: Colors.transparent,
      //                         backgroundImage: NetworkImage(data['image'])),
      //                     Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                           data['name'],
      //                           style: TextStyle(
      //                               fontWeight: FontWeight.bold, fontSize: 18),
      //                         ),
      //                         Text(data['post'])
      //                       ],
      //                     ),
      //                     Column(
      //                       children: [
      //                         Icon(
      //                           Icons.mail,
      //                           color: Color(0xff919293),
      //                         ),
      //                         Icon(Icons.phone, color: Color(0xff919293))
      //                       ],
      //                     )
      //                   ],
      //                 ),
      //               ));
      //             },
      //           );
      //   },
      // ),
    );
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
