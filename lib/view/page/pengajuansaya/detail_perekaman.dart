import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/api/api.dart';

class DetailPerekaman extends StatefulWidget {
  String id;
  DetailPerekaman({this.id});
  @override
  _DetailPengajuanState createState() => _DetailPengajuanState();
}

class _DetailPengajuanState extends State<DetailPerekaman> {
  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);

  String idpref, nip, andjwt = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nip = preferences.getString("nip");
      andjwt = preferences.getString("token");
    });
    print("nip: $nip, andjwt : $andjwt");
  }

  String spop_id = "";
  @override
  void initState() {
    super.initState();
    getPref();
    String id = widget.id;
    setState(() {
      spop_id = id;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      getData();
    });
    print("id spops : $spop_id");
  }

  String nopasal, objek_nama_jalan;
  int dataUp = 0;
  getData() async {
    var response = await http.post(Uri.encodeFull(BaseUrl.rekamdetail), body: {
      'spop_id': spop_id.toString(),
      'nip': nip.toString(),
      'andjwt': andjwt.toString()
    }, headers: {
      "Accept": "application/json"
    });
    final data = jsonDecode(response.body);
    setState(() {
      dataUp = 1;
      nopasal = data['nop_asal'];
      objek_nama_jalan = data['objek_nama_jalan'];
      print(nopasal);
      print(objek_nama_jalan);
    });
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    if (dataUp == 0) {
      return new Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: primaryColor,
          title: Text("DETAIL PEREKAMAN"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: primaryColor,
            title: Text("DETAIL PEREKAMAN"),
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: <Widget>[
                Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: _formView()),
              ])));
    }
  }

  Widget _formView() {
    return Form(
        child: Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 5, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "NOP Asal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                enabled: false,
                initialValue: nopasal.toString(),
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.grey.withOpacity(0.6),
                    filled: true))
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        color: secondColor,
        child: Text(
          "DATA OBJEK PAJAK",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 5, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Nama Jalan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                enabled: false,
                initialValue: objek_nama_jalan.toString(),
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.grey.withOpacity(0.6),
                    filled: true))
          ],
        ),
      ),
    ]));
  }
}
