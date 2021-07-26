import 'dart:io';

import 'package:bloc_stream_challenge/model/user_model.dart';
import 'package:bloc_stream_challenge/screen/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  await Hive.initFlutter(appDocPath);
  Hive.registerAdapter(UserModelAdapter());


  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserScreen(),
    );
  }

}
