import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/api/api.dart';
import 'package:sispos_pajak/view/page/pengajuansaya/detail_perekaman.dart';

class PemutakhiranCari extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<PemutakhiranCari> {
  String idpref, nip, andjwt = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idpref = preferences.getString("id");
      nip = preferences.getString("nip");
      andjwt = preferences.getString("token");
    });
    print("id: $idpref, andjwt : $andjwt");
  }

  int spopid;
  List data;
  Future<String> getData() async {
    var response = await http.post(Uri.encodeFull(BaseUrl.rekamsaya), body: {
      'user_id': idpref,
      'nip': nip.toString(),
      'andjwt': andjwt.toString()
    }, headers: {
      "Accept": "application/json"
    });
    this.setState(() {
      data = jsonDecode(response.body);
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    getPref();
    Future.delayed(const Duration(milliseconds: 300), () {
      // getData();
    });
    _IsSearching = false;
    cariData = "";
  }

  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);

  // CARI DATA
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text(
    "PEMUTAKHIRAN DATA",
    style: new TextStyle(color: Colors.white),
  );
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;
  String txtCari;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBar(context),
      body: Container(
        color: Colors.grey.withOpacity(0.2),
        child: Column(
          children: <Widget>[
            cariForm(),
            buttonCari()
            // Expanded(
            //   child: Material(
            //     child: ListView.builder(
            //       itemCount: data == null ? 0 : data.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return Card(
            //           child: InkWell(
            //             splashColor: Colors.blue[300],
            //             onDoubleTap: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => DetailPerekaman(
            //                           id: data[index]["id"],
            //                         )),
            //               );
            //             },
            //             child: Container(
            //               padding: EdgeInsets.only(
            //                   left: 9,
            //                   right: 9,
            //                   top: MediaQuery.of(context).size.width / 21,
            //                   bottom: MediaQuery.of(context).size.width / 21),
            //               child: Row(
            //                 children: <Widget>[
            //                   // Flexible(child: Text(data[index]["id"])),
            //                   Text((index + 1).toString()),
            //                   SizedBox(
            //                     width: 10,
            //                     child: Text("."),
            //                   ),
            //                   Flexible(
            //                       child: Container(
            //                           child: Text(data[index]["updated_at"]))),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Container(child: Text(data[index]["nama"])),
            //                   Text(" ( "),
            //                   Container(child: Text(data[index]["desa"])),
            //                   Text(" ) "),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget buttonCari() {
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context);
      },
      child: Container(
        width: 2 * (MediaQuery.of(context).size.width / 2.3) + 30,
        color: Colors.blue,
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.only(bottom: 15, top: 15),
        child: Center(
          child: Text(
            "CARI",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget cariForm() {
    return Container(
      padding: EdgeInsets.all(11),
      child: TextFormField(
        initialValue: "3318",
        maxLength: 14,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.number,
        validator: (e) {
          if (e.isNotEmpty) {
            if (e.length < 14) {
              return "NOP wajib diisi 14 digit nomor";
            }
          }
        },
        textInputAction: TextInputAction.next,
        onSaved: (e) => txtCari = e,
        obscureText: false,
        decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 3.0),
                borderRadius: BorderRadius.circular(5.0)),
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        "PENGAJUAN SAYA",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  String cariData = "";

  Widget buildBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: primaryColor,
      title: appBarTitle,
    );
  }
}
