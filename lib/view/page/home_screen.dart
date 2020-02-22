import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/view/page/beranda.dart';
import 'package:sispos_pajak/view/page/forum.dart';
import 'package:sispos_pajak/view/page/pengajuan.dart';
import 'package:sispos_pajak/view/page/rujukan.dart';

class HomePage extends StatefulWidget {
  final VoidCallback signOut;
  HomePage(this.signOut);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      // (_currentIndex == 0)
      //     ? Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //             builder: (BuildContext context) => BerandaPage()))
      //     : (_currentIndex == 1)
      //         ? Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (BuildContext context) => RujukanPage()))
      //         : (_currentIndex == 2)
      //             ? Navigator.pushReplacement(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (BuildContext context) => PengajuanPage()))
      //             : Navigator.pushReplacement(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (BuildContext context) => ForumPage()));
      _currentIndex = index;
    });
  }

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
        ? "$namanya(ADMIN)"
        : (level == "2") ? "$namanya(PETUGAS1)" : name = "$namanya(PETUGAS@)";
    print("nama: $name");
  }

  @override
  void initState() {
    super.initState();
    getPref();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() => _visible = false);
      }

      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() => _visible = true);
      }
    });
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

  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);

  ScrollController _scrollController;
  bool _visible = true;

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 3,
          title: Text("Profil Saya"),
          content: Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Text(
                  "NIP : $nip",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Tutup"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: <Widget>[
            // NestedScrollView(
            //   headerSliverBuilder: (context, boxScrolled) => [],
            //   body: ListView(controller: _scrollController, children: <Widget>[
            (_currentIndex == 0)
                ? BerandaPage()
                : (_currentIndex == 1)
                    ? RujukanPage()
                    : (_currentIndex == 2) ? PengajuanPage() : ForumPage(),
            // ]),
            // ),
            Material(
              elevation: 3,
              child: Container(
                color: Color(0xff088da5).withOpacity(0.4),
                height: 70,
                padding: EdgeInsets.only(bottom: 2),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [secondColor, primaryColor])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        // onTap: signOut(),
                        onTap: _showDialog,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(top: 20, right: 15),
                                child: Text(
                                  namanya,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
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
            // BottomNavBar(),
          ],
        ),
      ),
      bottomNavigationBar: !_visible
          ? SizedBox()
          : BottomNavigationBar(
              selectedFontSize: 12,
              unselectedFontSize: 10,
              iconSize: 29,
              unselectedItemColor: Colors.grey,
              selectedItemColor: secondColor,
              elevation: 2,
              backgroundColor: Color(0xffffffff),
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: new Text(
                    'BERANDA',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  title: Text(
                    'RUJUKAN',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.open_in_browser),
                    title: Text(
                      'PENGAJUAN SAYA',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    title: Text(
                      'FORUM',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ))
              ],
            ),
    );
  }
}
