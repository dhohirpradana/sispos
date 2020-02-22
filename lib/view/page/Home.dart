import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RumahPage extends StatefulWidget {
  final VoidCallback signOut;
  RumahPage(this.signOut);
  @override
  _RumahPageState createState() => _RumahPageState();
}

class _RumahPageState extends State<RumahPage> {
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
                    top: MediaQuery.of(context).size.height / 7),
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
                                            onTap: () {},
                                            child: Container(
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
                                            onTap: () {},
                                            child: Container(
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
                                            onTap: () {},
                                            child: Container(
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
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              // Container Dasar Widget
              Container(
                // Logout Button
                padding: EdgeInsets.only(right: 10, top: 5),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 10 / 2),
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
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void logoutDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          title: Text("Yakin keluar akun?"),
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