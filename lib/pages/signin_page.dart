/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scicare/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height -50,
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  style: simpleTextStyle(),
                  decoration: textFieldInput("Email"),
                ),
                TextField(
                  style: simpleTextStyle(),
                  decoration: textFieldInput("Password"),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Text("Forgot Password ?", style: simpleTextStyle(),)
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff003c71),
                        const Color(0xff2A75BC)
                      ]
                    ),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("Sign In",
                  style: mediumTextStyle()
                  ,),
                ),
                SizedBox(height: 16,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                          const Color(0xff2A75BC),
                          const Color(0xff003c71)
                          ]
                      ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("Sign In with Google",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                    ),),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't  have account ?", style: mediumTextStyle(),),
                    Text("Register now", style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      decoration: TextDecoration.underline
                    ),)
                  ],
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
