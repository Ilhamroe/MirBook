import 'package:flutter/material.dart';
import 'package:mir_book/widgets/navbar_side.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavbarSide(),
      appBar: AppBar(
        title: const Text("Mir Book"),
      ),
      body: Center(
        child: Text("Logout"),
      ),
    );
  }
}
