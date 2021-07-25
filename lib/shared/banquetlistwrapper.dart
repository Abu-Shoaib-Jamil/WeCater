import 'package:flutter/material.dart';
import 'package:listing/shared/banquetlistwithoutsearch.dart';
import 'package:listing/shared/banquetlistwithsearch.dart';

class BanquetListWrapper extends StatefulWidget {
  final String searchvalue;
  BanquetListWrapper({required this.searchvalue});
  @override
  _BanquetListWrapperState createState() => _BanquetListWrapperState();
}

class _BanquetListWrapperState extends State<BanquetListWrapper> {
  @override
  Widget build(BuildContext context) {
    if(widget.searchvalue.isEmpty){
      return Expanded(child:BanquetListWithoutSearch());
    }else{
      return Expanded(child: BanquetListWithSearch(searchvalue:widget.searchvalue));
    }
  }
}