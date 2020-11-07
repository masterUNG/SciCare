import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scicare/models/post_model.dart';
import 'package:scicare/widgets/widgets.dart';

class AdminAnswer extends StatefulWidget {
  final String idStudent;
  AdminAnswer({Key key, this.idStudent}) : super(key: key);
  @override
  _AdminAnswerState createState() => _AdminAnswerState();
}

class _AdminAnswerState extends State<AdminAnswer> {
  String idStudent;
  List<PostModel> postModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idStudent = widget.idStudent;
    print('##### idStudent ===> $idStudent');
    readData();
    readAnswer();
  }

  Future<Null> readAnswer() async {
    await FirebaseFirestore.instance
        .collection('PostPsu')
        .doc(idStudent)
        .collection('Answer')
        .snapshots()
        .listen((event) {
          for (var snapshot in event.docs) {
            
          }
        });
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('PostPsu')
          .doc(idStudent)
          .collection('PostMessage')
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          // print('snapshot ==>> ${snapshot.data()}');
          PostModel model = PostModel.fromJson(snapshot.data());
          setState(() {
            postModels.add(model);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: postModels.length == 0
          ? Mystyle().showProgress()
          : Row(
              children: [
                buildListQuestion(context),
              ],
            ),
    );
  }

  Container buildListQuestion(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: postModels.length,
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(postModels[index].message),
                Text(postModels[index].dateTimeMessage),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String checkAnswer(String string) {
    String answer = '';
    if (string != null) {
      answer = string;
    }
    return answer;
  }
}
