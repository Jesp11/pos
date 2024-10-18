import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pos/models/category.dart';

class CategoryDropdown extends StatefulWidget {
  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  List<Category> categories = [];
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final categoryBox = Hive.box('categoryBox');
    setState(() {
      categories = categoryBox.values
          .map((e) => Category.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      hint: Text("Select a category"),
      value: selectedCategory,
      onChanged: (Category? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
      items: categories.map((Category category) {
        return DropdownMenuItem<Category>(
          value: category,
          child: Text(category.name),
        );
      }).toList(),
    );
  }
}
