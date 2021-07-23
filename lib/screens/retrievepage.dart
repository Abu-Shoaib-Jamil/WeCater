import 'package:flutter/material.dart';
import 'package:listing/shared/catererslistwrapper.dart';
import 'package:listing/shared/testfield.dart';

class RetrievePage extends StatefulWidget {
  @override
  _RetrievePageState createState() => _RetrievePageState();
}

class _RetrievePageState extends State<RetrievePage> {
  final _searchKey = GlobalKey<FormFieldState>();
  String _searchvalue="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                CatererListWrapper(searchvalue: _searchvalue,),
              ],
            ),
          ),
      ),
    );
  }
}