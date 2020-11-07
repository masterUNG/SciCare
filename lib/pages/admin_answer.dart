import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scicare/models/answer_model.dart';
import 'package:scicare/models/post_model.dart';
import 'package:scicare/widgets/dialog.dart';
import 'package:scicare/widgets/widgets.dart';

class AdminAnswer extends StatefulWidget {
  final String idStudent;
  AdminAnswer({Key key, this.idStudent}) : super(key: key);
  @override
  _AdminAnswerState createState() => _AdminAnswerState();
}

class _AdminAnswerState extends State<AdminAnswer> {
  String idStudent, answer, dateTimeAnswer;
  List<PostModel> postModels = List();
  List<AnswerModel> answerModels = List();

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
    if (answerModels.length != 0) {
      answerModels.clear();
    }

    await FirebaseFirestore.instance
        .collection('PostPsu')
        .doc(idStudent)
        .collection('Answer')
        .snapshots()
        .listen((event) {
      for (var snapshot in event.docs) {
        AnswerModel model = AnswerModel.fromJson(snapshot.data());
        print('###############ans ======>>> ${model.answer}');
        print('###############DateTime ====>>>> ${model.dateTimeAnswer}');
        setState(() {
          answerModels.add(model);
        });
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
      body: (postModels.length == 0)
          ? Mystyle().showProgress()
          : Stack(
              children: [
                buildListView(context),
                buildAnswerMassage(context),
              ],
            ),
    );
  }

  Future<Null> insertAnswer() async {
    AnswerModel model =
        AnswerModel(answer: answer, dateTimeAnswer: dateTimeAnswer);

    Map<String, dynamic> map = model.toJson();

    print('####### ((((((( dateTimeAnswer ===>> ${map['DateTimeAnswer']}');

    Map<String, dynamic> map2 = Map();
    map2['Answer'] = answer;
    map2['DateTimeAnswer'] = dateTimeAnswer;

    await FirebaseFirestore.instance
        .collection('PostPsu')
        .doc(idStudent)
        .collection('Answer')
        .doc()
        .set(map2)
        .then((value) => readAnswer());
  }

  Column buildAnswerMassage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(color: Mystyle().bluecolor),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  width: 250,
                  child: TextField(
                    onChanged: (value) => answer = value.trim(),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  DateTime dateTime = DateTime.now();
                  dateTimeAnswer =
                      DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
                  print(
                      '################ dateTimeAnswer ===>> $dateTimeAnswer');

                  if (answer == null || answer.isEmpty) {
                    normalDialog(context, 'ให้ตอบคำถามก่อน คะ');
                  } else {
                    insertAnswer();
                  }
                },
                child: Text('Answer'),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row buildListView(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildListQuestion(context),
        answerModels.length == 0 ? SizedBox() : buildListAnswer(context),
      ],
    );
  }

  Container buildListAnswer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5 - 10,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: answerModels.length,
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(answerModels[index].answer),
                Text(checkAnswer(answerModels[index].dateTimeAnswer)),
              ],
            ),
          ),
        ),
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
