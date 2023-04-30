import 'package:dio/dio.dart';
import 'package:major_project_fronted/constant/api_constant.dart';
import 'package:major_project_fronted/constant/custom_toast.dart';
import 'package:major_project_fronted/model/chekin_model.dart';
import 'package:major_project_fronted/model/status_model.dart';

class FormServices {
  final baseurl = Apis.baseUrl;

  Future getDefaultForm() async {
    try {
      Response response =
          await Dio().get('${Apis.baseUrl}${Apis.getDefaultForm}');
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on Exception catch (e) {
      print('error while get form default in service');
      print(e);
      return null;
      // TODO
    }
  }

  Future getCustomFormAttribute() async {
    List<List<String>> attributeList = [];
    try {
      Response response =
          await Dio().get('${Apis.baseUrl}${Apis.getCustomAttribute}');
      var data = response.data;

      for (var oneform in data) {
        List<String> oneFormTempList = [];
        oneform.forEach((key, value) => oneFormTempList.add(value.toString()));

        attributeList.add(oneFormTempList);
      }

      return attributeList;
    } catch (error) {
      rethrow;
    }
  }

  Future updateFormPublish(bool status, String formId) async {
    try {
      Response response = await Dio().put('$baseurl${Apis.updateStatus}',
          queryParameters: {"_id": formId, "isPublished": status});
      if (response.statusCode == 200) {

        return StatusModel.fromMap(response.data);
      }
      return null;
    } on Exception catch (e) {
      print('error while updatae in service');
      print(e);
      // TODO
    }
  }

  Future saveCustomForm({required Map<String, dynamic> m}) async {
    try {
      Response response =
          await Dio().post('${Apis.baseUrl}${Apis.createForm}', data: m);
      if (response.statusCode == 200) {

        return StatusModel.fromMap(response.data);
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      showCustomToast('Network Error');
      return null;
    }
  }

  List<CheckinModel> listTodayChekin = [];

  Future getAllTodayChekins({required String Date}) async {
    listTodayChekin = [];
    Response response = await Dio().get('$baseurl${Apis.getAllTodayChekins}',
        queryParameters: {"date": Date});
    if (response.statusCode == 200) {
      for (var data in response.data) {
        listTodayChekin.add(CheckinModel.fromMap(data));
      }
      return listTodayChekin;
    } else {
      return null;
    }
  }

  List<CheckinModel> listAllChekin = [];
  Future getallChekin()async{
    listAllChekin = [];
    try {
      Response response=await Dio().get('$baseurl${Apis.getAllChekins}');
      if(response.statusCode==200){
        for(var onedata in response.data){
          listAllChekin.add(CheckinModel.fromMap(onedata));
        }
        return listAllChekin;
      }else{
        return null;
      }
    } on Exception catch (e) {
      return null;
      // TODO
    }
  }
  List<CheckinModel> listChekin = [];

  Future getdailyChekinEmployee({required String userId}) async {
    listChekin = [];
    try {
      Response response = await Dio().get('$baseurl${Apis.getEmployeeChekin}',
          queryParameters: {"empId": userId});
      if (response.statusCode == 200) {
        for (var data in response.data) {
          listChekin.add(CheckinModel.fromMap(data));
        }
        return listChekin;
      } else {
        return null;
      }
    } on Exception catch (e) {
      showCustomToast('Something Went Wrong');
      return null;

      // TODO
    }
  }

  Future chekAlreadyFilled(
      {required String userId, required String formId}) async {
    try {
      Response response = await Dio().get('${baseurl}${Apis.checkIfFilled}',
          queryParameters: {"userId": userId, "formId": formId});
      if (response.statusCode == 200) {
        return StatusModel.fromMap(response.data);
      }
    } on Exception catch (e) {
      showCustomToast('Cannot get form data');
      return null;
      // TODO
    }
  }

  Future updateCustomFormVerificationStatus(
      {required String userId,
      required String formId,
      required bool isVerified}) async {
    try {
      Response response = await Dio().put(
          '${baseurl}${Apis.updateCustomFormVerification}',
          queryParameters: ({
            "userId": userId,
            "formId": formId,
            "isVerified": isVerified
          }));
      if (response.statusCode == 200) {
        return StatusModel.fromMap(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);
      showCustomToast('Network Error');
      return null;
      // TODO
    }
  }

  Future getCustomFormResponseByUserId({required String userID}) async {
    try {
      Response response = await Dio().get(
          '${baseurl}${Apis.getCustomFormResponseByUserId}',
          queryParameters: {"userID": userID});
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      return null;
      // TODO
    }
  }

  Future getCustomFormResponse() async {
    try {
      Response response =
          await Dio().get('${baseurl}${Apis.getCustomFormResponse}');
      if (response.statusCode == 200) {

        return response.data;
      } else {
        showCustomToast('Server Error');
      }
    } on Exception catch (e) {
      showCustomToast('Server Error');
      return null;
      // TODO
    }
  }

  Future chekIfTodayMarked({required Map<String, dynamic> data}) async {
    try {
      Response response = await Dio()
          .get('${baseurl}${Apis.chekTodayMarked}', queryParameters: data);
      if (response.statusCode == 200) {
        return StatusModel.fromMap(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      showCustomToast('something went wrong');
      return null;
      // TODO
    }
  }

  Future markDailyChekin({required Map<String, dynamic> attendance}) async {
    try {
      Response response =
          await Dio().post('$baseurl${Apis.markTodayChekin}', data: attendance);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      return false;
      // TODO
    }
  }

  Future<bool> submitCustomForm(
      {required Map<String, dynamic> formData,
      required String formUserId,
      required String formUserName,
      required String formUserRole,
      required String formId}) async {
    try {
      int total = 0;
      formData.forEach((key, value) {
        total += int.parse(value.toString());
      });
      formData['total'] = total;
      formData['userId'] = formUserId;
      formData['role'] = formUserRole;
      formData['userName'] = formUserName;
      formData['formId'] = formId;
      formData['isVerified'] = false;
      formData['createdAt'] = DateTime.now().toString();
      formData['updatedAt'] = DateTime.now().toString();

      Response response = await Dio().post(
        '${Apis.baseUrl}${Apis.submitForm}',
        data: formData,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      showCustomToast('Network Error Form Not submitted');
      return false;
    }
  }
}
