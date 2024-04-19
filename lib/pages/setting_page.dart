import 'package:flutter/material.dart';
import 'package:mir_book/widgets/navbar_side.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavbarSide(),
      appBar: AppBar(
        title: const Text("Mir Book"),
      ),
      body: Center(
        child: Text("SettingPage"),
      ),
    );
  }
}
