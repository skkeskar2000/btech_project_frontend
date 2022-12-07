import 'package:flutter/material.dart';

Color headingTextColor = const Color(0xFFEA580C);
Color textWhiteColour = Colors.white;


hideLoading(BuildContext context) {
  Navigator.pop(context);
}

showLoading(BuildContext context) {
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
