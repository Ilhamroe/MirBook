import 'package:flutter/material.dart';
import 'package:mir_book/widgets/navbar_side.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavbarSide(),
      appBar: AppBar(
        title: const Text("Mir Book"),
      ),
      body: Center(
        child: Text("ProfilePage"),
      ),
    );
  }
}
