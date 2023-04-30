
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/custom_toast.dart';
import 'package:major_project_fronted/model/usermodel.dart';
import 'package:major_project_fronted/services/auth_service.dart';
import 'package:major_project_fronted/views/ceo/ceo_screen.dart';
import 'package:major_project_fronted/views/employee/employeescreen.dart';
import 'package:major_project_fronted/views/manager/manager_screen.dart';

class AuthController extends ChangeNotifier {
  AuthService authService = AuthService();
  bool clickedLogin = false;
  bool isSuccess = true;
  String name = '';
  String id = '';
  String role = '';

  Future<void> LoginController(
      BuildContext context, String email, String password) async {

    clickedLogin = true;
    notifyListeners();
    isSuccess = true;
    try {
      dynamic response = await authService.login(email, password);
      if (response != null) {
        name = response.name;
        id = response.id;
        role = response.role;
        if (response.role == 'employee') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return EmployeePage();
            }),
          );
          clickedLogin = false;
          notifyListeners();
        } else if (response.role == 'ceo') {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return CEOScreen();
            }),
          );
          clickedLogin = false;
          notifyListeners();
        } else {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ManagerScreen();
            }),
          );
          clickedLogin = false;
          notifyListeners();
        }
      } else {
        clickedLogin = false;
        isSuccess = false;
        notifyListeners();
        await Future.delayed(Duration(seconds: 10));
        isSuccess = true;
        notifyListeners();

        // Fluttertoast.showToast(
        //     msg: "This is Center Short Toast",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
      }
    } on Exception catch (e) {
      print('something wenţ wrong');
      // TODO
    }
  }

  Future registerNewUser(
      {required String email,
      required String password,
      required String name,
      required String role}) async {
    bool response = await authService.registerNewUser(
        email: email, password: password, name: name, role: role);
    if (response) {
      showCustomToast('New user added');
    } else {
      showCustomToast('Something went wrong');
    }
  }

  List<UserModel> allEmployeeList = [];
List<UserModel>allManagerList=[];
bool managerLoading=true;
  Future getAllUsers({required String currentId}) async {
    managerLoading=true;
    allManagerList=[];
    allEmployeeList = [];
    var response = await authService.getAllUsers();
    for (UserModel oneuser in response) {
      if (oneuser.id != currentId && oneuser.role == 'employee') {

        allEmployeeList.add(oneuser);
      }
      if(oneuser.role=='manager'){

        allManagerList.add(oneuser);
      }
    }
    managerLoading=false;
    notifyListeners();
  }

  Future removeUser({required String userId, required String currentId}) async {
    try {
      bool response = await authService.removeUser(userId: userId);
      if (response) {
        showCustomToast('Removed user');
      } else {
        showCustomToast('Something went wrong');
      }
      await getAllUsers(currentId: currentId);
      notifyListeners();
    } on Exception catch (e) {
      showCustomToast('Unable to remove');
      // TODO
    }
  }
}
