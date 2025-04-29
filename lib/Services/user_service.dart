import 'dart:convert';

import 'package:demo_interview/Models/api_respone.dart';
import 'package:demo_interview/Models/user.dart';
import 'package:demo_interview/constant.dart';
import 'package:http/http.dart' as http;


//Sign In
Future<ApiRespone> signin(String username, String password) async {
  ApiRespone apiRespone = ApiRespone();
  try {
    final Response = await http.post(Uri.parse(signinURL),
        body: {'username': username, 'password': password});

    switch (Response.statusCode) {
      case 200:
        apiRespone.data = User.fromjson(jsonDecode(Response.body));
        break;
      case 422:
        final errors = jsonDecode(Response.body)['errors'];
        apiRespone.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiRespone.error = jsonDecode(Response.body)['message'];
        break;
      default:
        apiRespone.error = somethingwentWrong;
        break;
    }
  } catch (e) {
    apiRespone.error = serverError;
  }

  return apiRespone;
}

//Sign Up
Future<ApiRespone> signup(String first, String last, String gender, String username, String email, String password, String confirm) async {
  ApiRespone apiRespone = ApiRespone();
  try {
    final Response = await http.post(Uri.parse(signupURL),
        body: {
          'first': first,
          'last': last,
          'gender': gender,
          'username': username, 
          'email': email, 
          'password': password,
          'confirm': confirm
        });

    switch (Response.statusCode) {
      case 200:
        apiRespone.data = User.fromjson(jsonDecode(Response.body));
        break;
      case 422:
        final errors = jsonDecode(Response.body)['errors'];
        apiRespone.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiRespone.error = jsonDecode(Response.body)['message'];
        break;
      default:
        apiRespone.error = somethingwentWrong;
        break;
    }
  } catch (e) {
    apiRespone.error = serverError;
  }

  return apiRespone;
}


// //Sign Out
// Future<bool> signout() async{
//   SharedPre
// }