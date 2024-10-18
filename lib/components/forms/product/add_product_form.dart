import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/services/product_service.dart';
import 'package:pos/services/category_service.dart';
import 'package:pos/services/supplier_service.dart';
import 'package:pos/utils/alerts/dialog_alert.dart';

class AddProductForm extends StatefulWidget {
  @override
  _AddProductsForm createState() => _AddProductsForm();
}

class _AddProductsForm extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final CategoryService categoryService = CategoryService();
  final SupplierService supplierService = SupplierService();
  final ProductService productService = ProductService();

  String? selectedCategory;
  String? selectedSupplier;

  List<String> categories = [];
  List<String> suppliers = [];

  @override
  void initState() {
    super.initState();
    _loadCategoriesAndSuppliers();
  }

  Future<void> _loadCategoriesAndSuppliers() async {
    categories = await categoryService.getCategoryNames(); 
    suppliers = supplierService.getSupplier().map((e) => e.company).toList(); 
    setState(() {}); 
  }

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
                labelText: 'Product Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product name';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories
                  .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please enter the category';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            DropdownButtonFormField<String>(
              value: selectedSupplier,
              items: suppliers
                  .map((supplier) => DropdownMenuItem<String>(
                        value: supplier,
                        child: Text(supplier),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Supplier',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedSupplier = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please enter the supplier';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the price';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter value number';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quiantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product quantity';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter the product quantity';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String name = nameController.text;
                  int price = int.parse(priceController.text);
                  int quantity = int.parse(quantityController.text);
                  String category = selectedCategory!;
                  String supplier = selectedSupplier!;

                  bool success = await productService.registerProduct(
                    name: name,
                    category: category,
                    supplier: supplier,
                    price: price,
                    quantity: quantity,
                  );
                  
                  if (success) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogAlert(
                          context: context, 
                          title: 'Success', 
                          content: 'The product has been added successfully', 
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
                          content: 'Product creation failed', 
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
                  'Crear Producto',
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
