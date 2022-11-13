// import 'package:dio/dio.dart';
// import 'package:flutter_auth/Screens/Model/Categories.dart';

// abstract class Services1 {
//   static Future<Categories?> getByid(int id) async {
//     try {
//       var response =
//           await Dio().get('https://v2starter.putraprima.id/api/categories');

//       if (response.statusCode == 200) {
//         return Categories(
//             id: response.data['categories']['id'],
//             name: response.data['categories']['name']);
//       }

//       return null;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   static Future<Categories?> createUser(String email, String password) async {}
// }
