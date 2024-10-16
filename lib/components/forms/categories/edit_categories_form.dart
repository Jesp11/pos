import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/models/category.dart';
import 'package:pos/services/category_service.dart';

class EditCategoriesForm extends StatefulWidget {
  final Category category;

  const EditCategoriesForm({Key? key, required this.category}) : super(key: key);

  @override
  _EditCategoriesFormState createState() => _EditCategoriesFormState();
}

class _EditCategoriesFormState extends State<EditCategoriesForm> {
  final CategoryService categoryService = CategoryService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.category.name;
    descriptionController.text = widget.category.description;
  }

  Future<void> _saveCategory() async {
    final updatedCategory = Category(
      name: nameController.text,
      description: descriptionController.text,
    );

    bool success = await categoryService.updateCategory(widget.category, updatedCategory);
    if (success) {
      Navigator.pop(context); // Regresa a la pantalla anterior
    } else {
      // Maneja el error si la actualización falla
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('No se pudo actualizar la categoría.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Nombre',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.deepPurple),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            labelText: 'Descripción',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.deepPurple),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _saveCategory,
          child: const Text(
            'Guardar',
            style: TextStyle(color: Colors.white), // Texto en blanco
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Aumentar el ancho
            backgroundColor: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
