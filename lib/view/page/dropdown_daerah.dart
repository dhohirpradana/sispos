import 'package:flutter/material.dart';

class DropDownDaerah extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDownDaerah> {
  String _pilihkec;
  String _pilihDes;
  String kecTxt;
  List<Map> _kecamatan = [
    {"id": "3318010", "id_kabupaten": "3318", "nama": " Sukolilo"},
    {"id": "3318020", "id_kabupaten": "3318", "nama": " Kayen"},
    {"id": "3318030", "id_kabupaten": "3318", "nama": " Tambakromo"},
    {"id": "3318040", "id_kabupaten": "3318", "nama": " Winong"},
    {"id": "3318050", "id_kabupaten": "3318", "nama": " Pucakwangi"},
    {"id": "3318060", "id_kabupaten": "3318", "nama": " Jaken"},
    {"id": "3318070", "id_kabupaten": "3318", "nama": " Batangan"},
    {"id": "3318080", "id_kabupaten": "3318", "nama": " Juwana"},
    {"id": "3318090", "id_kabupaten": "3318", "nama": " Jakenan"},
    {"id": "3318100", "id_kabupaten": "3318", "nama": " Pati"},
    {"id": "3318110", "id_kabupaten": "3318", "nama": " Gabus"},
    {"id": "3318120", "id_kabupaten": "3318", "nama": " Margorejo"},
    {"id": "3318130", "id_kabupaten": "3318", "nama": " Gembong"},
    {"id": "3318140", "id_kabupaten": "3318", "nama": " Tlogowungu"},
    {"id": "3318150", "id_kabupaten": "3318", "nama": " Wedarijaksa"},
    {"id": "3318160", "id_kabupaten": "3318", "nama": " Trangkil"},
    {"id": "3318170", "id_kabupaten": "3318", "nama": " Margoyoso"},
    {"id": "3318180", "id_kabupaten": "3318", "nama": " Gunung Wungkal"},
    {"id": "3318190", "id_kabupaten": "3318", "nama": " Cluwak"},
    {"id": "3318200", "id_kabupaten": "3318", "nama": " Tayu"},
    {"id": "3318210", "id_kabupaten": "3318", "nama": " Dukuhseti"}
  ];

  List<Map> _sukolilo = [
    {"id": "3318010001", "id_kecamatan": "3318010", "nama": "Pakem"},
    {"id": "3318010002", "id_kecamatan": "3318010", "nama": "Prawoto"},
    {"id": "3318010003", "id_kecamatan": "3318010", "nama": "Wegil"},
    {"id": "3318010004", "id_kecamatan": "3318010", "nama": "Kuwawur"},
    {"id": "3318010005", "id_kecamatan": "3318010", "nama": "Porang Paring"},
    {"id": "3318010006", "id_kecamatan": "3318010", "nama": "Sumbersoko"},
    {"id": "3318010007", "id_kecamatan": "3318010", "nama": "Tompegunung"},
    {"id": "3318010008", "id_kecamatan": "3318010", "nama": "Kedumulyo"},
    {"id": "3318010009", "id_kecamatan": "3318010", "nama": "Gadudero"},
    {"id": "3318010010", "id_kecamatan": "3318010", "nama": "Sukolilo"},
    {"id": "3318010011", "id_kecamatan": "3318010", "nama": "Kedungwinong"},
    {"id": "3318010012", "id_kecamatan": "3318010", "nama": "Baleadi"},
    {"id": "3318010013", "id_kecamatan": "3318010", "nama": "Wotan"},
    {"id": "3318010014", "id_kecamatan": "3318010", "nama": "Baturejo"},
    {"id": "3318010015", "id_kecamatan": "3318010", "nama": "Kasiyan"},
    {"id": "3318010016", "id_kecamatan": "3318010", "nama": "Cengkalsewu"}
  ];

  List<Map> _kayen = [
    {"id": "3318020001", "id_kecamatan": "3318020", "nama": "Jimbaran"},
    {"id": "3318020002", "id_kecamatan": "3318020", "nama": "Durensawit"},
    {"id": "3318020003", "id_kecamatan": "3318020", "nama": "Slungkep"},
    {"id": "3318020004", "id_kecamatan": "3318020", "nama": "Beketel"},
    {"id": "3318020005", "id_kecamatan": "3318020", "nama": "Purwokerto"},
    {"id": "3318020006", "id_kecamatan": "3318020", "nama": "Sumbersari"},
    {"id": "3318020007", "id_kecamatan": "3318020", "nama": "Brati"},
    {"id": "3318020008", "id_kecamatan": "3318020", "nama": "Jatiroto"},
    {"id": "3318020009", "id_kecamatan": "3318020", "nama": "Kayen"},
    {"id": "3318020010", "id_kecamatan": "3318020", "nama": "Trimulyo"},
    {"id": "3318020011", "id_kecamatan": "3318020", "nama": "Srikaton"},
    {"id": "3318020012", "id_kecamatan": "3318020", "nama": "Pasuruhan"},
    {"id": "3318020013", "id_kecamatan": "3318020", "nama": "Pesagi"},
    {"id": "3318020014", "id_kecamatan": "3318020", "nama": "Rogomulyo"},
    {"id": "3318020015", "id_kecamatan": "3318020", "nama": "Talun"},
    {"id": "3318020016", "id_kecamatan": "3318020", "nama": "Boloagung"},
    {"id": "3318020017", "id_kecamatan": "3318020", "nama": "Sundoluhur"}
  ];

  List<Map> _tambakromo = [
    {"id": "3318030001", "id_kecamatan": "3318030", "nama": "Pakis"},
    {"id": "3318030002", "id_kecamatan": "3318030", "nama": "Maitan"},
    {"id": "3318030003", "id_kecamatan": "3318030", "nama": "Wukirsari"},
    {"id": "3318030004", "id_kecamatan": "3318030", "nama": "Sinomwidodo"},
    {"id": "3318030005", "id_kecamatan": "3318030", "nama": "Keben"},
    {"id": "3318030006", "id_kecamatan": "3318030", "nama": "Larangan"},
    {"id": "3318030007", "id_kecamatan": "3318030", "nama": "Tambakromo"},
    {"id": "3318030008", "id_kecamatan": "3318030", "nama": "Mojomulyo"},
    {"id": "3318030009", "id_kecamatan": "3318030", "nama": "Karangawen"},
    {"id": "3318030010", "id_kecamatan": "3318030", "nama": "Mangunrekso"},
    {"id": "3318030011", "id_kecamatan": "3318030", "nama": "Tambaharjo"},
    {"id": "3318030012", "id_kecamatan": "3318030", "nama": "Tambahagung"},
    {"id": "3318030013", "id_kecamatan": "3318030", "nama": "Sitirejo"},
    {"id": "3318030014", "id_kecamatan": "3318030", "nama": "Kedalingan"},
    {"id": "3318030015", "id_kecamatan": "3318030", "nama": "Karangmulyo"},
    {"id": "3318030016", "id_kecamatan": "3318030", "nama": "Karangwono"},
    {"id": "3318030017", "id_kecamatan": "3318030", "nama": "Angkatan Lor"},
    {"id": "3318030018", "id_kecamatan": "3318030", "nama": "Angkatan Kidul"}
  ];

