import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/app_route.dart';
import 'package:major_project_fronted/constant/utils.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Employee Analysis",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: _body(context),
    );
  }

  Center _body(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 700,
        height: 250,
        child: Card(
          color: Colors.white60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Welcome to EmployeeAnalysis!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const Text(
                "This is the voice chat application. You can create Open, Public or Private rooms for voice cummunication on any topic. It's usefull for students, teachers, bussiness for communication in group.",
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppConst.signInScreen);
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: headingTextColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'Next -> ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
