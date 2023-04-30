
import 'dart:convert';

class DefaultQuestions {
  DefaultQuestions({
    required this.id,
    required this.isPublished,
    required this.que1,
    required this.que2,
    required this.que3,
    required this.que4,
    required this.que5,
    required this.que6,
    required this.que7,
    required this.que8,
    required this.que9,
    required this.que10,
  });

  String id;
  bool isPublished;
  String que1;
  String que2;
  String que3;
  String que4;
  String que5;
  String que6;
  String que7;
  String que8;
  String que9;
  String que10;

  factory DefaultQuestions.fromJson(String str) => DefaultQuestions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DefaultQuestions.fromMap(Map<String, dynamic> json) => DefaultQuestions(
    id: json["_id"],
    isPublished: json["isPublished"],
    que1: json["Que1"],
    que2: json["Que2"],
    que3: json["Que3"],
    que4: json["Que4"],
    que5: json["Que5"],
    que6: json["Que6"],
    que7: json["Que7"],
    que8: json["Que8"],
    que9: json["Que9"],
    que10: json["Que10"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "isPublished": isPublished,
    "Que1": que1,
    "Que2": que2,
    "Que3": que3,
    "Que4": que4,
    "Que5": que5,
    "Que6": que6,
    "Que7": que7,
    "Que8": que8,
    "Que9": que9,
    "Que10": que10,
  };
}
