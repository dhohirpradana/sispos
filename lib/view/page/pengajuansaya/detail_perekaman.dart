import 'package:flutter/material.dart';

class DetailPerekaman extends StatefulWidget {
  String id;
  DetailPerekaman({this.id});
  @override
  _DetailPengajuanState createState() => _DetailPengajuanState();
}

class _DetailPengajuanState extends State<DetailPerekaman> {
  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);

  @override
  void initState() {
    super.initState();
    String id = widget.id;
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: false,
      backgroundColor: primaryColor,
      title: Text("DETAIL PEREKAMAN"),
    ));
  }
}
