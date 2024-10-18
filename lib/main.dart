import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/models/user.dart';
import 'package:pos/screens/categories/edit_category_screen.dart';
import 'package:pos/screens/inventory/inventory_screen.dart';
import 'package:pos/screens/products/add_product_screen.dart';
import 'package:pos/screens/products/product_screen.dart';
import 'package:pos/screens/report/ticket_screen.dart';
import 'package:pos/screens/sales/sale_datail_screen.dart';
import 'package:pos/screens/sales/sales_screen.dart';
import 'package:pos/screens/suppliers/add_supplier_screen.dart';
import 'package:pos/screens/suppliers/edit_supplier_screen.dart';
import 'package:pos/screens/suppliers/supplier_screen.dart';
import 'screens/user/login_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/user/register_screen.dart';
import 'screens/categories/category_screen.dart';
import 'screens/categories/add_categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var userBox = await Hive.openBox('userBox');
  var categoryBox = await Hive.openBox('categoryBox');
  var supplierBox = await Hive.openBox('supplyBox');
  var ticketBox = await Hive.openBox('ticketBox');
  var productBox = await Hive.openBox('productBox');
  
    User defaultUser = User(username: 'poncess', password: 'admin123', role: 'Admin');
    await userBox.put(defaultUser.username, defaultUser.toMap());
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/sales': (context) => SalesScreen(),
        '/sales/detail': (context) => SaleDetailScreen(selectedProducts: {},),
        '/register': (context) => const RegisterScreen(),
        '/product': (context) => ProductScreen(),
        '/product/add': (context) => const AddProductsScreen(),
        '/product/edit': (context) => const AddProductsScreen(),
        '/category': (context) => CategoryScreen(),
        '/category/add': (context) => const AddCategoriesScreen(),
        '/category/edit': (context) => EditCategoryScreen(),
        '/supplier': (context) => SupplierScreen(),
        '/supplier/add': (context) => const AddSupplierScreen(),
        '/supplier/edit': (context) =>  EditSupplierScreen(),
        '/inventory': (context) => InventoryScreen(),
        '/ticket': (context) => TicketScreen(),

      },
    );
  }
}
