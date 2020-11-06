import 'package:flutter/material.dart';
import 'package:scicare/widgets/widgets.dart';

class PostSau extends StatefulWidget {
  PostSau({Key key}) : super(key:key);
  @override
  _PostSauState createState() => _PostSauState();
}

class _PostSauState extends State<PostSau> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Text('Message page'),
    );
  }
}
