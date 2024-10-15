import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/models/user.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/sales_screen.dart';
import 'screens/register_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var userBox = await Hive.openBox('userBox');
  //await userBox.clear();
  if(userBox.isEmpty){
    User defaultUser = User(username: 'admin', password: 'admin123', role: 'Admin');
    await userBox.put(defaultUser.username, defaultUser.toMap());
  }
  runApp(MainApp());
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
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
