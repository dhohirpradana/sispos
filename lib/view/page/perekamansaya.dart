import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/api/api.dart';
import 'package:sispos_pajak/view/page/pengajuansaya/detail_perekaman.dart';

class RekamanSayaPage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<RekamanSayaPage> {
  String idpref, nip, andjwt = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idpref = preferences.getString("id");
      nip = preferences.getString("nip");
      andjwt = preferences.getString("token");
      // token = preferences.getString("token");
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
    print("uid : $idpref");
    this.setState(() {
      data = jsonDecode(response.body);
      // spopid = data['id'];
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    getPref();
    Future.delayed(const Duration(milliseconds: 700), () {
      getData();
      setState(() {});
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
    "DATA PEREKAMAN SAYA",
    style: new TextStyle(color: Colors.white),
  );
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildBar(context),
        body: Material(
          child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  splashColor: Colors.blue[300],
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPerekaman(
                                id: data[index]["id"],
                              )),
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 9, right: 9, top: 7, bottom: 7),
                    child: Row(
                      children: <Widget>[
                        // Flexible(child: Text(data[index]["id"])),
                        Text((index + 1).toString()),
                        SizedBox(
                          width: 10,
                          child: Text("."),
                        ),
                        Flexible(
                            child: Container(
                                child: Text(data[index]["updated_at"]))),
                        SizedBox(
                          width: 10,
                        ),
                        Container(child: Text(data[index]["nama"])),
                        Text(" ( "),
                        Container(child: Text(data[index]["desa"])),
                        Text(" ) "),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
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
      // actions: <Widget>[
      //   IconButton(
      //     icon: actionIcon,
      //     onPressed: () {
      //       setState(() {
      //         if (this.actionIcon.icon == Icons.search) {
      //           this.actionIcon = Icon(
      //             Icons.close,
      //             color: Colors.white,
      //           );
      //           this.appBarTitle = TextField(
      //             // inputFormatters: [
      //             //   new BlacklistingTextInputFormatter(
      //             //       new RegExp('[\\.|\\,]')),
      //             // ],
      //             onSubmitted: (v) {
      //               setState(() {
      //                 cariData = v;
      //                 print(cariData);
      //                 getData();
      //               });
      //             },
      //             controller: _searchQuery,
      //             style: TextStyle(
      //               color: Colors.white,
      //             ),
      //             decoration: InputDecoration(
      //                 prefixIcon: Icon(Icons.search, color: Colors.white),
      //                 hintText: "Cari...",
      //                 hintStyle: TextStyle(color: Colors.white)),
      //           );
      //           _handleSearchStart();
      //         } else {
      //           _handleSearchEnd();
      //         }
      //       });
      //     },
      //   ),
      // ]
    );
  }
}
