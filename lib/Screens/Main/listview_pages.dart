import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Model/Categories.dart';

import 'ui/listview_page.dart';

class PageListView extends StatefulWidget {
  const PageListView({Key? key}) : super(key: key);

  @override
  _PageListViewState createState() => _PageListViewState();
}

class _PageListViewState extends State<PageListView> {
  List<Categories> listCities = [];

  getListCities() async {
    try {
      var response = await http.get(
          Uri.parse(
            'https://v2starter.putraprima.id/api/categories',
          ),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        final dataDecode = jsonDecode(response.body);
        setState(() {
          for (var i = 0; i < dataDecode.length; i++) {
            listCities.add(Categories.fromJson(dataDecode[i]));
          }
        });
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    getListCities();
    super.initState();
  }

  Widget bulidListItem(index) {
    var item = listCities[index];

    return ListKota(nama: item.name.toString());
    /*return Card(
      child: ListTile(
        title:
            Text(item.name.toString(), style: const TextStyle(fontSize: 18.0)),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade400,
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.edit))),
              const SizedBox(width: 5),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.delete)))
            ]),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories View"),
      ),
      body: ListView.builder(
          itemCount: listCities.length,
          itemBuilder: (BuildContext context, int index) {
            return bulidListItem(index);
          }),
    );
  }
}