  List<Map> _winong = [
    {"id": "3318040001", "id_kecamatan": "3318040", "nama": "Pohgading"},
    {"id": "3318040002", "id_kecamatan": "3318040", "nama": "Gunungpanti"},
    {"id": "3318040003", "id_kecamatan": "3318040", "nama": "Godo"},
    {"id": "3318040004", "id_kecamatan": "3318040", "nama": "Kropak"},
    {"id": "3318040005", "id_kecamatan": "3318040", "nama": "Karangsumber"},
    {"id": "3318040006", "id_kecamatan": "3318040", "nama": "Guyangan"},
    {"id": "3318040007", "id_kecamatan": "3318040", "nama": "Sugihan"},
    {"id": "3318040008", "id_kecamatan": "3318040", "nama": "Kebolampang"},
    {"id": "3318040009", "id_kecamatan": "3318040", "nama": "Tlogorejo"},
    {"id": "3318040010", "id_kecamatan": "3318040", "nama": "Pagendisan"},
    {"id": "3318040011", "id_kecamatan": "3318040", "nama": "Pekalongan"},
    {"id": "3318040012", "id_kecamatan": "3318040", "nama": "Danyangmulyo"},
    {"id": "3318040013", "id_kecamatan": "3318040", "nama": "Kudur"},
    {"id": "3318040014", "id_kecamatan": "3318040", "nama": "Padangan"},
    {"id": "3318040015", "id_kecamatan": "3318040", "nama": "Blingijati"},
    {"id": "3318040016", "id_kecamatan": "3318040", "nama": "Mintorahayu"},
    {"id": "3318040017", "id_kecamatan": "3318040", "nama": "Kebowan"},
    {"id": "3318040018", "id_kecamatan": "3318040", "nama": "Winong"},
    {"id": "3318040019", "id_kecamatan": "3318040", "nama": "Klecoregonang"},
    {"id": "3318040020", "id_kecamatan": "3318040", "nama": "Bumiharjo"},
    {"id": "3318040021", "id_kecamatan": "3318040", "nama": "Tawangrejo"},
    {"id": "3318040022", "id_kecamatan": "3318040", "nama": "Bringinwareng"},
    {"id": "3318040023", "id_kecamatan": "3318040", "nama": "Sumbermulyo"},
    {"id": "3318040024", "id_kecamatan": "3318040", "nama": "Degan"},
    {"id": "3318040025", "id_kecamatan": "3318040", "nama": "Serutsadang"},
    {"id": "3318040026", "id_kecamatan": "3318040", "nama": "Pulorejo"},
    {"id": "3318040027", "id_kecamatan": "3318040", "nama": "Karangkonang"},
    {"id": "3318040028", "id_kecamatan": "3318040", "nama": "Tanggel"},
    {"id": "3318040029", "id_kecamatan": "3318040", "nama": "Wirun"},
    {"id": "3318040030", "id_kecamatan": "3318040", "nama": "Sarimulyo"}
  ];

  List<Map> _puncakwangi = [
    {"id": "3318050001", "id_kecamatan": "3318050", "nama": "Wateshaji"},
    {"id": "3318050002", "id_kecamatan": "3318050", "nama": "Lumbungmas"},
    {"id": "3318050003", "id_kecamatan": "3318050", "nama": "Mojoagung"},
    {"id": "3318050004", "id_kecamatan": "3318050", "nama": "Sitimulyo"},
    {"id": "3318050005", "id_kecamatan": "3318050", "nama": "Kletek"},
    {"id": "3318050006", "id_kecamatan": "3318050", "nama": "Terteg"},
    {"id": "3318050007", "id_kecamatan": "3318050", "nama": "Mencon"},
    {"id": "3318050008", "id_kecamatan": "3318050", "nama": "Pucakwangi"},
    {"id": "3318050009", "id_kecamatan": "3318050", "nama": "Kepohkencono"},
    {"id": "3318050010", "id_kecamatan": "3318050", "nama": "Karangwotan"},
    {"id": "3318050011", "id_kecamatan": "3318050", "nama": "Bodeh"},
    {"id": "3318050012", "id_kecamatan": "3318050", "nama": "Triguno"},
    {"id": "3318050013", "id_kecamatan": "3318050", "nama": "Tanjungsekar"},
    {"id": "3318050014", "id_kecamatan": "3318050", "nama": "Pelemgede"},
    {"id": "3318050015", "id_kecamatan": "3318050", "nama": "Sokopuluhan"},
    {"id": "3318050016", "id_kecamatan": "3318050", "nama": "Tegalwero"},
    {"id": "3318050017", "id_kecamatan": "3318050", "nama": "Plosorejo"},
    {"id": "3318050018", "id_kecamatan": "3318050", "nama": "Karangrejo"},
    {"id": "3318050019", "id_kecamatan": "3318050", "nama": "Jetak"},
    {"id": "3318050020", "id_kecamatan": "3318050", "nama": "Grogolsari"}
  ];

