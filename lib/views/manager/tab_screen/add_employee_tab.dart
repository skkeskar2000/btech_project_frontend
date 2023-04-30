import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/auth_controller.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmployeeTab extends StatefulWidget {
  const AddEmployeeTab({Key? key}) : super(key: key);

  @override
  State<AddEmployeeTab> createState() => _AddEmployeeTabState();
}

class _AddEmployeeTabState extends State<AddEmployeeTab> {
  String name = '';
  String email = '';
  String role = '';
  String password = '';
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/brown_bg.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(15)),
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Add Employee',
                        style: kHeadingTextStyle.copyWith(color: Colors.white),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 60),
                        height: 480,
                        margin:
                            EdgeInsets.only(left: 300, right: 300, top: 150),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1,color: Colors.black38)
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                name = value;
                              },
                              controller: controller1,
                              decoration: CustomInputDecoration(
                                  label: 'User Name',
                                  hint: 'Enter user name ',
                                  icon: Icon(Icons.person)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: controller2,
                              onChanged: (val) {
                                email = val;
                              },
                              decoration: CustomInputDecoration(
                                  label: 'Email',
                                  hint: 'Enter email ',
                                  icon: Icon(Icons.email_outlined)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: controller3,
                              onChanged: (val) {
                                password = val;
                              },
                              obscureText: true,
                              decoration: CustomInputDecoration(
                                  label: 'Password',
                                  hint: 'Enter Password ',
                                  icon: Icon(Icons.password)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: controller4,
                              onChanged: (val) {
                                role = val;
                              },
                              decoration: CustomInputDecoration(
                                  label: 'Role ',
                                  hint: 'Enter role of user ',
                                  icon: Icon(Icons.wallet_travel)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                provider.registerNewUser(
                                    email: email,
                                    password: password,
                                    name: name,
                                    role: role);
                                controller1.clear();
                                controller2.clear();
                                controller3.clear();
                                controller4.clear();
                              },
                              child: IconTextButton(
                                  icon: Icon(Icons.done,color: Colors.white,),
                                  title: 'Add Employee',
                                  isSelected: true),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
