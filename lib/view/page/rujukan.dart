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
  String namaCari = "";

  @override
  void initState() {
    super.initState();
    _lihatData();
  }

  final list = new List<RujukanModel>();
  _lihatData() async {
    list.clear();
    final response =
        await http.post(BaseUrl.lihat, body: {"namaCari": namaCari});
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new RujukanModel(api['nop'], api['nama_subjek_pajak']);
        list.add(ab);
      });
    }
  }

  final _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // _lihatData();
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 75, bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "CARI NAMA SUBJEK PAJAK",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _key,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => namaCari = e,
                      obscureText: false,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  final form = _key.currentState;
                                  form.save();
                                  print(namaCari);
                                  _lihatData();
                                });
                              }),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 3.0),
                              borderRadius: BorderRadius.circular(5.0)),
                          fillColor: Colors.white,
                          filled: true)),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "NOP",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "NAMA SUBJEK PAJAK",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  final nop = x.nop;
                  final nama = x.namaSP;

                  return InkWell(
                    onTap: () {},
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom: 10, left: 10, right: 5),
                              child: Text(
                                nop,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom: 10, left: 10, right: 5),
                              child: Text(
                                nama,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
