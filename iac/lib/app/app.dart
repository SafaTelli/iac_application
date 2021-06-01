// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iac/l10n/l10n.dart';
import 'package:iac/login/view/login.dart';
import 'package:iac/welcome/view/welcome.dart';
import 'package:iac/router.dart' as router;

import '../routing_constants.dart';
import 'package:firebase_core/firebase_core.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Something wrong");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(
              accentColor: const Color(0xFF13B9FF),
              appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
            ),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            onGenerateRoute: router.generateRoute,
            initialRoute: WelcomeViewRoute,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
