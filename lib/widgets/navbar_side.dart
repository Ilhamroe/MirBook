import 'package:flutter/material.dart';
import 'package:mir_book/authentication/logout.dart';
import 'package:mir_book/pages/b_home_page.dart';
import 'package:mir_book/pages/list_book_page.dart';
import 'package:mir_book/pages/profile_page.dart';
import 'package:mir_book/pages/setting_page.dart';

class NavbarSide extends StatelessWidget {
  const NavbarSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Ilham Oe",
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            accountEmail: const Text(
              "iramadani@gmail.com",
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/images/logo_mir_book.png'),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text(
              "Beranda",
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const BeforeHomePage(),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text(
              "Daftar Buku",
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ListBookPage(),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              "Profile",
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
              "Setting",
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SettingPage(),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.transparent,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              "Logout",
              style: TextStyle(fontFamily: 'Nunito'),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Logout(),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
