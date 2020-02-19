import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopBar extends StatefulWidget {
  final VoidCallback signOut;
  TopBar(this.signOut);
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String nip = "", nama = "", namanya = "", token = "", level = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      nip = preferences.getString("nip");
      nama = preferences.getString("nama");
      level = preferences.getString("level");
    });
    nama = (level == "3")
        ? "$namanya (admin)"
        : (level == "2") ? "$namanya (petugas1)" : nama = "$namanya (petugas2)";
    print("nama: $nama");
  }

  bool isLogout = false;

  @override
  void initState() {
    super.initState();
    isLogout = false;
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(25), bottomRight: Radius.circular(10)),
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
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(25),
            //     bottomRight: Radius.circular(10))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: signOut(),
                child: Container(
                    child: Text(
                  "KELUAR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
