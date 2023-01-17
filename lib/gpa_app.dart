// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gpa_calculator/Models/lecture.dart';
import 'package:gpa_calculator/constants.dart';
import 'package:gpa_calculator/leccture_list.dart';
import 'package:gpa_calculator/show_gpa.dart';

class GpaApp extends StatefulWidget {
  const GpaApp({Key? key}) : super(key: key);

  @override
  State<GpaApp> createState() => _GpaAppState();
}

class _GpaAppState extends State<GpaApp> {
  var formKey = GlobalKey<FormState>();
  double chosenGrade = 4;
  double chosenCredit = 1;
  String lectureName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            "GPA Calculator",
            style: Constants.titleStyle,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _buildForm(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _buildLetterDrop(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _buildCreditDrops(),
                          ),
                        ),
                        IconButton(
                          onPressed: _calculate,
                          icon: Icon(Icons.arrow_forward_ios_rounded),
                          color: Constants.mainColor,
                          iconSize: 40,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: ShowGpa(
                    gpa: Constants.calculateGpa(),
                    lectureCount: Constants.lectures.length,
                  )),
            ],
          ),
          Expanded(
            child: LectureList(
              onDismiss: (i) {
                Constants.lectures.removeAt(i);
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: TextFormField(
        validator: (name) {
          if (name!.isEmpty) {
            return "Please enter name of the lecture!";
          } else {
            return null;
          }
        },
        onSaved: (name) {
          lectureName = name!;
        },
        decoration: InputDecoration(
          hintText: "e.g. Calculus I",
          border: Constants.borderRadius,
          filled: true,
          fillColor: Constants.mainColor.shade100.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget _buildLetterDrop() {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Constants.mainColor.shade100.withOpacity(0.3),
          ),
          child: DropdownButton(
            elevation: 16,
            iconEnabledColor: Constants.mainColor.shade200,
            value: chosenGrade,
            items: Constants.grades(),
            onChanged: (double? grade) {
              setState(() {
                chosenGrade = grade!;
              });
            },
            underline: Container(),
          ),
        ),
      ],
    );
  }

  Widget _buildCreditDrops() {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Constants.mainColor.shade100.withOpacity(0.3),
          ),
          child: DropdownButton(
            elevation: 16,
            iconEnabledColor: Constants.mainColor.shade200,
            value: chosenCredit,
            items: Constants.credits(),
            onChanged: (double? credit) {
              setState(() {
                chosenCredit = credit!;
              });
            },
            underline: Container(),
          ),
        ),
      ],
    );
  }

  _calculate() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var lecture = Lecture(
        name: lectureName,
        grade: chosenGrade,
        credit: chosenCredit,
      );
      Constants.addLecture(lecture);
      setState(() {
        formKey.currentState!.reset();
      });
    }
  }
}
