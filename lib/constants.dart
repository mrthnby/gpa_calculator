import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpa_calculator/Models/lecture.dart';

class Constants {
  static const MaterialColor mainColor = Colors.indigo;

  static final TextStyle titleStyle = GoogleFonts.quicksand(
      fontSize: 24, fontWeight: FontWeight.w900, color: mainColor);

  static final OutlineInputBorder borderRadius = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none);

  static final TextStyle gpaBodyStyle = GoogleFonts.quicksand(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: mainColor,
  );

  static final TextStyle gpaStyle = GoogleFonts.quicksand(
    fontSize: 55,
    fontWeight: FontWeight.w600,
    color: mainColor,
  );

  static List _gradeLetters() {
    return ["AA", "BA", "BB", "BC", "CC", "DC", "DD", "FD", "FF"];
  }

  static double? _letterGrade(String letter) {
    switch (letter) {
      case "AA":
        return 4.0;
      case "BA":
        return 3.5;
      case "BB":
        return 3.0;
      case "BC":
        return 2.5;
      case "CC":
        return 2.0;
      case "DC":
        return 1.5;
      case "DD":
        return 1.0;
      case "FD":
        return 0.5;
      case "FF":
        return 0.0;
    }
  }

  static List<DropdownMenuItem<double>>? grades() {
    return _gradeLetters()
        .map((e) => DropdownMenuItem(
              value: _letterGrade(e),
              child: Text(e),
            ))
        .toList();
  }

  static List<int> _creditNums() {
    return List.generate(10, (index) => index + 1);
  }

  static List<DropdownMenuItem<double>> credits() {
    return _creditNums()
        .map((e) => DropdownMenuItem(
              value: e.toDouble(),
              child: Text(e.toString()),
            ))
        .toList();
  }

  static List<Lecture> lectures = [];

  static void addLecture(Lecture lecture) {
    lectures.add(lecture);
  }

  static double calculateGpa() {
    double totalGrade = 0, totalCredit = 0;
    Constants.lectures.forEach((element) {
      totalGrade += element.credit * element.grade;
      totalCredit += element.credit;
    });

    return totalGrade / totalCredit;
  }
}
