import 'package:hive/hive.dart';
import '../models/category.dart';

class CategoryService {
  final Box categoryBox;

  CategoryService() : categoryBox = Hive.box('categoryBox');

  Future<bool> registerCategory(String name, String description) async {
    try {
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
    // Busca la categoría en la caja y la elimina
    final index = categoryBox.values.toList().indexWhere(
      (element) => Category.fromMap(Map<String, dynamic>.from(element)).name == category.name,
    );

    if (index != -1) {
      await categoryBox.deleteAt(index);
    }
  }

  Future<bool> updateCategory(Category oldCategory, Category newCategory) async {
    // Busca la categoría en la caja y la actualiza
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
