import 'package:flutter/material.dart';
import 'package:pos/components/cards/dashboard_card.dart';
import 'package:pos/screens/inventory/inventory_screen.dart';
import 'package:pos/screens/products/product_screen.dart';
import 'package:pos/screens/report/ticket_screen.dart';
import 'package:pos/screens/sales/sales_screen.dart';
import 'package:pos/screens/suppliers/supplier_screen.dart';
import '../categories/category_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../user/login_screen.dart'; 

class DashboardScreen extends StatelessWidget {
  
  final List<Map<String, dynamic>> cards = [
    {'title': 'Tickets', 'icon': FontAwesomeIcons.fileLines, 'number': 1, 'screen': TicketScreen()},
    {'title': 'Sales Screen', 'icon': FontAwesomeIcons.cartShopping, 'number': 2, 'screen': SalesScreen()},
    {'title': 'Products', 'icon': FontAwesomeIcons.boxOpen, 'number': 3, 'screen': ProductScreen()},
    {'title': 'Categories', 'icon': FontAwesomeIcons.tags, 'number': 4, 'screen': CategoryScreen()},
    {'title': 'Store', 'icon': FontAwesomeIcons.store, 'number': 5, 'screen': InventoryScreen()},
    {'title': 'Suppliers', 'icon': FontAwesomeIcons.truck, 'number': 6, 'screen': SupplierScreen()},
    {'title': 'Log Out', 'icon': FontAwesomeIcons.rightFromBracket, 'number': 7},
    //{'title': 'Users', 'icon': FontAwesomeIcons.users, 'number': 8},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            childAspectRatio: 1, 
          ),
          children: cards.map((card) {
            return DashboardCard(
              title: card['title'],
              icon: card['icon'], 
              onTap: () {
                if (card['number'] == 7) {
                  _logout(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => card['screen'] ?? Container(),
                    ),
                  );
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
