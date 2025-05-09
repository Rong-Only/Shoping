import 'dart:convert';

import 'package:demo_interview/Models/api_respone.dart';
import 'package:demo_interview/Models/user.dart';
import 'package:demo_interview/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Sign In
Future<ApiRespone> signin(String username, String password) async {
  ApiRespone apiRespone = ApiRespone();
  try {
    final Response = await http.post(Uri.parse(signinURL),
        headers: {'Accept': 'application/json'},
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
Future<ApiRespone> signup(String firstname, lastname, gender, username, email,
    password, confirmation) async {
  ApiRespone apiRespone = ApiRespone();
  try {
    final Response = await http.post(Uri.parse(signupURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'first_name': firstname,
      'last_name': lastname,
      'gender': gender,
      'username': username,
      'email': email,
      'password': password,
      'password_confirmation': confirmation
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

//getuser
Future<ApiRespone> getuser() async {
  ApiRespone apiRespone = ApiRespone();
  try {
    String token = await getToken();
    final Response = await http.get(
      Uri.parse(userURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (Response.statusCode) {
      case 200:
        apiRespone.data = User.fromjson(jsonDecode(Response.body));
        break;
      case 401:
        apiRespone.error = unauthorized;
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

//get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

//get user id
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('getuser') ?? 0;
}

//Sign Out
Future<bool> signout() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}
