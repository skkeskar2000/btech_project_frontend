class UserModel {
  String? id;
  String? email;
  String? password;
  String? name;
  String? role;

  UserModel(
      {this.id, this.email, this.password, this.name, this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['role'] = role;
    return data;
  }
}