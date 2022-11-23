import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_project_fronted/api_const.dart';
import 'package:major_project_fronted/services/service_const.dart';
import 'package:major_project_fronted/view/bloc/form_bloc/employee_form_event.dart';
import 'package:major_project_fronted/view/bloc/form_bloc/employee_form_state.dart';

class EmployeeFormBloc extends Bloc<EmployeeFormEvent, EmployeeFormState> {
  EmployeeFormBloc() : super(EmployeeFormInitialState()) {
    on<CheckFormFilledEvent>((event, emit) async {
      try {
        var url =
            Uri.parse('?userId=${event.userId}&isDisplay=${event.isDisplay}');

        Response response =
            await dio().get('${Apis.baseUrl}${Apis.getForm}', queryParameters: {
          'userId': event.userId,
          'isDisplay': event.isDisplay,
        });
        var data = response.data;
        print(response.statusCode);
        print(data);
        if (response.statusCode == 400) {
          if (data['message'] == 'Form is Filled') {
            emit(AllReadyFormFilledState());
          } else {
            emit(FormNotFilledState());
          }
        } else if (response.statusCode == 200) {
          if (event is CheckFormFilledEvent) {
            emit(AllReadyFormFilledState());
          }
        } else {
          emit(FailureState());
        }
      } catch (error) {
        emit(FailureState());
        print(error);
      }
    });
    on<FailureEvent>((event, emit) => emit(FailureState()));
    // on<SubmitButtonEvent>((event, emit) async {
    //   await saveForm(event,emit);
    // });
    // on<GetFormEvent>((event, emit)async{
    //   await getForm(event, emit);
    // });
  }
}
