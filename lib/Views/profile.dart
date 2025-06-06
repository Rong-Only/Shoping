import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class profile_screen extends StatefulWidget {
  const profile_screen({super.key});

  @override
  State<profile_screen> createState() => _profileState();
}

class _profileState extends State<profile_screen> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SHOPING",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 227, 207, 54),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          buildStackProfile(),
        ],
      ),
    );
  }

//Profile
  Widget buildStackProfile() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 227, 207, 54), // Background color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 10, // Adjust profile picture position
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null
                ? Icon(Icons.person, size: 80, color: Colors.grey[700])
                : null,
          ),
        ),
        Positioned(
          bottom: 20,
          left: 90,
          child: GestureDetector(
            onTap: _pickImage,
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
            ),
          ),
        ),
        const Positioned(
            top: 35,
            left: 150,
            child: Column(
              children: [
                Text(
                  "Rong",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
        const Positioned(
            top: 75,
            left: 150,
            child: Column(
              children: [
                Text(
                  "ID USER : 00000001",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
