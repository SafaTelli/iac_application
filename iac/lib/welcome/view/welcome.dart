import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iac/data/models/PushNotification.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../routing_constants.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<WelcomePage> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  // ignore: prefer_final_fields
  late final FirebaseMessaging _messaging;
  late PushNotification _notificationInfo;
  late int _totalNotifications;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _totalNotifications = 0;
    registerNotification();
    FirebaseMessaging.instance
        .getToken()
        .then((value) => {print('token == ${value}')});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        // title: message.data['title'],
        // body: message.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });

    /* FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (injector.get<AppPreferences>().isLoggedIn()) {
        if (message != null) {
          // Utils.showErrorToast("Notification clicked when app is terminated !");
          if(message.notification != null) {
            _handleMessageNotificationRedirection(message);
          }
        }
      }
    });
*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff6A994E),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 600,
                height: MediaQuery.of(context).size.height * .65,
                child: const Image(
                  image: AssetImage('images/welcome.png'),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .35,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      const Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "INSAT ANDROID CLUB",
                          style:
                              // ignore: lines_longer_than_80_chars
                              const TextStyle(
                                  color: Color(0xffBC4749),
                                  fontSize: 25,
                                  fontFamily: 'Google-Sans'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: FlatButton(
                            textColor: Color(0xff386641),
                            onPressed: () {
                              Navigator.pushNamed(context, SignUpViewRoute);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: Color(0xff386641),
                                    width: 1,
                                    style: BorderStyle.solid)),
                            child: const Text("INSCRIPTION"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: FlatButton(
                            textColor: Colors.white,
                            color: Color(0xff386641),
                            onPressed: () {
                              Navigator.pushNamed(context, LoginViewRoute);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: Color(0xff386641),
                                    width: 1,
                                    style: BorderStyle.solid)),
                            child: const Text("CONNEXION"),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(3),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, HomeViewRoute);
                                },
                                child: Text(
                                  'Continuer',
                                  style: const TextStyle(
                                      color: Color(0xffBC4749),
                                      fontSize: 18,
                                      fontFamily: 'Google-Sans'),
                                ),
                              )),
                          const Padding(
                              padding: EdgeInsets.all(3),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Color(0xffBC4749),
                              ))
                        ],
                      ),
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }

  void registerNotification() async {
    //...
    // ignore: avoid_dynamic_calls
    //await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    //_messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('notification here: ${message.messageId}');
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
