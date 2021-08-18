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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Video Section
                    Expanded(
                      flex: 1,
                      child: VideoWidget(),
                    ),
                    //Image Section
                    //Detail Section
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Profile Photo, Name Section and Like Button and bookmark icon.
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Profile Photo
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    foregroundImage:
                                        AssetImage("asset/profile.jpg"),
                                    radius: 30.0,
                                  ),
                                ),
                                //Name Section
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "$_name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                                //Bookmark and like button
                                Expanded(
                                  flex: 1,
                                  child: Wrap(
                                    spacing: 5.0,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.bookmark,
                                      ),
                                      Icon(
                                        Icons.favorite_rounded,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          //Ratings
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Food Rating
                                Expanded(
                                  flex: 1,
                                  child: Wrap(
                                    spacing: 5.0,
                                    children: [
                                      Text("Food Quality : $_foodrate"),
                                      StarRating(rating: _foodrate.toDouble()),
                                    ],
                                  ),
                                ),
                                //Hygiene Rating
                                Expanded(
                                  flex: 1,
                                  child: Wrap(
                                    spacing: 5.0,
                                    children: [
                                      Text("Hygiene: $_hygienerate"),
                                      StarRating(
                                          rating: _hygienerate.toDouble()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Special Item
                          Expanded(
                            flex: 1,
                            child: Text("Spacial Item : $_specialitem"),
                          ),
                        ],
                      ),
                    ),
                  ],
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
