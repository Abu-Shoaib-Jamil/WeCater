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

  @override
  void initState() {
    checkbookmark();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("${widget.colname}" + "-record")
              .doc(widget.docId)
              .get(),
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
                                    if (!_isfavourite) {
                                      setState(() {
                                        _isfavourite = !_isfavourite;
                                      });
                                    } else {
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
                                Text("4.3k"),
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

// Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     //Video Section
//                     VideoWidget(),
//                     //Image Section
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     //Detail Section
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         //Profile Photo, Name Section and Like Button and bookmark icon.
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             //Profile Photo
//                             Expanded(
//                               flex: 1,
//                               child: CircleAvatar(
//                                 foregroundImage:
//                                     AssetImage("asset/profile.jpg"),
//                                 radius: 20.0,
//                               ),
//                             ),
//                             //Name Section
//                             Expanded(
//                               flex: 3,
//                               child: Text(
//                                 "$_name",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 24.0,
//                                 ),
//                               ),
//                             ),
//                             //Bookmark and like button
//                             Expanded(
//                               flex: 1,
//                               child: Wrap(
//                                 spacing: 5.0,
//                                 alignment: WrapAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.bookmark,
//                                   ),
//                                   Icon(
//                                     Icons.favorite_rounded,
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         //Food Rating
//                         Wrap(
//                           spacing: 5.0,
//                           children: [
//                             Text("Food Quality : "),
//                             StarRating(
//                               rating: _foodrate.toDouble(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5.0,
//                         ),
//                         //Hygiene Rating
//                         Wrap(
//                           spacing: 5.0,
//                           children: [
//                             Text("Hygiene: "),
//                             StarRating(
//                               rating: _hygienerate.toDouble(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20.0,
//                         ),
//                         //Special Item
//                         Text("Special Item : $_specialitem"),
//                       ],
//                     ),
//                   ],
//                 );
