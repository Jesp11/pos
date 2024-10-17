import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/services/supplier_service.dart';
import 'package:pos/utils/alerts/dialog_alert.dart';

class AddSupplierForm extends StatefulWidget {
  @override
  _AddSupplierForm createState() => _AddSupplierForm();
}

class _AddSupplierForm extends State<AddSupplierForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final SupplierService supplierService = SupplierService();

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
              controller: companyController,
              decoration: InputDecoration(
                labelText: 'Company',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the company name';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: contactController,
              decoration: InputDecoration(
                labelText: 'Contact',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter contact';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String company = companyController.text;
                  String contact = contactController.text;

                  bool success = await supplierService.registerSupplier(company, contact);
                  if (success) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialogAlert(
                          context: context, 
                          title: 'Success', 
                          content: 'The supplier has been added successfully', 
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
                          content: 'Failed to create supplier', 
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
                  'Create Supplier',
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
