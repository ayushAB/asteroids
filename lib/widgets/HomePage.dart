import 'package:asteroids/widgets/AsteroidList.dart';

import 'package:asteroids/widgets/DatePicker.dart';

import 'package:asteroids/widgets/Star.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String startDate = "";
  String endDate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: Color(0xFFE6734F),
        title: Text('Asteroids'),
      ),
      backgroundColor: Color(0xff2C394B).withOpacity(0.2),
      body: SafeArea(
        child: Stack(
          children: [
            HeroAnimation(),
            Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        DatePicker(
                          titleText: "From",
                          onDateSelected: (date) => {startDate = date},
                        ),
                        DatePicker(
                            titleText: "To",
                            onDateSelected: (date) => {endDate = date}),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFFE6734F))),
                                child: Text('Search'),
                                onPressed: () => {setState(() {})}),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        child: AsteroidList(
                            startDate: startDate, endDate: endDate),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
