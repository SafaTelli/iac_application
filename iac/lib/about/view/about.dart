import 'package:flutter/material.dart';
import 'package:iac/widgets/drawer.dart';

class AboutPage extends StatelessWidget {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Image.asset('images/logo.png'),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'INSAT ANDROID CLUB est le club dédié à la technologie Android au sein de l’INSAT Institut National des Sciences Appliquées et de Technologies .',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                          'CLUB fondé le 1er septembre 2011 par M Belhassine Amine et M Bassem Kassis, premier club à vocation Android en Tunisie, il se place aujourd’hui comme club leader de la technologie Android en Tunisie.',
                          style: TextStyle(fontSize: 15))),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                          'Notre club vise à démocratiser la technologie Android dans notre Pays, et ce à travers ses différentes actions dirigées principalement vers les développeurs d\'applications et de systèmes.',
                          style: TextStyle(fontSize: 15))),
                ],
              ),
            ),
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
          ),
        ],
      ),
    );
  }
}