  List<Map> _jaken = [
    {"id": "3318060001", "id_kecamatan": "3318060", "nama": "Boto"},
    {"id": "3318060002", "id_kecamatan": "3318060", "nama": "Trikoyo"},
    {"id": "3318060003", "id_kecamatan": "3318060", "nama": "Sumberan"},
    {"id": "3318060004", "id_kecamatan": "3318060", "nama": "Mojolampir"},
    {"id": "3318060005", "id_kecamatan": "3318060", "nama": "Mantingan"},
    {"id": "3318060006", "id_kecamatan": "3318060", "nama": "Ronggo"},
    {"id": "3318060007", "id_kecamatan": "3318060", "nama": "Sumberagung"},
    {"id": "3318060008", "id_kecamatan": "3318060", "nama": "Sidoluhur"},
    {"id": "3318060009", "id_kecamatan": "3318060", "nama": "Srikaton"},
    {"id": "3318060010", "id_kecamatan": "3318060", "nama": "Arumanis"},
    {"id": "3318060011", "id_kecamatan": "3318060", "nama": "Tegalarum"},
    {"id": "3318060012", "id_kecamatan": "3318060", "nama": "Sidomukti"},
    {"id": "3318060013", "id_kecamatan": "3318060", "nama": "Mojoluhur"},
    {"id": "3318060014", "id_kecamatan": "3318060", "nama": "Kebonturi"},
    {"id": "3318060015", "id_kecamatan": "3318060", "nama": "Lundo"},
    {"id": "3318060016", "id_kecamatan": "3318060", "nama": "Sukorukun"},
    {"id": "3318060017", "id_kecamatan": "3318060", "nama": "Sumberejo"},
    {"id": "3318060018", "id_kecamatan": "3318060", "nama": "Manjang"},
    {"id": "3318060019", "id_kecamatan": "3318060", "nama": "Tamansari"},
    {"id": "3318060020", "id_kecamatan": "3318060", "nama": "Sumberarum"},
    {"id": "3318060021", "id_kecamatan": "3318060", "nama": "Sriwedari"}
  ];

  List<Map> _batangan = [
    {"id": "3318070001", "id_kecamatan": "3318070", "nama": "Tlogomojo"},
    {"id": "3318070002", "id_kecamatan": "3318070", "nama": "Sukoagung"},
    {"id": "3318070003", "id_kecamatan": "3318070", "nama": "Bulumulyo"},
    {"id": "3318070004", "id_kecamatan": "3318070", "nama": "Tompomulyo"},
    {"id": "3318070005", "id_kecamatan": "3318070", "nama": "Kuniran"},
    {"id": "3318070006", "id_kecamatan": "3318070", "nama": "Gunungsari"},
    {"id": "3318070007", "id_kecamatan": "3318070", "nama": "Kedalon"},
    {"id": "3318070008", "id_kecamatan": "3318070", "nama": "Klayusiwalan"},
    {"id": "3318070009", "id_kecamatan": "3318070", "nama": "Ngening"},
    {"id": "3318070010", "id_kecamatan": "3318070", "nama": "Raci"},
    {"id": "3318070011", "id_kecamatan": "3318070", "nama": "Ketitangwetan"},
    {"id": "3318070012", "id_kecamatan": "3318070", "nama": "Bumimulyo"},
    {"id": "3318070013", "id_kecamatan": "3318070", "nama": "Jembangan"},
    {"id": "3318070014", "id_kecamatan": "3318070", "nama": "Lengkong"},
    {"id": "3318070015", "id_kecamatan": "3318070", "nama": "Mangunlegi"},
    {"id": "3318070016", "id_kecamatan": "3318070", "nama": "Batursari"},
    {"id": "3318070017", "id_kecamatan": "3318070", "nama": "Gajahkumpul"},
    {"id": "3318070018", "id_kecamatan": "3318070", "nama": "Pecangaan"}
  ];

  List<Map> _juwana = [
    {"id": "3318080001", "id_kecamatan": "3318080", "nama": "Sejomulyo"},
    {"id": "3318080002", "id_kecamatan": "3318080", "nama": "Bringin"},
    {"id": "3318080003", "id_kecamatan": "3318080", "nama": "Ketip"},
    {"id": "3318080004", "id_kecamatan": "3318080", "nama": "Pekuwon"},
    {"id": "3318080005", "id_kecamatan": "3318080", "nama": "Karang"},
    {"id": "3318080006", "id_kecamatan": "3318080", "nama": "Karangrejo"},
    {"id": "3318080007", "id_kecamatan": "3318080", "nama": "Bumirejo"},
    {"id": "3318080008", "id_kecamatan": "3318080", "nama": "Kedungpancing"},
    {"id": "3318080009", "id_kecamatan": "3318080", "nama": "Jepuro"},
    {"id": "3318080010", "id_kecamatan": "3318080", "nama": "Tluwah"},
    {"id": "3318080011", "id_kecamatan": "3318080", "nama": "Doropayung"},
    {"id": "3318080012", "id_kecamatan": "3318080", "nama": "Mintomulyo"},
    {"id": "3318080013", "id_kecamatan": "3318080", "nama": "Gadingrejo"},
    {"id": "3318080014", "id_kecamatan": "3318080", "nama": "Margomulyo"},
    {"id": "3318080015", "id_kecamatan": "3318080", "nama": "Langgenharjo"},
    {"id": "3318080016", "id_kecamatan": "3318080", "nama": "Genengmulyo"},
    {"id": "3318080017", "id_kecamatan": "3318080", "nama": "Agungmulyo"},
    {"id": "3318080018", "id_kecamatan": "3318080", "nama": "Bakaran Kulon"},
    {"id": "3318080019", "id_kecamatan": "3318080", "nama": "Bakaran Wetan"},
    {"id": "3318080020", "id_kecamatan": "3318080", "nama": "Dukutalit"},
    {"id": "3318080021", "id_kecamatan": "3318080", "nama": "Growong Kidul"},
    {"id": "3318080022", "id_kecamatan": "3318080", "nama": "Growong Lor"},
    {"id": "3318080023", "id_kecamatan": "3318080", "nama": "Kauman"},
    {"id": "3318080024", "id_kecamatan": "3318080", "nama": "Pajeksan"},
    {"id": "3318080025", "id_kecamatan": "3318080", "nama": "Kudukeras"},
    {"id": "3318080026", "id_kecamatan": "3318080", "nama": "Kebonsawahan"},
    {"id": "3318080027", "id_kecamatan": "3318080", "nama": "Bajomulyo"},
    {"id": "3318080028", "id_kecamatan": "3318080", "nama": "Bendar"},
    {"id": "3318080029", "id_kecamatan": "3318080", "nama": "Trimulyo"}
  ];

