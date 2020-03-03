import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/view/page/perekaman/perekaman.dart';
import 'package:sispos_pajak/view/page/perekamansaya.dart';
import 'package:sispos_pajak/view/page/truejukan.dart';

class RumahPage extends StatefulWidget {
  final VoidCallback signOut;
  RumahPage(this.signOut);
  @override
  _RumahPageState createState() => _RumahPageState();
}

class _RumahPageState extends State<RumahPage> {
  @override
  void initState() {
    super.initState();
    getPref();
  }

  Color color1 = Color(0xffdaf8e3);
  Color color2 = Color(0xff97ebdb);
  Color color3 = Color(0xff00c2c7);
  Color color4 = Color(0xff0086ad);
  Color color5 = Color(0xff005582);

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String id = "",nip = "", name = "", namanya = "", token = "", level = "", andjwt = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      level = preferences.getString("level");
      nip = preferences.getString("nip");
      name = preferences.getString("name");
      id = preferences.getString("id");
      andjwt = preferences.getString("token");
      // token = preferences.getString("token");
    });
    namanya = name;
    name = (level == "3")
        ? "$namanya(ADMIN)"
        : (level == "2") ? "$namanya(PETUGAS1)" : name = "$namanya(PETUGAS2)";
    print("nama: $name, id: $id, token: $andjwt");
  }

  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  stops: [0.2, 1],
                  colors: [primaryColor, secondColor])),
          child: Stack(
            children: <Widget>[
              Container(
                // Dasar Widget
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          MediaQuery.of(context).size.width / 9),
                      topRight: Radius.circular(
                          MediaQuery.of(context).size.width / 9)),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  MediaQuery.of(context).size.width / 9),
                              topRight: Radius.circular(
                                  MediaQuery.of(context).size.width / 9))),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              // SIP SIP
                              ClipPath(
                                clipper: RoundedDiagonalPathClipper(),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  color: color4.withOpacity(0.02),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 7,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            splashColor:
                                                color3.withOpacity(0.5),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TruejukanPage()),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              color: Colors.transparent,
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Icon(
                                                          Icons.assignment,
                                                          size: 32,
                                                        ),
                                                      ),
                                                      Text(
                                                        "RUJUKAN",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Container(
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 7,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            splashColor:
                                                color3.withOpacity(0.5),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RekamanSayaPage()),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              color: Colors.transparent,
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Icon(
                                                          Icons.open_in_browser,
                                                          size: 32,
                                                        ),
                                                      ),
                                                      Text(
                                                        "PENGAJUAN SAYA",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 7,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            splashColor:
                                                color3.withOpacity(0.5),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PerekamanPage()),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              color: Colors.transparent,
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 32,
                                                        ),
                                                      ),
                                                      Text(
                                                        "PEREKAMAN DATA",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Container(
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 7,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            splashColor:
                                                color3.withOpacity(0.5),
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              color: Colors.transparent,
                                              height: 90,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 32,
                                                        ),
                                                      ),
                                                      Text(
                                                        "PEMUTAKHIRAN",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10),
                                      elevation: 7,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        splashColor: color3.withOpacity(0.5),
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          color: Colors.transparent,
                                          height: 90,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.4,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child: Icon(
                                                      Icons.help_outline,
                                                      size: 32,
                                                    ),
                                                  ),
                                                  Text(
                                                    "PANDUAN",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              // Container Dasar Widget
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height /
                                      7 /
                                      2,
                                  left: 10),
                              width: 35,
                              child: Image(
                                  image: AssetImage(
                                      'lib/view/assets/images/logokabpati.png'))),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 7 / 2,
                                left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "SISPOS PAJAK",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "SISTEM PENDATAAN OBJEK DAN SUBJEK PAJAK",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    // Logout Button
                    padding: EdgeInsets.only(top: 5),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 7 / 2,
                        right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          splashColor: Colors.redAccent,
                          onTap: () {
                            logoutDialog();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.input,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Logout",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text("© Babahaha 2020")),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void logoutDialog() {
    // String deviceid = await DeviceId.getID;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          title: Text("Yakin keluar akun?"),
          // content: Text(deviceid.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Tekan lagi untuk keluar");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
