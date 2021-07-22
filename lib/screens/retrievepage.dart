import 'package:flutter/material.dart';
import 'package:listing/shared/catererslistwrapper.dart';
import 'package:listing/shared/testfield.dart';

class RetrievePage extends StatefulWidget {
  @override
  _RetrievePageState createState() => _RetrievePageState();
}

class _RetrievePageState extends State<RetrievePage> {
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
                  decoration: inputfield.copyWith(hintText:"Search",prefixIcon: Icon(Icons.search_rounded),suffixIcon: InkWell(onTap:()async{setState((){_searchvalue="";});},child:Icon(Icons.cancel),),),
                  onChanged: (val){
                    setState((){
                      _searchvalue = val;
                    });
                  },
                ),
                SizedBox(height: 10.0,),
                Expanded(child: CatererListWrapper(searchvalue: _searchvalue,)),
              ],
            ),
          ),
      ),
    );
  }
}