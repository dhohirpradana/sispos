import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sispos_pajak/api/api.dart';

class PerekamanPage extends StatefulWidget {
  @override
  _PerekamanPageState createState() => _PerekamanPageState();
}

class _PerekamanPageState extends State<PerekamanPage> {
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
      //     ),
      //   ),
      //   // );
      //   //   },
      // ),
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

  int _value = 0;
  int _value1 = 0;
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
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      focusNode: _nopAsalFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _nopAsalFocus, _objekNamaJalanFocus);
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
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [
                        BlacklistingTextInputFormatter(
                            RegExp("[0123456789/`~!@#%^&-=+*()?<>{[}.,]")),
                      ],
                      keyboardType: TextInputType.text,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Nama jalan wajib diisi";
                        }
                      },
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
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Blok / KAV No wajib diisi";
                        }
                      },
                      focusNode: _objekBlok,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _objekBlok, _objekKec);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Kecamatan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      inputFormatters: [
                        BlacklistingTextInputFormatter(
                            RegExp("[0123456789/`~!@#%^&-=+*()?<>{[}.,]")),
                      ],
                      keyboardType: TextInputType.text,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Kecamatan wajib diisi";
                        }
                      },
                      focusNode: _objekKec,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _objekKec, _objekDesa);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => objekKec = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: objekKecController,
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
                      inputFormatters: [
                        BlacklistingTextInputFormatter(
                            RegExp("[0123456789/`~!@#%^&-=+*()?<>{[}.,]")),
                      ],
                      keyboardType: TextInputType.text,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Desa wajib diisi";
                        }
                      },
                      focusNode: _objekDesa,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _objekDesa, _objekRw);
                      },
                      textInputAction: TextInputAction.next,
                      onSaved: (e) => objekDesa = e,
                      onChanged: (e) {
                        setState(() {
                          // validationText = "";
                        });
                      },
                      controller: objekDesaController,
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
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "RW wajib diisi";
                        }
                      },
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
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "RT wajib diisi";
                        }
                      },
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
                      inputFormatters: [
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
                      inputFormatters: [
                        BlacklistingTextInputFormatter(
                            RegExp("[0123456789/`~!@#%^&-=+*()?<>{[}.,]")),
                      ],
                      keyboardType: TextInputType.text,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Nama subjek pajak wajib diisi";
                        }
                      },
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
                      inputFormatters: [
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
                      inputFormatters: [
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
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "RW wajib diisi";
                        }
                      },
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
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "RT wajib diisi";
                        }
                      },
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
                        WhitelistingTextInputFormatter(RegExp("[0123456789]")),
                      ],
                      keyboardType: TextInputType.number,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "No KTP wajib diisi";
                        }
                      },
                      focusNode: _subjekKtp,
                      onFieldSubmitted: (term) {
                        _subjekKtp.unfocus();
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

    final response = await http.post(BaseUrl.rekam, body: {
      "nop": nopAsal,
      "objekjalan": objekNamajalan,
      "objekblok": objekBlok,
      "objekkec": objekKec,
      "objekdesa": objekDesa,
      "objekrw": objekRw,
      "objekrt": objekRt,
      "subjeknama": subjekNama,
      "subjeknamajalan": subjekNamaJalan,
      "subjekkab": subjekKab,
      "subjekdesa": subjekDesa,
      "subjekrw": subjekRw,
      "subjekrt": subjekRt,
      "subjekktp": subjekKtp,
    });

    final data = jsonDecode(response.body);

    new Future.delayed(new Duration(milliseconds: 0), () async {
      int value = data['value'];
      if (value == 1) {
        setState(() {});
        Navigator.pop(context);
        print("Data BERHASIL diunggah");
      } else if (value == 0) {
        Navigator.pop(context);
        setState(() {});
        print("Data GAGAL diunggah");
      }
    });
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
}
