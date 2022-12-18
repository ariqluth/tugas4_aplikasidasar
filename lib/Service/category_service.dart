import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../Screens/Model/Categories.dart';
import 'baseurl_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesService {
  Future<List<Categories>> categoriesList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = await sp.getString("token");

    if (token == null) {
      throw new Exception('TOKEN TIdak ada/ NULL');
    }

    var url = Uri.parse(baseUrl + 'categories');

    final apiResult = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    final payload = (jsonDecode(apiResult.body)['data'] as List);

    return payload.map((e) => Categories.fromJson(e)).toList();
  }

  static Future<Response> Createcategories(
    String name,
  ) async {
    var url = Uri.parse(baseUrl + 'categories');

    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = await sp.getString("token");

    if (token == null) {
      throw new Exception('ERROR TOKEN NULL');
    }

    Map data = {
      'name': name,
    };

    http.Response response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: data,
    );

    // var jsonObject = json.decode(response.body);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to Create categories.');
    }
  }

  Future<Response> deleteCategories(Categories categories) async {
    var url = Uri.parse(baseUrl + 'categories/${categories.id}');

    SharedPreferences sp = await SharedPreferences.getInstance();

    String? token = await sp.getString("token");

    if (token == null) {
      throw new Exception('ERROR TOKEN NULL');
    }

    final headers = {
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final response = await delete(
      url,
      headers: headers,
    );

    print(response.statusCode);

    return response;
  }

  static Future updateCategories(Categories categories, String newName) async {
    final sp = await SharedPreferences.getInstance();

    var Url = Uri.parse(baseUrl + 'categories/${categories.id}');

    final token = sp.getString('token');

    final response = await http.put(
      Url,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: {
        "name": newName,
      },
    );

    return response;
  }
}
