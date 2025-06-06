import 'dart:convert';
import 'package:demo_interview/Models/api_category.dart';
import 'package:demo_interview/Models/api_respone.dart';
import 'package:demo_interview/Models/product.dart';
import 'package:demo_interview/Models/user.dart';
import 'package:demo_interview/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Sign In
Future<ApiRespone> signin(String username, String password) async {
  ApiRespone apiRespone = ApiRespone();
  try {
    final response = await http.post(Uri.parse(signinURL),
        headers: {'Accept': 'application/json'},
        body: {'username': username, 'password': password});

    switch (response.statusCode) {
      case 200:
        apiRespone.data = User.fromjson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiRespone.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiRespone.error = jsonDecode(response.body)['message'];
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
    final response = await http.post(Uri.parse(signupURL), headers: {
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

    switch (response.statusCode) {
      case 200:
        apiRespone.data = User.fromjson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiRespone.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiRespone.error = jsonDecode(response.body)['message'];
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
    final response = await http.get(
      Uri.parse(userURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiRespone.data = User.fromjson(jsonDecode(response.body));
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

//product
Future<ApiRespone> getProducts() async {
  ApiRespone apiRespone = ApiRespone();

  try {
    final response = await http.get(
      Uri.parse(productURL),
      headers: {
        'Accept': 'application/json',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    switch (response.statusCode) {
      case 200:
        final data = jsonDecode(response.body);
        if (data['data'] is List) {
          apiRespone.data = (data['data'] as List)
              .map((productJson) => Product.fromJson(productJson))
              .toList();
        } else {
          apiRespone.error = "Unexpected data format";
        }
        break;

      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiRespone.error = errors[errors.keys.first][0];
        break;

      case 403:
        apiRespone.error = jsonDecode(response.body)['message'];
        break;

      default:
        apiRespone.error = somethingwentWrong; // e.g., "Something went wrong"
        break;
    }
  } catch (e) {
    print('Exception: $e');
    apiRespone.error = serverError; // e.g., "Server error"
  }

  return apiRespone;
}

//get category
Future<ApiRespone> getCategory() async {
  ApiRespone apiCategory = ApiRespone();

  try {
    final responsecategory = await http.get(
      Uri.parse(categoryURL),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (responsecategory.statusCode == 200) {
      final dynamic itemCategory =
          jsonDecode(responsecategory.body);

      if (itemCategory is List) {
        apiCategory.data = itemCategory
            .map((Json) => CategoryApi.fromJson(Json))
            .toList();
      } else {
        apiCategory.error = "Unexpected data format";
      }
    } else if (responsecategory.statusCode == 403) {
      final responseBody = jsonDecode(responsecategory.body);
      apiCategory.error = responseBody['message'] ?? somethingwentWrong;
    } else {
      apiCategory.error = somethingwentWrong;
    }
  } catch (e) {
    print('Exception: $e');
    apiCategory.error = serverError;
  }

  return apiCategory;
}
