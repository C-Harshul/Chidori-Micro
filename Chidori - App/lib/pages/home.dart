import 'package:flutter/material.dart';
import './contacts.dart';
import './add_message.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  final _pageOptions = [
    Landing(),
    GestureMessages(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: _pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
    
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.contact_page, size: 30), title: Text('Contacts')),
            BottomNavigationBarItem(icon: Icon(Icons.message ,size: 30), title: Text('Gesture Messages')),
            
          ],
          selectedItemColor: Color(0xFF04FFB4),
          elevation: 5.0,
          unselectedItemColor: Colors.white,
          currentIndex: selectedPage,
          backgroundColor: Colors.black,
          
          onTap: (index){
            setState(() {
              selectedPage = index;
            });
          },
        )
    );
  }
}