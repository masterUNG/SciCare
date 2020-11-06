import 'package:flutter/material.dart';
import 'package:scicare/widgets/widgets.dart';

class CalendarSau extends StatefulWidget {
  CalendarSau({Key key}) : super(key: key);
  @override
  _CalendarSauState createState() => _CalendarSauState();
}

class _CalendarSauState extends State<CalendarSau> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Text('Calendar page'),
    );
  }
}
