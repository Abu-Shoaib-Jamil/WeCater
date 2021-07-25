import 'package:flutter/material.dart';
import 'package:listing/shared/banquetlistwrapper.dart';
import 'package:listing/shared/catererslistwrapper.dart';

class CatererBanquetListWrapper extends StatefulWidget {
  final String? dropdownvalue;
  final String searchvalue;
  CatererBanquetListWrapper({required this.dropdownvalue,required this.searchvalue}); 
  @override
  _CatererBanquetListWrapperState createState() => _CatererBanquetListWrapperState();
}

class _CatererBanquetListWrapperState extends State<CatererBanquetListWrapper> {
  @override
  Widget build(BuildContext context) {
    if(widget.dropdownvalue=="Caterer"){
      return CatererListWrapper(searchvalue: widget.searchvalue);
    }else{
      return BanquetListWrapper(searchvalue: widget.searchvalue);
    }
  }
}