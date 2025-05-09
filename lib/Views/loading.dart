// ignore_for_file: prefer_const_constructors

import 'package:demo_interview/Models/api_respone.dart';
import 'package:demo_interview/Services/user_service.dart';
import 'package:demo_interview/Views/main.dart';
import 'package:demo_interview/Views/signin.dart';
import 'package:demo_interview/constant.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Signin()), (route) => false);
    } else {
      ApiRespone respone = await getuser();
      if (respone.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false);
      } else if (respone.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Signin()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${respone.error}')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Color.fromARGB(255, 227, 207, 54),
      child: CircularProgressIndicator(),
    );
  }
}
