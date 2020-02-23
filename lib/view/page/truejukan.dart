import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TruejukanPage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<TruejukanPage> {
  List data;
  Future<String> getData() async {
    var response = await http.post(
        Uri.encodeFull("http://catbaha.000webhostapp.com/lihat.php"),
        body: {'namaCari': cariData},
        headers: {"Accept": "application/json"});
    print(cariData);
    this.setState(() {
      data = jsonDecode(response.body);
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    getData();
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
    "DATA RUJUKAN",
    style: new TextStyle(color: Colors.white),
  );
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildBar(context),
        body:
            // FutureBuilder(
            //     future: getData(), // your async method that returns a future
            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
            //       if (snapshot.hasData) {
            // return
            Material(
          child: ListView.builder(
            itemCount:
                data == null ? 0 : (data.length >= 51) ? 50 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  splashColor: Colors.blue[300],
                  onDoubleTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 9, right: 9, top: 7, bottom: 7),
                    child: Row(
                      children: <Widget>[
                        Flexible(child: Text(data[index]["nop"])),
                        SizedBox(
                          width: 15,
                        ),
                        Text(data[index]["nama_subjek_pajak"]),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
        // }
        //   return Center(child: CircularProgressIndicator());
        // }),
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
