import 'package:flutter/material.dart';
import 'package:otp_reader/home.dart';
import 'package:otp_reader/home_page.dart';
import 'package:otp_reader/principal.dart';
import 'package:pinput/pinput.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => Principal(),
        '/home': (context) => Home(),
        '/home1': (context) => HomePage(),
      },
    );
  }
}
