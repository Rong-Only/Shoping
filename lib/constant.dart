//-----------STRING-----------\\
// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'package:flutter/material.dart';

const baseURL = "http://192.168.2.5:8000/api";
const signinURL = baseURL + "/Signin";
const signupURL = baseURL + "/Signup";
const signoutURL = baseURL + "/Signout";
const userURL = baseURL + "/user";

//-----------ERROR-----------\\
const serverError = "Server error";
const unauthorized = "Unautthorized";
const somethingwentWrong = "Something Went Wrong, try again!";


//
// InputDecoration(String hintText, {required String hintText, required TextStyle hintStyle}){
//   return InputDecoration(
//                           hintText: 'Username',
//                           hintStyle: TextStyle(color: Colors.white),
//                           border: InputBorder.none, // Removes default border
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
// }