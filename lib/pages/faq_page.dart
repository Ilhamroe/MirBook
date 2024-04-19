import 'package:flutter/material.dart';
import 'package:mir_book/widgets/navbar_side.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavbarSide(),
      appBar: AppBar(
        title: const Text("Mir Book"),
      ),
      body: Center(
        child: Text("FaqPage"),
      ),
    );
  }
}
