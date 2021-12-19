import 'package:asteroids/widgets/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asteroids',
      theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Poppins'),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
