import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/api/api.dart';

class RekamanSayaPage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<RekamanSayaPage> {
  String idpref;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idpref = preferences.getString("id");
      // token = preferences.getString("token");
    });
    print("id: $idpref");
  }

  List data;
  Future<String> getData() async {
    var response = await http.post(Uri.encodeFull(BaseUrl.rekamsaya),
        body: {'user_id': idpref}, headers: {"Accept": "application/json"});
    print("uid : $idpref");
    this.setState(() {
      data = jsonDecode(response.body);
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

  @override
  void dispose() {
    super.dispose();
    // _timer.cancel();
  }

  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);

  // CARI DATA
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text(
    "PENGAJUAN SAYA",
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
            itemCount:
                data == null ? 0 : (data.length > 505) ? 500 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  splashColor: Colors.blue[300],
                  // onDoubleTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 9, right: 9, top: 7, bottom: 7),
                    child: Row(
                      children: <Widget>[
                        // Flexible(child: Text(data[index]["id"])),
                        Flexible(
                            child: Container(
                                child: Text(data[index]["updated_at"]))),
                        SizedBox(
                          width: 10,
                        ),
                        Container(child: Text(data[index]["nop_asal"])),
                        SizedBox(
                          width: 5,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {})
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
        "DATA RUJUKAN",
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
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = TextField(
                    // inputFormatters: [
                    //   new BlacklistingTextInputFormatter(
                    //       new RegExp('[\\.|\\,]')),
                    // ],
                    onSubmitted: (v) {
                      setState(() {
                        cariData = v;
                        print(cariData);
                        getData();
                      });
                    },
                    controller: _searchQuery,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        hintText: "Cari...",
                        hintStyle: TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }
}
