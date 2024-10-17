import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pos/models/supplier.dart';

class SupplierDropdown extends StatefulWidget {
  @override
  _SupplierDropdownState createState() => _SupplierDropdownState();
}

class _SupplierDropdownState extends State<SupplierDropdown> {
  List<Supplier> suppliers = [];
  Supplier? selectedSupplier;

  @override
  void initState() {
    super.initState();
    loadSuppliers();
  }

  Future<void> loadSuppliers() async {
    final supplierBox = Hive.box('supplierBox');
    setState(() {
      suppliers = supplierBox.values
          .map((e) => Supplier.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Supplier>(
      hint: Text("Selecciona un proveedor"),
      value: selectedSupplier,
      onChanged: (Supplier? newValue) {
        setState(() {
          selectedSupplier = newValue;
        });
      },
      items: suppliers.map((Supplier supplier) {
        return DropdownMenuItem<Supplier>(
          value: supplier,
          child: Text(supplier.company),
        );
      }).toList(),
    );
  }
}
