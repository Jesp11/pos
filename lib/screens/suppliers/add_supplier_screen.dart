import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/components/forms/supplier/add_supplier_form.dart';

class AddSupplierScreen extends StatelessWidget {
  const AddSupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Add Supplier', style: GoogleFonts.montserrat()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'New Supplier',
              style: GoogleFonts.montserrat(fontSize: 35, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            AddSupplierForm(),
          ],
        ),
      ),
    );
  }
}
