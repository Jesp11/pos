import 'package:flutter/material.dart';
import 'package:pos/models/category.dart';
import 'package:pos/models/supplier.dart';
import 'package:pos/services/category_service.dart';
import 'package:pos/services/supplier_service.dart';
import 'package:pos/utils/alerts/dialog_alert.dart';

class EditSupplierForm extends StatefulWidget {
  final Supplier supplier; // Cambié 'Category' por 'Supplier'
  const EditSupplierForm({Key? key, required this.supplier}) : super(key: key);

  @override
  _EditSupplierFormState createState() => _EditSupplierFormState();
}

class _EditSupplierFormState extends State<EditSupplierForm> {
  final SupplierService supplierService = SupplierService();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    companyController.text = widget.supplier.company;
    contactController.text = widget.supplier.contact;
  }

  Future<void> _saveSupplier() async {
    final updatedSupplier = Supplier(
      company: companyController.text,
      contact: contactController.text,
    );
    bool success = await supplierService.updateSupplier(widget.supplier, updatedSupplier);
    if (success) {
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('No se pudo actualizar el proveedor.'),
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
          controller: companyController,
          decoration: InputDecoration(
            labelText: 'Company',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.deepPurple),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: contactController,
          decoration: InputDecoration(
            labelText: 'Contact',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.deepPurple),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _saveSupplier,
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 45),
            backgroundColor: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
