import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0, adapterName: 'UserAdapter')
class UserModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final String token;

  UserModel({this.name = "", this.userName = "", this.token = ""});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(userName: json['username'], token: json['token']);
}
