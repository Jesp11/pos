import 'package:hive/hive.dart';
import '../models/category.dart';
import 'package:pos/utils/alerts/dialog_alert.dart';

class CategoryService {
  final Box categoryBox;

  CategoryService() : categoryBox = Hive.box('categoryBox');

  Future<bool> registerCategory(String name, String description) async {
    try {
      bool categoryExists = categoryBox.values.any((element) {
        final existingCategory = Category.fromMap(Map<String, dynamic>.from(element));
        return existingCategory.name.toLowerCase() == name.toLowerCase(); 
      });

      if (categoryExists) {
        return false; 
      }

      final category = Category(name: name, description: description);
      await categoryBox.add(category.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Category> getCategories() {
    return categoryBox.values
        .map((e) => Category.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> deleteCategory(Category category) async {
    final index = categoryBox.values.toList().indexWhere(
      (element) => Category.fromMap(Map<String, dynamic>.from(element)).name == category.name,
    );

    if (index != -1) {
      await categoryBox.deleteAt(index);
    }
  }

  Future<bool> updateCategory(Category oldCategory, Category newCategory) async {

    bool categoryExists = categoryBox.values.any((element) {
      final existingCategory = Category.fromMap(Map<String, dynamic>.from(element));
      return existingCategory.name.toLowerCase() == newCategory.name.toLowerCase() && 
            existingCategory.name != oldCategory.name; // Asegúrate de que no sea la misma categoría
    });

    if (categoryExists) {
      return false; 
    }
    final index = categoryBox.values.toList().indexWhere(
      (element) => Category.fromMap(Map<String, dynamic>.from(element)).name == oldCategory.name,
    );
    if (index != -1) {
      await categoryBox.putAt(index, newCategory.toMap());
      return true; 
    }
    return false; 
  }

}
