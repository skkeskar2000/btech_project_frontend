import 'package:major_project/bloc/employee_bloc/employee_form_bloc/employee_form_bloc.dart';

import '../../../model/form_entity.dart';

abstract class EmployeeFormEvent {}

class CheckFormFilledEvent extends EmployeeFormEvent {
  final String userId;
  final bool isDisplay;

  CheckFormFilledEvent({required this.isDisplay, required this.userId});
}

class FailureEvent extends EmployeeFormEvent {}

class SubmitButtonEvent extends EmployeeFormEvent {
  final int formOneQuestion;
  final int formTwoQuestion;
  final int formThreeQuestion;
  final int formFourQuestion;
  final int formFiveQuestion;
  final int formSixQuestion;
  final int formSevenQuestion;
  final int formEightQuestion;
  final String name;
  final String userId;
  final String role;

  SubmitButtonEvent({
    required this.formOneQuestion,
    required this.formTwoQuestion,
    required this.formThreeQuestion,
    required this.formFourQuestion,
    required this.formFiveQuestion,
    required this.formSixQuestion,
    required this.formSevenQuestion,
    required this.formEightQuestion,
    required this.name,
    required this.userId,
    required this.role,
  });
}

class GetFormEvent extends EmployeeFormEvent {
  final String userId;
  final bool isDisplay;
  GetFormEvent( {required this.isDisplay,required this.userId});
}