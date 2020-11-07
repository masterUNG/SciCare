import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scicare/models/post_model.dart';
import 'package:scicare/models/user_model.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/dialog.dart';
import 'package:scicare/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessegeStd extends StatefulWidget {
  MessegeStd({Key key}) : super(key: key);

  @override
  _MessegeStdState createState() => _MessegeStdState();
}

class _MessegeStdState extends State<MessegeStd> {
  String userLogined, userLoginHind, postString, urlImegeUser, urlImageAdmin;
  List<PostModel> postModels = List();
  bool showStatus = true;
  String idLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> readAllPost() async {
    if (postModels.length != 0) {
      postModels.clear();
    }

    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('PostPsu')
          .doc(userLogined)
          .collection('PostMessage')
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          PostModel model = PostModel.fromJson(snapshot.data());
          setState(() {
            postModels.add(model);
          });
        }
      });
    });
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userLogined = preferences.getString('Username');
    idLogin = preferences.getString('id');
    userLoginHind = userLogined.substring(0, userLogined.length - 3);
    userLoginHind = '${userLoginHind}xxx';
    print('userLoginHind ==>> $userLoginHind');
    readAllPost();

    String id = preferences.getString('id');
    String path =
        '${MyConstant().domain}/scicare/getProfileWhereId.php?isAdd=true&id=$id';
    await Dio().get(path).then((value) {
      print(' ############## value ===>> $value ############');
      if (value.toString() != 'null') {
        for (var json in json.decode(value.data)) {
          UserModel3 model3 = UserModel3.fromJson(json);
          setState(() {
            urlImegeUser = '${MyConstant().domain}${model3.urlProfile}';
            print('urlImageUser ==> $urlImegeUser');
          });
        }
      } else {}
    });

    String urlAPiAdmin =
        '${MyConstant().domain}/scicare/getProfileWhereId.php?isAdd=true&id=1';

    await Dio().get(urlAPiAdmin).then((value) {
      for (var json in json.decode(value.data)) {
        UserModel3 model = UserModel3.fromJson(json);
        setState(() {
          urlImageAdmin = model.urlProfile;
          print('########### urlImageAdmin ===>> $urlImageAdmin');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Stack(
        children: [
          buildListMessage(),
          buildPost(),
        ],
      ),
    );
  }

  Widget buildListMessage() => postModels.length == 0
      ? Center(child: Text('No Message'))
      : ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: postModels.length,
          itemBuilder: (context, index) => Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(postModels[index].message),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            postModels[index].dateTimeMessage,
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          postModels[index].answerAdmin == null
                              ? SizedBox()
                              : Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      child: urlImageAdmin == null
                                          ? SizedBox()
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  '${MyConstant().domain}$urlImageAdmin'),
                                            ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(postModels[index].answerAdmin),
                                  ],
                                ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  child: urlImegeUser == null
                      ? SizedBox()
                      : CircleAvatar(
                          backgroundImage: NetworkImage(urlImegeUser),
                        ),
                )
              ],
            ),
          ),
        );

  Future<Null> postProcess() async {
    await Firebase.initializeApp().then((value) async {
      DateTime dateTime = DateTime.now();
      String dateTimeString = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
      // print('Initial Firebase Success dateTime ==>> $dateTimeString');

      Map<String, dynamic> map = Map();
      map['Message'] = postString;
      map['DateTimeMessage'] = dateTimeString;

      Map<String, dynamic> map2 = Map();
      map2['id'] = idLogin;

      await FirebaseFirestore.instance
          .collection('PostPsu')
          .doc(userLogined)
          .set(map2)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('PostPsu')
            .doc(userLogined)
            .collection('PostMessage')
            .add(map)
            .then((value) {
          print('Post Success');
          readAllPost();
        });
      });
    });
  }

  Widget buildPost() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: Mystyle().bluecolor,
          margin: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white),
                width: 250,
                height: 40,
                child: TextField(
                  onChanged: (value) => postString = value.trim(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 14)),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  if (postString == null || postString.isEmpty) {
                    normalDialog(context, 'Post ห้ามว่างเปล่า คะ');
                  } else {
                    postProcess();
                  }
                },
                child: Text('Post'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
