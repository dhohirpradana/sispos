import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sispos_pajak/view/page/login.dart';

class BootScreen extends StatefulWidget {
  @override
  _BootScreenState createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen> {
  void _showDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {},
          child: AlertDialog(
            title: Text("Tidak ada koneksi internet"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ulangi"),
                onPressed: () {
                  startTime();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 15,
              ),
              FlatButton(
                child: Text("Tutup"),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 3540);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return new Timer(_duration, navigationPage);
      }
    } on SocketException catch (_) {
      _showDialog();
      print('not connected');
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width / 4.5,
                child: Stack(
                  children: <Widget>[
                    Container(
                        color: Colors.transparent,
                        child: Column(
                          children: <Widget>[
                            Image(
                                image: AssetImage(
                                    'lib/view/assets/images/logokabpati.png')),
                          ],
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "SISPOS PAJAK",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 22,
                    color: Color(0xff0e2f44).withOpacity(0.9),
                    fontWeight: FontWeight.w600),
              ),
            ],
          )),
        ],
      ),
    );
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }
}
