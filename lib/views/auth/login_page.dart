import 'dart:ui';

import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/auth_controller.dart';
import 'package:major_project_fronted/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService auth = AuthService();
  String name = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, provider, child) {
        return Scaffold(
            body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/company_bg_login.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: Container(
                    decoration: new BoxDecoration(
                        // color: Colors.grey.shade200.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/images/logo-white.png'),
                        fit: BoxFit.cover,
                        height: 180,
                        width: 250,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 250),
                child: LoginWidgit(provider),
              ),
            )
          ],
        ));
      },
    );
  }

  Column LoginWidgit(AuthController authController) {
    return Column(
      // column contain vertical alligned widgets
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        // give spacing
        Text(
          "Welcome $name",
          style: kHeadingTextStyle,
        ),

        /*   ----------------------------------------------------------------------------------------
                    *    1.Text field for user input of username
                    *    2.Validated using validator
                    *    3.Decorated using Inputdecorator
                    *    4.Caprured value of username and using set state it is displayed on welcome message
                    *    -----------------------------------------------------------------------------------------
                    * */
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextFormField(
            style: kContentStyle,

            // input area
            decoration: CustomInputDecoration(
                label: 'UserName',
                hint: 'Enter Username',
                icon: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.blue,
                )),

            onChanged: (value) {
              //capture entered value
              setState(() {
                name = value;
              });
            },
          ),
        ),

        /*  ------------------------------------------------------------------------------------------
                    *   1.Text field for password
                    *   2.Validated using validator
                    *   3.Validated for password length to be 6
                    *   4.obscured text
                    *   -----------------------------------------------------------------------------------------
                    * */
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: TextFormField(
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
            style: kContentStyle,
            decoration: CustomInputDecoration(
                label: 'Password',
                hint: 'Enter Password',
                icon: Icon(
                  CupertinoIcons.lock_circle,
                  color: Colors.blue,
                )),
          ),
        ),

        //Give space
        const SizedBox(height: 15),

        /*
                    *   1.Inkwell button inside it animated container
                    *   2.onTap method to capture tap of button
                    *   3.decoration using boxdecoration
                    *
                    *
                    * */
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            elevation: 15,
            child: InkWell(
              onTap: () {
                authController.LoginController(context, name, password);
              },
              child: AnimatedContainer(
                //to use splash color use ink inster of animeted comtainer

                duration: Duration(seconds: 1),

                alignment: Alignment.center,
                width: double.maxFinite,
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    gradient: LinearGradient(colors: [
                      Color(0xff303649),
                      Colors.blueGrey.shade700,
                      Colors.blueGrey.shade600
                    ]),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Login",
                  style: kContentStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        authController.clickedLogin
            ? SizedBox(
                height: 15,
                width: 15,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(),
        authController.isSuccess
            ? Container()
            : Container(
                child: Text(
                  'UserName Or Password is Incorrect!',
                  style: kContentStyle.copyWith(color: Colors.red),
                ),
              )
      ],
    );
  }


}
