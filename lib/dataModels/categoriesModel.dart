class Categories {
  final String message;
  final List<Category> data;
  final int status;

  Categories({
    required this.message,
    required this.data,
    required this.status,
  });

  // Factory method to create a Categories instance from JSON
  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
      status: json['status'] as int,
    );
  }
}

class Category {
  final int id;
  final String name;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Category instance from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
