import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scicare/models/user_model.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/widgets.dart';

class MessegeSau extends StatefulWidget {
  MessegeSau({Key key}) : super(key: key);

  @override
  _MessegeSauState createState() => _MessegeSauState();
}

class _MessegeSauState extends State<MessegeSau> {
  List<String> studentDocs = List();
  List<UserModel3> userModel3s = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('Initial Success');
      await FirebaseFirestore.instance
          .collection('PostPsu')
          .snapshots()
          .listen((event) async {
        for (var snapshot in event.docs) {
          String string = snapshot.id;
          // print('user ==>> $string');
          studentDocs.add(string);
        }

        for (var user in studentDocs) {
          String path =
              '${MyConstant().domain}/scicare/getUserWhereUser2.php?isAdd=true&Username=$user';
          await Dio().get(path).then((value) {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Text('Message page 123'),
    );
  }
}
