import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/models/user.dart';
import 'package:pos/screens/categories/edit_category_screen.dart';
import 'package:pos/screens/suppliers/add_supplier_screen.dart';
import 'package:pos/screens/suppliers/edit_supplier_screen.dart';
import 'package:pos/screens/suppliers/supplier_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/sales_screen.dart';
import 'screens/register_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/categories/category_screen.dart';
import 'screens/categories/add_categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var userBox = await Hive.openBox('userBox');
  var categoryBox = await Hive.openBox('categoryBox');
  var supplierBox = await Hive.openBox('supplyBox');
  
  if (userBox.isEmpty) {
    User defaultUser = User(username: 'admin', password: 'admin123', role: 'Admin');
    await userBox.put(defaultUser.username, defaultUser.toMap());
  }
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/dashboard',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/sales': (context) => SalesScreen(),
        '/register': (context) => const RegisterScreen(),
        '/inventory': (context) => const InventoryScreen(),
        '/category': (context) => CategoryScreen(),
        '/category/add': (context) => const AddCategoriesScreen(),
        '/category/edit': (context) => EditCategoryScreen(),
        '/supplier': (context) => SupplierScreen(),
        '/supplier/add': (context) => const AddSupplierScreen(),
        '/supplier/edit': (context) =>  EditSupplierScreen(),

      },
    );
  }
}
