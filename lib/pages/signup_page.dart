/*
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scicare/pages/home_page.dart';
import 'package:scicare/survices/auth.dart';
import 'package:scicare/widgets/widgets.dart';


//class
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String username, email, password;

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();

  final formkey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailNameTextEditingController = new TextEditingController();
  TextEditingController passwordNameTextEditingController = new TextEditingController();

  signup(){
    print(username);
    print(email);
    print(password);


    /*if(formkey.currentState.validate()){
      setState(() {
        isLoading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailNameTextEditingController.text,
          passwordNameTextEditingController.text).then((val){
            //print("${val.uid}");
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomePage()
            ));
      });
    }*/
  }

  Future<Null> sendToDb()async{

    String url = 'http://172.28.34.87/adduser.php?isAdd=true&Username=$username&Email=$email&Password=$password';


    try{
      Response response = await Dio().get(url);
      print('res = $response');

      /*if (response.toString() == 'true'){
        Navigator.pop(context);
      }else{
        print('ลองใหม่ดิ');
      }*/

    }catch(e){

    }

  }

  @override
  Widget build(BuildContext context) {
    String username, email, password;
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height -50,
        alignment: Alignment.bottomCenter,
        child: isLoading ? Container(
          child: Center(child: CircularProgressIndicator()),
        ): SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(onChanged: (value) => username = value.trim() ,
                        validator: (val){
                          return val.isEmpty || val.length < 4 ? "Please Enter Username" :val;
                        },
                        controller: userNameTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInput("Username"),
                      ),
                      TextFormField(onChanged: (value) => email = value.trim() ,
                        validator: (val){
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val) ? null : "Please Enter Email address";
                        },
                        controller: emailNameTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInput("Email"),
                      ),
                      TextFormField(onChanged: (value) => password = value.trim() ,
                        obscureText: true,
                        validator: (val){
                          return val.length > 6 ? null : "Please enter password 6+ character";
                        },
                        controller: passwordNameTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInput("Password"),
                      ),
                    ],
                  ),
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
                  //width: MediaQuery.of(context).size.width,
                  //padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xff003c71),
                          const Color(0xff2A75BC)
                        ]
                    ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: RaisedButton(
                    onPressed: (){
                      sendToDb();
                      print('name = $username, email =$email, password = $password');

                    },
                    child: Text('signup',style: mediumTextStyle(),),

                  ),

                ),
                /*GestureDetector(
                  onTap: (){
                    sendToDb();
                  },
                  child: Container(
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
                    child: Text("Sign Up",
                      style: mediumTextStyle()
                      ,),
                  ),
                )*/
                SizedBox(height: 16,),
                /*Container(
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
                  child: Text("Sign Up with Google",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                    ),),
                ),*/
                SizedBox(height: 16,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already  have account ?", style: mediumTextStyle(),),
                      Text("SignIn now", style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          decoration: TextDecoration.underline
                      ),)
                    ],
                  ),
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