  List<Map> _jakenan = [
    {"id": "3318090001", "id_kecamatan": "3318090", "nama": "Kedungmulyo"},
    {"id": "3318090002", "id_kecamatan": "3318090", "nama": "Sendangsoko"},
    {"id": "3318090003", "id_kecamatan": "3318090", "nama": "Tambahmulyo"},
    {"id": "3318090004", "id_kecamatan": "3318090", "nama": "Tondokerto"},
    {"id": "3318090005", "id_kecamatan": "3318090", "nama": "Mantingan Tengah"},
    {"id": "3318090006", "id_kecamatan": "3318090", "nama": "Jatisari"},
    {"id": "3318090007", "id_kecamatan": "3318090", "nama": "Karangrejo Lor"},
    {"id": "3318090008", "id_kecamatan": "3318090", "nama": "Sidomulyo"},
    {"id": "3318090009", "id_kecamatan": "3318090", "nama": "Plosojenar"},
    {"id": "3318090010", "id_kecamatan": "3318090", "nama": "Jakenan"},
    {"id": "3318090011", "id_kecamatan": "3318090", "nama": "Dukuhmulyo"},
    {"id": "3318090012", "id_kecamatan": "3318090", "nama": "Tanjungsari"},
    {"id": "3318090013", "id_kecamatan": "3318090", "nama": "Puluhan Tengah"},
    {"id": "3318090014", "id_kecamatan": "3318090", "nama": "Sembaturagung"},
    {"id": "3318090015", "id_kecamatan": "3318090", "nama": "Glonggong"},
    {"id": "3318090016", "id_kecamatan": "3318090", "nama": "Kalimulyo"},
    {"id": "3318090017", "id_kecamatan": "3318090", "nama": "Tlogorejo"},
    {"id": "3318090018", "id_kecamatan": "3318090", "nama": "Sonorejo"},
    {"id": "3318090019", "id_kecamatan": "3318090", "nama": "Ngastorejo"},
    {"id": "3318090020", "id_kecamatan": "3318090", "nama": "Sidoarum"},
    {"id": "3318090021", "id_kecamatan": "3318090", "nama": "Karangrowo"},
    {"id": "3318090022", "id_kecamatan": "3318090", "nama": "Tondomulyo"},
    {"id": "3318090023", "id_kecamatan": "3318090", "nama": "Bungasrejo"}
  ];

  List<Map> _pati = [
    {"id": "3318100001", "id_kecamatan": "3318100", "nama": "Panjunan"},
    {"id": "3318100002", "id_kecamatan": "3318100", "nama": "Gajahmati"},
    {"id": "3318100003", "id_kecamatan": "3318100", "nama": "Mustokoharjo"},
    {"id": "3318100004", "id_kecamatan": "3318100", "nama": "Semampir"},
    {"id": "3318100005", "id_kecamatan": "3318100", "nama": "Pati Wetan"},
    {"id": "3318100006", "id_kecamatan": "3318100", "nama": "Blaru"},
    {"id": "3318100007", "id_kecamatan": "3318100", "nama": "Pati Kidul"},
    {"id": "3318100008", "id_kecamatan": "3318100", "nama": "Plangitan"},
    {"id": "3318100009", "id_kecamatan": "3318100", "nama": "Puri"},
    {"id": "3318100010", "id_kecamatan": "3318100", "nama": "Winong"},
    {"id": "3318100011", "id_kecamatan": "3318100", "nama": "Ngarus"},
    {"id": "3318100012", "id_kecamatan": "3318100", "nama": "Pati Lor"},
    {"id": "3318100013", "id_kecamatan": "3318100", "nama": "Parenggan"},
    {"id": "3318100014", "id_kecamatan": "3318100", "nama": "Sidoharjo"},
    {"id": "3318100015", "id_kecamatan": "3318100", "nama": "Kalidoro"},
    {"id": "3318100016", "id_kecamatan": "3318100", "nama": "Sarirejo"},
    {"id": "3318100017", "id_kecamatan": "3318100", "nama": "Geritan"},
    {"id": "3318100018", "id_kecamatan": "3318100", "nama": "Dengkek"},
    {"id": "3318100019", "id_kecamatan": "3318100", "nama": "Sugiharjo"},
    {"id": "3318100020", "id_kecamatan": "3318100", "nama": "Widorokandang"},
    {"id": "3318100021", "id_kecamatan": "3318100", "nama": "Payang"},
    {"id": "3318100022", "id_kecamatan": "3318100", "nama": "Kutoharjo"},
    {"id": "3318100023", "id_kecamatan": "3318100", "nama": "Sidokerto"},
    {"id": "3318100024", "id_kecamatan": "3318100", "nama": "Mulyoharjo"},
    {"id": "3318100025", "id_kecamatan": "3318100", "nama": "Tambaharjo"},
    {"id": "3318100026", "id_kecamatan": "3318100", "nama": "Tambahsari"},
    {"id": "3318100027", "id_kecamatan": "3318100", "nama": "Ngepungrojo"},
    {"id": "3318100028", "id_kecamatan": "3318100", "nama": "Purworejo"},
    {"id": "3318100029", "id_kecamatan": "3318100", "nama": "Sinoman"}
  ];

  List<Map> _gabus = [
    {"id": "3318110001", "id_kecamatan": "3318110", "nama": "Wuwur"},
    {"id": "3318110002", "id_kecamatan": "3318110", "nama": "Karaban"},
    {"id": "3318110003", "id_kecamatan": "3318110", "nama": "Tlogoayu"},
    {"id": "3318110004", "id_kecamatan": "3318110", "nama": "Bogotanjung"},
    {"id": "3318110005", "id_kecamatan": "3318110", "nama": "Koryokalangan"},
    {"id": "3318110006", "id_kecamatan": "3318110", "nama": "Gabus"},
    {"id": "3318110007", "id_kecamatan": "3318110", "nama": "Tanjunganom"},
    {"id": "3318110008", "id_kecamatan": "3318110", "nama": "Sunggingwarno"},
    {"id": "3318110009", "id_kecamatan": "3318110", "nama": "Penanggungan"},
    {"id": "3318110010", "id_kecamatan": "3318110", "nama": "Tambahmulyo"},
    {"id": "3318110011", "id_kecamatan": "3318110", "nama": "Sugihrejo"},
    {"id": "3318110012", "id_kecamatan": "3318110", "nama": "Mojolawaran"},
    {"id": "3318110013", "id_kecamatan": "3318110", "nama": "Sambirejo"},
    {"id": "3318110014", "id_kecamatan": "3318110", "nama": "Pantirejo"},
    {"id": "3318110015", "id_kecamatan": "3318110", "nama": "Tanjang"},
    {"id": "3318110016", "id_kecamatan": "3318110", "nama": "Gebang"},
    {"id": "3318110017", "id_kecamatan": "3318110", "nama": "Plumbungan"},
    {"id": "3318110018", "id_kecamatan": "3318110", "nama": "Babalan"},
    {"id": "3318110019", "id_kecamatan": "3318110", "nama": "Koripandriyo"},
    {"id": "3318110020", "id_kecamatan": "3318110", "nama": "Soko"},
    {"id": "3318110021", "id_kecamatan": "3318110", "nama": "Gempolsari"},
    {"id": "3318110022", "id_kecamatan": "3318110", "nama": "Banjarsari"},
    {"id": "3318110023", "id_kecamatan": "3318110", "nama": "Mintobasuki"},
    {"id": "3318110024", "id_kecamatan": "3318110", "nama": "Kosekan"}
  ];

