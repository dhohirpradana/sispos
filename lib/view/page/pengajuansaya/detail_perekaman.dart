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

      tanahJenis = data['tanah_jenis'];

      print(subjekRw);
      if (tanahJenis == "1") {
        print(data['bangunan_luas']);
      }
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
