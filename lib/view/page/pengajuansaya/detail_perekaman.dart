import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/api/api.dart';

class DetailPerekaman extends StatefulWidget {
  String id;
  DetailPerekaman({this.id});
  @override
  _DetailPengajuanState createState() => _DetailPengajuanState();
}

class _DetailPengajuanState extends State<DetailPerekaman> {
  Color primaryColor = Color(0xff0e2f44);
  Color secondColor = Color(0xff088da5);

  bool isEnableEdit = false;

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
  final FocusNode _subjekTelp = FocusNode();
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
  final subjekTelpController = TextEditingController();
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
  String subjekTelp;
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

  String idpref, nip, andjwt = "";
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nip = preferences.getString("nip");
      andjwt = preferences.getString("token");
    });
    print("nip: $nip, andjwt : $andjwt");
  }

  String spop_id = "";
  @override
  void initState() {
    super.initState();
    getPref();
    getDesaData();
    String id = widget.id;
    setState(() {
      spop_id = id;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      getData();
    });
    print("id spops : $spop_id");
  }

  String tanahJenis, objekDesaText;
  int dataUp = 0;
  getData() async {
    var response = await http.post(Uri.encodeFull(BaseUrl.rekamdetail), body: {
      'spop_id': spop_id.toString(),
      'nip': nip.toString(),
      'andjwt': andjwt.toString()
    }, headers: {
      "Accept": "application/json"
    });
    final data = jsonDecode(response.body);
    setState(() {
      dataUp = 1;
      nopAsal = data['nop_asal'];
      objekNamajalan = data['objek_nama_jalan'];
      objekBlok = data['objek_blok_kav'];
      objekDesaText = data['objek_desa'];
      objekRw = data['objek_rw'];
      objekRt = data['objek_rt'];

      subjekNama = data['subjek_nama'];
      subjekNamaJalan = data['subjek_nama_jalan'];
      subjekKab = data['subjek_kab'];
      subjekDesa = data['subjek_desa'];
      subjekRw = data['subjek_rw'];
      subjekRt = data['subjek_rt'];
      subjekKtp = data['subjek_ktp'];
      subjekTelp = data['subjek_hp'];

      _value = int.parse(data['subjek_status']) - 1;
      _value1 = int.parse(data['subjek_kerja']) - 1;
      _value2 = int.parse(data['tanah_jenis']) - 1;

      tanahLuas = data['tanah_luas'];

      if (_value2 == 0) {
        bangunanLuas = data['bangunan_luas'];
        bangunanLantaiJumlah = data['bangunan_lj'];
        bangunanTahunBangun = data['bangunan_bangun'];
        bangunanTahunRenov = data['bangunan_renov'];
        bangunanListrikDaya = data['bangunan_listrik'];

        _value3 = int.parse(data['bangunan_penggunaan']) - 1;
        _value4 = int.parse(data['bangunan_kondisi']) - 1;
        _value5 = int.parse(data['bangunan_konstruksi']) - 1;
        _value6 = int.parse(data['bangunan_atap']) - 1;
        _value7 = int.parse(data['bangunan_dinding']) - 1;
        _value8 = int.parse(data['bangunan_lantai']) - 1;
        _value9 = int.parse(data['bangunan_langit']) - 1;
      }

      print("test data : $bangunanLantaiJumlah $bangunanListrikDaya");
    });
    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    if (dataUp == 0) {
      return new Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: primaryColor,
          title: Text("DETAIL PEREKAMAN"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: primaryColor,
            title: Text("DETAIL PEREKAMAN"),
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: <Widget>[
                Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: _formView()),
              ])));
    }
  }

  Widget _formView() {
    return Form(
        child: Column(children: <Widget>[
      _nopAsal(),
      Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        color: secondColor,
        child: Text(
          "DATA OBJEK PAJAK",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      _dataObjekPajakJalan(),
      _dataObjekPajakBlok(),
      _dataObjekPajakDesa(),
      _dataObjekPajakRw(),
      _dataObjekPajakRt(),
      Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        color: secondColor,
        child: Text(
          "DATA SUBJEK PAJAK",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      _subjekStatus(),
      _subjekKerja(),
      _dataSubjekNama(),
      _dataSubjeknamaJalan(),
      _dataSubjekKab(),
      _dataSubjekDesa(),
      _dataSubjekRw(),
      _dataSubjekRt(),
      _dataSubjekKtp(),
      _dataSubjekHp(),
      Container(
        // margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        color: secondColor,
        child: Text(
          "DATA TANAH",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      _dataTanahLuas(),
      _dataTanahJenis(),
      (_value2 == 0) ? _rincianBangunan() : SizedBox(),
      SizedBox(
        height: 5,
      ),
      _button(),
    ]));
  }

  Widget _button() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  isEnableEdit = true;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.3,
                color: Colors.green,
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Center(
                  child: Text(
                    "EDIT",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.3,
                color: Colors.red,
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Center(
                  child: Text(
                    "BATAL",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Container(
            width: 2 * (MediaQuery.of(context).size.width / 2.3) + 30,
            color: Colors.blue,
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.only(bottom: 15, top: 15),
            child: Center(
              child: Text(
                "SIMPAN",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _nopAsal() {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        margin: EdgeInsets.only(top: 5, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "NOP Asal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                initialValue: nopAsal.toString(),
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataObjekPajakJalan() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: objekNamajalan,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  BlacklistingTextInputFormatter(
                      RegExp("[/`~!@#%^&=+*()?<>{[}]")),
                ],
                keyboardType: TextInputType.text,
                focusNode: _objekNamaJalanFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _objekNamaJalanFocus, _objekBlok);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => objekNamajalan = e.toUpperCase(),
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataObjekPajakBlok() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: objekBlok,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
                keyboardType: TextInputType.text,
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
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataObjekPajakDesa() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Desa",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _desaOption()
        ],
      ),
    );
  }

  Widget _dataObjekPajakRw() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: objekRw,
                maxLength: 2,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (e) {
                  if (e.isNotEmpty) {
                    if (e.length < 2) {
                      return "RW wajib diisi 2 digit nomor";
                    }
                  }
                },
                focusNode: _objekRw,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _objekRw, _objekRt);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => objekRw = e.toUpperCase(),
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataObjekPajakRt() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: objekRt,
                maxLength: 3,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (e) {
                  if (e.isNotEmpty) {
                    if (e.length < 3) {
                      return "RT wajib diisi 3 digit nomor";
                    }
                  }
                },
                focusNode: _objekRt,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _objekRt, _subjekNama);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => objekRt = e.toUpperCase(),
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

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

  Widget _subjekStatus() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
    );
  }

  Widget _subjekKerja() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
    );
  }

  Widget _dataSubjekNama() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: subjekNama,
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
                  _fieldFocusChange(context, _subjekNama, _subjekNamaJalan);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => subjekNama = e.toUpperCase(),
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataSubjekKab() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: subjekKab,
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
                onSaved: (e) => subjekKab = e.toUpperCase(),
                onChanged: (e) {
                  if (subjekKabController.text != e.toUpperCase())
                    subjekKabController.value = subjekKabController.value
                        .copyWith(text: e.toUpperCase());
                },
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataSubjeknamaJalan() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: subjekNamaJalan,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  BlacklistingTextInputFormatter(
                      RegExp("[/`~!@#%^&=+*()?<>{[}]")),
                ],
                keyboardType: TextInputType.text,
                focusNode: _subjekNamaJalan,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _subjekNamaJalan, _subjekKab);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => subjekNamaJalan = e.toUpperCase(),
                onChanged: (e) {
                  if (subjekNamaJalanController.text != e.toUpperCase())
                    subjekNamaJalanController.value = subjekNamaJalanController
                        .value
                        .copyWith(text: e.toUpperCase());
                },
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataSubjekDesa() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: subjekDesa,
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
                onSaved: (e) => subjekDesa = e.toUpperCase(),
                onChanged: (e) {
                  if (subjekDesaController.text != e.toUpperCase())
                    subjekDesaController.value = subjekDesaController.value
                        .copyWith(text: e.toUpperCase());
                },
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataSubjekRw() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: subjekRw,
                maxLength: 2,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (e) {
                  if (e.isNotEmpty) {
                    if (e.length < 2) {
                      return "RW wajib diisi 2 digit nomor";
                    }
                  }
                },
                focusNode: _subjekRw,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _subjekRw, _subjekRt);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => subjekRw = e,
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataSubjekRt() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: subjekRt,
                maxLength: 3,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (e) {
                  if (e.isNotEmpty) {
                    if (e.length < 3) {
                      return "RT wajib diisi 3 digit nomor";
                    }
                  }
                },
                focusNode: _subjekRt,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _subjekRt, _subjekKtp);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => subjekRt = e,
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataSubjekKtp() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: subjekKtp,
                maxLength: 16,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
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
                  _fieldFocusChange(context, _subjekKtp, _subjekTelp);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => subjekKtp = e,
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataSubjekHp() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "No HP/ Telp",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                initialValue: subjekTelp,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(20),
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                focusNode: _subjekTelp,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _subjekTelp, _tanahLuas);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => subjekTelp = e,
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataTanahLuas() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                initialValue: tanahLuas,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (e) {
                  if (e.isEmpty) {
                    return "Luas tanah wajib diisi";
                  }
                },
                focusNode: _tanahLuas,
                onFieldSubmitted: (term) {
                  _tanahLuas.unfocus();
                },
                textInputAction: TextInputAction.done,
                onSaved: (e) => tanahLuas = e,
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataTanahJenis() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
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
                      _value2 = 0;
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
                      _value2 = 1;
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
                      _value2 = 2;
                      _jenisTanah();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _rincianBangunan() {
    return Column(
      children: <Widget>[
        Container(
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
                "TAMBAH BANGUNAN - $_bangunanke",
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
              _dataBangunanLuas(),
              _databangunanLantaiJumlah(),
              _dataBangunanBangun(),
              _dataBangunanRenov(),
              _dataBangunanListrik(),
              Text(
                "Jenis Penggunaan Bangunan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              _dataBangunanPenggunaan(),
              _dataBangunanKondisi(),
              _dataBangunanKonstruksi(),
              _dataBangunanAtap(),
              _dataBangunanDinding(),
              _dataBangunanLantai(),
              _dataBangunanLangit()
            ],
          ),
        ),
      ],
    );
  }

  Widget _dataBangunanPenggunaan() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Wrap(
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
    );
  }

  Widget _dataBangunanLuas() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Luas Bangunan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                initialValue: bangunanLuas,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  WhitelistingTextInputFormatter(RegExp("[0123456789\\.\\,]")),
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
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _databangunanLantaiJumlah() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Jumlah Lantai",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                initialValue: bangunanLantaiJumlah,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (e) {
                  if (e.isEmpty) {
                    return "Jumlah lantai wajib diisi";
                  }
                },
                focusNode: _bangunanLantaiJumlah,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(
                      context, _bangunanLantaiJumlah, _bangunanTahunBangun);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => bangunanLantaiJumlah = e,
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataBangunanBangun() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Tahun Dibangun",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                initialValue: bangunanTahunBangun,
                maxLength: 4,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (e) {
                  if (e.isEmpty) {
                    return "Tahun dibangun wajib diisi";
                  }
                },
                focusNode: _bangunanTahunBangun,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(
                      context, _bangunanTahunBangun, _bangunanTahunRenov);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => bangunanTahunBangun = e,
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataBangunanRenov() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Tahun Direnovasi",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                initialValue: bangunanTahunRenov,
                maxLength: 4,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (e) {
                  if (e.isEmpty) {
                    return "Nama jalan wajib diisi";
                  }
                },
                focusNode: _bangunanTahunRenov,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(
                      context, _bangunanTahunRenov, _bangunanListrikDaya);
                },
                textInputAction: TextInputAction.next,
                onSaved: (e) => bangunanTahunRenov = e,
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataBangunanListrik() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Daya Listrik Terpasang (WATT)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                initialValue: bangunanListrikDaya,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                  WhitelistingTextInputFormatter.digitsOnly
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
                },
                textInputAction: TextInputAction.done,
                onSaved: (e) => bangunanListrikDaya = e,
                obscureText: false,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    fillColor: Colors.white,
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _dataBangunanKondisi() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        padding: EdgeInsets.only(bottom: 19, top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Kondisi Pada Umumnya",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
    );
  }

  Widget _dataBangunanKonstruksi() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        padding: EdgeInsets.only(bottom: 19, top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Konstruksi",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
    );
  }

  Widget _dataBangunanAtap() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        padding: EdgeInsets.only(bottom: 19, top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Atap",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
    );
  }

  Widget _dataBangunanDinding() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        padding: EdgeInsets.only(bottom: 19, top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Dinding",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
    );
  }

  Widget _dataBangunanLantai() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        padding: EdgeInsets.only(bottom: 19, top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Lantai",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
    );
  }

  Widget _dataBangunanLangit() {
    return IgnorePointer(
      ignoring: !isEnableEdit,
      child: Container(
        padding: EdgeInsets.only(bottom: 0, top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Langit - Langit",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
          ],
        ),
      ),
    );
  }

  List data = List(); //edited line

  Future<String> getDesaData() async {
    var res = await http.get(Uri.encodeFull(BaseUrl.desa),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });
    return "Success mendapat data desa di pati";
  }

  Widget _desaOption() {
    return Material(
      shadowColor: Colors.purple,
      elevation: 9,
      child: Container(
        child: IgnorePointer(
          ignoring: !isEnableEdit,
          child: DropdownButton(
            hint: Text(
              "  $objekDesaText",
              style: TextStyle(color: Colors.black),
            ),
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
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
