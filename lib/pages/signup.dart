import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/dialog.dart';
import 'package:scicare/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String name, username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          MyLogo(),
          //Mystyle().MySizedBox(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xff003C71),
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Mystyle().MySizedBox(),
          NameForm(),
          Mystyle().MySizedBox(),
          UsernameForm(),
          Mystyle().MySizedBox(),
          PasswordForm(),
          Mystyle().MySizedBox(),
          RegisterBotton(),


        ],
      ),
    );
  }


  Widget RegisterBotton() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
          width: 200.0,
          child: RaisedButton(
            color: Mystyle().bluecolor,
            onPressed: (){
              print('name = $name, username = $username, password = $password');
              if( name == null ||
                  name.isEmpty ||
                  username == null ||
                  username.isEmpty ||
                  password == null ||
                  password.isEmpty){
                print('มีช่องว่าง');
                normalDialog(context, 'กรุณากรอกให้ครบทุกช่อง');

              }else{
                checkUser();

              }
            },
            child: Text('Register',
              style: TextStyle(
                  color: Mystyle().whitecolor
              ),),
          )
      ),
    ],
  );

  Future<Null> checkUser()async{
    String url = '${MyConstant().domain}/scicare/getUserWhereUser.php?isAdd=true&Name=$name';

    try{
      Response response = await Dio().get(url);
      if (response.toString() == 'null'){
        register();
      }else{
        normalDialog(context, 'Name $name ซ้ำ กรุณาเปลี่ยน Name ใหม่');
      }
    }catch(e){

    }
  }

  //192.168.88.91 ถาวรสุข
  //192.168.111.24 พฤกษา เพลซ

  Future<Null> register()async{
    String url = '${MyConstant().domain}/scicare/adduser.php?isAdd=true&Name=$name&Username=$username&Password=$password';

    try{
      Response response = await Dio().get(url);
      print('res = $response');

      if(response.toString() == 'true') {
        Navigator.pop(context);
      }else{
        normalDialog(context, 'ไม่สามารถสมัครได้ กรุณาลองใหม่อีกครั้งค่ะ');
      }

    }catch(e){

    }

  }

  Widget  NameForm() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 250.0,
        color: Mystyle().whitecolor,
        child: TextField(onChanged: (value) => name = value.trim(),

          decoration: InputDecoration(
            //border: BorderRadius.circular(30),
            prefixIcon: Icon(
              Icons.face,
              color: Mystyle().bluecolor,
            ),
            labelText: 'Name  : ',
            labelStyle: TextStyle(
                color: Mystyle().greycolor
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Mystyle().bluecolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Mystyle().blackcolor)),
          ),
        ),
      ),
    ],
  );




  Widget  UsernameForm() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 250.0,
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
                color: Mystyle().greycolor
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Mystyle().bluecolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Mystyle().blackcolor)),
          ),
        ),
      ),
    ],
  );

  Widget  PasswordForm() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 250.0,
        color: Mystyle().whitecolor,
        child: TextField(onChanged: (value) => password = value.trim(),

          decoration: InputDecoration(
            //border: BorderRadius.circular(30),
            prefixIcon: Icon(
              Icons.lock,
              color: Mystyle().bluecolor,
            ),
            labelText: 'Password  : ',
            labelStyle: TextStyle(
                color: Mystyle().greycolor
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Mystyle().bluecolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Mystyle().blackcolor)),
          ),
        ),
      ),
    ],
  );

  Widget MyLogo() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Mystyle().ShowLogo(),
  ],
  ) ;
}
