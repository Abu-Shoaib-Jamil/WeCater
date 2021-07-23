import 'package:flutter/material.dart';
import 'package:listing/shared/catererlistwithoutsearch.dart';
import 'package:listing/shared/catererlistwithsearch.dart';

class CatererListWrapper extends StatefulWidget {
  final String searchvalue;
  CatererListWrapper({required this.searchvalue});
  @override
  _CatererListWrapperState createState() => _CatererListWrapperState();
}

class _CatererListWrapperState extends State<CatererListWrapper> {
  @override
  Widget build(BuildContext context) {
    if(widget.searchvalue.isEmpty){
      return Expanded(child: CatererListWithoutSearch());
    }else{
      return Expanded(child: CatererListWithSearch(searchvalue:widget.searchvalue));
    }
  }
}
