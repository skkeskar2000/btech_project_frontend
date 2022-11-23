import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

static Future setString(String? key, String? value) async =>
      await _preferences?.setString(key!, value!);

  static String? getString(String key) => _preferences!.getString(key) ?? "N/A";

  static Future setBoolean(String key, bool value) async =>
      await _preferences?.setBool(key, value);

  static bool getBoolean(String key) => _preferences!.getBool(key) ?? false;

  static int getInt(dynamic key) {
    return _preferences!.getInt("$key") ?? 0;
  }

  static Future setInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }

  static void clearPref() {
    _preferences!.clear();
  }

}


class Preferences {
  static const String name = "name";
  static const String userid = "userid";
  static const String role = "role";

  static hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  // static Future<bool> checkNetwork() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   } else {
  //     Fluttertoast.showToast(
  //       msg: "No Internet Connection",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //     return false;
  //   }
  // }

  static onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("PleaseWait"),
              ],
            ),
          ),
        );
      },
    );
  }
}
