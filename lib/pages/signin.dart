import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scicare/models/user_model.dart';
import 'package:scicare/sau_page/main_sau.dart';
import 'package:scicare/pages/signup.dart';
import 'package:scicare/student_page/main_student.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/dialog.dart';
import 'package:scicare/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Mystyle().ShowLogo(),
              Text(
                'SCICARE Signin',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Color(0xff003C71),
                  fontWeight: FontWeight.bold
                ),
              ),
              Mystyle().MySizedBox(),
              UserForm(),
              Mystyle().MySizedBox(),
              PasswordForm(),
              Mystyle().MySizedBox(),
              LoginBotton(),
              SignUpBotton()

            ],
          ),
        ),
      ),
    );



  }

  Widget LoginBotton() => Container(
      width: 200.0,
      child: RaisedButton(
        color: Mystyle().bluecolor,
        onPressed: (){
          if(username == null || username.isEmpty || password == null || password.isEmpty){
            normalDialog(context, "มีช่องว่าง กรุณากรอกให้ครบ");
          }else{
            CheckAuthen();

          }

        },
        child: Text('Login',
        style: TextStyle(
          color: Mystyle().whitecolor
        ),),
      )
  );


  Future<Null> CheckAuthen()async{
    String url = '${MyConstant().domain}/scicare/getUserWhereUser2.php?isAdd=true&Username=$username';
    try{
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('result = $result');
      for(var map in result){
        UserModel userModel = UserModel.fromJson(map);
        if(password == userModel.password){
          if(username == 'User'){
            RouteToService(MainStudent(), userModel);
          }else if (username == 'admin01'){
            RouteToService(MainSAU(), userModel);
          }else if (username != 'admin01'){
            RouteToService(MainStudent(), userModel);
          }else{
            normalDialog(context, 'Error');
          }


        }else{
          normalDialog(context, 'Username หรือ Password ผิด ดรุณาลองใหม่อีกครั้ง');

        }
      }


    }catch(e){

    }
  }

  Future<Null> RouteToService(Widget myWidget, UserModel userModel) async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('Name', userModel.name);
    preferences.setString('Username', userModel.username);
    preferences.setString('Password', userModel.password);


    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget,);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }



  Widget SignUpBotton() => Container(
      width: 200.0,
      child: RaisedButton(
        color: Mystyle().bluecolor,
        onPressed: (){
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) =>SignUp()
          ));

          //Navigator.push(SignUp(), route)
        },
        child: Text('Signup',
          style: TextStyle(
              color: Mystyle().whitecolor
          ),),
      )
  );


  Widget  UserForm() => Container(
      width: 300.0,
      color: Mystyle().whitecolor,
      child: TextField(onChanged: (value) => username = value.trim(),

        decoration: InputDecoration(
          //border: BorderRadius.circular(30),
          prefixIcon: Icon(
            Icons.person,
            color: Mystyle().bluecolor,
          ),
          labelText: 'Username  : ',
          labelStyle: TextStyle(
            color: Mystyle().blackcolor
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Mystyle().bluecolor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Mystyle().blackcolor)),
        ),
      ),
  );

  Widget  PasswordForm() => Container(
    width: 300.0,
    color: Mystyle().whitecolor,
    child: TextField(onChanged: (value) => password = value.trim(),
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Mystyle().bluecolor,
        ),
        labelText: 'Password  : ',
        labelStyle: TextStyle(
            color: Mystyle().blackcolor
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Mystyle().bluecolor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Mystyle().blackcolor)),
      ),
    ),
  );
}

    