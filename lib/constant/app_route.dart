import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:major_project_fronted/view/auth/signInScreen.dart';
import 'package:major_project_fronted/view/auth/welcomScreen.dart';
import 'package:major_project_fronted/view/ceo/ceo_home.dart';
import 'package:major_project_fronted/view/employee/employee_home.dart';
import 'package:major_project_fronted/view/manager/manager.dart';

class AppConst {
  static const String welcomeScreen = "/";
  static const String signInScreen = "/signIn";
  static const String ceoHome = "/ceo";
  static const String employeeHome = "/employee";
  static const String managerHome = "/manger";
}

class AppRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppConst.welcomeScreen:
        {
          return FluentPageRoute(builder: (context) => const WelcomeScreen());
        }
      case AppConst.signInScreen:
        {
          return FluentPageRoute(builder: (context) => const SignInScreen());
        }
      case AppConst.ceoHome:
        return FluentPageRoute(builder: (context) => const CeoHome());

      case AppConst.employeeHome:
        return FluentPageRoute(builder: (context) => const EmployeeHome());

      case AppConst.managerHome:
        return FluentPageRoute(builder: (context) => const ManagerHome());
      default:
        return CupertinoPageRoute(builder: (context) => ErrorPage());
    }
  }
}

final GoRouter router = GoRouter(
    // urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: AppConst.welcomeScreen,
        builder: (context, state) => WelcomeScreen(),
      ),
      GoRoute(
          path: AppConst.signInScreen,
          builder: (context, state) => const SignInScreen(),),
      GoRoute(path: '/login', builder: (context, state) => SignInScreen()),
    ]);

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
