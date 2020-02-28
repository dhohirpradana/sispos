import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/api/api.dart';

class PerekamanPage extends StatefulWidget {
  @override
  _PerekamanPageState createState() => _PerekamanPageState();
}

class _PerekamanPageState extends State<PerekamanPage> {
  @override
  void initState() {
    super.initState();
    getSWData();
    getPref();
    print("Jenis Tanah: $_tanah");
  }

  String idpref, andjwt, nip;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idpref = preferences.getString("id");
      nip = preferences.getString("nip");
      andjwt = preferences.getString("token");
      // token = preferences.getString("token");
    });
    print("id: $idpref,nip: $nip, andjwt: $andjwt");
  }

  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: primaryColor,
        title: Text("PEREKAMAN DATA"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 15, right: 15),
                child: _formInputan()),
            Container(
                margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                child: _submitButton()),
            SizedBox(
              height: 245,
            ),
            Column(
              children: <Widget>[Text("© Babahaha 2020")],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  final _key = new GlobalKey<FormState>();

  final FocusNode _nopAsalFocus = FocusNode();
  final FocusNode _objekNamaJalanFocus = FocusNode();
  final FocusNode _objekBlok = FocusNode();
  final FocusNode _objekKec = FocusNode();
  final FocusNode _objekDesa = FocusNode();
  final FocusNode _objekRw = FocusNode();
  final FocusNode _objekRt = FocusNode();
  final FocusNode _subjekNama = FocusNode();
  final FocusNode _subjekNamaJalan = FocusNode();
  final FocusNode _subjekKab = FocusNode();
  final FocusNode _subjekDesa = FocusNode();
  final FocusNode _subjekRw = FocusNode();
  final FocusNode _subjekRt = FocusNode();
  final FocusNode _subjekKtp = FocusNode();
  final FocusNode _tanahLuas = FocusNode();
  final FocusNode _bangunanLuas = FocusNode();
  final FocusNode _bangunanLantaiJumlah = FocusNode();
  final FocusNode _bangunanTahunBangun = FocusNode();
  final FocusNode _bangunanTahunRenov = FocusNode();
  final FocusNode _bangunanJumlah = FocusNode();
  final FocusNode _bangunanListrikDaya = FocusNode();

  final nopAsalController = TextEditingController();
  final objekNamaJalanController = TextEditingController();
  final objekBlokController = TextEditingController();
  final objekKecController = TextEditingController();
  final objekDesaController = TextEditingController();
  final objekRwController = TextEditingController();
  final objekRtController = TextEditingController();
  final subjekNamaController = TextEditingController();
  final subjekNamaJalanController = TextEditingController();
  final subjekKabController = TextEditingController();
  final subjekDesaController = TextEditingController();
  final subjekRwController = TextEditingController();
  final subjekRtController = TextEditingController();
  final subjekKtpController = TextEditingController();
  final tanahLuasController = TextEditingController();
  final bangunanLuasController = TextEditingController();
  final bangunanLantaiJumlahController = TextEditingController();
  final bangunanTahunBangunController = TextEditingController();
  final bangunanTahunRenovController = TextEditingController();
  final bangunanJumlahController = TextEditingController();
  final bangunanListrikDayaController = TextEditingController();

  String nopAsal;
  String objekNamajalan;
  String objekBlok;
  String objekKec;
  String objekDesa;
  String objekRw;
  String objekRt;
  String subjekNama;
  String subjekNamaJalan;
  String subjekKab;
  String subjekDesa;
  String subjekRw;
  String subjekRt;
  String subjekKtp;
  String tanahLuas;
  String bangunanLuas;
  String bangunanLantaiJumlah;
  String bangunanTahunBangun;
  String bangunanTahunRenov;
  String bangunanJumlah;
  String bangunanListrikDaya;

  int _value = 0;
  int _value1 = 4;
  int _value2 = 1;
  int _value3 = 1;
  int _value4 = 1;
  int _value5 = 2;
  int _value6 = 2;
  int _value7 = 2;
  int _value8 = 3;
  int _value9 = 2;

  int _bangunanke = 0;
  int _kerja = 1;
  int _status = 1;
  int _tanah = 2;
  int _bangunanPenggunaan = 1;
  int _bangunanKondisi = 1;
  int _bangunanKonstruksi = 1;
  int _bangunanAtap = 1;
  int _bangunanDinding = 1;
  int _bangunanLantai = 1;
  int _bangunanLangit = 1;

  int _istanahbangunan = 0;

  void _statusSubjek() {
    setState(() {
      _status = _value + 1;
      print(_status);
    });
  }

  void _kerjaSubjek() {
    setState(() {
      _kerja = _value1 + 1;
      print(_kerja);
    });
  }

  void _jenisTanah() {
    setState(() {
      _tanah = _value2 + 1;
      print(_tanah);
    });
  }

  void _penggunaanBangunan() {
    setState(() {
      _bangunanPenggunaan = _value3 + 1;
      print(_bangunanPenggunaan);
    });
  }

  void _kondisiBangunan() {
    setState(() {
      _bangunanKondisi = _value4 + 1;
      print(_bangunanKondisi);
    });
  }

  void _konstruksiBangunan() {
    setState(() {
      _bangunanKonstruksi = _value5 + 1;
      print(_bangunanKonstruksi);
    });
  }

  void _atapBangunan() {
    setState(() {
      _bangunanAtap = _value6 + 1;
      print(_bangunanAtap);
    });
  }

  void _dindingBangunan() {
    setState(() {
      _bangunanDinding = _value7 + 1;
      print(_bangunanDinding);
    });
  }

  void _lantaiBangunan() {
    setState(() {
      _bangunanLantai = _value8 + 1;
      print(_bangunanLantai);
    });
  }

  void _langitBangunan() {
    setState(() {
      _bangunanLangit = _value9 + 1;
      print(_bangunanLangit);
    });
  }

  void _nopAsalHelp() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(
                Icons.help,
                color: Colors.blue,
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text("PENGISIAN NOP ASAL"),
            ],
          ),
          content: Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    "Kosongkan nop asal apabila objek pajak belum pernah memiliki nop (tidak memiliki nop asal)."),
                SizedBox(
                  height: 15,
                ),
                Text(
                    "Apabila memiliki NOP Asal, Masukan format pengisian xx.xx.xxx.xxx.xxx.xxxx.x (misal. 33.18.010.001.001.0001.0)."),
                SizedBox(
                  height: 15,
                ),
                Text("Lakukan pengisian dengan benar.")
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            //  FlatButton(
            //     child: Text("Close"),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
          ],
        );
      },
    );
  }

  Widget _formInputan() {
    return Form(
        key: _key,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "NOP Asal",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "* Kosongkan Jika",
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                      Text(
                        " TIDAK ADA ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "NOP Asal",
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.help,
                            color: Colors.blue,
                            size: 22,
                          ),
                          onPressed: () {
                            _nopAsalHelp();
                          })
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(24),
                        WhitelistingTextInputFormatter(
                            RegExp("[0123456789\\.]")),
                      ],
                      keyboardType: TextInputType.number,
                      focusNode: _nopAsalFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _nopAsalFocus, _objekNamaJalanFocus);
                      },
                      validator: (e) {
                        if (e.length > 0 && e.length < 24) {
                          return "Masukan 24 karakter NOP";
                        }
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => nopAsal = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: nopAsalController,
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
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              color: secondColor,
              child: Text(
                "DATA OBJEK PAJAK",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Nama Jalan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        BlacklistingTextInputFormatter(
                            RegExp("[/`~!@#%^&=+*()?<>{[}]")),
                      ],
                      keyboardType: TextInputType.text,
                      // validator: (e) {
                      //   if (e.isEmpty) {
                      //     return "Nama jalan wajib diisi";
                      //   }
                      // },
                      focusNode: _objekNamaJalanFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _objekNamaJalanFocus, _objekBlok);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => objekNamajalan = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: objekNamaJalanController,
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
                    "Blok / KAV Nomor",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      keyboardType: TextInputType.text,
                      // validator: (e) {
                      //   if (e.isEmpty) {
                      //     return "Blok / KAV No wajib diisi";
                      //   }
                      // },
                      focusNode: _objekBlok,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _objekBlok, _objekRw);
                        print(objekBlok);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => objekBlok = e.toUpperCase(),
                      onChanged: (e) {
                        if (objekBlokController.text != e.toUpperCase())
                          objekBlokController.value = objekBlokController.value
                              .copyWith(text: e.toUpperCase());
                      },
                      controller: objekBlokController,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Desa",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _DesaOption()
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "RW",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      // validator: (e) {
                      //   if (e.isEmpty) {
                      //     return "RW wajib diisi";
                      //   }
                      // },
                      focusNode: _objekRw,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _objekRw, _objekRt);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => objekRw = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: objekRwController,
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
                    "RT",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      // validator: (e) {
                      //   if (e.isEmpty) {
                      //     return "RT wajib diisi";
                      //   }
                      // },
                      focusNode: _objekRt,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _objekRt, _subjekNama);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => objekRt = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: objekRtController,
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
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              color: secondColor,
              child: Text(
                "DATA SUBJEK PAJAK",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.red[500],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Pemilik",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value == 0,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? 0 : 0;
                            _statusSubjek();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.red[500],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Penyewa",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value == 1,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? 1 : 1;
                            _statusSubjek();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.red[500],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Pengelola",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value == 2,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? 2 : 2;
                            _statusSubjek();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.red[500],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Pemakai",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value == 3,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? 3 : 3;
                            _statusSubjek();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.red[500],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Sengketa",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value == 4,
                        onSelected: (bool selected) {
                          setState(() {
                            _value = selected ? 4 : 4;
                            _statusSubjek();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pekerjaan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.green[600],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "PNS",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value1 == 0,
                        onSelected: (bool selected) {
                          setState(() {
                            _value1 = selected ? 0 : 0;
                            _kerjaSubjek();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.green[600],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "ABRI",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value1 == 1,
                        onSelected: (bool selected) {
                          setState(() {
                            _value1 = selected ? 1 : 1;
                            _kerjaSubjek();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.green[600],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Pensiunan",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value1 == 2,
                        onSelected: (bool selected) {
                          setState(() {
                            _value1 = selected ? 2 : 2;
                            _kerjaSubjek();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.green[600],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Badan",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value1 == 3,
                        onSelected: (bool selected) {
                          setState(() {
                            _value1 = selected ? 3 : 3;
                            _kerjaSubjek();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.green[600],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Lainya",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value1 == 4,
                        onSelected: (bool selected) {
                          setState(() {
                            _value1 = selected ? 4 : 4;
                            _kerjaSubjek();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Nama Subjek Pajak",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                        BlacklistingTextInputFormatter(
                            RegExp("[0123456789/`~!@#%^&-=+*()?<>{[}.,]")),
                      ],
                      keyboardType: TextInputType.text,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Nama subjek pajak wajib diisi";
                        }
                      },
                      focusNode: _subjekNama,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _subjekNama, _subjekNamaJalan);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => subjekNama = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: subjekNamaController,
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
                    "Nama jalan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        BlacklistingTextInputFormatter(
                            RegExp("[/`~!@#%^&=+*()?<>{[}]")),
                      ],
                      keyboardType: TextInputType.text,
                      // validator: (e) {
                      //   if (e.isEmpty) {
                      //     return "Nama jalan wajib diisi";
                      //   }
                      // },
                      focusNode: _subjekNamaJalan,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _subjekNamaJalan, _subjekKab);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => subjekNamaJalan = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: subjekNamaJalanController,
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
                    "Kabupaten",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15),
                        BlacklistingTextInputFormatter(
                            RegExp("[0123456789/`~!@#%^&-=+*()?<>{[}.,]")),
                      ],
                      keyboardType: TextInputType.text,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Kabupaten wajib diisi";
                        }
                      },
                      focusNode: _subjekKab,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _subjekKab, _subjekDesa);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => subjekKab = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: subjekKabController,
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
                    "Desa",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                        BlacklistingTextInputFormatter(
                            RegExp("[0123456789/`~!@#%^&-=+*()?<>{[}.,]")),
                      ],
                      keyboardType: TextInputType.text,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Desa wajib diisi";
                        }
                      },
                      focusNode: _subjekDesa,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _subjekDesa, _subjekRw);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => subjekDesa = e,
                      onChanged: (e) {
                        setState(() {
                          e.toString().toUpperCase();
                          // validationText = "";
                        });
                      },
                      controller: subjekDesaController,
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
                    "RW",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      // validator: (e) {
                      //   if (e.isEmpty) {
                      //     return "RW wajib diisi";
                      //   }
                      // },
                      focusNode: _subjekRw,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _subjekRw, _subjekRt);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => subjekRw = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: subjekRwController,
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
                    "RT",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      // validator: (e) {
                      //   if (e.isEmpty) {
                      //     return "RT wajib diisi";
                      //   }
                      // },
                      focusNode: _subjekRt,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _subjekRt, _subjekKtp);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => subjekRt = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: subjekRtController,
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
                    "No KTP",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "No KTP wajib diisi";
                        } else if (e.length < 16) {
                          return "No KTP wajib diisi 16 digit";
                        }
                      },
                      focusNode: _subjekKtp,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _subjekKtp, _tanahLuas);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => subjekKtp = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: subjekKtpController,
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
              // margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              color: secondColor,
              child: Text(
                "DATA TANAH",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Luas Tanah",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      // validator: (e) {
                      //   if (e.isEmpty) {
                      //     return "No KTP wajib diisi";
                      //   }
                      // },
                      focusNode: _tanahLuas,
                      onFieldSubmitted: (term) {
                        _tanahLuas.unfocus();
                      },
                      textInputAction: TextInputAction.done,
                      onSaved: (e) => tanahLuas = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: tanahLuasController,
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
              padding: EdgeInsets.only(bottom: 19, top: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Jenis Tanah",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12.0,
                    children: <Widget>[
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.purple[500],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Tanah + Bangunan",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value2 == 0,
                        onSelected: (bool selected) {
                          setState(() {
                            _bangunanke = selected ? 1 : _bangunanke;
                            print("bangunan ke : $_bangunanke");
                            _istanahbangunan = 1;
                            _value2 = selected ? 0 : 0;
                            _jenisTanah();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.purple[500],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Kavling",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value2 == 1,
                        onSelected: (bool selected) {
                          setState(() {
                            _bangunanke = selected ? 0 : 0;
                            print("bangunan ke : $_bangunanke");
                            _istanahbangunan = 0;
                            _value2 = selected ? 1 : 1;
                            _jenisTanah();
                          });
                        },
                      ),
                      ChoiceChip(
                        pressElevation: 0.0,
                        selectedColor: Colors.purple[500],
                        backgroundColor: Colors.blue[500],
                        label: Text(
                          "Tanah Kosong",
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: _value2 == 2,
                        onSelected: (bool selected) {
                          setState(() {
                            _bangunanke = selected ? 0 : 0;
                            print("bangunan ke : $_bangunanke");
                            _istanahbangunan = 0;
                            _value2 = selected ? 2 : 2;
                            _jenisTanah();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            (_value2 == 0) ? _rincianBangunan() : SizedBox(),
          ],
        ));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  check() {
    setState(() {});
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      // print("$nip, $pass");
      simpan();
    }
    // }
  }

  simpan() async {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                new Text("Menyimpan data pengajuan"),
              ],
            ),
          ),
        );
      },
    );

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kkmmssEEEdMMM').format(now);
    String uid = idpref;
    final response = await http.post(BaseUrl.rekam, body: {
      "nopasal": nopAsal.toString(),
      "objekjalan": objekNamajalan.toString(),
      "objekblok": objekBlok.toString(),
      "objekdesa": objekDesa.toString(),
      "objekrw": objekRw.toString(),
      "objekrt": objekRt.toString(),
      "subjekstatus": _status.toString(),
      "subjekpekerjaan": _kerja.toString(),
      "subjeknama": subjekNama.toString(),
      "subjeknamajalan": subjekNamaJalan.toString(),
      "subjekkab": subjekKab.toString(),
      "subjekdesa": subjekDesa.toString(),
      "subjekrw": subjekRw.toString(),
      "subjekrt": subjekRt.toString(),
      "subjekktp": subjekKtp.toString(),
      "uid": uid.toString(),
      "uuid": formattedDate.toString(),
      "tanahluas": tanahLuas.toString(),
      "tanahjenis": _value2.toString(),
      "bangunanluas": bangunanLuas.toString(),
      "bangunanbangun": bangunanTahunBangun.toString(),
      "bangunanrenov": bangunanTahunRenov.toString(),
      "bangunanjumlahlantai": bangunanLantaiJumlah.toString(),
      "bangunandaya": bangunanListrikDaya.toString(),
      "bangunanjumlah": bangunanJumlah.toString(),
      "bangunanpenggunaan": _bangunanPenggunaan.toString(),
      "bangunankondisi": _bangunanKondisi.toString(),
      "bangunankonstruksi": _bangunanKonstruksi.toString(),
      "bangunanatap": _bangunanAtap.toString(),
      "bangunandinding": _bangunanDinding.toString(),
      "bangunanlantai": _bangunanLantai.toString(),
      "bangunanlangit": _bangunanLangit.toString(),
      "andjwt": andjwt.toString()
    });
    // print(nopAsal.toString());
    // print(objekNamajalan.toString());
    // print(objekBlok.toString());
    // print(objekKec.toString());
    // print(objekDesa.toString());
    // print(objekRw.toString());
    // print(objekRt.toString());
    // print(_status.toString());
    // print(_kerja.toString());
    // print(subjekNama.toString());
    // print(subjekNamaJalan.toString());
    // print(subjekKab.toString());
    // print(subjekDesa.toString());
    // print(subjekRw.toString());
    // print(subjekRt.toString());
    // print(subjekKtp.toString());
    // print(formattedDate.toString());
    // print(_tanahLuas.toString());

    final data = jsonDecode(response.body);

    new Future.delayed(new Duration(milliseconds: 0), () async {
      int value = data['value'];
      String msg = data['pesan'];
      String tanahapi = data['tanahjenis'];
      print(value);
      print(msg);
      print(tanahapi);
      if (value == 1) {
        Fluttertoast.showToast(
            msg: "Data BERHASIL diunggah",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            // backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
        Navigator.pop(context);
        print("Data BERHASIL diunggah");
      } else if (value == 0) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Data GAGAL diunggah",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            // backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
        print("Data GAGAL diunggah");
      }
    });
  }

  Widget _rincianBangunan() {
    return Column(
      children: <Widget>[
        Container(
          // margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          color: secondColor,
          child: Text(
            "RINCIAN DATA BANGUNAN",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.only(top: 10, bottom: 0, right: 10),
          width: MediaQuery.of(context).size.width,
          // color: secondColor,
          child: Material(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "BANGUNAN KE - $_bangunanke",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 19, top: 10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Jenis Penggunaan Bangunan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 12.0,
                children: <Widget>[
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Perumahan",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 0,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 0 : 0;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Perkantoran Swasta",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 1,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 1 : 1;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Pabrik",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 2,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 2 : 2;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Toko / Apotik / Pasar / Ruko",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 3,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 3 : 3;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Rumah Sakit Klinik",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 4,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 4 : 4;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Olahraga / Rekresi",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 5,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 5 : 5;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Hotel / Wisma",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 6,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 6 : 6;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Bengkel / Gudang / Pertanian",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 7,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 7 : 7;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Gedung Pemerintahan",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 8,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 8 : 8;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Lain-lain",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 9,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 9 : 9;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Bangunan Tak Kena Pajak",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 10,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 10 : 10;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Bangunan Parkir",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 11,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 11 : 11;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Apartemen",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 12,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 12 : 12;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Pompa Mobil",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 13,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 13 : 13;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Tangki Minyak",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 14,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 14 : 14;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: Colors.brown[500],
                    backgroundColor: Colors.blue[500],
                    label: Text(
                      "Gedung Sekolah",
                      style: TextStyle(color: Colors.white),
                    ),
                    selected: _value3 == 15,
                    onSelected: (bool selected) {
                      setState(() {
                        _value3 = selected ? 15 : 15;
                        _penggunaanBangunan();
                      });
                    },
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Luas Bangunan",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        // textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          WhitelistingTextInputFormatter(
                              RegExp("[0123456789\\.]")),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Luas bangunan wajib diisi";
                          }
                        },
                        focusNode: _bangunanLuas,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, _bangunanLuas, _bangunanLantaiJumlah);
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (e) => bangunanLuas = e,
                        onChanged: (e) {
                          setState(() {
                            // validationText = "";
                          });
                        },
                        controller: bangunanLuasController,
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
                      "Jumlah Lantai",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        // textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          WhitelistingTextInputFormatter(
                              RegExp("[0123456789\\.]")),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Jumlah lantai wajib diisi";
                          }
                        },
                        focusNode: _bangunanLantaiJumlah,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _bangunanLantaiJumlah,
                              _bangunanTahunBangun);
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (e) => bangunanLantaiJumlah = e,
                        onChanged: (e) {
                          setState(() {
                            // validationText = "";
                          });
                        },
                        controller: bangunanLantaiJumlahController,
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
                      "Tahun Dibangun",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        // textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          WhitelistingTextInputFormatter(
                              RegExp("[0123456789\\.]")),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Tahun dibangun wajib diisi";
                          }
                        },
                        focusNode: _bangunanTahunBangun,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _bangunanTahunBangun,
                              _bangunanTahunBangun);
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (e) => bangunanTahunBangun = e,
                        onChanged: (e) {
                          setState(() {
                            // validationText = "";
                          });
                        },
                        controller: bangunanTahunBangunController,
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
                      "Tahun Direnovasi",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        // textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          WhitelistingTextInputFormatter(
                              RegExp("[0123456789\\.]")),
                        ],
                        keyboardType: TextInputType.number,
                        // validator: (e) {
                        //   if (e.isEmpty) {
                        //     return "Nama jalan wajib diisi";
                        //   }
                        // },
                        focusNode: _bangunanTahunRenov,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, _bangunanTahunRenov, _bangunanJumlah);
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (e) => bangunanTahunRenov = e,
                        onChanged: (e) {
                          setState(() {
                            // validationText = "";
                          });
                        },
                        controller: bangunanTahunRenovController,
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
                      "Jumlah Bangunan",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        // textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          WhitelistingTextInputFormatter(
                              RegExp("[0123456789\\.]")),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Jumlah bangunan wajib diisi";
                          }
                        },
                        focusNode: _bangunanJumlah,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(
                              context, _bangunanJumlah, _bangunanListrikDaya);
                        },
                        textInputAction: TextInputAction.next,
                        onSaved: (e) => bangunanJumlah = e,
                        onChanged: (e) {
                          setState(() {
                            // validationText = "";
                          });
                        },
                        controller: bangunanJumlahController,
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
                      "Daya Listrik Terpasang (WATT)",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        // textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          WhitelistingTextInputFormatter(
                              RegExp("[0123456789\\.]")),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Daya listrik terpasang wajib diisi";
                          }
                        },
                        focusNode: _bangunanListrikDaya,
                        onFieldSubmitted: (term) {
                          _bangunanListrikDaya.unfocus();
                          // _fieldFocusChange(
                          //     context, _bangunanJumlah, _bangunanListrikDaya);
                        },
                        textInputAction: TextInputAction.done,
                        onSaved: (e) => bangunanListrikDaya = e,
                        onChanged: (e) {
                          setState(() {
                            // validationText = "";
                          });
                        },
                        controller: bangunanListrikDayaController,
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
                padding: EdgeInsets.only(bottom: 19, top: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Kondisi Pada Umumnya",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0,
                      children: <Widget>[
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffc02739),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Sangat Baik",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value4 == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _value4 = selected ? 0 : 0;
                              _kondisiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffc02739),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Baik",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value4 == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _value4 = selected ? 1 : 1;
                              _kondisiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffc02739),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Sedang",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value4 == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              _value4 = selected ? 2 : 2;
                              _kondisiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffc02739),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Jelek",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value4 == 3,
                          onSelected: (bool selected) {
                            setState(() {
                              _value4 = selected ? 3 : 3;
                              _kondisiBangunan();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 19, top: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Konstruksi",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0,
                      children: <Widget>[
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff4d089a),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Baja",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value5 == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _value5 = selected ? 0 : 0;
                              _konstruksiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff4d089a),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Beton",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value5 == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _value5 = selected ? 1 : 1;
                              _konstruksiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff4d089a),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Batu Bata",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value5 == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              _value5 = selected ? 2 : 2;
                              _konstruksiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff4d089a),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Kayu",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value5 == 3,
                          onSelected: (bool selected) {
                            setState(() {
                              _value5 = selected ? 3 : 3;
                              _konstruksiBangunan();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 19, top: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Atap",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0,
                      children: <Widget>[
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff5b8c5a),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Decrabon / Beton / Genteng Glazur",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value6 == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _value6 = selected ? 0 : 0;
                              _atapBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff5b8c5a),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Genteng Beton / Alumunium",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value6 == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _value6 = selected ? 1 : 1;
                              _atapBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff5b8c5a),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Genteng Biasa",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value6 == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              _value6 = selected ? 2 : 2;
                              _atapBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff5b8c5a),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Asbes",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value6 == 3,
                          onSelected: (bool selected) {
                            setState(() {
                              _value6 = selected ? 3 : 3;
                              _atapBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff5b8c5a),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Seng",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value6 == 4,
                          onSelected: (bool selected) {
                            setState(() {
                              _value6 = selected ? 4 : 4;
                              _atapBangunan();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 19, top: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Dinding",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0,
                      children: <Widget>[
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffba6b57),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Kaca / Alumunium",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value7 == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _value7 = selected ? 0 : 0;
                              _dindingBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffba6b57),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Beton",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value7 == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _value7 = selected ? 1 : 1;
                              _dindingBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffba6b57),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Batu Bata / Conblok",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value7 == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              _value7 = selected ? 2 : 2;
                              _dindingBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffba6b57),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Kayu",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value7 == 3,
                          onSelected: (bool selected) {
                            setState(() {
                              _value7 = selected ? 3 : 3;
                              _dindingBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffba6b57),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Seng",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value7 == 4,
                          onSelected: (bool selected) {
                            setState(() {
                              _value7 = selected ? 4 : 4;
                              _dindingBangunan();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 19, top: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Lantai",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0,
                      children: <Widget>[
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff6e5773),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Marmer",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value8 == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _value8 = selected ? 0 : 0;
                              _lantaiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff6e5773),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Keramik",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value8 == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _value8 = selected ? 1 : 1;
                              _lantaiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff6e5773),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Teraso",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value8 == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              _value8 = selected ? 2 : 2;
                              _lantaiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff6e5773),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Ubin PC / Papan",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value8 == 3,
                          onSelected: (bool selected) {
                            setState(() {
                              _value8 = selected ? 3 : 3;
                              _lantaiBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xff6e5773),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Semen",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value8 == 4,
                          onSelected: (bool selected) {
                            setState(() {
                              _value8 = selected ? 4 : 4;
                              _lantaiBangunan();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 19, top: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Langit - Langit",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 12.0,
                      children: <Widget>[
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffc02739),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Akustik / Jati",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value9 == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _value9 = selected ? 0 : 0;
                              _langitBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffc02739),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Triplek / Asbes Bambu",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value9 == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _value9 = selected ? 1 : 1;
                              _langitBangunan();
                            });
                          },
                        ),
                        ChoiceChip(
                          pressElevation: 0.0,
                          selectedColor: Color(0xffc02739),
                          backgroundColor: Colors.blue[500],
                          label: Text(
                            "Tidak Ada",
                            style: TextStyle(color: Colors.white),
                          ),
                          selected: _value9 == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              _value9 = selected ? 2 : 2;
                              _langitBangunan();
                            });
                          },
                        ),
                      ],
                    ),
                    Row(children: <Widget>[
                      _tambahButton(),
                      (_bangunanke > 0) ? _batalTambahButton() : SizedBox(),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tambahButton() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[],
        color: Colors.green[600],
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          splashColor: Colors.green.withOpacity(0.5),
          onTap: () {
            _tanahLuas.requestFocus();
            setState(() {
              _bangunanke = _bangunanke + 1;
              print("tambah : $_bangunanke");
            });
            // check();
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            child: Text(
              'Tambah Bangunan',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  Widget _batalTambahButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[],
        color: Colors.red[500],
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          splashColor: Colors.red.withOpacity(0.5),
          onTap: () {
            _tanahLuas.requestFocus();
            setState(() {
              (_bangunanke > 1)
                  ? _bangunanke = _bangunanke - 1
                  : _bangunanke = 1;
              print("batal : $_bangunanke");
            });
            // check();
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            child: Text(
              'Batal Tambah',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
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
              'SIMPAN',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  List data = List(); //edited line

  Future<String> getSWData() async {
    var res = await http.get(Uri.encodeFull(BaseUrl.desa),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });
    // print(resBody);

    return "Success mendapat data desa di pati";
  }

  Widget _DesaOption() {
    return Material(
      shadowColor: Colors.purple,
      elevation: 9,
      child: Container(
        child: DropdownButton(
          items: data.map((item) {
            return new DropdownMenuItem(
              child: Container(
                  padding: EdgeInsets.all(15), child: Text(item['nama'])),
              value: item['id'].toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              objekDesa = newVal;
              print(objekDesa);
            });
          },
          value: objekDesa,
        ),
      ),
    );
  }
}
