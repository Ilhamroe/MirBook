import 'package:flutter/material.dart';
import 'package:mir_book/widgets/navbar_side.dart';

class ReadBookPage extends StatefulWidget {
  const ReadBookPage({super.key});

  @override
  State<ReadBookPage> createState() => _ReadBookPageState();
}

class _ReadBookPageState extends State<ReadBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavbarSide(),
      appBar: AppBar(
        title: const Text("Mir Book"),
      ),
      body: Center(
        child: Text("ReadBookPage"),
      ),
    );
  }
}
