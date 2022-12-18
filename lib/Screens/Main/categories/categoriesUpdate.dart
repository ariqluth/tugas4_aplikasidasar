// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:stisla/Screens/Main/listview_pages.dart';

import '../../../Service/baseurl_service.dart';
import '../../../Service/category_service.dart';
import '../../Model/Categories.dart';

class UpdateCategories extends StatefulWidget {
  Categories categories;
  UpdateCategories({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  State<UpdateCategories> createState() => _UpdateCategoriesState();
}

class _UpdateCategoriesState extends State<UpdateCategories> {
  TextEditingController __name = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    __name.text = widget.categories!.name;
  }

  @override
  savepressed() async {
    String newName = __name.text;
    Categories? newCategory = widget.categories;

    if (newName.isNotEmpty) {
      http.Response response =
          await CategoriesService.updateCategories(newCategory, __name.text);
      Map responseMap = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PageListView(),
          ),
        );
      } else {
        errorSnackBar(context, 'Failed to update');
      }
    } else {
      errorSnackBar(context, 'enter Category fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Category"),
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
                child: Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
