import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/components/cards/supplier_card.dart';
import 'package:pos/models/supplier.dart';
import 'package:pos/services/supplier_service.dart';
import 'package:pos/utils/alerts/dialog_alert.dart';

class SupplierScreen extends StatefulWidget {
  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  final SupplierService supplierService = SupplierService();
  List<Supplier> suppliers = [];

  @override
  void initState() {
    super.initState();
    _loadSuppliers();
  }

  Future<void> _loadSuppliers() async {
    suppliers = supplierService.getSupplier(); 
    setState(() {}); // Esto actualiza la UI  
  }

  void _editSupplier(Supplier supplier) {
    Navigator.pushNamed(context, '/supplier/edit', arguments: supplier).then((_) {
      _loadSuppliers(); 
    });
  }

  void _deleteSupplier(Supplier supplier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogAlert(
          context: context, 
          title: 'Delete Supplier?', 
          content: 'Are you sure you want to delete this supplier?', 
          confirmButtonText: 'Delete', 
          onConfirm: () { 
            supplierService.deleteSupplier(supplier);
            _loadSuppliers(); 
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
        'Suppliers',
        style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/supplier/add').then((_) {
              _loadSuppliers(); // Actualiza la lista al regresar
            });
          },
        ),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: suppliers.isEmpty
          ? Center(
              child: Text(
                'No suppliers available.',
                style: GoogleFonts.montserrat(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: suppliers.length,
              itemBuilder: (context, index) {
                final supplier = suppliers[index];
                return SupplierCard(
                  title: supplier.company,
                  description: supplier.contact,
                  onEdit: () => _editSupplier(supplier), 
                  onDelete: () => _deleteSupplier(supplier), 
                );
              },
            ),
    ),
  );
}

}
