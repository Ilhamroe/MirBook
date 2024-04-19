import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mir_book/pages/b_home_page.dart'; // Import your home page here

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BeforeHomePage(),
    );
  }
}
