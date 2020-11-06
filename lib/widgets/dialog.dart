import 'package:flutter/material.dart';

Future<void> normalDialog(BuildContext context, String messsage)async {
  showDialog(context: context,
      builder: (context) =>
          SimpleDialog(
            title: Text(messsage), children: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            )
          ],
          )
  );
}