import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/components/cards/category_card.dart';
import 'package:pos/services/category_service.dart';
import 'package:pos/models/category.dart';
import 'package:pos/utils/alerts/dialog_alert.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryService categoryService = CategoryService();
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    categories = await categoryService.getCategories(); 
    setState(() {});
  }

 void _editCategory(Category category) {
  Navigator.pushNamed(context, '/category/edit', arguments: category).then((_) {
    _loadCategories(); 
  });
}


  void _deleteCategory(Category category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogAlert(
          context: context, 
          title: 'Deleted category?', 
          content: 'Are you sure you want to delete this category?', 
          confirmButtonText: 'Delete', 
          onConfirm: () { 
            categoryService.deleteCategory(category);
              _loadCategories(); 
              Navigator.pop(context);
          },
          onCancel: () => Navigator.pop(context)
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text(
          'Categories',
          style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/category/add').then((_) {
                _loadCategories();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: categories.isEmpty
            ? Center(
                child: Text(
                  'No categories available.',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(
                    title: category.name,
                    description: category.description,
                    onEdit: () => _editCategory(category), 
                    onDelete: () => _deleteCategory(category), 
                  );
                },
              ),
      ),
    );
  }
}
