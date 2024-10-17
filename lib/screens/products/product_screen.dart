import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/components/cards/product_card.dart'; 
import 'package:pos/models/products.dart';
import 'package:pos/services/product_service.dart'; 
import 'package:pos/utils/alerts/dialog_alert.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductService productService = ProductService();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    products = await productService.getProducts(); 
    setState(() {});
  }

  void _editProduct(Product product) {
    Navigator.pushNamed(context, '/product/edit', arguments: product).then((_) {
      _loadProducts(); 
    });
  }

  void _deleteProduct(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogAlert(
          context: context, 
          title: 'Delete product?', 
          content: 'Are you sure you want to delete this category?', 
          confirmButtonText: 'Delete', 
          onConfirm: () { 
            productService.deleteProduct(product);
            _loadProducts(); 
            Navigator.pop(context);
          },
          onCancel: () => Navigator.pop(context),
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
          'Productos',
          style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/product/add').then((_) {
                _loadProducts();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: products.isEmpty
            ? Center(
                child: Text(
                  'No hay productos disponibles.',
                  style: GoogleFonts.montserrat(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    title: product.name,
                    category: product.category,
                    onEdit: () => _editProduct(product), 
                    onDelete: () => _deleteProduct(product), 
                  );
                },
              ),
      ),
    );
  }
}