  List<Map> _margorejo = [
    {"id": "3318120001", "id_kecamatan": "3318120", "nama": "Jambean Kidul"},
    {"id": "3318120002", "id_kecamatan": "3318120", "nama": "Wangunrejo"},
    {"id": "3318120003", "id_kecamatan": "3318120", "nama": "Bumirejo"},
    {"id": "3318120004", "id_kecamatan": "3318120", "nama": "Sokokulon"},
    {"id": "3318120005", "id_kecamatan": "3318120", "nama": "Jimbaran"},
    {"id": "3318120006", "id_kecamatan": "3318120", "nama": "Ngawen"},
    {"id": "3318120007", "id_kecamatan": "3318120", "nama": "Margorejo"},
    {"id": "3318120008", "id_kecamatan": "3318120", "nama": "Penambuhan"},
    {"id": "3318120009", "id_kecamatan": "3318120", "nama": "Langenharjo"},
    {"id": "3318120010", "id_kecamatan": "3318120", "nama": "Dadirejo"},
    {"id": "3318120011", "id_kecamatan": "3318120", "nama": "Sukoharjo"},
    {"id": "3318120012", "id_kecamatan": "3318120", "nama": "Badegan"},
    {"id": "3318120013", "id_kecamatan": "3318120", "nama": "Pegandan"},
    {"id": "3318120014", "id_kecamatan": "3318120", "nama": "Sukobubuk"},
    {"id": "3318120015", "id_kecamatan": "3318120", "nama": "Banyuurip"},
    {"id": "3318120016", "id_kecamatan": "3318120", "nama": "Langse"},
    {"id": "3318120017", "id_kecamatan": "3318120", "nama": "Metaraman"},
    {"id": "3318120018", "id_kecamatan": "3318120", "nama": "Muktiharjo"}
  ];

  List<Map> _gembong = [
    {"id": "3318130001", "id_kecamatan": "3318130", "nama": "Bermi"},
    {"id": "3318130002", "id_kecamatan": "3318130", "nama": "Kedungbulus"},
    {"id": "3318130003", "id_kecamatan": "3318130", "nama": "Semirejo"},
    {"id": "3318130004", "id_kecamatan": "3318130", "nama": "Wonosekar"},
    {"id": "3318130005", "id_kecamatan": "3318130", "nama": "Gembong"},
    {"id": "3318130006", "id_kecamatan": "3318130", "nama": "Plukaran"},
    {"id": "3318130007", "id_kecamatan": "3318130", "nama": "Bageng"},
    {"id": "3318130008", "id_kecamatan": "3318130", "nama": "Pohgading"},
    {"id": "3318130009", "id_kecamatan": "3318130", "nama": "Klakah Kasian"},
    {"id": "3318130010", "id_kecamatan": "3318130", "nama": "Ketanggan"},
    {"id": "3318130011", "id_kecamatan": "3318130", "nama": "Sitiluhur"}
  ];

  List<Map> _tlogowungu = [
    {"id": "3318140001", "id_kecamatan": "3318140", "nama": "Tamansari"},
    {"id": "3318140002", "id_kecamatan": "3318140", "nama": "Sambirejo"},
    {"id": "3318140003", "id_kecamatan": "3318140", "nama": "Tlogorejo"},
    {"id": "3318140004", "id_kecamatan": "3318140", "nama": "Purwosari"},
    {"id": "3318140005", "id_kecamatan": "3318140", "nama": "Regaloh"},
    {"id": "3318140006", "id_kecamatan": "3318140", "nama": "Wonorejo"},
    {"id": "3318140007", "id_kecamatan": "3318140", "nama": "Tlogosari"},
    {"id": "3318140008", "id_kecamatan": "3318140", "nama": "Sumbermulyo"},
    {"id": "3318140009", "id_kecamatan": "3318140", "nama": "Guwo"},
    {"id": "3318140010", "id_kecamatan": "3318140", "nama": "Tajungsari"},
    {"id": "3318140011", "id_kecamatan": "3318140", "nama": "Lahar"},
    {"id": "3318140012", "id_kecamatan": "3318140", "nama": "Suwatu"},
    {"id": "3318140013", "id_kecamatan": "3318140", "nama": "Cabak"},
    {"id": "3318140014", "id_kecamatan": "3318140", "nama": "Klumpit"},
    {"id": "3318140015", "id_kecamatan": "3318140", "nama": "Gunungsari"}
  ];

  List<Map> _wedarijaksa = [
    {"id": "3318150001", "id_kecamatan": "3318150", "nama": "Bumiayu"},
    {"id": "3318150002", "id_kecamatan": "3318150", "nama": "Margorejo"},
    {"id": "3318150003", "id_kecamatan": "3318150", "nama": "Sukoharjo"},
    {"id": "3318150004", "id_kecamatan": "3318150", "nama": "Tawangharjo"},
    {"id": "3318150005", "id_kecamatan": "3318150", "nama": "Ngurensiti"},
    {"id": "3318150006", "id_kecamatan": "3318150", "nama": "Bangsalrejo"},
    {"id": "3318150007", "id_kecamatan": "3318150", "nama": "Tluwuk"},
    {"id": "3318150008", "id_kecamatan": "3318150", "nama": "Sidoharjo"},
    {"id": "3318150009", "id_kecamatan": "3318150", "nama": "Ngurenrejo"},
    {"id": "3318150010", "id_kecamatan": "3318150", "nama": "Jontro"},
    {"id": "3318150011", "id_kecamatan": "3318150", "nama": "Panggungroyom"},
    {"id": "3318150012", "id_kecamatan": "3318150", "nama": "Suwaduk"},
    {"id": "3318150013", "id_kecamatan": "3318150", "nama": "Wedarijaksa"},
    {"id": "3318150014", "id_kecamatan": "3318150", "nama": "Pagerharjo"},
    {"id": "3318150015", "id_kecamatan": "3318150", "nama": "Jatimulyo"},
    {"id": "3318150016", "id_kecamatan": "3318150", "nama": "Jetak"},
    {"id": "3318150017", "id_kecamatan": "3318150", "nama": "Kepoh"},
    {"id": "3318150018", "id_kecamatan": "3318150", "nama": "Tlogoharum"}
  ];

