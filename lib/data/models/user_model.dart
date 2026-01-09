class UserModel {
  String? name;
  String? email;
  String? uId;
  UserModel({this.email, this.name, this.uId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'], name: json['name'], uId: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'id': uId, 'name': name};
  }
}
