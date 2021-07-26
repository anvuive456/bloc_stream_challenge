import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {

  @HiveField(0)
  int userId;

  @HiveField(1)
  String userName;

  @HiveField(2)
  bool userStatus;

  @HiveField(3)
  String userAbout;

  UserModel({required this.userName, required this.userStatus, required this.userAbout, required this.userId});




}
