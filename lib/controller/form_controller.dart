import 'package:major_project_fronted/constant/custom_toast.dart';
import 'package:major_project_fronted/model/charDataModel.dart';
import 'package:major_project_fronted/model/chekin_model.dart';
import 'package:major_project_fronted/model/default_form_mode.dart';
import 'package:major_project_fronted/services/form_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class FormController extends ChangeNotifier {
  FormServices formServices = FormServices();
  List<DefaultQuestions> formList = [];
  bool isFormListLoading = true;

  Future getDefaultFormList() async {
    isFormListLoading = true;
    formList = [];
    try {
      var response = await formServices.getDefaultForm();
      if (response != null) {
        for (var data in response) {

          formList.add(DefaultQuestions.fromMap(data));
        }
        isFormListLoading = false;
        notifyListeners();
      }
    } on Exception catch (e) {
      isFormListLoading = false;
      notifyListeners();
      // TODO
    }
  }

  List<List<String>> customFormAttributeList = [];
  bool isCustomFormListLoading = true;

  Future getCustomFormAttribute() async {
    customFormAttributeList = [];
    isCustomFormListLoading = true;
    var response = await formServices.getCustomFormAttribute();
    if (response != null) {
      customFormAttributeList = response;

      isCustomFormListLoading = false;
    } else {
      showCustomToast('Unable to get Custom Forms');
    }

    notifyListeners();
  }

  Future updateFormPublishStatus(String formId, bool status) async {
    var response = await formServices.updateFormPublish(status, formId);
    if (response != null) {
      if (response.status == true) {

        await getDefaultFormList();
        notifyListeners();
      }
    }
  }

  bool isSaveSuccess = false;
  bool isSaving = true;

  Future saveCustomForm({required Map<String, dynamic> questionMap}) async {
    isSaving = true;
    showCustomToast('Saving Form');
    var response = await formServices.saveCustomForm(m: questionMap);
    if (response != null) {
      isSaveSuccess = response.status;
    } else {
      showCustomToast('Form not saved');
      isSaveSuccess = false;
    }
    isSaving = false;
    await getCustomFormAttribute();
    notifyListeners();
  }

  late bool isFilledAlready;
  bool isLoadingSubmitForm = true;

  Future checkAlreadyFilled(
      {required String userId, required String formId}) async {
    isFilledAlready = true;
    isLoadingSubmitForm = true;
    try {
      var response =
          await formServices.chekAlreadyFilled(userId: userId, formId: formId);
      if (response != null) {
        if (response.msg == 'NotFilled') {
          isFilledAlready = false;
        } else {
          isFilledAlready = true;
        }
      }
      isLoadingSubmitForm = false;
      notifyListeners();
    } on Exception catch (e) {
      showCustomToast('Cannot get form data');
      // TODO
    }
  }

  List userFormResp = [];
  double maxVal = 0;
  List<ChartDataEntity> userTotalAnsPercentageGraph = [];
  List<ChartDataEntity> userTotalScoreGraph = [];

  Future getCustomFormResponseByUserId({required String userID}) async {
    maxVal = 0;
    userFormResp = [];
    userTotalAnsPercentageGraph = [];
    userTotalScoreGraph = [];
    userTotalAnsPercentageGraph.add(ChartDataEntity(x: '', y: 0.0));
    var response =
        await formServices.getCustomFormResponseByUserId(userID: userID);
    if (response != null) {
      userFormResp = response;
      int i = 0;
      for (var oneresp in userFormResp) {
        double totalMark = (oneresp.length - 10) * 10;
        oneresp.forEach((key, value) {
          if (key == "total") {

            if (maxVal < value) {
              maxVal = value;
            }

            userTotalScoreGraph
                .add(ChartDataEntity(x: 'Quiz No. ${++i}', y: value));
            double percentage = (value / totalMark) * 100;
            userTotalAnsPercentageGraph
                .add(ChartDataEntity(x: 'Quiz No. ${i}', y: percentage));
          }
        });
      }
    } else {
      showCustomToast('something went wrong');
    }
    userTotalScoreGraph.sort((a, b) => b.y.compareTo(a.y));
    if (userTotalScoreGraph.length < 4) {
      List<ChartDataEntity> temp = [];
      temp = List.from(userTotalScoreGraph.reversed);
      userTotalScoreGraph = temp;

    } else {
      List<ChartDataEntity> temp = [];
      for (int i = 0; i < 3; i++) {
        temp.add(userTotalScoreGraph[i]);
      }
      userTotalScoreGraph = List.from(temp.reversed);
    }
    maxVal = maxVal + 2;
    notifyListeners();
  }

  List<Map<String, dynamic>> customFormResponse = [];
  double allTopScore = 0;
  double allLeastScore = 1000;
  int pendingVerifications = 0;
  int lessPercentageCandidates = 0;
  Map<String, List<double>> customFormAns = {};
  List<ChartDataEntity> quizResponseAverageGraphList = [];

  Future getCustomFormResponse() async {
    customFormAns = {};
    quizResponseAverageGraphList = [];
    quizResponseAverageGraphList.add(ChartDataEntity(x: '', y: 0));
    lessPercentageCandidates = 0;
    pendingVerifications = 0;
    allTopScore = 0;
    allLeastScore = 1000;
    customFormResponse = [];
    var response = await formServices.getCustomFormResponse();
    if (response != null) {
      for (var oneRespo in response) {
        String tempId = '';
        double totaltempperc = 0;
        double totalMark = (oneRespo.length - 10) * 10;
        oneRespo.forEach((key, value) {
          if (key == "formId") {
            tempId = value;
          }
          if (key == "isVerified") {
            if (!value) {
              pendingVerifications = pendingVerifications + 1;
            }
          }
          if (key == "total") {
            double percentage = (value / totalMark) * 100;
            totaltempperc = percentage;
            if (percentage < 50) {
              ++lessPercentageCandidates;
            }

            if (allLeastScore > value) {
              allLeastScore = value;
            }
            if (allTopScore < value) {
              allTopScore = value;
            }
          }
        });
        if (customFormAns[tempId] == null) {
          customFormAns[tempId] = [];

        }

        customFormAns[tempId]!.add(totaltempperc);
        customFormResponse.add(oneRespo);
      }
    } else {
      showCustomToast('error');
    }
    int i=0;
    customFormAns.forEach((key, value) {
      double average = 0;

      for (double one in value) {
        average = average + one;
      }
      average = average / value.length;
      quizResponseAverageGraphList.add(ChartDataEntity(x: 'Quiz ${++i}', y: average));
    });

    notifyListeners();
  }

  Future updateCustomFormVerification(
      {required String userId,
      required String formId,
      required bool isVerified}) async {
    try {
      var response = await formServices.updateCustomFormVerificationStatus(
          userId: userId, formId: formId, isVerified: isVerified);
      if (response != null) {
        if (response.status) {
          showCustomToast('Update Success');
          await getCustomFormResponse();
        } else {
          showCustomToast('Not updated');
        }
      }
      notifyListeners();
    } on Exception catch (e) {
      showCustomToast('Not Updated');
      // TODO
    }
  }

  bool isSubmitCustomFormSuccess = false;
  bool showButton = false;
  List<CheckinModel> allTodatyChekinList = [];
  List<CheckinModel> allyesterdayChekinList = [];

  Future getAllTodayChekins(
      {required String Date, required bool isPrevious}) async {
    var response = await formServices.getAllTodayChekins(Date: Date);
    if (response != null) {
      if (isPrevious) {
        allyesterdayChekinList = [];
        allyesterdayChekinList = response;
      } else {
        allTodatyChekinList = [];
        allTodatyChekinList = response;
      }
    }
    notifyListeners();
  }

  Future chekIfTodayMarked({required Map<String, dynamic> data}) async {
    try {
      var response = await formServices.chekIfTodayMarked(data: data);
      if (response != null) {
        showButton = !response.status;
      } else {
        showButton = false;
      }
      notifyListeners();
    } on Exception catch (e) {
      // TODO
    }

  }
  List<CheckinModel> listAllChekin = [];
  Future getAllChekin()async{
    listAllChekin = [];
    var response=await formServices.getallChekin();
    if(response!=null){
      listAllChekin=response;
    }
    notifyListeners();
  }

  List<DateTime> chekinDateList = [];
  var myFormat = DateFormat('d-MM-yyyy');

  Future getdailyChekinEmployee({required String userId}) async {
    chekinDateList = [];
    var response = await formServices.getdailyChekinEmployee(userId: userId);

    if (response != null) {
      for (CheckinModel oneDay in response) {
        chekinDateList.add(myFormat.parse(oneDay.date));
      }
    }
    notifyListeners();

  }

  Future markTodayChekin({required Map<String, dynamic> attendance}) async {
    try {
      bool response =
          await formServices.markDailyChekin(attendance: attendance);
      if (response) {
        showCustomToast('Successfully marked attendance');
      } else {
        showCustomToast('Something went wrong');
      }
      await chekIfTodayMarked(data: attendance);
      await getdailyChekinEmployee(userId: attendance['empId']);
      notifyListeners();
    } on Exception catch (e) {
      showCustomToast('Something went wrong');
      // TODO
    }
  }

  Future submitCustomForm(
      {required Map<String, dynamic> queAns,
      required String formUserId,
      required String formUserName,
      required String formId}) async {
    isSubmitCustomFormSuccess = false;
    try {
      bool isSuccessSubmit = await formServices.submitCustomForm(
          formData: queAns,
          formUserId: formUserId,
          formUserName: formUserName,
          formUserRole: 'Employee',
          formId: formId);

      isSubmitCustomFormSuccess = isSuccessSubmit;
      notifyListeners();
    } on Exception catch (e) {
      showCustomToast('Form Not Submitted');
      // TODO
    }
  }
}
