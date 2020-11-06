import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scicare/student_page/profile/profile_std.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/dialog.dart';
import 'package:scicare/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpProfile extends StatefulWidget {
  UpProfile({Key key}) : super(key:key);
  @override
  _UpProfileState createState() => _UpProfileState();
}

class _UpProfileState extends State<UpProfile> {

  File profile;
  String name, bio, urlProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 10,height: 50,),
            profilePicture(),
            Mystyle().MySizedBox(),
            addProfile(),
            Mystyle().MySizedBox(),
            CaptionField(),
            Mystyle().MySizedBox(),
            upPicButton(),
          ],
        ),

      ),
    );
  }

  Row profilePicture() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_left,
            size: 50.0,
          ),
          onPressed: () {

          },),

        Container(
          width: 250.0,height: 250,
          child: profile == null ? Image.asset('images/profile_std03.png') : Image.file(profile),
        ),

        IconButton(
          icon: Icon(
            Icons.arrow_right,
            size: 50.0,
          ),
          onPressed: () {

          },),
      ],
    );
  }

  Row addProfile() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      IconButton(
        icon: Icon(
          Icons.add_photo_alternate,
          size: 40,
        ),
        onPressed: () =>
            chooseImage(ImageSource.gallery),
      )
    ],);

  Future<Null>chooseImage(ImageSource imageSource)async{
    try{
      var pic = await ImagePicker.pickImage(
          source: imageSource,
          maxWidth: 800,
          maxHeight: 800);
      setState(() {
        profile = pic;
      });
    }catch(e){

    }
  }

  Widget CaptionField() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 250,
        child: TextField(onChanged: (value) => bio = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_add),
            labelText: 'Bio : ',
            border: OutlineInputBorder(),
          ),
        ),
      )
    ],);

  Widget upPicButton() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 250,
        child: RaisedButton.icon(
          color: Mystyle().bluecolor,
            onPressed: (){
              if(bio == null || bio.isEmpty){
                normalDialog(context, 'กรุณากรอกข้อมูล Bio ด้วยค่ะ');
              }else if(profile == null){
                normalDialog(context, 'กรุณาเเนบรูปภาพด้วยค่ะ');
              }else{
                uploadProfile();
              }
            },
            icon: Icon(Icons.create),
            label: Text('Up Profile',
            style: TextStyle(
              color: Mystyle().whitecolor
            ),)),
      )],);

  Future<Null>uploadProfile()async{


    String url = '${MyConstant().domain}/scicare/saveprofile.php';


    Random random = Random();
    int i = random.nextInt(1000000);
    String nameProfile = 'Profile$i.jpg';

    try{

      Map<String, dynamic> map = Map();
      map['profile'] = await MultipartFile.fromFile(profile.path, filename: nameProfile);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {print('$value');});


      urlProfile = '/scicare/profile/$nameProfile';
      print('urlImage = $urlProfile');

      editStdProfile();


    }catch(e){

    }


  }

  Future<Null>editStdProfile()async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');

    String url = '${MyConstant().domain}/scicare/addProfileWhereId.php?isAdd=true&id=$id&Bio=$bio&UrlProfile=$urlProfile';

    await Dio().get(url).then((value) {
      if(value.toString() == 'true'){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ProfileStd()));

      }else{
        normalDialog(context, 'กรุณาลองใหม่อีกครั้งค่ะ');

      }
    });
  }
}



