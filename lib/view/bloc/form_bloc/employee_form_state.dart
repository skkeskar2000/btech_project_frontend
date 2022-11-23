
import 'package:major_project/bloc/employee_bloc/sideBar_bloc/side_bar_state.dart';

import '../../../model/form_entity.dart';

abstract class EmployeeFormState {}

class EmployeeFormInitialState extends EmployeeFormState {}
class AllReadyFormFilledState extends EmployeeFormState{}
class FormNotFilledState extends EmployeeFormState{}
class FailureState extends EmployeeFormState {}
class SubmitButtonState extends EmployeeFormState {}
class SuccessfulSubmittedFormState extends EmployeeFormState {
  final String message;
  SuccessfulSubmittedFormState({required this.message});

}
class ErrorSubmitFormState extends EmployeeFormState {
  final String message;
  ErrorSubmitFormState({required this.message});
}

class FillAllFieldState extends EmployeeFormState{
  final String message;
  FillAllFieldState({required this.message});
}

class GetFormDataState extends EmployeeFormState{
  final FormEntity formData;
  GetFormDataState({required this.formData});
}

class FormNotVerifiedState extends EmployeeFormState{}