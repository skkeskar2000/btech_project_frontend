import 'package:fluttertoast/fluttertoast.dart';

showCustomToast(String msg) {
  Fluttertoast.showToast(
      fontSize: 20, msg: msg, webPosition: "Centre", timeInSecForIosWeb: 4);
}