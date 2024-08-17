import 'package:flutter/material.dart';
import 'package:unit_conversion/UnitConversionScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Unit Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UnitConversionScreen(),
    );
  }
}

