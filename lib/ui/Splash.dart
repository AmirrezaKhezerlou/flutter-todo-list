import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo/ui/Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'images/ic_logo.png',
                width: 120,
                height: 120,
              ),
            ),
            SizedBox(
              width: 20,
              height: 28,
            ),
            Text(
              "فهرست کار ها",
              style: TextStyle(fontSize: 18, fontFamily: 'iransans'),
            ),
            SizedBox(
              width: 20,
              height: 28,
            ),
            SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.blue : Colors.black12,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
