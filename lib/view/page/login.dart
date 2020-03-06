import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/api/api.dart';
import 'package:sispos_pajak/view/page/Home.dart';
import 'package:sispos_pajak/view/widget/bezier_container.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    getPref();
  }

  final FocusNode _nipFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  LoginStatus _loginStatus = LoginStatus.signIn;
  final _key = new GlobalKey<FormState>();

  savePref(int value, String id, String nip, String name, String level,
      String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("id", id);
      preferences.setString("level", level);
      preferences.setString("nip", nip);
      preferences.setString("name", name);
      preferences.setString("token", token);
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(value);
    print(_loginStatus);
    print("id : $id");
    print(name);
    setState(() {
      value = preferences.getInt("value");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    setState(() {
      preference.setInt("value", null);
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  check() {
    setState(() {
      validationText = "";
      internetStatusText = "";
    });
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
    // }
  }

  String id;
  String pass;
  String nip;
  String name;
  String level;
  String token;
  bool _secure = true;

  String validationText = "";
  String internetStatusText = "";

  final nipController = TextEditingController();
  final passController = TextEditingController();

  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);

  showHide() {
    setState(() {
      _secure = !_secure;
    });
  }

  bool _barrierDimissable = false;

  login() async {
    showDialog(
      context: context,
      barrierDismissible: _barrierDimissable,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {},
          child: Dialog(
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    margin: EdgeInsets.all(10),
                    child: CircularProgressIndicator()),
                new Text("Tunggu..."),
              ],
            ),
          ),
        );
      },
    );

    var content = new Utf8Encoder().convert(pass);
    var md5 = crypto.md5;
    var passmd5 = md5.convert(content);
    String md5pass = passmd5.toString();
    print(passmd5);

    final response =
        await http.post(BaseUrl.login, body: {"nip": nip, "pass": md5pass})
        // .timeout(const Duration(seconds: 15))
        ;

    final data = jsonDecode(response.body);

    new Future.delayed(new Duration(milliseconds: 0), () async {
      int value = data['value'];
      String id = data['id'];
      String level = data['level'];
      String nip = data['nip'];
      String name = data['name'];
      String token = data['token'];
      if (value == 1) {
        setState(() {
          savePref(value, id, nip, name, level, token);
          // print("id user : $id");
          // print("andjwt : $token");
          _loginStatus = LoginStatus.signIn;
        });
        Navigator.pop(context);
        validationText = "";
        if (level == "1" || level == "2" || level == "3") {
          print(nip);
          print(name);
          print(level);
          setState(() {
            validationText = "";
            internetStatusText = "";
          });
          var duration = const Duration(seconds: 0);
          return Timer(duration, () {
          });
        } else {}
      } else if (value == 0) {
        Navigator.pop(context);
        setState(() {
          internetStatusText = "";
          validationText = "Email atau password salah";
        });
        print("Email atau password salah");
      }
    });
  }

  Widget _validation() {
    return Row(
      children: <Widget>[
        Container(
          child: Text(validationText,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget _submitButton() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [secondColor, primaryColor])),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          splashColor: Colors.purple.withOpacity(0.5),
          onTap: () {
            check();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            child: Text(
              'MASUK',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'SIS',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: secondColor,
          ),
          children: [
            TextSpan(
              text: 'POS',
              style: TextStyle(color: primaryColor, fontSize: 35),
            ),
            TextSpan(
              text: ' PAJA',
              style: TextStyle(color: secondColor, fontSize: 35),
            ),
            TextSpan(
              text: 'K',
              style: TextStyle(color: primaryColor, fontSize: 35),
            ),
          ]),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "NIP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    inputFormatters: [
                      new BlacklistingTextInputFormatter(
                          new RegExp('[\\.|\\,]')),
                    ],
                    keyboardType: TextInputType.number,
                    validator: (e) {
                      if (e.isEmpty) {
                        return "NIP tidak boleh kosong";
                      }
                    },
                    focusNode: _nipFocus,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(context, _nipFocus, _passFocus);
                    },
                    textInputAction: TextInputAction.next,
                    onSaved: (e) => nip = e,
                    onChanged: (e) {
                      setState(() {
                        validationText = "";
                      });
                    },
                    controller: nipController,
                    obscureText: false,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3.0),
                            borderRadius: BorderRadius.circular(5.0)),
                        fillColor: Colors.white,
                        filled: true))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    enableInteractiveSelection: false,
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Password tidak boleh kosong";
                      }
                    },
                    focusNode: _passFocus,
                    onFieldSubmitted: (value) {
                      _passFocus.unfocus();
                      setState(() {
                        validationText = "";
                        internetStatusText = "";
                      });
                    },
                    textInputAction: TextInputAction.done,
                    onSaved: (e) => pass = e,
                    onChanged: (e) {
                      setState(() {
                        validationText = "";
                      });
                    },
                    controller: passController,
                    obscureText: _secure,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          autofocus: false,
                          onPressed: showHide,
                          icon: Icon(_secure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: _secure ? Colors.green : Colors.red[400],
                        ),
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3.0),
                            borderRadius: BorderRadius.circular(5.0)),
                        fillColor: Colors.white,
                        filled: true))
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return OfflineBuilder(
          debounceDuration: Duration.zero,
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            if (connectivity == ConnectivityResult.none) {
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.7,
                              color: Colors.transparent,
                              child:
                                  Image(image: AssetImage('assets/wifi.png')),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "TIDAK ADA INTERNET",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return child;
          },
          child: Scaffold(
            body: WillPopScope(
              onWillPop: onWillPop,
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.grey[200].withOpacity(0.7),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ClipPath(
                        clipper: RoundedDiagonalPathClipper(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.91,
                          color: Color(0xff45b6fe).withOpacity(0.31),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer()),
                  GestureDetector(
                    onTap: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: SizedBox(),
                          ),
                          _title(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 2 / 3 +
                                  20,
                              child: _emailPasswordWidget()),
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 2 / 3 + 20,
                            child: _validation(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 2 / 3 +
                                  20,
                              child: _submitButton()),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 2 / 3 + 20,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(internetStatusText,
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.red)),
                                ),
                              ],
                            ),
                          ),
                          _divider(),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        // return HomePage(signOut);
        return RumahPage(signOut);
        break;
    }
  }
}