  List<Map> _trangkil = [
    {"id": "3318160001", "id_kecamatan": "3318160", "nama": "Pasucen"},
    {"id": "3318160002", "id_kecamatan": "3318160", "nama": "Ketanen"},
    {"id": "3318160003", "id_kecamatan": "3318160", "nama": "Trangkil"},
    {"id": "3318160004", "id_kecamatan": "3318160", "nama": "Kajar"},
    {"id": "3318160005", "id_kecamatan": "3318160", "nama": "Asempapan"},
    {"id": "3318160006", "id_kecamatan": "3318160", "nama": "Sambilawang"},
    {"id": "3318160007", "id_kecamatan": "3318160", "nama": "Guyangan"},
    {"id": "3318160008", "id_kecamatan": "3318160", "nama": "Kertomulyo"},
    {"id": "3318160009", "id_kecamatan": "3318160", "nama": "Tlutup"},
    {"id": "3318160010", "id_kecamatan": "3318160", "nama": "Kadilangu"},
    {"id": "3318160011", "id_kecamatan": "3318160", "nama": "Krandan"},
    {"id": "3318160012", "id_kecamatan": "3318160", "nama": "Rejoagung"},
    {"id": "3318160013", "id_kecamatan": "3318160", "nama": "Karanglegi"},
    {"id": "3318160014", "id_kecamatan": "3318160", "nama": "Karangwage"},
    {"id": "3318160015", "id_kecamatan": "3318160", "nama": "Mojoagung"},
    {"id": "3318160016", "id_kecamatan": "3318160", "nama": "Tegalharjo"}
  ];

  List<Map> _margoyoso = [
    {"id": "3318170001", "id_kecamatan": "3318170", "nama": "Tegalarum"},
    {"id": "3318170002", "id_kecamatan": "3318170", "nama": "Soneyan"},
    {"id": "3318170003", "id_kecamatan": "3318170", "nama": "Tanjungrejo"},
    {"id": "3318170004", "id_kecamatan": "3318170", "nama": "Sidomukti"},
    {"id": "3318170005", "id_kecamatan": "3318170", "nama": "Pohijo"},
    {"id": "3318170006", "id_kecamatan": "3318170", "nama": "Kertomulyo"},
    {"id": "3318170007", "id_kecamatan": "3318170", "nama": "Langgenharjo"},
    {"id": "3318170008", "id_kecamatan": "3318170", "nama": "Pangkalan"},
    {"id": "3318170009", "id_kecamatan": "3318170", "nama": "Bulumanis Kidul"},
    {"id": "3318170010", "id_kecamatan": "3318170", "nama": "Bulumanis Lor"},
    {"id": "3318170011", "id_kecamatan": "3318170", "nama": "Sekarjalak"},
    {"id": "3318170012", "id_kecamatan": "3318170", "nama": "Kajen"},
    {"id": "3318170013", "id_kecamatan": "3318170", "nama": "Ngemplak Kidul"},
    {"id": "3318170014", "id_kecamatan": "3318170", "nama": "Purworejo"},
    {"id": "3318170015", "id_kecamatan": "3318170", "nama": "Purwodadi"},
    {"id": "3318170016", "id_kecamatan": "3318170", "nama": "Ngemplak Lor"},
    {"id": "3318170017", "id_kecamatan": "3318170", "nama": "Waturoyo"},
    {"id": "3318170018", "id_kecamatan": "3318170", "nama": "Cebolek Kidul"},
    {"id": "3318170019", "id_kecamatan": "3318170", "nama": "Tunjungrejo"},
    {"id": "3318170020", "id_kecamatan": "3318170", "nama": "Margoyoso"},
    {"id": "3318170021", "id_kecamatan": "3318170", "nama": "Margotuhu Kidul"},
    {"id": "3318170022", "id_kecamatan": "3318170", "nama": "Semerak"}
  ];

  List<Map> _gunungwungkal = [
    {"id": "3318180001", "id_kecamatan": "3318180", "nama": "Jepalo"},
    {"id": "3318180002", "id_kecamatan": "3318180", "nama": "Sidomulyo"},
    {"id": "3318180003", "id_kecamatan": "3318180", "nama": "Sampok"},
    {"id": "3318180004", "id_kecamatan": "3318180", "nama": "Pesagen"},
    {"id": "3318180005", "id_kecamatan": "3318180", "nama": "Gadu"},
    {"id": "3318180006", "id_kecamatan": "3318180", "nama": "Gajihan"},
    {"id": "3318180007", "id_kecamatan": "3318180", "nama": "Perdopo"},
    {"id": "3318180008", "id_kecamatan": "3318180", "nama": "Gulangpongge"},
    {"id": "3318180009", "id_kecamatan": "3318180", "nama": "Jrahi"},
    {"id": "3318180010", "id_kecamatan": "3318180", "nama": "Giling"},
    {"id": "3318180011", "id_kecamatan": "3318180", "nama": "Bancak"},
    {"id": "3318180012", "id_kecamatan": "3318180", "nama": "Gunungwungkal"},
    {"id": "3318180013", "id_kecamatan": "3318180", "nama": "Jembulwunut"},
    {"id": "3318180014", "id_kecamatan": "3318180", "nama": "Ngetuk"},
    {"id": "3318180015", "id_kecamatan": "3318180", "nama": "Sumberrejo"}
  ];

