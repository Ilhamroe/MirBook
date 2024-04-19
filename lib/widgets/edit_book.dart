import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mir_book/database/db_helper.dart';
import 'package:mir_book/pages/b_home_page.dart';

class EditBookWidget extends StatefulWidget {
  int? idBook;
  Map<String, dynamic>? exisiting_data;
  EditBookWidget({super.key, this.exisiting_data, this.idBook});

  @override
  State<EditBookWidget> createState() => _EditBookWidgetState();
}

class _EditBookWidgetState extends State<EditBookWidget> {
  int? id;
  late List<Map<String, dynamic>> allData = [];

  final TextEditingController judulBukuController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  String? selectedCategory;
  List<String> categories = [
    'Teknologi',
    'Kesehatan',
    'Sejarah',
    'Ensiklopedia',
    'Bisnis'
  ];

  // refresh data
  Future<void> _refreshData() async {
    final List<Map<String, dynamic>> data = await SQLHelper.getAllData();
    setState(() {
      allData = data;
    });
  }

  // show data by id
  void getSingleData(int id) async {
    final data = await SQLHelper.getSingleData(id);

    setState(() {
      judulBukuController.text = data[0]['title'];
      deskripsiController.text = data[0]['description'];
      selectedCategory = data[0]['description'];
    });
  }

  // add data
  Future<void> _addData() async {
    await SQLHelper.createData(
      judulBukuController.text,
      deskripsiController.text,
      selectedCategory,
    );
    _refreshData();
  }

  //update data
  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
      id,
      judulBukuController.text,
      deskripsiController.text,
      selectedCategory,
    );
    _refreshData();
  }

  void _resetSetting() {
    setState(() {
      judulBukuController.clear();
      deskripsiController.clear();
      selectedCategory = null;
    });
  }

  void _submitSetting(int id) async {
    await _updateData(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BeforeHomePage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    judulBukuController.text = widget.exisiting_data?['title'] ?? "";
    deskripsiController.text = widget.exisiting_data?['description'] ?? "";
    selectedCategory = widget.exisiting_data?['category'] ?? null;
  }

  @override
  void dispose() {
    judulBukuController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(26, 15, 26, 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Tambahkan Buku',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 6.4),
              const Text(
                'Judul Buku',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextField(
                maxLength: 20,
                maxLines: 1,
                controller: judulBukuController,
                decoration: const InputDecoration(
                  counterText: '',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Deskripsi Buku',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(
                  counterText: '',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kategori Buku',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: InputDecoration(
                  hintText: 'Pilih kategori buku',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _resetSetting,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 45.0),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitSetting(widget.exisiting_data?['id']);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 45.0),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
