import 'package:flutter/material.dart';
import 'package:sispos_pajak/view/page/perekamansaya.dart';

class PengajuanSaya extends StatefulWidget {
  @override
  _DetailPengajuanState createState() => _DetailPengajuanState();
}

class _DetailPengajuanState extends State<PengajuanSaya> {
  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);
  Color color1 = Color(0xffdaf8e3);
  Color color2 = Color(0xff97ebdb);
  Color color3 = Color(0xff00c2c7);
  Color color4 = Color(0xff0086ad);
  Color color5 = Color(0xff005582);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: primaryColor,
        title: Text("PENGAJUAN SAYA"),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 7,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      splashColor: color3.withOpacity(0.5),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RekamanSayaPage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.transparent,
                        height: 90,
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                    Icons.label_important,
                                    size:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                ),
                                Text(
                                  "DATA PEREKAMAN SAYA",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              29,
                                      fontWeight: FontWeight.w500),
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
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Icon(
                                    Icons.label,
                                    size:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                ),
                                Text(
                                  "DATA PEMUTAKHIRAN SAYA",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              29,
                                      fontWeight: FontWeight.w500),
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
      ),
    );
  }
}
