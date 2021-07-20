import 'package:flutter/material.dart';
import 'package:wecater/screens/banquetpage.dart';
import 'package:wecater/screens/catererpage.dart';
import 'package:wecater/screens/packagepage.dart';
import 'package:wecater/screens/profilepage.dart';
import 'package:wecater/services/authservice.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // User? user;
  // @override
  // void initState() {
  //   super.initState();
  //   getUser();
  // }
  // Future getUser()async{
  //   User? _user = FirebaseAuth.instance.currentUser;
  //   setState(() {
  //     user = _user;
  //   });
  // }
  int _currentIndex = 1;
  final PageController _pageController = PageController();
  var _pages = [
    CatererPage(),
    BanquetPage(),
    PackagePage(),
    ProfilePage(),
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: CircleAvatar(
          backgroundImage:AssetImage("asset/logo.png"),radius: 10.0,backgroundColor: Colors.white,
        ),
        title: Text("WeCater",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
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
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Banquets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake_rounded),
            label: "Caterers",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_rounded),
            label: "Packages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
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