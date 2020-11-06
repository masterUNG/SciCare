import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scicare/student_page/post/editPost.dart';
import 'package:scicare/widgets/widgets.dart';

class PostStd extends StatefulWidget {
  PostStd({Key key}) : super(key:key);

  @override
  _PostStdState createState() => _PostStdState();
}

class _PostStdState extends State<PostStd> {
  
  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              buildText(),
              postButton()

            ],
          ),
        ),
      )

    );
  }



  Text buildText() => Text('Post Page');

  Row postButton() => Row(mainAxisAlignment: MainAxisAlignment.end,
      children:<Widget>[
        Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
                child: FloatingActionButton(backgroundColor: Mystyle().bluecolor,
                  child: Icon(Icons.edit),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EditPost()
                    ));

                },),
              )
            ],),
        ),
      ]
  );

  void routToEditPost(){
    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (context) => EditPost(),);
    Navigator.push(context, materialPageRoute);
  }
}