import 'dart:convert';
import 'package:ecommerce/models/category.dart';

class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String price;
  final String description;
  final String body;
  final int stock;
  final int sellNumber;
  final int categoryId;
  final String createdAt;
  final String updatedAt;
  final Category category;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.body,
    required this.stock,
    required this.sellNumber,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'description': description,
      'body': body,
      'stock': stock,
      'sellNumber': sellNumber,
      'categoryId': categoryId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'Category': category.toMap(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      body: map['body'] ?? '',
      stock: map['stock'] ?? 0,
      sellNumber: map['sellNumber'] ?? 0,
      categoryId: map['categoryId'] ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      category: Category.fromMap(map['Category'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