  List<Map> _cluwak = [
    {"id": "3318190001", "id_kecamatan": "3318190", "nama": "Medani"},
    {"id": "3318190002", "id_kecamatan": "3318190", "nama": "Sentul"},
    {"id": "3318190003", "id_kecamatan": "3318190", "nama": "Plaosan"},
    {"id": "3318190004", "id_kecamatan": "3318190", "nama": "Payak"},
    {"id": "3318190005", "id_kecamatan": "3318190", "nama": "Sirahan"},
    {"id": "3318190006", "id_kecamatan": "3318190", "nama": "Mojo"},
    {"id": "3318190007", "id_kecamatan": "3318190", "nama": "Karangsari"},
    {"id": "3318190008", "id_kecamatan": "3318190", "nama": "Bleber"},
    {"id": "3318190009", "id_kecamatan": "3318190", "nama": "Ngawen"},
    {"id": "3318190010", "id_kecamatan": "3318190", "nama": "Ngablak"},
    {"id": "3318190011", "id_kecamatan": "3318190", "nama": "Gesengan"},
    {"id": "3318190012", "id_kecamatan": "3318190", "nama": "Gerit"},
    {"id": "3318190013", "id_kecamatan": "3318190", "nama": "Sumur"}
  ];

  List<Map> _tayu = [
    {"id": "3318200001", "id_kecamatan": "3318200", "nama": "Pondowan"},
    {"id": "3318200002", "id_kecamatan": "3318200", "nama": "Kedungsari"},
    {"id": "3318200003", "id_kecamatan": "3318200", "nama": "Margomulyo"},
    {"id": "3318200004", "id_kecamatan": "3318200", "nama": "Pakis"},
    {"id": "3318200005", "id_kecamatan": "3318200", "nama": "Sendangrejo"},
    {"id": "3318200006", "id_kecamatan": "3318200", "nama": "Jepat Kidul"},
    {"id": "3318200007", "id_kecamatan": "3318200", "nama": "Tunggulsari"},
    {"id": "3318200008", "id_kecamatan": "3318200", "nama": "Jepat Lor"},
    {"id": "3318200009", "id_kecamatan": "3318200", "nama": "Tendas"},
    {"id": "3318200010", "id_kecamatan": "3318200", "nama": "Keboromo"},
    {"id": "3318200011", "id_kecamatan": "3318200", "nama": "Sambiroto"},
    {"id": "3318200012", "id_kecamatan": "3318200", "nama": "Tayu Wetan"},
    {"id": "3318200013", "id_kecamatan": "3318200", "nama": "Tayu Kulon"},
    {"id": "3318200014", "id_kecamatan": "3318200", "nama": "Pundenrejo"},
    {"id": "3318200015", "id_kecamatan": "3318200", "nama": "Kedungbang"},
    {"id": "3318200016", "id_kecamatan": "3318200", "nama": "Bendokaton Kidul"},
    {"id": "3318200017", "id_kecamatan": "3318200", "nama": "Purwokerto"},
    {"id": "3318200018", "id_kecamatan": "3318200", "nama": "Bulungan"},
    {"id": "3318200019", "id_kecamatan": "3318200", "nama": "Luwang"},
    {"id": "3318200020", "id_kecamatan": "3318200", "nama": "Dororejo"},
    {"id": "3318200021", "id_kecamatan": "3318200", "nama": "Kalikalong"}
  ];

  List<Map> _dukuhseti = [
    {"id": "3318210001", "id_kecamatan": "3318210", "nama": "Wedusan"},
    {"id": "3318210002", "id_kecamatan": "3318210", "nama": "Grogolan"},
    {"id": "3318210003", "id_kecamatan": "3318210", "nama": "Dumpil"},
    {"id": "3318210004", "id_kecamatan": "3318210", "nama": "Bakalan"},
    {"id": "3318210005", "id_kecamatan": "3318210", "nama": "Ngagel"},
    {"id": "3318210006", "id_kecamatan": "3318210", "nama": "Kenanti"},
    {"id": "3318210007", "id_kecamatan": "3318210", "nama": "Alasdowo"},
    {"id": "3318210008", "id_kecamatan": "3318210", "nama": "Banyutowo"},
    {"id": "3318210009", "id_kecamatan": "3318210", "nama": "Dukuhseti"},
    {"id": "3318210010", "id_kecamatan": "3318210", "nama": "Kembang"},
    {"id": "3318210011", "id_kecamatan": "3318210", "nama": "Tegalombo"},
    {"id": "3318210012", "id_kecamatan": "3318210", "nama": "Puncel"}
  ];

