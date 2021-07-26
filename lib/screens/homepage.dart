import 'package:flutter/material.dart';
import 'package:listing/screens/listbanquet.dart';
import 'package:listing/screens/listcaterer.dart';
import 'package:listing/screens/retrievepage.dart';
import 'package:listing/screens/uploadassets.dart';
import 'package:listing/service/authservice.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  var _pages = [
    ListCaterer(),
    ListBanquet(),
    UploadAsset(),
    RetrievePage(),
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: CircleAvatar(
          backgroundImage:AssetImage("asset/logo.png"),radius: 10.0,backgroundColor: Colors.black,
        ),
        title: Text("WeCater MasterApp",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        actions: [
          TextButton.icon(
            onPressed: ()async{
              await Authentication().logout();
            },
            icon: Icon(Icons.exit_to_app,color: Colors.black),
            label: Text("Logout",style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index){
          setState((){
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.red,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake_rounded),
            label: "Caterers",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Banquets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Asset",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: "Retrieve",
          ),
        ],
        onTap: (index){
          setState((){
            _currentIndex = index;
            _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          });
        },
      ),
    );
  }
}