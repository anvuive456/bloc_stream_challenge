import 'dart:async';
import 'dart:math';

import 'package:bloc_stream_challenge/model/user_model.dart';
import 'package:faker/faker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'fake_data.dart';

Future<List<UserModel>> _getUsers(int length) async {
  await Hive.openBox<UserModel>('user');
  var userBox = await Hive.box<UserModel>('user');
  await generateData();
  List<int> keys= userBox.keys.cast<int>().toList();
  return Future.delayed(Duration(seconds: 1), () {
    return List<UserModel>.generate(length, (int index) {
      UserModel um = nullUserModel();
      print(userBox.length);
      print(userBox.get(index)!.userName.toString());
      print(userBox.keyAt(index));
       keys.forEach((element) {
         if(element==index) {
           um= userBox.get(index)!;
         }
       });
     return um;
    });
  });
}

class UsersStream {
  int length=0;
  late Stream<List<UserModel>> stream;
  late bool hasMore;
  late bool _isLoading;
  List<UserModel>? _data;
  StreamController<List<UserModel>>? _controller;

  UsersStream() {
    _data = [];
    _controller = StreamController<List<UserModel>>.broadcast();
    _isLoading = false;
    stream = _controller!.stream;
    hasMore = true;
    refresh();
  }

  Future<void> refresh() {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false}) async {
    if (clearCachedData) {

      length=0;
      _data = [];
      hasMore = true;
    }
    if (_isLoading || !hasMore) {
      return Future.value();
    }

    length=length+10;
    return _getUsers(length).then((postsData) {
      _isLoading = false;
      _data!.addAll(postsData);
      hasMore = (_data!.length < 100);
      _controller!.add(_data!);
    });
  }
}
