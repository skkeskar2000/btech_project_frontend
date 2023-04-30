
import 'dart:convert';

class CheckinModel {
  CheckinModel({
    required this.id,
    required this.empId,
    required this.empName,
    required this.date,
    required this.v,
  });

  String id;
  String empId;
  String empName;
  String date;
  int v;

  factory CheckinModel.fromJson(String str) => CheckinModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckinModel.fromMap(Map<String, dynamic> json) => CheckinModel(
    id: json["_id"],
    empId: json["empId"],
    empName: json["empName"],
    date: json["date"],
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "empId": empId,
    "empName": empName,
    "date": date,
    "__v": v,
  };
}
