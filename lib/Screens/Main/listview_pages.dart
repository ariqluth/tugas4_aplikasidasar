import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:stisla/Screens/Main/categories/categoriesUpdate.dart';
import 'package:stisla/Screens/Model/Categories.dart';

import '../../Service/category_service.dart';
import 'categories/categoriesCreate.dart';

class PageListView extends StatefulWidget {
  const PageListView({Key? key}) : super(key: key);

  @override
  _PageListViewState createState() => _PageListViewState();
}

class _PageListViewState extends State<PageListView> {
  List<Categories> listCities = [];
  final link = CategoriesService();

  getLink() async {
    listCities = await link.categoriesList();
  }
  // getListCities() async {
  //   try {
  //     var response = await http.get(
  //         Uri.parse(
  //           'https://5afd-36-85-58-61.ap.ngrok.io/api/categories',
  //         ),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         });

  //     if (response.statusCode == 200) {
  //       final dataDecode = jsonDecode(response.body);
  //       setState(() {
  //         for (var i = 0; i < dataDecode.length; i++) {
  //           listCities.add(Categories.fromJson(dataDecode[i]));
  //         }
  //       });
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  @override
  void initState() {
    getLink();
    super.initState();
  }

  Widget bulidListItem(index) {
    var item = listCities[index];

    return Card(
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateCategories(categories: item),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit))),
              const SizedBox(width: 5),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        link.deleteCategories(item);
                      },
                      icon: const Icon(Icons.delete)))
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories View"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateCategory(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: link.categoriesList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Categories>? listCategories =
                  snapshot.data as List<Categories>?;
              print(listCategories);
              return ListView.builder(
                  itemCount: listCities.length,
                  itemBuilder: (BuildContext context, int index) {
                    var categories = listCities![index];
                    return bulidListItem(index);
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
