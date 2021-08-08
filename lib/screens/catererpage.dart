import 'package:flutter/material.dart';
import 'package:wecater/screens/generatelist.dart';
import 'package:wecater/services/getlocation.dart';

class CatererPage extends StatefulWidget {
  @override
  _CatererPageState createState() => _CatererPageState();
}

class _CatererPageState extends State<CatererPage> {
  String? _locdropvalue = "Any Location";
  String? _servedropvalue = "both";
  double _userlat=0,_userlong=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment : MainAxisAlignment.start,
        crossAxisAlignment : CrossAxisAlignment.center,
        children:[
          Expanded(
            flex:1,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Location Dropdown
                DropdownButton(
                  value : _locdropvalue,
                  items: <String>[
                          'Any Location',
                          'Your Location'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color:Colors.black),),
                          );
                        }).toList(),
                  onChanged: (String? val)async{
                    setState((){
                      _locdropvalue = val;
                    });
                    if(val=='Your Location'){
                      var _loc = await Location().determinePosition();
                      setState(() {
                        _userlat = _loc.latitude;
                        _userlong = _loc.longitude;
                      });
                    }else{
                      setState(() {
                        _userlat = 0;
                        _userlong = 0;
                      });
                    }
                  },
                ),
                //Serve DropDown Button
                DropdownButton(
                  value : _servedropvalue,
                  items: <String>[
                          'both',
                          'veg',
                          'nonveg',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(color:Colors.black),),
                          );
                        }).toList(),
                  onChanged: (String? val){
                    setState((){
                      _servedropvalue = val;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex:1,
            child: Text("$_userlat\n$_userlong"),
          ),
          Expanded(
            flex: 10,
            child: GenerateList(colname: "caterer",serve: _servedropvalue, userlat: _userlat,userlong : _userlong),
          ),
        ],
      ),
    );
  }
}