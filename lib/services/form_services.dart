import 'package:dio/dio.dart';
import 'package:major_project_fronted/api_const.dart';
import 'package:major_project_fronted/constant/toast.dart';
import 'package:major_project_fronted/preferences.dart';
import 'package:major_project_fronted/services/service_const.dart';

class FormServices {
  static Future<bool> saveCustomForm({required Map<String, dynamic> m}) async {
    try {
      Response response =
          await dio().post('${Apis.baseUrl}${Apis.createForm}', data: m);
      if (response.statusCode == 200 && response.data['msg'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getFormAttribute() async {
    List<Map<String, dynamic>> attributeList = [];
    try {
      Response response =
          await dio().get('${Apis.baseUrl}${Apis.getCustomAttribute}');
      var data = response.data as List;
      data[0].forEach(
        (key, value) => attributeList.add({key: value}),
      );
      // print(attributeList);
      return attributeList;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> saveForm({
    required Map<String, dynamic> formData,
    String? formUserId,
    String? formUserName,
    String? formUserRole,
  }) async {
    try {
      String? userId =
          formUserId ?? SharedPreferenceHelper.getString(Preferences.userid);
      String? name =
          formUserName ?? SharedPreferenceHelper.getString(Preferences.name);
      String? role =
          formUserRole ?? SharedPreferenceHelper.getString(Preferences.role);

      int total = 0;
      formData.forEach((key, value) {
        total += int.parse(value);
      });
      formData['total'] = total.toString();
      formData['userId'] = userId;
      formData['role'] = role;
      formData['userName'] = name;
      formData['isVerified'] = false;
      formData['createdAt'] = DateTime.now().toString();
      formData['updatedAt'] = DateTime.now().toString();

      Response response = await dio().post(
        '${Apis.baseUrl}${Apis.saveForm}',
        data: formData,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  static Future<Tuple> checkFormFilled() async {
    try {
      String? userId = SharedPreferenceHelper.getString(Preferences.userid);
      Response response = await dio().get(
        '${Apis.baseUrl}${Apis.getForm}',
        queryParameters: {'userId': userId, 'isDisplay': false},
      );
      if (response.statusCode == 200) {
        return Tuple(
          status: response.data['status'],
          msg: response.data['msg'],
        );
      } else {
        return Tuple(status: false, msg: "Something went wrong");
      }
    } catch (error) {
      return Tuple(status: false, msg: error.toString());
    }
  }

  static Future<Map<String, dynamic>> getForm({required String userId}) async {
    try {
      Response response = await dio().get(
        '${Apis.baseUrl}${Apis.getForm}',
        queryParameters: {'userId': userId, 'isDisplay': true},
      );
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getAllForm({required String role}) async {
    try {
      Response response = await dio().get('${Apis.baseUrl}${Apis.getAllForm}',
          queryParameters: {'role': role});
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> updateForm(
      {required String formId, required bool isVerified}) async {
    try {
      Response response = await dio()
          .put('${Apis.baseUrl}${Apis.verifyForm}', queryParameters: {
        "formId": formId,
        "isVerified": isVerified,
      });
      flutterToast(response.data['msg']);
      return response.data['status'];
    } catch (error) {
      flutterToast(error.toString());
      return false;
    }
  }

  static Future<bool> deleteForm({required String formId}) async {
    try {
      Response response = await dio()
          .delete('${Apis.baseUrl}${Apis.deleteForm}', queryParameters: {
        "formId": formId,
      });
      return response.data['status'];
    } on DioError catch (error) {
      print(error);
      flutterToast(error.toString());
      return false;
    }
  }
}
