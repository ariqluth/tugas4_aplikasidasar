import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:stisla/Service/category_service.dart';

import '../../../Service/baseurl_service.dart';
import '../listview_pages.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  TextEditingController __name = TextEditingController(text: "Category");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  savepressed() async {
    String password = __name.text;

    if (password.isNotEmpty) {
      http.Response response =
          await CategoriesService.createcategories(__name.text);
      Map responseMap = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PageListView(),
          ),
        );
      } else {
        errorSnackBar(context, 'Failed to save data');
      }
    } else {
      errorSnackBar(context, 'enter Category fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: __name,
                // obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category Name',
                  hintText: 'Enter Category Name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              width: double.infinity,
              height: 40,
              // convert button
              child: ElevatedButton(
                onPressed: savepressed,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Background color
                ),
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
