
import 'dart:convert';

class StatusModel {
  StatusModel({
    required this.status,
    required this.msg,
  });

  bool status;
  String msg;

  factory StatusModel.fromJson(String str) => StatusModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusModel.fromMap(Map<String, dynamic> json) => StatusModel(
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "msg": msg,
  };
}
