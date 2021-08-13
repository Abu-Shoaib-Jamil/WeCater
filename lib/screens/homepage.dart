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
  int _currentIndex = 0;
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
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(66, 32, 87, 1),
        fixedColor: Colors.white,
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
            icon: Icon(Icons.local_offer_rounded),
            label: "Packages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(_currentIndex,
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          });
        },
      ),
    );
  }
}
