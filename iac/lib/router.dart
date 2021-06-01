import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iac/about/view/about.dart';
import 'package:iac/calendar/view/calendar.dart';
import 'package:iac/data/repository/staff_repository.dart';
import 'package:iac/login/cubit/cubit/login_cubit.dart';
import 'package:iac/login/view/login.dart';
import 'package:iac/routing_constants.dart';
import 'package:iac/singup/cubit/cubit/signup_cubit.dart';
import 'package:iac/singup/view/signup.dart';
import 'package:iac/staff/cubit/cubit/staff_cubit.dart';
import 'package:iac/staff/view/staff.dart';
import 'package:iac/welcome/view/welcome.dart';

import 'data/repository/staff_rep_ext.dart';
import 'home/view/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case WelcomeViewRoute:
      return MaterialPageRoute(builder: (context) => WelcomePage());
    case LoginViewRoute:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (BuildContext context) => LoginCubit(),
                child: LoginPage(),
              ));
    case SignUpViewRoute:
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (BuildContext context) => SignupCubit(),
                child: SignUpPage(),
              ));
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case AboutViewRoute:
      return MaterialPageRoute(builder: (context) => AboutPage());
    case CalendarViewRoute:
      return MaterialPageRoute(builder: (context) => CalendarPage());
    case StaffViewRoute:
      var repository = StaffRepositoryFireStore();
      return MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (BuildContext context) => StaffCubit(
                  repository: repository,
                ),
                child: StaffPage(),
              ));
    default:
      return MaterialPageRoute(builder: (context) => WelcomePage());
  }
}
