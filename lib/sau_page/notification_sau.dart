import 'package:flutter/material.dart';
import 'package:scicare/widgets/widgets.dart';

class NottificationSau extends StatefulWidget {
  NottificationSau({Key key}) : super(key:key);

  @override
  _NottificationSauState createState() => _NottificationSauState();
}

class _NottificationSauState extends State<NottificationSau> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Text('Message page'),
    );
  }
}