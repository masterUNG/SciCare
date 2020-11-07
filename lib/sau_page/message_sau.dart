import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scicare/models/user_model.dart';
import 'package:scicare/pages/admin_answer.dart';

import 'package:scicare/widgets/widgets.dart';

class MessegeSau extends StatefulWidget {
  MessegeSau({Key key}) : super(key: key);

  @override
  _MessegeSauState createState() => _MessegeSauState();
}

class _MessegeSauState extends State<MessegeSau> {
  List<String> studentDocs = List();
  List<UserModel3> userModel3s = List();
  List<String> idStudents = List();
  List<int> amounts = List();

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

          findAmountMessage(string);

          setState(() {
            idStudents.add(string);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: (idStudents.length == 0) || (amounts.length == 0)
          ? Mystyle().showProgress()
          : ListView.builder(
              itemCount: idStudents.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminAnswer(
                        idStudent: idStudents[index],
                      ),
                    )),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          changeId(idStudents[index]),
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(amounts[index].toString())
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  String changeId(String string) {
    String result = string;
    result = result.substring(0, result.length - 3);
    result = '${result}xxx';
    return result;
  }

  Future<Null> findAmountMessage(String string) async {
    await FirebaseFirestore.instance
        .collection('PostPsu')
        .doc(string)
        .collection('PostMessage')
        .snapshots()
        .listen((event) {
      int amount = event.docs.length;
      setState(() {
        amounts.add(amount);
      });
    });
  }
}
