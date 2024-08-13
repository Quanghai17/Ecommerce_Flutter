import 'package:flutter/material.dart';
import 'package:ecommerce/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  void setCategories(List<Category> categories) {
    _categories = categories;
    notifyListeners();
  }

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }
}
