import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scicare/student_page/post/editPost.dart';
import 'package:scicare/widgets/widgets.dart';

class PostStd extends StatefulWidget {
  PostStd({Key key}) : super(key: key);

  @override
  _PostStdState createState() => _PostStdState();
}

class _PostStdState extends State<PostStd> {
  File file;

  @override
  void initState() {
    super.initState();
    readAllPost();
  }

  Future<Null> readAllPost() async {
    await Firebase.initializeApp().then((value)async {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: postButton(),
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                buildText(),
              ],
            ),
          ),
        ));
  }

  Text buildText() => Text('Post Page123');

  Row postButton() =>
      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
                child: FloatingActionButton(
                  backgroundColor: Mystyle().bluecolor,
                  child: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditPost()));
                  },
                ),
              )
            ],
          ),
        ),
      ]);

  void routToEditPost() {
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => EditPost(),
    );
    Navigator.push(context, materialPageRoute);
  }
}
