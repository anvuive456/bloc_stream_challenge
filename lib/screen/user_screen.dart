

import 'package:bloc_stream_challenge/model/user_model.dart';
import 'package:bloc_stream_challenge/model/user_stream.dart';
import 'package:flutter/material.dart';
import 'package:bloc_stream_challenge/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final scrollController = ScrollController();
  late UsersStream usersStream;

  @override
  void initState() {
    usersStream = UsersStream();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        usersStream.loadMore();
      }
    });

    super.initState();
  }

  @override
  void dispose() {

    Hive.box('usermodel').close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<List<UserModel>>(
          stream: usersStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               List<UserModel>? users=snapshot.data;
              return RefreshIndicator(
                onRefresh: usersStream.refresh,
                child: ListView.builder(
                controller: scrollController,
                itemCount: users!.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < users.length) {
                    return UserCard(user: users[index]);
                  } else if (usersStream.hasMore) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.0),
                      child: Center(child: Text('nothing more to load!')),
                    );
                  }
                }),
              );
            } else
              return loadingCircle();
          },
        ),
      ),
    );
  }
}
