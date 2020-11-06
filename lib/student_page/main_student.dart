import 'package:flutter/material.dart';
import 'package:scicare/student_page/post/post_std.dart';

import 'package:scicare/student_page/profile/UpProfile.dart';
import 'package:scicare/student_page/profile/profile_std.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:scicare/student_page/message_std.dart';
import 'package:scicare/student_page/menu_std.dart';
import 'package:scicare/student_page/notification_std.dart';


class MainStudent extends StatefulWidget {
  MainStudent({Key key}) : super(key: key);
  @override
  _MainStudentState createState() => _MainStudentState();
}

class _MainStudentState extends State<MainStudent> {

  PageController _pageController = PageController();

  List<Widget> _screen = [
    MenuStd(), MessegeStd(), PostStd(), NotificationStd(), ProfileStd(),UpProfile()
  ];

  int _selectedIndex =0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _onItemTaped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }

  String nameUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();

  }

  Future<Null> findUser()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar(context),
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTaped,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.menu,
                    color: _selectedIndex ==0 ? Colors.yellow :Colors.grey),
                title: Text('',
                  style: TextStyle(
                      color: _selectedIndex ==0 ? Colors.yellow :Colors.grey
                  ),),
                backgroundColor: Color(0xff003C71)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.message,
                    color: _selectedIndex ==1 ? Colors.yellow :Colors.grey),
                title: Text('Message',
                  style: TextStyle(
                      color: _selectedIndex ==1 ? Colors.yellow :Colors.grey
                  ),),
                backgroundColor: Color(0xff003C71)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: _selectedIndex ==2 ? Colors.yellow :Colors.grey),
                title: Text('Home',
                  style: TextStyle(
                      color: _selectedIndex ==2 ? Colors.yellow :Colors.grey
                  ),),
                backgroundColor: Color(0xff003C71)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active,
                    color: _selectedIndex ==3 ? Colors.yellow :Colors.grey),
                title: Text('Notification',
                  style: TextStyle(
                      color: _selectedIndex ==3 ? Colors.yellow :Colors.grey
                  ),),
                backgroundColor: Color(0xff003C71)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,
                    color: _selectedIndex ==4 ? Colors.yellow :Colors.grey),
                title: Text('Profile',
                  style: TextStyle(
                      color: _selectedIndex ==4 ? Colors.yellow :Colors.grey
                  ),),
                backgroundColor: Color(0xff003C71)
            ),
          ],
        )
    );
  }
}
