import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PackagePage extends StatefulWidget {
  @override
  _PackagePageState createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 3;
    double cardWidth = MediaQuery.of(context).size.width;
    List<String> packagesNames = [
      "Shaadi",
      "Reception",
      "Anniversary",
      "Birthday",
      "Farewell",
      "Reunion"
    ];
    List<String> packagesImages = [
      "asset/shaadi.jpg",
      "asset/reception.jpg",
      "asset/anniversary.jpg",
      "asset/birthday.jpg",
      "asset/farewell.jpg",
      "asset/reunion.jpg"
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: packagesNames.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: AssetImage(
                          packagesImages[index],
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: cardHeight / 3,
                      width: cardWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text(
                        packagesNames[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 50.0,
              );
            },
          ),
        ),
      ),
    );
  }
}
