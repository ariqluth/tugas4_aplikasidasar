// // import 'package:dio/dio.dart';
// // import 'package:flutter_auth/Screens/Model/Categories.dart';

// // abstract class Services1 {
// //   static Future<Categories?> getByid(int id) async {
// //     try {
// //       var response =
// //           await Dio().get('https://v2starter.putraprima.id/api/categories');

// //       if (response.statusCode == 200) {
// //         return Categories(
// //             id: response.data['categories']['id'],
// //             name: response.data['categories']['name']);
// //       }

// //       return null;
// //     } catch (e) {
// //       throw Exception(e.toString());
// //     }
// //   }

// //   static Future<Categories?> createUser(String email, String password) async {}



// // }



//   logOut() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     final token = preferences.getString('token');
   
//      final response = await http.post(
//           // Uri.parse("https://api.sobatcoding.com/testing/login"),
//           // Uri.parse("https://5699-114-6-31-174.ap.ngrok.io/api/auth/login"),
//           // Uri.parse("https://V2starter.putraprima.id/api/auth/login"),
//           Uri.parse(
//               "https://0968-2001-448a-5040-456c-1845-3a47-2476-4236.ap.ngrok.io/api/auth/login"),
//           headers: {
//             'Content-Type': 'application/json; charset=UTF-8',
//             'Charset': 'utf-8',
//             'Authorization': 'Bearer $token',
//           },
//          );
//         if (!mounted) return;
//       if (response.statusCode == 204) {
//        setState(() {
//         preferences.remove("is_login");
//         preferences.remove("email");
//         preferences.remove('token');
//     });

//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => const LoginScreen(),
//       ),
//       (route) => false,
//     );

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//           content: Text(
//         "Berhasil logout",
//         style: TextStyle(fontSize: 16),
//       )),
//     );
//   }
// // 