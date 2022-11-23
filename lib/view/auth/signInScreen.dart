import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/app_route.dart';
import 'package:major_project_fronted/constant/toast.dart';
import 'package:major_project_fronted/constant/utils.dart';
import 'package:major_project_fronted/services/auth_services.dart';
import 'package:major_project_fronted/services/service_const.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          height: 300,
          child: Card(
            color: Colors.white60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Log In"),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Email',
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Password',
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      _signIn(email,password,context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: headingTextColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "LogIn",
                        // style: TextStyle(
                        //   color: Colors.white,
                        // ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn(String email,String password,BuildContext context) async{
    try{
      Tuple response = await AuthServices.signIn(email, password);
      if(response.status){
        if(response.msg == 'ceo'){
          Navigator.popAndPushNamed(context, AppConst.ceoHome);
        }
        if(response.msg == "employee"){
          Navigator.popAndPushNamed(context, AppConst.employeeHome);
        }
      }else{
        print('error');
        flutterToast("error");
      }
    }catch(error){
      flutterToast(error.toString());
    }
  }
}
