import 'package:dio/dio.dart';
import 'package:major_project_fronted/api_const.dart';
import 'package:major_project_fronted/constant/toast.dart';
import 'package:major_project_fronted/model/user_model.dart';
import 'package:major_project_fronted/preferences.dart';
import 'package:major_project_fronted/services/service_const.dart';

class AuthServices {
  static Future<Tuple> signIn(String email, String password) async {
    try {
      Response response = await dio().get(
        '${Apis.baseUrl}${Apis.signIn}',
        queryParameters: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        SharedPreferenceHelper.setString(Preferences.name, response.data['name']);
        SharedPreferenceHelper.setString(Preferences.userid, response.data['_id']);
        SharedPreferenceHelper.setString(Preferences.role, response.data['role']);

        flutterToast("Successfully login");
        if (response.data['role'] == "ceo") {
          return Tuple(status: true, msg: "ceo");
        }
        else if (response.data['role'] == "employee") {
          return Tuple(status: true, msg: "employee");
        }
        else{
          return Tuple(status: true, msg: "manager");
        }
      }
      else {
        return(Tuple(status: false,msg: "Check Your email or password "));
      }
    } catch (error) {
      print(error);
      return Tuple(status: true, msg: "error");
    }
  }

  static Future<List<UserModel>>getUsers({required String userRole})async{
    try{
      Response response = await dio().get(
        '${Apis.baseUrl}${Apis.getUsers}',
        queryParameters: {'role':userRole},
      );
      if(response.data['status']){
        List<UserModel>userList = [];
        for(var i in response.data['data']){
          userList.add(UserModel.fromJson(i));
        }
        return userList;
      }else{
        flutterToast(response.data['msg']);
        return [];
      }
    } on DioError catch (error){
      rethrow;
    }
  }

  static Future<dynamic>addUser(dynamic data)async{
    try{
      dynamic response = dio().post(Apis.baseUrl+Apis.addUser,data: data);
      return response;
    } on DioError catch (error) {
      rethrow;
    }
  }
}