  List<Map> _noselect = [
    {"nama": ""}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5, right: 10),
                // padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "KECAMATAN",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      elevation: 2,
                      child: Container(
                      width: MediaQuery.of(context).size.width/2.4,
                        padding: const EdgeInsets.all(3.0),
                        decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                            border: new Border.all(color: Colors.grey)),
                        child: DropdownButton<String>(
                          iconSize: 0.0,
                          isDense: true,
                          hint: new Text(
                            "PILIH KECAMATAN",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          value: _pilihkec,
                          onChanged: (String newValue) {
                            setState(() {
                              _pilihkec = newValue;
                            });

                            print(_pilihkec);
                          },
                          items: _kecamatan.map((Map map) {
                            return DropdownMenuItem<String>(
                              value: map["nama"].toString().toUpperCase(),
                              child: new Text(
                                map["nama"].toString().toUpperCase(),
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "DESA",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width/2.4,
                      padding: const EdgeInsets.all(3.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          border: new Border.all(color: Colors.grey)),
                      child: DropdownButton<String>(
                        iconSize: 0.0,
                          isDense: true,
                          hint: new Text(
                            "PILIH DESA",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          value: _pilihDes,
                          onChanged: (String newValue) {
                            setState(() {
                              _pilihDes = newValue;
                            });

                            print(_pilihDes);
                          },
                          items: (_pilihkec == " SUKOLILO")
                              ? _sukolilo.map((Map map) {
                                  return DropdownMenuItem<String>(
                                    value: map["nama"].toString(),
                                    child: new Text(
                                      map["nama"].toString().toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }).toList()
                              : (_pilihkec == " KAYEN")
                                  ? _kayen.map((Map map) {
                                      return DropdownMenuItem<String>(
                                        value: map["nama"].toString(),
                                        child: new Text(
                                          map["nama"].toString().toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    }).toList()
                                  : (_pilihkec == " TAMBAKROMO")
                                      ? _tambakromo.map((Map map) {
                                          return DropdownMenuItem<String>(
                                            value: map["nama"].toString(),
                                            child: new Text(
                                              map["nama"]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          );
                                        }).toList()
                                      : (_pilihkec == " WINONG")
                                          ? _winong.map((Map map) {
                                              return DropdownMenuItem<String>(
                                                value: map["nama"].toString(),
                                                child: new Text(
                                                  map["nama"]
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              );
                                            }).toList()
                                          : (_pilihkec == " PUCAKWANGI")
                                              ? _puncakwangi.map((Map map) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value:
                                                        map["nama"].toString(),
                                                    child: new Text(
                                                      map["nama"]
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  );
                                                }).toList()
                                              : (_pilihkec == " JAKEN")
                                                  ? _jaken.map((Map map) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: map["nama"]
                                                            .toString(),
                                                        child: new Text(
                                                          map["nama"]
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      );
                                                    }).toList()
                                                  : (_pilihkec == " BATANGAN")
                                                      ? _batangan
                                                          .map((Map map) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: map["nama"]
                                                                .toString(),
                                                            child: new Text(
                                                              map["nama"]
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          );
                                                        }).toList()
                                                      : (_pilihkec == " JUWANA")
                                                          ? _juwana
                                                              .map((Map map) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: map[
                                                                        "nama"]
                                                                    .toString(),
                                                                child: new Text(
                                                                  map["nama"]
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              );
                                                            }).toList()
                                                          : (_pilihkec ==
                                                                  " JAKENAN")
                                                              ? _jakenan.map(
                                                                  (Map map) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: map[
                                                                            "nama"]
                                                                        .toString(),
                                                                    child:
                                                                        new Text(
                                                                      map["nama"]
                                                                          .toString()
                                                                          .toUpperCase(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                  );
                                                                }).toList()
                                                              : (_pilihkec ==
                                                                      " PATI")
                                                                  ? _pati.map(
                                                                      (Map
                                                                          map) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        value: map["nama"]
                                                                            .toString(),
                                                                        child:
                                                                            new Text(
                                                                          map["nama"]
                                                                              .toString()
                                                                              .toUpperCase(),
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      );
                                                                    }).toList()
                                                                  : (_pilihkec ==
                                                                          " GABUS")
                                                                      ? _gabus.map((Map
                                                                          map) {
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                map["nama"].toString(),
                                                                            child:
                                                                                new Text(
                                                                              map["nama"].toString().toUpperCase(),
                                                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                            ),
                                                                          );
                                                                        }).toList()
                                                                      : (_pilihkec ==
                                                                              " MARGOREJO")
                                                                          ? _margorejo.map((Map
                                                                              map) {
                                                                              return DropdownMenuItem<String>(
                                                                                value: map["nama"].toString(),
                                                                                child: new Text(
                                                                                  map["nama"].toString().toUpperCase(),
                                                                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                ),
                                                                              );
                                                                            }).toList()
                                                                          : (_pilihkec == " GEMBONG")
                                                                              ? _gembong.map((Map map) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: map["nama"].toString(),
                                                                                    child: new Text(
                                                                                      map["nama"].toString().toUpperCase(),
                                                                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  );
                                                                                }).toList()
                                                                              : (_pilihkec == " TLOGOWUNGU")
                                                                                  ? _tlogowungu.map((Map map) {
                                                                                      return DropdownMenuItem<String>(
                                                                                        value: map["nama"].toString(),
                                                                                        child: new Text(
                                                                                          map["nama"].toString().toUpperCase(),
                                                                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                        ),
                                                                                      );
                                                                                    }).toList()
                                                                                  : (_pilihkec == " WEDARIJAKSA")
                                                                                      ? _wedarijaksa.map((Map map) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: map["nama"].toString(),
                                                                                            child: new Text(
                                                                                              map["nama"].toString().toUpperCase(),
                                                                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                            ),
                                                                                          );
                                                                                        }).toList()
                                                                                      : (_pilihkec == " TRANGKIL")
                                                                                          ? _trangkil.map((Map map) {
                                                                                              return DropdownMenuItem<String>(
                                                                                                value: map["nama"].toString(),
                                                                                                child: new Text(
                                                                                                  map["nama"].toString().toUpperCase(),
                                                                                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              );
                                                                                            }).toList()
                                                                                          : (_pilihkec == " MARGOYOSO")
                                                                                              ? _margoyoso.map((Map map) {
                                                                                                  return DropdownMenuItem<String>(
                                                                                                    value: map["nama"].toString(),
                                                                                                    child: new Text(
                                                                                                      map["nama"].toString().toUpperCase(),
                                                                                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  );
                                                                                                }).toList()
                                                                                              : (_pilihkec == " GUNUNG WUNGKAL")
                                                                                                  ? _gunungwungkal.map((Map map) {
                                                                                                      return DropdownMenuItem<String>(
                                                                                                        value: map["nama"].toString(),
                                                                                                        child: new Text(
                                                                                                          map["nama"].toString().toUpperCase(),
                                                                                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                                        ),
                                                                                                      );
                                                                                                    }).toList()
                                                                                                  : (_pilihkec == " CLUWAK")
                                                                                                      ? _cluwak.map((Map map) {
                                                                                                          return DropdownMenuItem<String>(
                                                                                                            value: map["nama"].toString(),
                                                                                                            child: new Text(
                                                                                                              map["nama"].toString().toUpperCase(),
                                                                                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                                            ),
                                                                                                          );
                                                                                                        }).toList()
                                                                                                      : (_pilihkec == " TAYU")
                                                                                                          ? _tayu.map((Map map) {
                                                                                                              return DropdownMenuItem<String>(
                                                                                                                value: map["nama"].toString(),
                                                                                                                child: new Text(
                                                                                                                  map["nama"].toString().toUpperCase(),
                                                                                                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                                                ),
                                                                                                              );
                                                                                                            }).toList()
                                                                                                          : (_pilihkec == " DUKUHSETI")
                                                                                                              ? _dukuhseti.map((Map map) {
                                                                                                                  return DropdownMenuItem<String>(
                                                                                                                    value: map["nama"].toString(),
                                                                                                                    child: new Text(
                                                                                                                      map["nama"].toString().toUpperCase(),
                                                                                                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                                                    ),
                                                                                                                  );
                                                                                                                }).toList()
                                                                                                              : _noselect.map((Map map) {
                                                                                                                  return DropdownMenuItem<String>(
                                                                                                                    value: map["nama"].toString(),
                                                                                                                    child: new Text(
                                                                                                                      map["nama"].toString().toUpperCase(),
                                                                                                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                                                                                                    ),
                                                                                                                  );
                                                                                                                }).toList()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
