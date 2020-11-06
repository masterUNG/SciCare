//import 'dart:html';
import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';




class WebPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  WebPage({Key key}) : super(key: key);
  final String title = 'Launch url';

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  Future<void> _launched;
  String phoneNumber = '';
  String _launchedUrl01 = 'https://sis-hatyai1.psu.ac.th/Student/Default.aspx';
  String _launchedUrl02 = 'https://www.sci.psu.ac.th/home/';
  String _launchedUrl03 = 'https://transcript.psu.ac.th/';
  String _launchedUrl04 = 'https://scmis.sci.psu.ac.th/sccheckgraduate/login.asp';
  String _launchedUrl05 = 'https://scmis.sci.psu.ac.th/examinationroom/SearchSeat.aspx';

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,

        forceWebView: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    }
    else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset('images/sci_psu.png',
              height: 150,)
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: const Text('Student Information System'),
                onPressed: (){
                  _launchInApp(_launchedUrl01);
                },
              ),
              RaisedButton(
                child: const Text('Sci PSU'),
                onPressed: (){
                  _launchInApp(_launchedUrl02);
                },
              ),
              RaisedButton(
                child: const Text('Transcript'),
                onPressed: (){
                  _launchInApp(_launchedUrl03);
                },
              ),
              RaisedButton(
                child: const Text('ระบบตรวจสอบการลงทะเบียนตามหลักสูตร'),
                onPressed: (){
                  _launchInApp(_launchedUrl04);
                },
              ),
              RaisedButton(
                child: const Text('เช็คที่นั่งสอบ'),
                onPressed: (){
                  _launchInApp(_launchedUrl05);
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}





