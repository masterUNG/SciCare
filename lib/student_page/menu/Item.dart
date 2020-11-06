// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:scicare/models/user_model.dart';
// import 'package:scicare/widgets/constant.dart';
// import 'package:scicare/widgets/widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Item extends StatefulWidget {
//   @override
//   _ItemState createState() => _ItemState();
// }
//
// class _ItemState extends State<Item> {
//
//   UserModel2 userModel2;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     readDataItem();
//   }
//
//   Future<Null> readDataItem()async{
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String id = preferences.get('id');
//     print('id == $id');
//
//     String url = '${MyConstant().domain}/scicare/getItemWhereId.php?isAdd=true&id=$id';
//     Response response = await Dio().get(url);
//     print('res == $response');
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: <Widget>[
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scicare/widgets/constant.dart';
import 'package:scicare/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item extends StatefulWidget {
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item>{

  bool status = true;

  @override
  void initState(){
    // TODO: inplement initState
    super.initState();
    readItem();
  }

  Future<Null> readItem()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    print('id = $id');

    String url = '${MyConstant().domain}/scicare/getItemWhereId.php?isAdd=true&id=$id';
    Response response = await Dio().get(url);
    print('res ==> $response');


    if(response.toString() != 'null'){




    }else{
      setState(() {
        status = false;
      });


    }

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
     appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            showContent()
          ],
        ),
      ),

    );
  }

  Widget showContent() {
    return status ? Text('รายการของหาย') : Center(child: Text('ยังไม่มีข้อมูล'),);
  }
}