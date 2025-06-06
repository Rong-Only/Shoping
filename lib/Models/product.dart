class Product {
  final int id;
  final String name;
  final int categoryId;
  final String description;
  final String imgurl;
  final int stock;
  final double price;
  final int ratingRate;
  final int ratingCount;

  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.imgurl,
    required this.stock,
    required this.price,
    required this.ratingRate,
    required this.ratingCount,
  });

  // Create a Product from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      description: json['description'],
      imgurl: json['img_url'] ?? '',
      stock: json['stock'],
      price: (json['price'] as num).toDouble(), // Safe conversion
      ratingRate: json['rating_rate'],
      ratingCount: json['rating_count'],
    );
  }

  // // Convert a Product to a JSON map
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'category_id': categoryid,
  //     'name': name,
  //     'description': description,
  //     'img_url': imgurl,
  //     'stock': stock,
  //     'price': price,
  //     'rating_rate': ratingRate,
  //     'rating_count': ratingCount
  //   };
  // }
  @override
  String toString() {
    return 'Product(name: $name, img_url: $imgurl)';
  }
}
