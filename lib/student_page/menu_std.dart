import 'package:flutter/material.dart';
import 'package:scicare/student_page/menu/Item.dart';
import 'package:scicare/student_page/menu/item_lost.dart';
//import 'file:///C:/Users/niglo/Desktop/Project/SCICARE/scicare/lib/student_page/web_page.dart';
import 'package:scicare/student_page/menu/web_page.dart';
import 'package:scicare/student_page/menu/datetime_std.dart';
import 'package:scicare/widgets/widgets.dart';

class MenuStd extends StatefulWidget {
  MenuStd({Key key}) : super(key:key);

  @override
  _MenuStdState createState() => _MenuStdState();
}

class _MenuStdState extends State<MenuStd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(height: 150,)
                  ],
                ),
                SingleChildScrollView(
                  child: Row(
                    children: <Widget>[
                      Container(width: 32.5,),
                      Container(
                        width: 150,
                        height: 150,
                        child: RaisedButton(
                          child: Image.asset('search.png'),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ItemLost()
                            ));
                          },
                        ),
                      ),
                      Container(
                        width: 20,

                      ),
                      Container(
                        width: 150,
                        height: 150,
                        child: RaisedButton(
                          child: Image.asset('box.png'),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Item()
                            ));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 20,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(width: 32.5,),
                    Container(
                      width: 150,
                      height: 150,
                      child: RaisedButton(

                        child: Image.asset('calendar.png'),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => selectDateTime()
                          ));
                        },

                      ),
                    ),
                    Container(width: 20,),
                    Container(
                      width: 150,
                      height: 150,
                      child: RaisedButton(
                        child: Image.asset('web.png'),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => WebPage()
                          ));
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )



    );
  }
}