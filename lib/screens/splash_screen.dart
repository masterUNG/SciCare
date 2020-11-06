import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scicare/pages/signin.dart';
import 'package:scicare/sau_page/main_sau.dart';
import 'package:scicare/student_page/main_student.dart';
import 'package:scicare/widgets/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
    checkPreferance();
  }

  startTimer() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
    
  }

  Future<Null> checkPreferance()async{
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('Username');
    if(username != null && username.isNotEmpty){
      if(username == 'admin01'){
        RouteToService(MainSAU());
      }else if(username != 'admin01'){
        RouteToService(MainStudent());
      }else {
        normalDialog(context, 'Error');
      }
    }
  }catch(e){

  }
  }

  void RouteToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget,);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
  
  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => SignIn()
    ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003C71),
      body: Center(
        child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          children: <Widget>[
            Container(

            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text('SCICARE  APPLICATION\n\nfaculty of science',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white
            ),),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,

            )
          ],
        ),
      ),
    );
  }
}