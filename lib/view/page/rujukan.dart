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

  @override
  void dispose() {
    textCariController.dispose();
    super.dispose();
  }

  final list = new List<RujukanModel>();
  _lihatData() async {
    final response = await http
        .post(BaseUrl.lihat, body: {"namaCari": textCariController.text});
    if (response.contentLength == 2) {
    } else {
      list.clear();
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new RujukanModel(api['nop'], api['nama_subjek_pajak']);
        list.add(ab);
        print(api['nama_subjek_pajak']);
        _listView();
      });
    }
  }

  final _key = new GlobalKey<FormState>();
  TextEditingController textCariController = new TextEditingController();

  ListView _listView() {
    return ListView.builder(
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
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 5),
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
                      padding: EdgeInsets.only(bottom: 10, left: 10, right: 5),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Material(
          color: Colors.white,
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(top: 35, bottom: 10, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "CARI NAMA SUBJEK PAJAK",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                            controller: textCariController,
                            obscureText: false,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      setState(() {
                                        _lihatData();
                                        // _listView();
                                        print(textCariController.text);
                                      });
                                    }),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 3.0),
                                    borderRadius: BorderRadius.circular(5.0)),
                                fillColor: Colors.white,
                                filled: true)),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5),
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
                                "NOMOR OBJEK PAJAK",
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
                Flexible(child: _listView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
