import 'package:flutter/material.dart';
import 'package:mir_book/pages/account_page.dart';
import 'package:mir_book/pages/home_page.dart';
import 'package:mir_book/widgets/add_book.dart';
import 'package:mir_book/widgets/navbar_bottom.dart';
import 'package:mir_book/widgets/navbar_side.dart';

class BeforeHomePage extends StatefulWidget {
  const BeforeHomePage({Key? key}) : super(key: key);

  @override
  State<BeforeHomePage> createState() => _BeforeHomePageState();
}

class _BeforeHomePageState extends State<BeforeHomePage> {
  int? id;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      HomePage(),
      AddBookWidget(),
      AccountPage(),
    ];

    return Scaffold(
      extendBody: true,
      drawer: const NavbarSide(),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavbarBottom(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
