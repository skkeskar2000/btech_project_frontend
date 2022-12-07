import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/toast.dart';
import 'package:major_project_fronted/constant/utils.dart';
import 'package:major_project_fronted/services/auth_services.dart';

class AddUserWidget extends StatefulWidget {
  const AddUserWidget({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    name.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          constraints: BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            children: [
              customFilled(
                  heading: 'Enter Your Name',
                  text: name,
              ),
              customFilled(
                  heading: 'Enter Your Email',
                  text: email),
              customFilled(
                  heading: 'Enter Your Password',
                  text: password),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (email.text.isEmpty || name.text.isEmpty ||
                      password.text.isEmpty) {
                    flutterToast('Fill All the fields');
                  } else {
                    showLoading(context);
                    var data = {
                      "email": email.text,
                      "password": password.text,
                      "name": name.text,
                      "role": widget.type
                    };
                    try {
                      var response = await AuthServices.addUser(data);
                      flutterToast(response.data['message']);
                    } catch (error) {
                      flutterToast(error.toString());
                    }
                    name.clear();
                    password.clear();
                    email.clear();
                    hideLoading(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Add User'),
                ),
              ),
            ],
          ),
        ));
  }

  Container customFilled(
      {required String heading, required TextEditingController text}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Type here..',
              border: OutlineInputBorder(),
            ),
            controller: text,
          ),
        ],
      ),
    );
  }
}
