class CategoryApi {
  final int categoryid;
  final String categoryname;

  CategoryApi({required this.categoryid, required this.categoryname});

  factory CategoryApi.fromJson(Map<String, dynamic> json) {
    return CategoryApi(
      categoryid: json['id'],
      categoryname: json['name'],
    );
  }
  @override
  String toString() {
    return 'CategoryApi(id: $categoryid, name: $categoryname)';
  }
}
