import 'package:flutter/material.dart';
import 'package:listing/shared/catererlistwithoutsearch.dart';
import 'package:listing/shared/catererlistwithsearch.dart';

class CatererListWrapper extends StatefulWidget {
  String searchvalue;
  CatererListWrapper({required this.searchvalue});
  @override
  _CatererListWrapperState createState() => _CatererListWrapperState();
}

class _CatererListWrapperState extends State<CatererListWrapper> {
  @override
  Widget build(BuildContext context) {
    if(widget.searchvalue.isEmpty){
      return CatererListWithoutSearch();
    }else{
      return CatererListWithSearch(searchvalue:widget.searchvalue);
    }
  }
}
