import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:major_project_fronted/model/user_model.dart';
import 'package:major_project_fronted/services/user_list_widget';
import 'package:major_project_fronted/view/ceo/view_dashboard.dart';
import 'package:major_project_fronted/view/employee/sidenav/dashboard.dart';
import 'package:major_project_fronted/view/widget/UserCardWidget.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({Key? key, required this.user}) : super(key: key);
  final String user;

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  late Future<List<UserModel>> getEmployee;
  List<UserModel> _userList = [];

  @override
  void initState() {
    getEmployee = AuthServices.getUsers(userRole: widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      initialData: _userList,
        future: getEmployee,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              _userList = snapshot.data!;
              return GridView.builder(
                itemCount: _userList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 5 / 6,
                ),
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        FluentPageRoute(
                          builder: (context) =>
                              ViewDashboard(userId: _userList[index].id!,),
                        ),
                      );
                    },
                    child: UserCardWidget(
                      employeeName: _userList[index].name!,
                    ),
                  );
                },
              );
            } else {
              return const Text('Something went wrong');
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
