import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wecater/services/generatelist.dart';
import 'package:wecater/services/getlocation.dart';
import 'package:wecater/shareditems/inputfield.dart';

class CatererPage extends StatefulWidget {
  @override
  _CatererPageState createState() => _CatererPageState();
}

class _CatererPageState extends State<CatererPage> {
  String? _locdropvalue = "Any Location";
  String? _servedropvalue = "both";
  double _userlat = 0, _userlong = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            bottom: PreferredSize(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: TextFormField(
                  decoration: inputdeco.copyWith(hintText: "Search Caterers"),
                ),
              ),
              preferredSize: Size.fromHeight(73.0),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(5),
              ),
            ),
            backgroundColor: Color.fromRGBO(66, 32, 87, 1),
            stretch: true,
            automaticallyImplyLeading: false,
            title: Text("WeCater", style: TextStyle(color: Colors.white)),
            centerTitle: true,
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage("asset/catererappbar.png"),
                fit: BoxFit.fill,
              ),
              stretchModes: [
                StretchMode.zoomBackground,
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Location Dropdown
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      width: MediaQuery.of(context).size.width / 3,
                      alignment: Alignment.center,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                        ),
                        value: _locdropvalue,
                        items: <String>['Any Location', 'Your Location']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? val) async {
                          setState(() {
                            _locdropvalue = val;
                          });
                          if (val == 'Your Location') {
                            var _loc = await Location().determinePosition();
                            setState(() {
                              _userlat = _loc.latitude;
                              _userlong = _loc.longitude;
                            });
                          } else {
                            setState(() {
                              _userlat = 0;
                              _userlong = 0;
                            });
                          }
                        },
                      ),
                    ),
                    //Serve DropDown Button
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        color: Colors.white,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      width: MediaQuery.of(context).size.width / 3,
                      alignment: Alignment.center,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                        ),
                        value: _servedropvalue,
                        items: <String>[
                          'both',
                          'veg',
                          'nonveg',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          setState(() {
                            _servedropvalue = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            sliver: GenerateList(
              serve: _servedropvalue,
              colname: "caterer",
              userlat: _userlat,
              userlong: _userlong,
            ),
          ),
        ],
      ),
    );
  }
}
