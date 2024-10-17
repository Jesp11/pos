import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/services/category_service.dart';
import 'package:pos/utils/alerts/dialog_alert.dart';

class CategoriesForm extends StatefulWidget {
  @override
  _CategoriesForm createState() => _CategoriesForm();
}

class _CategoriesForm extends State<CategoriesForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final CategoryService categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the category name';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String name = nameController.text;
                  String description = descriptionController.text;

                  bool success = await categoryService.registerCategory(name, description);
                  if (success) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogAlert(
                          context: context, 
                          title: 'Success', 
                          content: 'The category has been added successfully', 
                          confirmButtonText: 'Ok', 
                          onConfirm: () { 
                             Navigator.pop(context);
                             Navigator.pop(context);
                           }
                          );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogAlert(
                          context: context, 
                          title: 'Error', 
                          content: 'Failed to create category', 
                          confirmButtonText: 'Ok', 
                          onConfirm: () { 
                             Navigator.pop(context);
                           }
                          );
                      },
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.deepPurple,
              ),
              child: Center(
                child: Text(
                  'Create Category',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
