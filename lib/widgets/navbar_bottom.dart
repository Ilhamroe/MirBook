import 'dart:ui';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mir_book/database/db_helper.dart';
import 'package:mir_book/widgets/add_book.dart';

class NavbarBottom extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavbarBottom({
    required this.currentIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<NavbarBottom> createState() => _NavbarBottomState();
}

class _NavbarBottomState extends State<NavbarBottom> {
  String? selectedCategory;
  bool isLoading = false;
  late List<Map<String, dynamic>> _allData = [];

  final TextEditingController judulBukuController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  // refresh data
  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    final List<Map<String, dynamic>> data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _showModal(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      judulBukuController.text = existingData['title'];
      deskripsiController.text = existingData['description'];
      selectedCategory = existingData['category'] as String?;
    }

    final newData = await showCupertinoModalPopup(
      context: context,
      builder: (_) => Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
              ),
              child: AddBookWidget(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemsIcon = <Widget>[
      const Icon(Icons.home, color: Colors.white),
      IconButton(
        onPressed: () => _showModal(null),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      const Icon(Icons.person, color: Colors.white),
    ];

    final List<CurvedNavigationBarItem> items = itemsIcon
        .map((widget) => CurvedNavigationBarItem(child: widget))
        .toList();

    return CurvedNavigationBar(
      color: Colors.blue,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 300),
      height: 50,
      items: items,
      index: widget.currentIndex,
      onTap: widget.onTap,
    );
  }
}
