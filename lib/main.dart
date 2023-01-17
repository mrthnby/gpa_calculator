import 'package:flutter/material.dart';
import 'package:gpa_calculator/constants.dart';
import 'gpa_app.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Constants.mainColor,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const GpaApp(),
    );
  }
}
