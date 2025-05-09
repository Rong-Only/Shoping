// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isSelectedicon = false;

  int _selectedIndex = 0;
  List<dynamic> _items = [];
  bool _isLoading = true;
  bool _hasError = false;
  final List<String> categories = [
    "All",
    "Shirt",
    "Trousers",
    "Shoe",
    "Bag",
    "Chair",
    "Table",
    "Sofa"
  ];
  List listTitle = [
    {"title": "Shirt"},
    {"title": "Trousers"},
    {"title": "Shoe"},
    {"title": "Bag"},
    {"title": "Chair"},
    {"title": "Table"},
    {"title": "Sofa"},
    {"title": "More"},
  ];
  List listIcon = [
    {"icon": "shirt.png"},
    {"icon": "trousers.png"},
    {"icon": "sport-shoe.png"},
    {"icon": "briefcase.png"},
    {"icon": "swivel-chair.png"},
    {"icon": "table.png"},
    {"icon": "sofa.png"},
    {"icon": "more.png"},
  ];
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // final url = Uri.parse("https://fakestoreapi.com/products");
    // final url = Uri.parse("http://192.168.2.5/api/products/list");
    final url =
        Uri.parse("http://192.168.1.3:8000/api/Product"); //API Shoping coffee
    // final url =
    //     Uri.parse("http://192.168.2.5:8000/api/Product"); //API Shoping home
    setState(() {
      _isLoading = true; // Ensure loading starts before request
      _hasError = false; // Reset error state
    });
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _items = json.decode(response.body)['data'];
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      setState(() {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      });
    }
  }

  final List<String> items = List.generate(10, (index) => 'Item $index');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: <Widget>[
              Container(
                height: 105,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 207, 54),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    )),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 40),
                  child: Row(
                    children: [
                      Text('Hi Rong!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                      Spacer(),
                      CircleAvatar(
                        backgroundImage: AssetImage('icons/adwords.png'),
                        radius: 35,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 75),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26, // Added color for visibility
                          offset: Offset(0, 10),
                          blurRadius:
                              50, // Reduced blur radius for better effect
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 194, 193, 193),
                          ),
                          border: InputBorder.none, // Removes default border
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "icons/search.png",
                                height: 40,
                                width: 40,
                              )),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      Text(
                        "Special Product",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Sea All",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 170, // Constrains ListView height
                  width: double.infinity,
                  child: ListView(
                    scrollDirection:
                        Axis.horizontal, // Enable horizontal scrolling
                    children: List.generate(10, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          width: 350, // Width of each container
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(
                                255, 227, 207, 54), // Color
                          ),
                          child: Center(
                            child: Text(
                              'Item $index', // Display item number (or use other dynamic content)
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      for (int i = 0; i < listTitle.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 21, right: 15),
                          child: Container(
                            width: 70, // Set the width of the container
                            height: 70, // Set the height of the container
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 227, 207, 54),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                      "icons/${listIcon[i]['icon']}",
                                      height: 40,
                                      width: 40,
                                    )),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Text(
                    "Most Popular",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Sea All",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(children: [
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final label = categories[index];
                    final isSelected = index == _selectedIndex;
                    return Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 15 : 10),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: isSelected
                                  ? Color.fromARGB(255, 227, 207, 54)
                                  : Colors.transparent,
                              side: BorderSide(color: Colors.black, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              label,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.black : Colors.black,
                              ),
                            )));
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Show loading spinner
                  : _hasError
                      ? Center(child: Text("Failed to load data"))
                      : Wrap(
                          spacing: 8.0, // Horizontal space
                          runSpacing: 8.0, // Vertical space
                          children: List.generate(_items.length, (index) {
                            var item = _items[index];
                            return Stack(
                              children: [
                                Card(
                                  color: Colors.white,
                                  elevation: 1,
                                  child: Container(
                                    width: 200,
                                    height: 290,
                                    padding: EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            child: Image.network(
                                              item["img_url"] ??
                                                  "", // Handle null image
                                              width: 150,
                                              height: 200,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Icon(Icons.image, size: 100),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        // The title can now be placed in the column
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                item["name"] ??
                                                    "No Name", // Title from API
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 8),
                                              // The title can now be placed in the column
                                              Text(
                                                '\$${item["price"] ?? "0.00"}', // Display price with "$" symbol
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 11,
                                    right: 15,
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        // Text color
                                        backgroundColor:
                                            Color.fromARGB(255, 227, 207, 54),
                                      ),
                                      child: Text(
                                        "Buy",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.black),
                                      ),
                                    )),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      color: const Color.fromARGB(
                                          255, 227, 227, 227),
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isSelectedicon =
                                                !_isSelectedicon; // Toggle the selected state
                                          });
                                        },
                                        icon: Image.asset(
                                          'icons/heart.png',
                                          color: _isSelectedicon
                                              ? Colors.red
                                              : null,
                                        )),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
            ]),
          ],
        ),
      ),
    );
  }
}
