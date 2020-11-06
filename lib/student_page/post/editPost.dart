import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/dialog.dart';
import 'package:scicare/widgets/widgets.dart';

class EditPost extends StatefulWidget {
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {

  File file;
  String detail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              buildText(),
              picPost(),
              choosePic(),
              detailPost(),
              upPostButton()
            ],

          ),
        ),


      ),

    );
  }

  Widget upPostButton() => Container(width: 200,
    child: RaisedButton.icon(color: Mystyle().bluecolor,
        onPressed: (){
      if(file == null){
        normalDialog(context, 'กรุณาแนบรูปภาพ');

      }else if(detail == null || detail.isEmpty){
        normalDialog(context, 'กรุณากรอกรายละเอียดโพสท์ค่ะ');
      }else{
        uploadPost();
      }

        }, icon: Icon(Icons.send,color: Mystyle().whitecolor,), label: Text('Post',style: TextStyle(color: Mystyle().whitecolor),)),
  );

  Future<Null>uploadPost()async{

    String url ='${MyConstant().domain}/scicare/savepost.php';

    Random random = Random();
    int i = random.nextInt(10000000);
    String namefile = 'post$i.jpg';
    
    try{
      Map<String, dynamic> map = Map();
      map['post'] = await MultipartFile.fromFile(file.path, filename: namefile);
      FormData fromData = FormData.fromMap(map);
      
      await Dio().post(url, data: fromData).then((value) {
        String urlPathImage = '/scicare/post/$namefile';
        print ('pathImage === ${MyConstant().domain}$urlPathImage');
      });
    }catch(e){
      
    }

  }




  Text buildText() => Text('Edit Post');

  Widget detailPost() => Row(mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(margin: EdgeInsets.only(top: 16),
        width: 300,
        child: TextField(onChanged: (value) => detail = value.trim(),
          decoration: InputDecoration(border: OutlineInputBorder(),
              labelText: 'detail post'),
        ),)
    ],);

  Future<Null>chooseImage(ImageSource source)async{
    try{
      var object = await ImagePicker.pickImage(
          source: source,
          maxHeight: 800,
          maxWidth: 800
      );

      setState(() {
        file = File(object.path);
      });
    }catch (e){

    }
  }

  Widget choosePic() => Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(icon: Icon(Icons.add_a_photo),onPressed: () => chooseImage(ImageSource.camera),),
      IconButton(icon: Icon(Icons.add_photo_alternate),onPressed: () => chooseImage(ImageSource.gallery),)
    ],
  );

  Widget picPost() => Container(
    margin: EdgeInsets.only(top: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250,height: 250,
          child: file == null
              ? Image.asset('images/post_it.png')
              : Image.file(file),)
      ],
    ),);


}
