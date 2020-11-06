import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scicare/models/user_model.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/dialog.dart';
import 'package:scicare/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  UserModel3 userModel3;
  String name, bio, urlProfile;
  File file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readProfile();
  }

  Future<Null> readProfile()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    print('id == $id');

    String url = '${MyConstant().domain}/scicare/getProfileWhereId.php?isAdd=true&id=$id';
    Response response = await Dio().get(url);
    print('Res === $response');

    var result = json.decode(response.data);

    for (var map in result){
      print(map);

      setState(() {
        userModel3 = UserModel3.fromJson(map);
        name = UserModel3().name;
        bio = UserModel3().bio;
        urlProfile = UserModel3().urlProfile;


      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: userModel3 == null 
          ? Mystyle().showProgress() 
          : showProfile(),
    );
  }

  Widget showProfile() => SingleChildScrollView(
    child: Column(
        children: <Widget>[
          profilePic(),
          editPic(),
          //nameFrom(),
          bioFrom(),
          upEdit()
        ],
    ),
  );

  Widget upEdit() => Container(
    width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(color: Mystyle().bluecolor,
          onPressed: confirmDialog,
          icon: Icon(Icons.edit,color: Colors.white,),
          label: Text('Upload Profile',
            style: TextStyle(color: Colors.white),)));

  Future<Null> confirmDialog()async{
    showDialog(context: context,
        builder: (context) => SimpleDialog(
          title: Text('ยืนยันการเปลี่ยนแปลง'),
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlineButton(onPressed: () {
                Navigator.pop(context);
                editThread();
              },
              child: Text('ยืนยัน'),),
              OutlineButton(onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก'),
              )
            ],)
          ],
        ));
  }

  Future<Null>editThread()async{

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameProfile = 'newProfile$i.jpg';

    Map<String, dynamic>map = Map();
    map['profile'] = await MultipartFile.fromFile(file.path, filename: nameProfile);


    FormData formData = FormData.fromMap(map);

    String urlUpload = '${MyConstant().domain}/scicare/saveprofile.php';
    await Dio().post(urlUpload, data: formData).then((value) async{

      urlProfile = '/scicare/profile/$nameProfile';
      String id = userModel3.id;
      String url = '${MyConstant().domain}/scicare/addProfileWhereId.php?isAdd=true&id=$id&Bio=$bio&UrlProfile=$urlProfile';

      Response response = await Dio().get(url);
      if(response.toString() == 'true'){
        Navigator.pop(context);

      }else{
        normalDialog(context, 'อัพโหลดไม่สำเร็จ กรุณาลองใหม่');

      }
    });



  }

  Widget editPic() => Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: Icon(Icons.add_a_photo),onPressed: () => chooseImage(ImageSource.camera),),
          IconButton(icon: Icon(Icons.add_photo_alternate),onPressed: () => chooseImage(ImageSource.gallery),)
        ],
  );

  Widget profilePic() => Container(
    margin: EdgeInsets.only(top: 16),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 250,height: 250,
                child: file == null ?Image.network('${MyConstant().domain}${userModel3.urlProfile}') : Image.file(file)),

          ],
      ),
  );

  Future<Null>chooseImage(ImageSource source)async{
    try{
      var object = await ImagePicker.pickImage(
          source: source,
          maxHeight: 800,
          maxWidth: 800
      );

      setState(() {
        file = object;
      });
    }catch (e){

    }
  }

  // Widget nameFrom() => Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //     Container(margin: EdgeInsets.only(top: 16.0),
  //     width: 250,
  //     child: TextFormField(onChanged: (value) => name = value,
  //       initialValue: userModel3.name,
  //       decoration: InputDecoration(border: OutlineInputBorder(),
  //           labelText: 'name'),),
  //   ),]
  // );

  Widget bioFrom() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(margin: EdgeInsets.only(top: 16.0),
          width: 250,
          child: TextFormField(onChanged: (value) => bio = value,
            initialValue: userModel3.bio,
            decoration: InputDecoration(border: OutlineInputBorder(),
                labelText: 'bio'),),
        ),]
  );



}
