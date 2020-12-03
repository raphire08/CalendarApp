import 'package:flutter/material.dart';
import 'package:snapwork_test/screens/dateScreen.dart';
import 'package:snapwork_test/screens/eventScreen.dart';
import 'common.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snapwork Test',
      theme: ThemeData(
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/dateScreen': (BuildContext context) => DateScreen(),
        '/eventScreen': (BuildContext context) => EventScreen(),
      },
      initialRoute: '/dateScreen',
    );
  }
}
