import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:wecater/screens/detailpage.dart';
import 'package:geolocator/geolocator.dart';

// ignore: must_be_immutable
class GenerateList extends StatefulWidget {
  String? colname, serve;
  double userlat, userlong;
  GenerateList(
      {required this.serve,
      required this.colname,
      required this.userlat,
      required this.userlong});
  @override
  _GenerateListState createState() => _GenerateListState();
}

class _GenerateListState extends State<GenerateList> {
  Future getDistance(String address) async {
    List<Location> _loc = await locationFromAddress(address);
    var _dist = Geolocator.distanceBetween(widget.userlat, widget.userlong,
        _loc.first.latitude, _loc.first.longitude);
    return _dist.ceil();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.colname == 'caterer') {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('caterer-record')
              .orderBy('averagerate', descending: true)
              .where('serve', isEqualTo: widget.serve)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return SliverList(
                delegate: SliverChildListDelegate(
                  snapshot.data!.docs.map((doc) {
                    String _name = doc.get('name');
                    var _avrate = doc.get('averagerate');
                    var _serve = doc.get('serve');
                    String _docid = doc.id;
                    if (widget.userlat == 0 && widget.userlong == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    docId: _docid,
                                    colname: widget.colname.toString()),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100.0),
                                bottomLeft: Radius.circular(100.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("asset/caterer.jpg"),
                                  radius: 25.0,
                                ),
                                title: Text(
                                  "$_name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                ),
                                subtitle: Text("$_serve"),
                                trailing: Wrap(
                                  spacing: 5.0,
                                  children: [
                                    Text(
                                      "$_avrate",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Icon(
                                      Icons.stars,
                                      color: Colors.amberAccent,
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (widget.userlat != 0 && widget.userlong != 0) {
                      var _distance;
                      getDistance(doc.get('address'))
                          .then((value) => _distance = value);
                      print(_distance);
                      if (_distance <= 10000) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      docId: _docid,
                                      colname: widget.colname.toString()),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100.0),
                                  bottomLeft: Radius.circular(100.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("asset/caterer.jpg"),
                                    radius: 25.0,
                                  ),
                                  title: Text(
                                    "$_name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                  subtitle: Text("$_serve"),
                                  trailing: Wrap(
                                    spacing: 5.0,
                                    children: [
                                      Text(
                                        "$_avrate",
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      Icon(
                                        Icons.stars,
                                        color: Colors.amberAccent,
                                        size: 18.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SliverToBoxAdapter(child: Container());
                      }
                    } else {
                      return SliverToBoxAdapter(child: Container());
                    }
                  }).toList(),
                ),
              );
            }
          });
    } else {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('banquet-record')
              .orderBy('averagerate', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return SliverList(
                delegate: SliverChildListDelegate(
                  snapshot.data!.docs.map((doc) {
                    String _name = doc.get('name');
                    var _avrate = doc.get('averagerate');
                    String _banqaddress = doc.get('address');
                    String _docid = doc.id;
                    if (widget.userlat == 0 && widget.userlong == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    docId: _docid,
                                    colname: widget.colname.toString()),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100.0),
                                bottomLeft: Radius.circular(100.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("asset/banquet.jpg"),
                                  radius: 25.0,
                                ),
                                title: Text(
                                  "$_name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                ),
                                subtitle: Text("$_banqaddress"),
                                trailing: Wrap(
                                  spacing: 5.0,
                                  children: [
                                    Text(
                                      "$_avrate",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Icon(
                                      Icons.stars,
                                      color: Colors.amberAccent,
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (widget.userlat != 0 && widget.userlong != 0) {
                      var _distance;
                      getDistance(_banqaddress).then((value) {
                        _distance = value;
                      });
                      if (_distance <= 10000) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      docId: _docid,
                                      colname: widget.colname.toString()),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100.0),
                                  bottomLeft: Radius.circular(100.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("asset/banquet.jpg"),
                                    radius: 25.0,
                                  ),
                                  title: Text(
                                    "$_name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                  subtitle: Text("$_banqaddress"),
                                  trailing: Wrap(
                                    spacing: 5.0,
                                    children: [
                                      Text(
                                        "$_avrate",
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      Icon(
                                        Icons.stars,
                                        color: Colors.amberAccent,
                                        size: 18.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  }).toList(),
                ),
              );
            }
          });
    }
  }
}
