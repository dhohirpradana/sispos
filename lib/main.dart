import 'package:flutter/material.dart';
import 'package:sispos_pajak/api/option_desa.dart';
import 'package:sispos_pajak/view/page/perekaman/perekaman.dart';
import 'view/boot/bootscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BootScreen(),
    );
  }
}
