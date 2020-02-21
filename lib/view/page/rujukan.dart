import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sispos_pajak/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:sispos_pajak/api/rujukan_model.dart';

class RujukanPage extends StatefulWidget {
  @override
  _RujukanPageState createState() => _RujukanPageState();
}

class _RujukanPageState extends State<RujukanPage> {
  @override
  void initState() {
    super.initState();
    _lihatData();
  }

  final list = new List<RujukanModel>();
  _lihatData() async {
    list.clear();
    final response = await http.get(BaseUrl.lihat);
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new RujukanModel(api['nop'], api['nama_subjek_pajak']);
        print(ab);
        print(api['nop']);
        print(api['nama_subjek_pajak']);
        list.add(ab);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _lihatData();
    return Container(
      color: Color(0xffecf0f1),
      margin: EdgeInsets.only(top: 50),
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, i) {
            final x = list[i];
            final nop = x.nop;
            final nama = x.namaSP;
            return Container(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(nop, style: TextStyle(fontSize: 16),),
                  SizedBox(width: 20,),
                  Text(nama, style: TextStyle(fontSize: 16),),
                ],
              ),
            );
          }),
    );
  }
}
