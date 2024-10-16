import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/models/category.dart';
import 'package:pos/components/forms/categories/edit_categories_form.dart'; 

class EditCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Category category = ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Categoría', style: GoogleFonts.montserrat()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EditCategoriesForm(category: category), 
      ),
    );
  }
}
