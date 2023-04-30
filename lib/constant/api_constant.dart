
class Apis{
  // static String baseUrl = 'http://localhost:5000/';
  static String baseUrl = 'https://btech-project-server.onrender.com/';


  static String signIn = 'auth/login';
  static String addUser = 'auth/register';

  static String getCustomAttribute = 'admin/getcustomform';
  static String createForm = 'admin/createform';
  static String getForm = 'form/getform';
  static String submitForm = 'form/submitform';
  static String getUsers = 'auth/selecteduser';
  static String getAllForm = 'form/getallform';
  static String verifyForm = 'form/varifyform';
  static String deleteForm = 'form/deleteForm';
  static String getDefaultForm='defaultform/getdefaultform';
  static String updateStatus='defaultform/publishStatus';
  static String checkIfFilled='form/checkalreadyfilled';
 static String getCustomFormResponse='form/getCustomFormResponses';
 static String updateCustomFormVerification='form/varifyform';
 static String markTodayChekin='dailychekin/markChekin';
 static String chekTodayMarked='dailychekin/chekIfTodayMarked';
 static String getEmployeeChekin='dailychekin/dailyChekinEmployee';
 static String getCustomFormResponseByUserId='form/getCustomFormResponseByUserId';
 static String getAllUser='auth/getAllUsers';
 static String removeUser="auth/removeUser";
 static String getAllTodayChekins='dailychekin/getAllTodayChekins';
 static String getAllChekins='dailychekin/allChekins';
}