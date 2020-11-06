import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scicare/models/user_model.dart';
import 'package:scicare/student_page/profile/UpProfile.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/signout.dart';
import 'package:scicare/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSau extends StatefulWidget {
  ProfileSau({Key key}) : super(key:key);



  @override

  //void init
  _ProfileSauState createState() => _ProfileSauState();

}

class _ProfileSauState extends State<ProfileSau> {

  File profile;
  String name, bio, urlProfile;
  bool status = true; // มีข้อมูล
  bool loadstatus = true; // โหลดข้อมูล
  UserModel3 userModel3;
  //var _isFirstCrossFadeEnabled = false;

  @override
  void initState() {

    super.initState();
    findUser();
    readProfile();
  }

  Future<Null> readProfile()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.get('id');
    print('id == $id');

    String url = '${MyConstant().domain}/scicare/getProfileWhereId.php?isAdd=true&id=$id';
    await Dio().get(url).then((value) {
      print('value == $value');
      var result = json.decode(value.data);
      print('result == $result');
      for (var map in result){
        setState(() {
          userModel3 = UserModel3.fromJson(map);
        });
        print('bio == ${userModel3.bio}');
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(width: 10,height: 50,),
              SizedBox(width: 10,height: 50,),
              //profilePicture(),
              showProfilePic(),
              Mystyle().MySizedBox(),
              showName(),
              Mystyle().MySizedBox(),
              //showBio(),
              userModel3 == null
                  ?  Mystyle().showProgress()
                  : userModel3.bio.isEmpty
                  ? showBio(context)
                  : showListProfile(),
              Mystyle().MySizedBox(),
              upPicButton(),
              Mystyle().MySizedBox(),
              signoutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Container showProfilePic() {
    return Container(
        width:200,height: 200,
        child: Image.network('${MyConstant().domain}${userModel3.urlProfile}')
    );
  }

  Widget showListProfile() => Column(
    children: <Widget>[Mystyle().showTitle(userModel3.bio)],);

  Widget upPicButton() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 250,
        child: RaisedButton.icon(
          color: Mystyle().bluecolor,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => UpProfile()
            ));
          },
          icon: Icon(Icons.create),
          label: Text('Up Profile',
              style: TextStyle(
                  color: Mystyle().whitecolor
              )),),
      )],);


  Text showName() => Text(name == null ? 'Student' : '$name');

  Widget showBio(BuildContext context) {
    return Text('BIOLOGOS',
        style: TextStyle(
            color: Color(0xff003C71),
            fontSize: 16
        ));
  }

  // Row profilePicture() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       IconButton(
  //         icon: Icon(
  //           Icons.arrow_left,
  //           size: 50.0,
  //         ),
  //         onPressed: () {
  //
  //         },),
  //
  //       Container(
  //         width: 250.0,height: 250,
  //         child: profile == null ? Image.asset('images/profile_std03.png') : Image.file(profile),
  //       ),
  //
  //       IconButton(
  //         icon: Icon(
  //           Icons.arrow_right,
  //           size: 50.0,
  //         ),
  //         onPressed: () {
  //           //animateCrossFade();
  //           //Navigator.push(SignUp(), route)
  //         },),
  //     ],
  //   );
  // }


  Container signoutButton(BuildContext context) {
    return Container(
      width: 200.0,
      child: RaisedButton(
        color: Mystyle().bluecolor,
        onPressed: () => signOut(context),
        child: Text('Sign Out',
            style: TextStyle(
                color: Mystyle().whitecolor
            )),
      ),
    );
  }

  Future<Null> findUser()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('Name');
      //bio = preferences.getString('Bio');
    });
  }



}