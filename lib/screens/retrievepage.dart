import 'package:flutter/material.dart';
import 'package:listing/screens/catererbanquetlistwrapper.dart';
import 'package:listing/screens/nonetwork.dart';
import 'package:listing/shared/testfield.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RetrievePage extends StatefulWidget {
  @override
  _RetrievePageState createState() => _RetrievePageState();
}

class _RetrievePageState extends State<RetrievePage> {
  final _searchKey = GlobalKey<FormFieldState>();
  String _searchvalue="";
  String? _dropdownvalue = "Caterer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context,snapshot){
              if(snapshot.data==ConnectivityResult.none){
                return NoNetwork();
              }else{
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //DropDown Button to change BanquetList Retrieve and CatererList Rertrieve
                      DropdownButton(
                        value: _dropdownvalue,
                        items:<String>[
                                'Caterer',
                                'Banquet'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style:TextStyle(color:Colors.black),),
                                );
                              }).toList(),
                        onChanged: (String? val){
                          setState((){
                            _dropdownvalue = val;
                          });
                        },
                      ),
                      TextFormField(
                        key: _searchKey,
                        decoration: inputfield.copyWith(hintText:"Search",prefixIcon: Icon(Icons.search_rounded),suffixIcon: InkWell(onTap:()async{_searchKey.currentState!.reset();setState((){_searchvalue="";});},child:Icon(Icons.cancel_outlined),),),
                        onChanged: (val){
                          setState((){
                            _searchvalue = val;
                          });
                        },
                      ),
                      SizedBox(height: 10.0,),
                      CatererBanquetListWrapper(dropdownvalue: _dropdownvalue,searchvalue: _searchvalue,),
                    ],
                  ),
                );
              }
            }
          ),
      ),
    );
  }
}
