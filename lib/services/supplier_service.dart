import 'package:hive/hive.dart';
import 'package:pos/models/supplier.dart';
import '../models/category.dart';
import 'package:pos/utils/alerts/dialog_alert.dart';

class SupplierService {
  final Box supplierBox;

  SupplierService() : supplierBox = Hive.box('supplyBox');

  Future<bool> registerSupplier(String company, String contact) async {
    try {
      company = company.trim();
      bool supplierExists = supplierBox.values.any((element) {
        final existingSupplier = Supplier.fromMap(Map<String, dynamic>.from(element));
        return existingSupplier.company.toLowerCase() == company.toLowerCase(); 
      });

      if (supplierExists) {
        return false; 
      }

      final supplier = Supplier(company: company, contact: contact);
      await supplierBox.add(supplier.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Supplier> getSupplier() {
    return supplierBox.values
        .map((e) => Supplier.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> deleteSupplier(Supplier supplier) async {
    final index = supplierBox.values.toList().indexWhere(
      (element) => Supplier.fromMap(Map<String, dynamic>.from(element)).company == supplier.company,
    );

    if (index != -1) {
      await supplierBox.deleteAt(index);
    }
  }

  Future<bool> updateSupplier(Supplier oldSupplier, Supplier newSupplier) async {
    final newName = newSupplier.company.trim();

    bool supplierExists = supplierBox.values.any((element) {
      final existingCategory = Supplier.fromMap(Map<String, dynamic>.from(element));
      return existingCategory.company.toLowerCase() == newName.toLowerCase() && 
            existingCategory.company.toLowerCase() != oldSupplier.company.toLowerCase();
    });

    if (supplierExists) {
      return false; 
    }

    final index = supplierBox.values.toList().indexWhere(
      (element) => Supplier.fromMap(Map<String, dynamic>.from(element)).company.toLowerCase() == oldSupplier.company.toLowerCase(),
    );

    if (index != -1) {
      await supplierBox.putAt(index, newSupplier.toMap());
      return true; 
    }
    
    return false; 
  }

  Supplier? getSupplierByName(String companyName) {
    try {
      return supplierBox.values
          .map((e) => Supplier.fromMap(Map<String, dynamic>.from(e)))
          .cast<Supplier?>()
          .firstWhere(
            (supplier) => supplier?.company.toLowerCase() == companyName.toLowerCase(),
            orElse: () => null, // Retorna null si no encuentra el proveedor
          );
    } catch (e) {
      return null;
    }
  }
}
