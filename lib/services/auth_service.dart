import 'package:dio/dio.dart';
import 'package:major_project_fronted/constant/api_constant.dart';
import 'package:major_project_fronted/constant/custom_toast.dart';
import 'package:major_project_fronted/model/usermodel.dart';
import 'package:major_project_fronted/prefrences.dart';

class AuthService {
  final baseurl = Apis.baseUrl;

  Future login(String email, String password) async {
    try {
      Response response = await Dio().get('$baseurl${Apis.signIn}',
          queryParameters: {'email': email, 'password': password});
      if (response.statusCode == 200) {

        SharedPreferenceHelper.setString(
            Preferences.name, response.data['name']);
        SharedPreferenceHelper.setString(
            Preferences.userid, response.data['_id']);
        SharedPreferenceHelper.setString(
            Preferences.role, response.data['role']);
        return UserModel.fromJson(response.data);
      }
      return null;
    } on Exception catch (e) {
      return null;

      // TODO
    }
  }

  Future registerNewUser(
      {required String email,
      required String password,
      required String name,
      required String role}) async {
    try {
      Response response = await Dio().post('$baseurl${Apis.addUser}', data: {
        "email": email,
        "password": password,
        "name": name,
        "role": role
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      showCustomToast('Something went wrong');
      return false;
      // TODO
    }
  }

  List<UserModel> userList = [];

  Future getAllUsers() async {
    userList = [];
    try {
      Response response = await Dio().get('${baseurl}${Apis.getAllUser}');
      if (response.statusCode == 200) {
        for (var user in response.data) {
          userList.add(UserModel.fromJson(user));
        }
        return userList;
      } else {
        return null;
      }
    } on Exception catch (e) {
      showCustomToast('Something went wrong in service');
      return null;
      // TODO
    }
  }

  Future removeUser({required String userId}) async {
    try {
      Response response = await Dio().delete('$baseurl${Apis.removeUser}',
          queryParameters: {'userId': userId});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      // TODO
      showCustomToast('Network error');
      return false;
    }
  }
}
