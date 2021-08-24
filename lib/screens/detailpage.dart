import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wecater/shareditems/star_rating_generator.dart';
import 'package:wecater/shareditems/videowidget.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  String docId, colname;
  DetailPage({required this.docId, required this.colname});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isbookmarked = false;
  bool _isfavourite = false;
  Future bookmark() async {
    await FirebaseFirestore.instance
        .collection("user-record")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
      {
        "bookmarks": FieldValue.arrayUnion([widget.docId]),
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future removebookmark() async {
    await FirebaseFirestore.instance
        .collection("user-record")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
      {
        "bookmarks": FieldValue.arrayRemove([widget.docId])
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future checkbookmark() async {
    await FirebaseFirestore.instance
        .collection("user-record")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      List bookmarkarray = value.get("bookmarks");
      if (bookmarkarray.contains(widget.docId)) {
        setState(() {
          _isbookmarked = true;
        });
      }
    });
  }

  Future like() async {
    DocumentReference _docRef = FirebaseFirestore.instance
        .collection("${widget.colname}-record")
        .doc(widget.docId);
    await FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(_docRef);
          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }
          int _likes = snapshot.get('likes') + 1;
          transaction.update(_docRef, {'likes': _likes});
          return _likes;
        })
        .then((value) => print("Like upvoted to $value"))
        .catchError((error) => print("Falied to update due to $error"));
  }

  Future unlike() async {
    DocumentReference _docRef = FirebaseFirestore.instance
        .collection("${widget.colname}-record")
        .doc(widget.docId);
    await FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot _docSnap = await transaction.get(_docRef);
          if (!_docSnap.exists) {
            throw Exception("User does not exist!");
          }
          int _likes = _docSnap.get('likes') - 1;
          transaction.update(_docRef, {'likes': _likes});
          return _likes;
        })
        .then((value) => print("Like upvoted to : $value"))
        .catchError((error) => print("Falied to update due to $error"));
  }

  Future checklike() async {
    await FirebaseFirestore.instance
        .collection("user-record")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      List likesarray = value.get("likes");
      if (likesarray.contains(widget.docId)) {
        setState(() {
          _isfavourite = true;
        });
      }
    });
  }

  @override
  void initState() {
    checkbookmark();
    checklike();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("${widget.colname}" + "-record")
              .doc(widget.docId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (widget.colname == 'caterer') {
                String _name = snapshot.data!.get('name');
                int _foodrate = snapshot.data!.get('foodrate');
                int _hygienerate = snapshot.data!.get('hygienerate');
                String _specialitem = snapshot.data!.get('specialitem');
                int _likes = snapshot.data!.get('likes');
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      //Video Section
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width,
                          child: VideoWidget(),
                        ),
                      ),
                      //Profile Picture
                      Positioned(
                        left: 30.0,
                        top: MediaQuery.of(context).size.height / 4.5,
                        child: CircleAvatar(
                          foregroundImage: AssetImage("asset/profile.jpg"),
                          radius: 40.0,
                        ),
                      ),
                      //Name
                      Positioned(
                        top: MediaQuery.of(context).size.height / 3.8,
                        left: 120,
                        child: Text(
                          "$_name",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //Bookmark and Like button
                      Positioned(
                        right: 20.0,
                        top: MediaQuery.of(context).size.height / 3.8,
                        child: Wrap(
                          spacing: 5.0,
                          alignment: WrapAlignment.center,
                          children: [
                            //Bookmark button
                            InkWell(
                              onTap: () async {
                                if (!_isbookmarked) {
                                  setState(() {
                                    _isbookmarked = !_isbookmarked;
                                  });
                                  await bookmark();
                                } else {
                                  setState(() {
                                    _isbookmarked = !_isbookmarked;
                                  });
                                  await removebookmark();
                                }
                              },
                              child: Icon(
                                Icons.bookmark,
                                color:
                                    (_isbookmarked) ? Colors.blue : Colors.grey,
                              ),
                            ),
                            //Like button
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 2.0,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await like();
                                    if (!_isfavourite) {
                                      setState(() {
                                        _isfavourite = !_isfavourite;
                                      });
                                    } else {
                                      await unlike();
                                      setState(() {
                                        _isfavourite = !_isfavourite;
                                      });
                                    }
                                  },
                                  child: Icon(
                                    Icons.favorite_rounded,
                                    color: (_isfavourite)
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                                Text("$_likes"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //Other Dtails of the caterer
                      Positioned(
                        top: MediaQuery.of(context).size.height / 3.2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Wrap(
                            spacing: 10.0,
                            direction: Axis.vertical,
                            children: [
                              //Intro about the caterers
                              Text(
                                "This caterer has been around for more than 15 years in this industry, when it comes to taste and quality of the food there is no competition Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                              ),
                              //FoodRating
                              Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 5.0,
                                children: [
                                  Text(
                                    "Food Quality : ",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  StarRating(
                                    rating: _foodrate.toDouble(),
                                  ),
                                ],
                              ),
                              //HygieneRating
                              Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 5.0,
                                children: [
                                  Text(
                                    "Hygiene : ",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  StarRating(
                                    rating: _hygienerate.toDouble(),
                                  ),
                                ],
                              ),
                              //Special item
                              Text("Special Item : $_specialitem"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                String _name = snapshot.data!.get('name');
                int _averagerate = snapshot.data!.get('averagerate');
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VideoWidget(),
                    Text("$_name"),
                    SizedBox(height: 20.0),
                    Text("$_averagerate"),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
