import 'package:demo_interview/Models/api_category.dart';
import 'package:demo_interview/Models/api_respone.dart';
import 'package:demo_interview/Models/product.dart';
import 'package:demo_interview/Services/user_service.dart';
import 'package:demo_interview/Views/buy.dart';
import 'package:demo_interview/constant.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isSelectedIcon = false;
  int selectedIndex = 0;
  List<Product> _items = [];
  List<CategoryApi> _itemCategory = [];
  bool _hasError = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getProduct();
    _getCategory();
  }

  void _getProduct() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      ApiRespone response = await getProducts();

      if (response.error == null && response.data != null) {
        List<Product> productList =
            (response.data as List).map((item) => item as Product).toList();

        setState(() {
          _items = productList;

          _hasError = false;
        });
      } else {
        setState(() {
          _hasError = true;
        });
      }
    } catch (e) {
      print("Exception caught while fetching products: $e");

      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _getCategory() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      ApiRespone responsecategoey = await getCategory();

      if (responsecategoey.data != null) {
        List<CategoryApi> categories =
            responsecategoey.data as List<CategoryApi>;

        setState(() {
          _itemCategory = categories;
          _hasError = false;
        });
      } else {
        setState(() {
          _hasError = true;
        });
      }
    } catch (e) {
      print("Exception caught while fetching categories: $e");

      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void onCategoryTap(int categoryId) {
    print("Tapped category id: $categoryId");
    // You can implement filtering logic here
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
            builheader(context),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                buildSectionTitle("Special Product"),
                const SizedBox(
                  height: 5,
                ),
                buildHotproduct(),
                buildCategoryicon()
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            buildSectionTitle("Most Popular"),
            Column(children: [
              buildCategoryFilterList(),
              const SizedBox(
                height: 10,
              ),
              buildProductGrid()
            ]),
          ],
        ),
      ),
    );
  }

  //Header of App
  Widget builheader(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        height: 105,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 227, 207, 54),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            )),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
          child: Row(
            children: [
              Text('Hi Rong!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              const CircleAvatar(
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
                  blurRadius: 50, // Reduced blur radius for better effect
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

//New or Hor Product
  Widget buildHotproduct() {
    return SizedBox(
      height: 170, // Constrains ListView height
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              width: 350, // Width of each container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 227, 207, 54), // Color
              ),
              child: Center(
                child: Text(
                  'Item $index', // Display item number (or use other dynamic content)
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

//Menu category
  Widget buildCategoryicon() {
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
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: [
          for (int i = 0; i < listTitle.length; i++)
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 21, right: 15),
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
    );
  }

//Title Text
  Widget buildSectionTitle(String title) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: kRow(title));
  }

//Category filter
  Widget buildCategoryFilterList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return const Center(child: Text("Failed to load categories"));
    }

    if (_itemCategory.isEmpty) {
      return const Center(child: Text("No categories available"));
    }

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: _itemCategory.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = _itemCategory[index];
          final isSelected = index == selectedIndex;

          return TextButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });
              onCategoryTap(category.categoryid);
            },
            style: TextButton.styleFrom(
              backgroundColor: isSelected
                  ? const Color.fromARGB(255, 227, 207, 54)
                  : Colors.transparent,
              side: const BorderSide(color: Colors.black, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              category.categoryname,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

//Product list
  Widget buildProductGrid() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_hasError) {
      return const Center(child: Text("Failed to load data"));
    }
    return Wrap(
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
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            12), // optional: rounded corners
                        child: Image.network(
                          "http://192.168.2.5:8000/storage/img_url/${item.imgurl}", // make sure this is correct
                          width: 150,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image, size: 100),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // The title can now be placed in the column
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            item.name, // Title from API
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // The title can now be placed in the column
                          Text(
                            '\$${item.price.toStringAsFixed(2)}', // Display price with "$" symbol
                            style: const TextStyle(
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Buyproduct()));
                  },
                  style: TextButton.styleFrom(
                    // Text color
                    backgroundColor: const Color.fromARGB(255, 227, 207, 54),
                  ),
                  child: const Text(
                    "Buy",
                    style: TextStyle(fontSize: 17, color: Colors.black),
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
                  color: const Color.fromARGB(255, 227, 227, 227),
                ),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isSelectedIcon =
                            !_isSelectedIcon; // Toggle the selected state
                      });
                    },
                    icon: Image.asset(
                      'icons/heart.png',
                      color: _isSelectedIcon ? Colors.red : null,
                    )),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
