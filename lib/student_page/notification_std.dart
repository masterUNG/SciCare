import 'package:flutter/material.dart';
import 'package:scicare/widgets/widgets.dart';

class NotificationStd extends StatefulWidget {
  NotificationStd({Key key}) : super(key:key);

  @override
  _NotificationStdState createState() => _NotificationStdState();
}

class _NotificationStdState extends State<NotificationStd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Text('Notification page'),
    );
  }
}