import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wecater/screens/banquetpage.dart';
import 'package:wecater/screens/catererpage.dart';
import 'package:wecater/screens/packagepage.dart';
import 'package:wecater/screens/profilepage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  bool _isbottombarvisible = true;
  late ScrollController _scrollBottomBarController;
  final PageController _pageController = PageController();
  var _pages = [
    CatererPage(),
    BanquetPage(),
    PackagePage(),
    ProfilePage(),
  ];
  void scrollDirectionFind() async {
    _scrollBottomBarController.addListener(() {
      var _scrolldirection =
          _scrollBottomBarController.position.userScrollDirection;
      if (_scrolldirection == ScrollDirection.reverse) {
        print("forward direction");
        if (!_isbottombarvisible) {
          setState(() {
            _isbottombarvisible = true;
          });
        }
      } else if (_scrolldirection == ScrollDirection.forward) {
        print("reverse direction");
        if (_isbottombarvisible) {
          setState(() {
            _isbottombarvisible = false;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollBottomBarController = new ScrollController();
    scrollDirectionFind();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollBottomBarController.removeListener(scrollDirectionFind);
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
      bottomNavigationBar: _isbottombarvisible
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0.0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.cake_rounded),
                  label: "Caterers",
                  backgroundColor: Color.fromRGBO(66, 32, 87, 1),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "Banquets",
                  backgroundColor: Color.fromRGBO(251, 220, 173, 1),
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
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                });
              },
            )
          : Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
            ),
    );
  }
}
