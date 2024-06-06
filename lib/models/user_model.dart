class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  String? id;

  UserModel({this.email, this.firstName, this.lastName, this.avatar, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firt_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firt_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    data['id'] = id;
    return data;
  }
}
