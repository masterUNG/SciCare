import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scicare/student_page/menu_std.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/dialog.dart';
import 'package:scicare/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemLost extends StatefulWidget {
  @override
  _ItemLostState createState() => _ItemLostState();
}

class _ItemLostState extends State<ItemLost> {

  File item;
  String detail, urlPicItem, phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(width: 10,height: 100,),
            Container(child: Text('แจ้งของหาย'),),
            Photo(),
            AddImage(),
            Mystyle().MySizedBox(),
            Container(child: Text('รายละเอียดของสิ่งของ'),),
            Mystyle().MySizedBox(),
            DetailField(),
            Mystyle().MySizedBox(),
            phoneFrom(),
            Mystyle().MySizedBox(),
            Mystyle().MySizedBox(),

            ConfirmButton()
          ],
        ),
      ),
    );
  }

  Widget ConfirmButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 0.0),
        width: 250,
        child: RaisedButton.icon(
          color: Mystyle().bluecolor,
            onPressed: (){
            if(detail == null || detail.isEmpty){
              normalDialog(context, 'กรุณากรอกรายละเอียดด้วยค่ะ');
            }else if(phone == null || phone.isEmpty){
              normalDialog(context, 'กรุณากรอกเบอร์โทรศัพท์ด้วยค่ะ');
            }else if(item == null){
              normalDialog(context, 'กรุณาเเนบรูปภาพด้วยค่ะ');
            }else{
              uploadIem();
            }
            },
            icon: Icon(
              Icons.save_alt,
              color: Colors.white,
            ),
            label: Text(
              'Confirm',
              style: TextStyle(color: Colors.white),
            )
        ),
      ),
    );
  }

  Future<Null>uploadIem()async{


    String url = '${MyConstant().domain}/scicare/saveItemlost.php';


    Random random = Random();
    int i = random.nextInt(1000000);
    String nameItemlost = 'Itemlost$i.jpg';

    try{

      Map<String, dynamic> map = Map();
      map['item'] = await MultipartFile.fromFile(item.path, filename: nameItemlost);

      FormData fromData = FormData.fromMap(map);
      await Dio().post(url, data: fromData).then((value) {print('$value');});



        urlPicItem = '/scicare/Itemlost/$nameItemlost';
        print('urlImage = $urlPicItem');
        addItemLost();



    }catch(e){

    }
  }

  Future<Null>addItemLost()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');

    String url = '${MyConstant().domain}/scicare/addItemlost.php?isAdd=true&idUser=$idUser&Detail=$detail&Phone=$phone&UrlPicItem=$urlPicItem';

    await Dio().get(url).then((value) {
      if(value.toString() == 'true'){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MenuStd()
        ));

      }else{
        normalDialog(context, 'กรุณาลองใหม่อีกครั้งค่ะ');

      }
    });
  }

  Row AddImage() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      IconButton(
          icon: Icon(
            Icons.add_a_photo,
            size: 40.0,
          ),
          onPressed: () => chooseImage(ImageSource.camera)),
      Container(
        width: 20,height: 20,
      ),
      IconButton(
          icon: Icon(
            Icons.add_photo_alternate,
            size: 40.0,
          ),
          onPressed: () => chooseImage(ImageSource.gallery)),
    ],
  );

  Future<Null> chooseImage(ImageSource imageSource)async{
    try{
      var object = await ImagePicker.pickImage(
          source: imageSource,
          maxHeight: 800.0,
          maxWidth: 800.0
      );
      setState(() {
        item = object;
      });

    }catch(e){

    }
  }

  Row Photo() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 250.0,height: 250,
        child: item == null ? Image.asset('images/image.png') : Image.file(item),
      ),
  ],);


  Widget DetailField() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[Container(
      width: 250.0,
      child: TextField(onChanged: (value) => detail = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.create),
          labelText: 'สถานที่พบ/เวลาที่พบ/อื่น ๆ',
          border: OutlineInputBorder(),
        ),
      ),
    ),
    ],
  );

  Widget phoneFrom() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 250.0,
        child: TextField(onChanged: (value) => phone = value.trim(),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(labelText: 'เบอร์โทรติดต่อ',
            prefixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(),
          ),),
      ),
    ],
  );

}
