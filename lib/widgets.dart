

import 'package:bloc_stream_challenge/model/user_model.dart';
import 'package:flutter/material.dart';

Widget loadingCircle() {
  return Center(
      child: CircularProgressIndicator(
      ));
}

Widget userName(String name) {
  return Text(
    'Name: $name',
    style: TextStyle(color: Colors.blue, fontSize: 20.0),
  );
}
Widget userId(int id){
  return Text('ID: ${id.toString()}');
}
Widget userStatus(bool status){
  return status ? Container(
    height: 20.0,
    width: 20.0,
    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
  ):Container(
    height: 20.0,
    width: 20.0,
    decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(10)),
  );
}

Widget userAbout(String about){
  return Text(about,style: TextStyle(color: Colors.black38),);
}

class UserCard extends StatelessWidget {
final UserModel user;
  const UserCard({Key? key,required this.user}) : assert(user !=null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(10.0)),
              userName(user.userName),
              Spacer(),
              userStatus(user.userStatus),
              Padding(padding: EdgeInsets.all(5.0)),
            ],
          ),
          Divider(),
          Row(children: [
            Padding(padding: EdgeInsets.all(10.0)),
            userId(user.userId),
            Spacer(),
            userAbout(user.userAbout),
            Padding(padding: EdgeInsets.all(5.0)),
          ]),
          Padding(padding: EdgeInsets.all(10.0)),
        ],
      ),
    );
  }
}
