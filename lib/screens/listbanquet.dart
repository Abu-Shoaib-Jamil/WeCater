import 'package:flutter/material.dart';
import 'package:listing/shared/testfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListBanquet extends StatefulWidget {
  @override
  _ListBanquetState createState() => _ListBanquetState();
}

class _ListBanquetState extends State<ListBanquet> {
  final _listKey = GlobalKey<FormState>();
  late String _banqname,
      _streetno,
      _streetname,
      _district,
      _pincode,
      _state,
      _contact;
  late int _hygienerate;
  setSearchParam(String banqname) {
    List<String> searchCasesList = [];
    String temp = "";
    for (int i = 0; i < banqname.length; i++) {
      temp = temp + banqname[i];
      searchCasesList.add(temp);
    }
    return searchCasesList;
  }

  Future _uploadData() async {
    try {
      await FirebaseFirestore.instance.collection('banquet-record').doc().set({
        'name': _banqname,
        'streetnumber': _streetno,
        'streetname': _streetname,
        'district': _district,
        'pincode': _pincode,
        'state': _state,
        'contact': _contact,
        'hygienerate': _hygienerate,
        'address': _streetno +
            ", " +
            _streetname +
            ", " +
            _district +
            "-" +
            _pincode +
            ", " +
            _state,
        'searchcases': setSearchParam(_banqname),
      });
      return 'success';
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Listing Form
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _listKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Banquet Name
                          TextFormField(
                            decoration:
                                inputfield.copyWith(labelText: "Banquet Name"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Caterer Name";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                _banqname = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          //Street number and Street Name
                          Row(
                            children: [
                              //Street Number
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  decoration: inputfield.copyWith(
                                      labelText: "Street No"),
                                  onChanged: (val) {
                                    setState(() {
                                      _streetno = val;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              //Street Name
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  decoration: inputfield.copyWith(
                                      labelText: "Street Name"),
                                  validator: (val) => (val!.isEmpty)
                                      ? "Enter Street Name"
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      _streetname = val;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          //District and Pincode
                          Row(
                            children: [
                              //District
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  decoration: inputfield.copyWith(
                                      labelText: "District"),
                                  validator: (val) =>
                                      (val!.isEmpty) ? "Enter District" : null,
                                  onChanged: (val) {
                                    setState(() {
                                      _district = val;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              //Pincode
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  decoration:
                                      inputfield.copyWith(labelText: "Pincode"),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter pincode";
                                    } else if (val.length != 6) {
                                      return "Pincode must be of length 6";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      _pincode = val;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          //State
                          TextFormField(
                            decoration: inputfield.copyWith(labelText: "State"),
                            validator: (val) =>
                                (val!.isEmpty) ? "Enter State" : null,
                            onChanged: (val) {
                              setState(() {
                                _state = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          //Contact
                          TextFormField(
                            decoration:
                                inputfield.copyWith(labelText: "Contact"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Contact";
                              } else if (val.length != 10) {
                                return "Wrong Contact";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                _contact = val;
                              });
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          //HygieneRating
                          TextFormField(
                              decoration: inputfield.copyWith(
                                  labelText: "Hygiene Rating(>=0 & <5)"),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter Hygiene Rating";
                                } else if (int.parse(val) > 6 &&
                                    int.parse(val) < 0) {
                                  return "0 <= Rating <= 5";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  _hygienerate = int.parse(val);
                                });
                              }),
                        ]),
                  ),
                ),
              ),
            ),
            //Upload Button
            Expanded(
              flex: 1,
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_listKey.currentState!.validate()) {
                      var _result = await _uploadData();
                      if (_result == 'success') {
                        _listKey.currentState!.reset();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Successfully Uploaded",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "$_result",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: Text("Upload"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
