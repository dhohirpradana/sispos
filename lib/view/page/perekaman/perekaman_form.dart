import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sispos_pajak/api/api.dart';
import 'package:image/image.dart' as Img;
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sispos_pajak/view/page/perekamansaya.dart';

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
    simbang = 0;
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
              children: <Widget>[
                Text(
                  "© Babahaha 2020",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 33,
                  ),
                )
              ],
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
        return AlertDialog(
          elevation: 3,
          title: Row(
            children: <Widget>[
              Icon(
                Icons.help,
                color: Colors.blue[900],
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text("PENGISIAN NOP ASAL"),
            ],
          ),
          content: Container(
            height: MediaQuery.of(context).size.height / 1.5,
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
                Text(
                    "Apabila nop asal yang anda memasukan tidak ditemukan pada database, data anda tidak akan tersimpan. Periksa kembali nop asal yang anda masukan atau anda dapat mengosongkannya."),
                SizedBox(
                  height: 15,
                ),
                Text("Lakukan pengisian dengan benar.")
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Tutup", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _tambahBangunanHelp() {
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
                color: Colors.blue[900],
                size: 25,
              ),
              SizedBox(
                width: 5,
              ),
              Text("TAMBAH BANGUNAN"),
            ],
          ),
          content: Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    "Klik tambah bangunan apabila tanah + bangunan memiliki lebih dari 1 bangunan, Apabila tanah + bangunan hanya memiliki 1 bangunan klik tombol simpan."),
                SizedBox(
                  height: 15,
                ),
                Text(
                    "Ketika anda mengkonfirmasi tambah bangunan, maka data bangunan yang anda inputkan akan tersimpan, kemudian anda dapat input data bangunan berikutnya."),
                SizedBox(
                  height: 15,
                ),
                Text(
                    "Teliti dan pastikan data yang anda inputkan sudah benar sebelum klik tombol tambah bangunan maupun simpan.")
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
        child: Column(children: <Widget>[
          _nopAsal(),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: secondColor,
            child: Text(
              "DATA OBJEK PAJAK",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          _dataObjekNamaJalan(),
          _dataObjekBlok(),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    _desaOption()
                  ],
                ),
              ],
            ),
          ),
          _dataObjekRw(),
          _dataObjekRt(),
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
          _dataSubjekStatus(),
          _dataSubjekKerja(),
          _dataSubjekNama(),
          _dataSubjeknamaJalan(),
          _dataSubjekKab(),
          _dataSubjekDesa(),
          _dataSubjekRw(),
          _dataSubjekRt(),
          _dataSubjekKtp(),
          _dataSubjekHp(),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: secondColor,
            child: Text(
              "UPLOAD FOTO DOKUMEN",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          _dataUploadKtp(),
          _dataUploadSertipikat(),
          _dataUploadSppt(),
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
          _dataTanahLuas(),
          _dataTanahJenis(),
          (_value2 == 0) ? _rincianBangunan() : SizedBox(),
        ]));
  }

  File _imageFile;
  List<File> _imageList = [];
  List<File> _imageList1 = [];
  List<File> _imageList2 = [];
  bool _isUploading = false;
  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pilih sebuah gambar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Kamera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Galeri'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
      _imageList.add(_imageFile);
    });
    // Closes the bottom sheet
    Navigator.pop(context);
  }

  void _openImagePickerModal1(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pilih sebuah gambar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Kamera'),
                  onPressed: () {
                    _getImage1(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Galeri'),
                  onPressed: () {
                    _getImage1(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _getImage1(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
      _imageList1.add(_imageFile);
    });
    // Closes the bottom sheet
    Navigator.pop(context);
  }

  void _openImagePickerModal2(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pilih sebuah gambar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Kamera'),
                  onPressed: () {
                    _getImage2(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Galeri'),
                  onPressed: () {
                    _getImage2(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _getImage2(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
      _imageList2.add(_imageFile);
    });
    // Closes the bottom sheet
    Navigator.pop(context);
  }

  List<Widget> builtImageDisplay() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: _imageList.length == 0
                ? new Image.asset('assets/images/format.jpg')
                : GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    crossAxisCount: 4,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    children: _imageList.map((File file) {
                      return GestureDetector(
                        onTap: () {},
                        child: new GridTile(
                          child: new Image.file(
                            file,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ),
      )
    ];
  }

  Future<Null> _uploadImagesSertipikat() async {
    int i = 0354;
    _imageList.forEach((f) async {
      setState(() {
        _isUploading = true;
      });
      // Find the mime type of the selected file by looking at the header bytes of the file
      final mimeTypeData =
          lookupMimeType(f.path, headerBytes: [0xFF, 0xD8]).split('/');
      // Intilize the multipart request
      final imageUploadRequest =
          http.MultipartRequest('POST', Uri.parse(BaseUrl.rekamfoto));
      // Attach the file in the request
      Timer(Duration(seconds: 1), () async {
        final file = await http.MultipartFile.fromPath('image', f.path,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
        imageUploadRequest.fields['ext'] = mimeTypeData[1];
        imageUploadRequest.fields['i'] = i.toString();
        imageUploadRequest.fields['uid'] = idpref.toString();
        imageUploadRequest.files.add(file);
        try {
          final streamedResponse = await imageUploadRequest.send();
          final response = await http.Response.fromStream(streamedResponse);
          if (response.statusCode != 200) {
            // _uploadImagesSppt();
          }
          final Map<String, dynamic> responseData = json.decode(response.body);
          _resetState();
          return responseData;
        } catch (e) {
          print(e);
          return null;
        }
      });
    });
  }

  Future<Null> _uploadImagesSppt() async {
    int i = 02354;
    _imageList1.forEach((f) async {
      setState(() {
        _isUploading = true;
      });
      // Find the mime type of the selected file by looking at the header bytes of the file
      final mimeTypeData =
          lookupMimeType(f.path, headerBytes: [0xFF, 0xD8]).split('/');
      // Intilize the multipart request
      final imageUploadRequest =
          http.MultipartRequest('POST', Uri.parse(BaseUrl.rekamfoto1));
      // Attach the file in the request
      Timer(Duration(seconds: 1), () async {
        final file = await http.MultipartFile.fromPath('image', f.path,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
        imageUploadRequest.fields['ext'] = mimeTypeData[1];
        imageUploadRequest.fields['i'] = i.toString();
        imageUploadRequest.fields['uid'] = idpref.toString();
        imageUploadRequest.files.add(file);
        try {
          final streamedResponse = await imageUploadRequest.send();
          final response = await http.Response.fromStream(streamedResponse);
          if (response.statusCode != 200) {
            return null;
          }
          final Map<String, dynamic> responseData = json.decode(response.body);
          _resetState();
          return responseData;
        } catch (e) {
          print(e);
          return null;
        }
      });
    });
  }

  Future<Null> _uploadImagesKtp() async {
    int i = 012354;
    _imageList2.forEach((f) async {
      setState(() {
        _isUploading = true;
      });
      // Find the mime type of the selected file by looking at the header bytes of the file
      final mimeTypeData =
          lookupMimeType(f.path, headerBytes: [0xFF, 0xD8]).split('/');
      // Intilize the multipart request
      final imageUploadRequest =
          http.MultipartRequest('POST', Uri.parse(BaseUrl.rekamfoto2));
      // Attach the file in the request
      Timer(Duration(seconds: 1), () async {
        final file = await http.MultipartFile.fromPath('image', f.path,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
        imageUploadRequest.fields['ext'] = mimeTypeData[1];
        imageUploadRequest.fields['i'] = i.toString();
        imageUploadRequest.fields['uid'] = idpref.toString();
        imageUploadRequest.files.add(file);
        try {
          final streamedResponse = await imageUploadRequest.send();
          final response = await http.Response.fromStream(streamedResponse);
          if (response.statusCode != 200) {
            return null;
          }
          final Map<String, dynamic> responseData = json.decode(response.body);
          _resetState();
          return responseData;
        } catch (e) {
          print(e);
          return null;
        }
      });
    });
  }

  void _resetState() {
    setState(() {
      _isUploading = false;
      _imageFile = null;
    });
  }

  File _image;
  Future getImageGallery() async {
    Random rand = new Random();
    int random = rand.nextInt(1000000) + 1000;

    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = random.toString();

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 1000);

    var compressImage = await File("$path/FromGallery_$title.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = imageFile;
      _imageList.add(_image);
    });
  }

  Future getImageCamera() async {
    Random rand = new Random();
    int random = rand.nextInt(1000000) + 1000;

    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = random.toString();

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 1000);

    var compressImage = await File("$path/FromCamera_$title.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = imageFile;
      _imageList.add(_image);
    });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  check() {
    final form = _key.currentState;
    if (simbang == 0) {
      if (form.validate()) {
        form.save();
        simpan();
      } else {
        FocusScope.of(context).requestFocus(_nopAsalFocus);
      }
    } else {
      simpan();
    }
  }

  check1() {
    setState(() {});
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      tambahBangunan();
    } else {
      FocusScope.of(context).requestFocus(_nopAsalFocus);
    }
  }

  int simbang = 0;
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

    if (simbang == 0) {
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
        "subjektelp": subjekTelp.toString(),
        "uid": uid.toString(),
        "uuid": formattedDate.toString(),
        "tanahluas": tanahLuas.toString(),
        "tanahjenis": (_value2 + 1).toString(),
        "nip": nip.toString(),
        "andjwt": andjwt.toString()
      });

      final data = jsonDecode(response.body);

      new Future.delayed(new Duration(milliseconds: 200), () async {
        int value = data['value'];
        int tambang = data['tambang'];
        String msg = data['pesan'];
        print(msg);
        if (value == 1) {
          (_value2 == 0) ? simpanbangunan() : () {};
          _uploadImagesSertipikat();
          _uploadImagesSppt();
          _uploadImagesKtp();

          Timer(Duration(seconds: 2), () {
            Fluttertoast.showToast(
                msg: "BERHASIL UPLOAD DATA",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.green.withOpacity(0.9),
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context);
            Navigator.pop(context);
          });
          print("Data BERHASIL diunggah");
        } else if (value == 0) {
          Timer(Duration(seconds: 2), () {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "GAGAL UPLOAD DATA",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.red.withOpacity(0.9),
                textColor: Colors.white,
                fontSize: 16.0);
            print("Data GAGAL diunggah");
          });
        } else if (value == 2) {
          _nopAsalFocus.requestFocus();
          Timer(Duration(seconds: 2), () {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Data NOP asal tidak ditemukan",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.black.withOpacity(0.5),
                textColor: Colors.white,
                fontSize: 16.0);
            print("Data NOP asal tidak ditemukan");
          });
        } else {
          Timer(Duration(seconds: 2), () {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Data entah kemana",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange.withOpacity(0.5),
                textColor: Colors.white,
                fontSize: 16.0);
            print("Value : $value");
            print("Tambang : $tambang");
          });
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "BERHASIL SIMPAN",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue.withOpacity(0.9),
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }
  }

  tambahBangunan() async {
    (simbang == 0)
        ? showDialog(
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
                      new Text("Sedang upload data bangunan"),
                    ],
                  ),
                ),
              );
            },
          )
        : () {};

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kkmmssEEEdMMM').format(now);
    String uid = idpref;

    if (simbang == 0) {
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
        "subjektelp": subjekTelp.toString(),
        "uid": uid.toString(),
        "uuid": formattedDate.toString(),
        "tanahluas": tanahLuas.toString(),
        "tanahjenis": (_value2 + 1).toString(),
        "nip": nip.toString(),
        "andjwt": andjwt.toString()
      });
      final data = jsonDecode(response.body);

      new Future.delayed(new Duration(milliseconds: 300), () async {
        int value = data['value'];
        int tambang = data['tambang'];
        String msg = data['pesan'];
        print(msg);
        Timer(Duration(seconds: 1), () {
          Navigator.pop(context);
        });
        if (value == 1) {
          setState(() {
            simbang = 1;
          });
          simpanbangunan();
          _uploadImagesSertipikat();
          _uploadImagesSppt();
          _uploadImagesKtp();
          Timer(Duration(seconds: 3), () {
            Fluttertoast.showToast(
                msg: "BERHASIL UPLOAD",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.green.withOpacity(0.9),
                textColor: Colors.white,
                fontSize: 16.0);
            Timer(Duration(seconds: 2), () {
              // Navigator.pop(context);
            });
          });
          print("BERHASIL");
        } else if (value == 0) {
          Timer(Duration(seconds: 2), () {
            Fluttertoast.showToast(
                msg: "GAGAL UPLOAD",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.red.withOpacity(0.9),
                textColor: Colors.white,
                fontSize: 16.0);
            print("Data GAGAL diunggah");
          });
        } else if (value == 2) {
          _nopAsalFocus.requestFocus();
          Timer(Duration(seconds: 2), () {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "NOP ASAL TIDAK DITEMUKAN",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange.withOpacity(0.9),
                textColor: Colors.white,
                fontSize: 16.0);
            print("Data NOP asal tidak ditemukan");
          });
        } else {
          Timer(Duration(seconds: 2), () {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Data entah kemana",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.orange.withOpacity(0.5),
                textColor: Colors.white,
                fontSize: 16.0);
            print("Value : $value");
            print("Tambang : $tambang");
          });
        }
      });
    } else {
      print(simbang);
      simpanbangunan();
    }
  }

  simpanbangunan() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kkmmssEEEdMMM').format(now);
    String uid = idpref;
    final response = await http.post(BaseUrl.rekambangunan, body: {
      "uid": uid.toString(),
      "uuid": formattedDate.toString(),
      "bangunanluas": bangunanLuas.toString(),
      "bangunanbangun": bangunanTahunBangun.toString(),
      "bangunanrenov": bangunanTahunRenov.toString(),
      "bangunanjumlahlantai": bangunanLantaiJumlah.toString(),
      "bangunandaya": bangunanListrikDaya.toString(),
      "bangunanpenggunaan": _bangunanPenggunaan.toString(),
      "bangunankondisi": _bangunanKondisi.toString(),
      "bangunankonstruksi": _bangunanKonstruksi.toString(),
      "bangunanatap": _bangunanAtap.toString(),
      "bangunandinding": _bangunanDinding.toString(),
      "bangunanlantai": _bangunanLantai.toString(),
      "bangunanlangit": _bangunanLangit.toString(),
      "andjwt": andjwt.toString()
    });

    final data = jsonDecode(response.body);
    Future.delayed(new Duration(milliseconds: 0), () async {
      int valbang = data['bangunan'];
      print(valbang);
      if (valbang == 1) {
        Fluttertoast.showToast(
            msg: "BERHASIL TAMBAH DATA BANGUNAN",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.green.withOpacity(0.9),
            textColor: Colors.white,
            fontSize: 16.0);
        bangunanLuasController.clear();
        bangunanLantaiJumlahController.clear();
        bangunanTahunBangunController.clear();
        bangunanTahunRenovController.clear();
        bangunanListrikDayaController.clear();
        FocusScope.of(context).requestFocus(_bangunanLuas);
        setState(() {
          _bangunanke = _bangunanke + 1;
          print("tambah ke => $_bangunanke");
        });
        print("Data Bangunan BERHASIL diunggah");
      } else if (valbang == 0) {
        print("Data Bangunan GAGAL diunggah");
      }
    });
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

  Widget _nopAsal() {
    return Container(
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
              IconButton(
                  icon: Icon(
                    Icons.help,
                    color: Colors.blue[800],
                    size: MediaQuery.of(context).size.width / 16,
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
              initialValue: "33.18.010.",
              inputFormatters: [
                LengthLimitingTextInputFormatter(24),
                WhitelistingTextInputFormatter(RegExp("[0123456789\\.]")),
              ],
              maxLength: 24,
              keyboardType: TextInputType.number,
              focusNode: _nopAsalFocus,
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, _nopAsalFocus, _objekNamaJalanFocus);
              },
              validator: (e) {
                if (e.length > 0 && e.length < 24) {
                  return "Masukan 24 karakter NOP";
                }
              },
              textInputAction: TextInputAction.next,
              onSaved: (e) => nopAsal = e,
              // controller: nopAsalController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataObjekNamaJalan() {
    return Container(
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
                LengthLimitingTextInputFormatter(35),
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
                _fieldFocusChange(context, _objekNamaJalanFocus, _objekBlok);
              },
              textInputAction: TextInputAction.next,
              onSaved: (e) => objekNamajalan = e.toUpperCase(),
              onChanged: (e) {
                if (objekNamaJalanController.text != e.toUpperCase())
                  objekNamaJalanController.value = objekNamaJalanController
                      .value
                      .copyWith(text: e.toUpperCase());
              },
              controller: objekNamaJalanController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataObjekBlok() {
    return Container(
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
                  objekBlokController.value =
                      objekBlokController.value.copyWith(text: e.toUpperCase());
              },
              controller: objekBlokController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataObjekRw() {
    return Container(
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
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataObjekRt() {
    return Container(
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
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataSubjekStatus() {
    return Container(
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
    );
  }

  Widget _dataSubjekKerja() {
    return Container(
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
    );
  }

  Widget _dataSubjekNama() {
    return Container(
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
                _fieldFocusChange(context, _subjekNama, _subjekNamaJalan);
              },
              textInputAction: TextInputAction.next,
              onSaved: (e) => subjekNama = e.toUpperCase(),
              onChanged: (e) {
                if (subjekNamaController.text != e.toUpperCase())
                  subjekNamaController.value = subjekNamaController.value
                      .copyWith(text: e.toUpperCase());
              },
              controller: subjekNamaController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataSubjeknamaJalan() {
    return Container(
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
              controller: subjekNamaJalanController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataSubjekKab() {
    return Container(
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
              onSaved: (e) => subjekKab = e.toUpperCase(),
              onChanged: (e) {
                if (subjekKabController.text != e.toUpperCase())
                  subjekKabController.value =
                      subjekKabController.value.copyWith(text: e.toUpperCase());
              },
              controller: subjekKabController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataSubjekDesa() {
    return Container(
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
              onSaved: (e) => subjekDesa = e.toUpperCase(),
              onChanged: (e) {
                if (subjekDesaController.text != e.toUpperCase())
                  subjekDesaController.value = subjekDesaController.value
                      .copyWith(text: e.toUpperCase());
              },
              controller: subjekDesaController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataSubjekRw() {
    return Container(
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
              controller: subjekRwController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataSubjekRt() {
    return Container(
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
              controller: subjekRtController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataSubjekHp() {
    return Container(
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
              // maxLength: 29,
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
              controller: subjekTelpController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataSubjekKtp() {
    return Container(
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
              controller: subjekKtpController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataTanahLuas() {
    return Container(
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
              controller: tanahLuasController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataTanahJenis() {
    return Container(
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
    );
  }

  Widget _dataBangunanPenggunaan() {
    return Wrap(
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
    );
  }

  Widget _dataBangunanLuas() {
    return Container(
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
              controller: bangunanLuasController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _databangunanLantaiJumlah() {
    return Container(
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
              controller: bangunanLantaiJumlahController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataBangunanBangun() {
    return Container(
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
              controller: bangunanTahunBangunController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataBangunanRenov() {
    return Container(
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
              controller: bangunanTahunRenovController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataBangunanListrik() {
    return Container(
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
              controller: bangunanListrikDayaController,
              obscureText: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 3.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  fillColor: Colors.white,
                  filled: true))
        ],
      ),
    );
  }

  Widget _dataBangunanKondisi() {
    return Container(
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
    );
  }

  Widget _dataBangunanKonstruksi() {
    return Container(
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
    );
  }

  Widget _dataBangunanAtap() {
    return Container(
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
    );
  }

  Widget _dataBangunanDinding() {
    return Container(
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
    );
  }

  Widget _dataBangunanLantai() {
    return Container(
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
    );
  }

  Widget _dataBangunanLangit() {
    return Container(
      padding: EdgeInsets.only(bottom: 19, top: 10),
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
          Row(children: <Widget>[
            _tambahButton(),
            SizedBox(
              width: 15,
            ),
            IconButton(
                icon: Icon(
                  Icons.help,
                  color: Colors.blue[800],
                  size: MediaQuery.of(context).size.width / 16,
                ),
                onPressed: () {
                  _tambahBangunanHelp();
                })
            // (_bangunanke > 0) ? _batalTambahButton() : SizedBox(),
          ]),
        ],
      ),
    );
  }

  Widget _dataUploadSertipikat() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Upload Foto Sertipikat",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 0.0, right: 0.0),
                          child: _imageList.length > 0
                              ? Stack(
                                  children: <Widget>[
                                    Image.file(
                                      _imageList[0],
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.7,
                                      alignment: Alignment.topCenter,
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.delete_forever,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                13,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            _imageList.removeAt(0);
                                          });
                                        })
                                  ],
                                )
                              : OutlineButton(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    height:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                        ),
                                        onPressed: () =>
                                            _openImagePickerModal(context),
                                      ),
                                    ),
                                  ),
                                )),
                      _imageList.length > 0
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0),
                              child: _imageList.length > 1
                                  ? Stack(
                                      children: <Widget>[
                                        Image.file(
                                          _imageList[1],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _imageList.removeAt(1);
                                              });
                                            })
                                      ],
                                    )
                                  : OutlineButton(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            onPressed: () =>
                                                _openImagePickerModal(context),
                                          ),
                                        ),
                                      ),
                                    ))
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _imageList.length > 1
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0),
                              child: _imageList.length > 2
                                  ? Stack(
                                      children: <Widget>[
                                        Image.file(
                                          _imageList[2],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _imageList.removeAt(2);
                                              });
                                            })
                                      ],
                                    )
                                  : OutlineButton(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            onPressed: () =>
                                                _openImagePickerModal(context),
                                          ),
                                        ),
                                      ),
                                    ))
                          : SizedBox(),
                      _imageList.length > 2
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0),
                              child: _imageList.length > 3
                                  ? Stack(
                                      children: <Widget>[
                                        Image.file(
                                          _imageList[3],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _imageList.removeAt(4);
                                              });
                                            })
                                      ],
                                    )
                                  : OutlineButton(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            onPressed: () =>
                                                _openImagePickerModal(context),
                                          ),
                                        ),
                                      ),
                                    ))
                          : SizedBox()
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _dataUploadSppt() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Upload Foto SPPT",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 0.0, right: 0.0),
                          child: _imageList1.length > 0
                              ? Stack(
                                  children: <Widget>[
                                    Image.file(
                                      _imageList1[0],
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.7,
                                      alignment: Alignment.topCenter,
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.delete_forever,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                13,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            _imageList1.removeAt(0);
                                          });
                                        })
                                  ],
                                )
                              : OutlineButton(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    height:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                        ),
                                        onPressed: () =>
                                            _openImagePickerModal1(context),
                                      ),
                                    ),
                                  ),
                                )),
                      _imageList1.length > 0
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0),
                              child: _imageList1.length > 1
                                  ? Stack(
                                      children: <Widget>[
                                        Image.file(
                                          _imageList1[1],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _imageList1.removeAt(1);
                                              });
                                            })
                                      ],
                                    )
                                  : OutlineButton(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            onPressed: () =>
                                                _openImagePickerModal1(context),
                                          ),
                                        ),
                                      ),
                                    ))
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _imageList1.length > 1
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0),
                              child: _imageList1.length > 2
                                  ? Stack(
                                      children: <Widget>[
                                        Image.file(
                                          _imageList1[2],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _imageList1.removeAt(2);
                                              });
                                            })
                                      ],
                                    )
                                  : OutlineButton(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            onPressed: () =>
                                                _openImagePickerModal1(context),
                                          ),
                                        ),
                                      ),
                                    ))
                          : SizedBox(),
                      _imageList1.length > 2
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0),
                              child: _imageList1.length > 3
                                  ? Stack(
                                      children: <Widget>[
                                        Image.file(
                                          _imageList1[3],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _imageList1.removeAt(4);
                                              });
                                            })
                                      ],
                                    )
                                  : OutlineButton(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            onPressed: () =>
                                                _openImagePickerModal1(context),
                                          ),
                                        ),
                                      ),
                                    ))
                          : SizedBox()
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _dataUploadKtp() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Upload Foto KTP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 0.0, right: 0.0),
                          child: _imageList2.length > 0
                              ? Stack(
                                  children: <Widget>[
                                    Image.file(
                                      _imageList2[0],
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.7,
                                      alignment: Alignment.topCenter,
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.delete_forever,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                13,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            _imageList2.removeAt(0);
                                          });
                                        })
                                  ],
                                )
                              : OutlineButton(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.7,
                                    height:
                                        MediaQuery.of(context).size.width / 2.7,
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                        ),
                                        onPressed: () =>
                                            _openImagePickerModal2(context),
                                      ),
                                    ),
                                  ),
                                )),
                      _imageList2.length > 0
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0),
                              child: _imageList2.length > 1
                                  ? Stack(
                                      children: <Widget>[
                                        Image.file(
                                          _imageList2[1],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _imageList2.removeAt(1);
                                              });
                                            })
                                      ],
                                    )
                                  : OutlineButton(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            onPressed: () =>
                                                _openImagePickerModal2(context),
                                          ),
                                        ),
                                      ),
                                    ))
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _imageList2.length > 1
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0),
                              child: _imageList2.length > 2
                                  ? Stack(
                                      children: <Widget>[
                                        Image.file(
                                          _imageList2[2],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _imageList2.removeAt(2);
                                              });
                                            })
                                      ],
                                    )
                                  : OutlineButton(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            onPressed: () =>
                                                _openImagePickerModal2(context),
                                          ),
                                        ),
                                      ),
                                    ))
                          : SizedBox(),
                      _imageList2.length > 2
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 0.0, right: 0.0),
                              child: _imageList2.length > 3
                                  ? Stack(
                                      children: <Widget>[
                                        Image.file(
                                          _imageList2[3],
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          alignment: Alignment.topCenter,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.delete_forever,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    13,
                                                color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                _imageList2.removeAt(4);
                                              });
                                            })
                                      ],
                                    )
                                  : OutlineButton(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.7,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                            ),
                                            onPressed: () =>
                                                _openImagePickerModal2(context),
                                          ),
                                        ),
                                      ),
                                    ))
                          : SizedBox()
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _tambahButton() {
    return Container(
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[],
        color: Colors.green[700],
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          splashColor: Colors.green.withOpacity(0.5),
          onTap: () {
            _bangunanLuas.requestFocus();
            check1();
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 1.40,
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Text(
              'TAMBAH BANGUNAN',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
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
            _bangunanLuas.requestFocus();
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
    return "Success mendapat data desa di pati";
  }

  Widget _desaOption() {
    return Material(
      shadowColor: Colors.purple,
      elevation: 9,
      child: Container(
        child: DropdownButton(
          hint: Text("  Pilih desa                      "),
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
