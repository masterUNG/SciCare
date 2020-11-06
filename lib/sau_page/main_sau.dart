import 'package:flutter/material.dart';
import 'package:scicare/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scicare/sau_page/calendar_page.dart';
import 'package:scicare/sau_page/message_sau.dart';
import 'package:scicare/sau_page/post_sau.dart';
import 'package:scicare/sau_page/notification_sau.dart';
import 'package:scicare/sau_page/profile/profile_sau.dart';


class MainSAU extends StatefulWidget {
  MainSAU({Key key}) : super(key: key);
  @override
  _MainSAUtState createState() => _MainSAUtState();
}

class _MainSAUtState extends State<MainSAU> {

  PageController _pageController = PageController();

  List<Widget> _screen = [
    CalendarSau(), MessegeSau(), PostSau(), NottificationSau(), ProfileSau()
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
                icon: Icon(Icons.calendar_today,
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
