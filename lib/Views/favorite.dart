// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Enable vertical scrolling
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Column(
            children: List.generate(5, (index) {
              return Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 207, 54),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
