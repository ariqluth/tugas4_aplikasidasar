import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login/login_screen.dart';
import 'listview_pages.dart';

class Mains extends StatefulWidget {
  const Mains({Key? key}) : super(key: key);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<Mains> {
  String email = "";
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin == true) {
      setState(() {
        email = pref.getString("email")!;
      });
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("is_login");
      preferences.remove("email");
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen(),
      ),
      (route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text(
        "Berhasil logout",
        style: TextStyle(fontSize: 16),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Selamat Datang",
              style: TextStyle(fontSize: 18.0),
            ),
            Text("Email : " + email, style: const TextStyle(fontSize: 24.0)),
            const SizedBox(height: 15),
            ElevatedButton.icon(
                onPressed: () {
                  logOut();
                },
                icon: const Icon(Icons.lock_open),
                label: const Text("Log Out")),
            const SizedBox(height: 15),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PageListView()));
                },
                icon: const Icon(Icons.list_alt),
                label: const Text("Page List View"))
          ],
        ),
      ),
    );
  }
}
