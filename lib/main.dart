import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      buttonColor: Colors.teal,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        // titleTextStyle: TextStyle(color: Colors.black, font)),
      ),
    ),
    home: Home(),
  ));
}
