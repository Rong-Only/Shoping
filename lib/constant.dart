//-----------STRING-----------\\
// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

// import 'package:flutter/material.dart';

// const baseURL = "http://192.168.2.5:8000/api";
import 'package:flutter/material.dart';

const baseURL = "http://192.168.1.3:8000/api";
const signinURL = baseURL + "/login";
const signupURL = baseURL + "/register";
const signoutURL = baseURL + "/logout";
const userURL = baseURL + "/profile";

//-----------ERROR-----------\\
const serverError = "Server error";
const unauthorized = "Unautthorized";
const somethingwentWrong = "Something Went Wrong, try again!";

InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      border: OutlineInputBorder(),
      labelText: label,
      hintStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      filled: true,
      fillColor: Colors.white);
}

// any button
ElevatedButton kElevatedButton(String label, Function onPressed) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // <-- set your background color here
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // optional: round corners
        ),
      ),
      onPressed: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.login,
            color: Colors.white,
            size: 20,
          )
        ],
      ));
}
