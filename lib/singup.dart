// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, unused_element

import 'package:demo_interview/login.dart';
import 'package:flutter/material.dart';

class Singup_page extends StatefulWidget {
  const Singup_page({super.key});

  @override
  State<Singup_page> createState() => _Singup_pageState();
}

String? _selectedGender;
Widget buildInputField({
  required String hintText,
  // required IconData icon,
  bool obscureText = false,
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    child: TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: hintText,
        enabledBorder: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        // prefixIcon: Icon(icon),
        // contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    ),
  );
}

class _Singup_pageState extends State<Singup_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SHOPING",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 227, 207, 54),
      ),
      backgroundColor: const Color.fromARGB(255, 227, 207, 54),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SIGNUP YOUR ACCOUNT',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Expanded(
                    child: buildInputField(
                      hintText: 'First Name',
                      // icon: Icons.person
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: buildInputField(
                      hintText: 'Last Name',
                      // icon: Icons.person
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: InputBorder.none,
                    // prefixIcon: Icon(Icons.person),
                    // contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  hint: Text("Select Gender",
                      style: TextStyle(color: Colors.black)),
                  value: _selectedGender,
                  items: ['Male', 'Female']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              buildInputField(
                hintText: 'Username', /*icon: Icons.person*/
              ),
              SizedBox(height: 10),
              buildInputField(
                hintText: 'Email', /*icon: Icons.email_outlined*/
              ),
              SizedBox(height: 10),
              buildInputField(
                  hintText: 'Password',
                  // icon: Icons.lock_outline,
                  obscureText: true),
              SizedBox(height: 10),
              buildInputField(
                  hintText: 'Confirm Password',
                  // icon: Icons.lock_open_outlined,
                  obscureText: true),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // <-- set your background color here
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // optional: round corners
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login_page(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
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
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You have already account!"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login_page(),
                            ));
                      },
                      child: Text("Sign in")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
