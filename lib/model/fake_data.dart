import 'dart:math';

import 'package:bloc_stream_challenge/model/user_model.dart';
import 'package:faker/faker.dart';
import 'package:hive_flutter/hive_flutter.dart';

late List<UserModel> userList = [];

Future<void> generateData() async {
  var userBox = await Hive.box<UserModel>('user');
  if (userBox.length < 100)
    for (int i = 0; i < 100; i++) {
      userBox.put(
          i,
          UserModel(
              userId: Random.secure().nextInt(100) + 1,
              userAbout: Faker().lorem.word(),
              userStatus: Random.secure().nextBool(),
              userName: Faker().person.name()));
    }
}
Future<void> clearData() async {
  var userBox = await Hive.box<UserModel>('user');
  userBox.clear();
}
UserModel nullUserModel() => UserModel(
    userName: 'null', userStatus: false, userAbout: 'null', userId: -1);
