import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/components/forms/supplier/edit_supplier_form.dart';
import 'package:pos/models/supplier.dart';

class EditSupplierScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final Supplier supplier = ModalRoute.of(context)!.settings.arguments as Supplier;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Edit Supplier', style: GoogleFonts.montserrat()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'Edit Category',
              style: GoogleFonts.montserrat(fontSize: 35, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EditSupplierForm(supplier: supplier),
            ),
          ],
        ),
      ),
    );
  }
}
