import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:stisla/Service/baseurl_service.dart';

import '../Screens/Model/Users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService {
  static Future<Response> CreateUser(
    String name,
    String email,
    String password,
    String confirm,
    String device_name,
  ) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    var url = Uri.parse(baseUrl + 'auth/register');

    Map data = {
      'name': name,
      'email': email,
      'password': password,
      "password_confirmation": confirm,
      'device_name': device_name,
    };

    http.Response response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
      },
      body: data,
    );

    // var jsonObject = json.decode(response.body);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      sp.setString("email", email);
      sp.setString("password", password);
      return response;
    } else {
      throw Exception('Failed to register.');
    }
  }
}
