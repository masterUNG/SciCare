import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
  return AppBar(
    title: Row(
      children: <Widget>[
        Image.asset('images/sci_psu.png',
          height: 150,)
      ],
    ),
  );
}

InputDecoration textFieldInput(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black)
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black)
    )
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.black,
        fontSize: 16,
  );
}

TextStyle mediumTextStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
}

class Mystyle {

  Container ShowLogo() {
    return Container(
      width: 300.0,
      height: 150.0,
      child: Image.asset('images/logo_psu.png'),
    );
  }

  TextStyle Title() {
    return TextStyle(
      color: Color(0xff003C71),
      fontSize: 16,
    );
  }

  Text showTitle(String title) => Text(
    title,
    style: TextStyle(
      fontSize: 16,
        color: Color(0xff003C71)

    ),
  );



  Color bluecolor = Color(0xff003C71);
  Color blackcolor = Colors.black;
  Color whitecolor = Colors.white;
  Color greycolor = Colors.grey;

  SizedBox MySizedBox() => SizedBox(width: 8.0, height: 16.0,);

  Widget showProgress(){
    return Center(child: CircularProgressIndicator(),);
  }


  Mystyle();
}


