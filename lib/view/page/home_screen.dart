import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/view/page/dropdown_daerah.dart';
import 'static/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  final VoidCallback signOut;
  HomePage(this.signOut);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String nip = "", name = "", namanya = "", token = "", level = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      level = preferences.getString("level");
      nip = preferences.getString("nip");
      name = preferences.getString("name");
      token = preferences.getString("token");
    });
    namanya = name.toUpperCase();
    name = (level == "3")
        ? "$namanya (admin)"
        : (level == "2") ? "$namanya (petugas1)" : name = "$namanya (petugas2)";
    print("nama: $name");
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  Color bgColor = Colors.grey[200].withOpacity(0.7);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 70, bottom: 50),
                padding: EdgeInsets.only(right: 10),
                color: bgColor,
                child: DropDownDaerah()),
            Material(
              elevation: 5,
              child: Container(
                color: Color(0xff088da5).withOpacity(0.4),
                height: 70,
                padding: EdgeInsets.only(bottom: 3),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xff0e2f44),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        // onTap: signOut(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(top: 20, right: 15),
                                child: Text(
                                  namanya,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
