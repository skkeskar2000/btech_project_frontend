import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:major_project_fronted/view/auth/signInScreen.dart';
import 'package:major_project_fronted/view/auth/welcomScreen.dart';
import 'package:major_project_fronted/view/ceo/ceo_home.dart';
import 'package:major_project_fronted/view/employee/employee_home.dart';

class AppConst {
  static const String welcomeScreen = "welcomeScreen";
  static const String signInScreen = "signInScreen";
  static const String ceoHome = "ceoHome";
  static const String employeeHome = "employeeHome";
  static const String managerHome = "mangerHome";
}

class AppRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppConst.welcomeScreen:
        {
          return CupertinoPageRoute(
              builder: (context) => const WelcomeScreen());
        }
      case AppConst.signInScreen:
        {
          return CupertinoPageRoute(builder: (context) => const SignInScreen());
        }
      case AppConst.ceoHome:
        return CupertinoPageRoute(builder: (context)=>const CeoHome());

      case AppConst.employeeHome:
        return FluentPageRoute(builder: (context)=> const EmployeeHome());
      default:
        return CupertinoPageRoute(builder: (context) => ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("error"),
      ),
      body: Center(
        child: Text("error"),
      ),
    );
  }
}
