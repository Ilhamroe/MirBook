import 'package:flutter/material.dart';
import 'package:mir_book/authentication/logout.dart';
import 'package:mir_book/pages/b_home_page.dart';
import 'package:mir_book/pages/faq_page.dart';
import 'package:mir_book/pages/profile_page.dart';
import 'package:mir_book/pages/setting_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BeforeHomePage(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Account MirBook",
            style: TextStyle(fontFamily: 'Nunito-Bold'),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.asset('assets/images/logo_mir_book.png'),
                title: const Text("Ilham Oe"),
                subtitle: const Text("iramadani@gmail.com"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 21.0, vertical: 8.0),
                child: Text(
                  'Account',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16.0),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text("Profile"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text("FAQ"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const FaqPage(),
                    ),
                  );
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text("Rate App"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Setting"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ),
                  );
                },
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Logout(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
