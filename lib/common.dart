import 'package:flutter/material.dart';

// Text Styles
TextStyle headingStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontWeight: FontWeight.w700,
);

TextStyle buttonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
);

TextStyle dateTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 24.0,
  fontWeight: FontWeight.w700,
);

TextStyle labelTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 14.0,
);

// Colors
Color primaryColor = Colors.blue[800];

Color verticalDividerColor = Colors.grey[400];
//Decoration

InputDecoration formFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(10.0),
  isDense: true,
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.grey)),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: Colors.grey)),
);
