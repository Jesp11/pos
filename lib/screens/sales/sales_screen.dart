import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/models/products.dart';
import 'package:pos/screens/sales/sale_datail_screen.dart';
import 'package:pos/services/product_service.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final ProductService productService = ProductService();
  List<Product> products = [];
  Map<Product, int> selectedProducts = {}; // Para almacenar la cantidad seleccionada

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    products = await productService.getProducts();
    setState(() {});
  }

  void _incrementProduct(Product product) {
    setState(() {
      selectedProducts[product] = (selectedProducts[product] ?? 0) + 1;
    });
  }

  void _decrementProduct(Product product) {
    setState(() {
      if ((selectedProducts[product] ?? 0) > 0) {
        selectedProducts[product] = selectedProducts[product]! - 1;
      }
    });
  }

  double _getTotalAmount() {
    double total = 0.0;
    selectedProducts.forEach((product, quantity) {
      total += product.price * quantity; // Sumar el precio de cada producto por la cantidad
    });
    return total;
  }

  void _goToDetailScreen() {
    if (_getTotalAmount() > 0) { // Solo navega si hay productos seleccionados
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaleDetailScreen(selectedProducts: selectedProducts),
        ),
      );
    } else {
      // Mostrar un mensaje si no hay productos seleccionados
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, selecciona al menos un producto.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text(
          'Ventas',
          style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: GoogleFonts.montserrat(fontSize: 18),
                              ),
                              Text(
                                'Precio: \$${product.price.toStringAsFixed(2)}',
                                style: GoogleFonts.montserrat(fontSize: 14),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () => _decrementProduct(product),
                                  ),
                                  Text('${selectedProducts[product] ?? 0}'),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () => _incrementProduct(product),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Costo Total: ${_getTotalAmount().toStringAsFixed(2)}',
              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16), // Espacio entre el costo total y el botón
            SizedBox(
              width: double.infinity, // Hacer el botón más ancho
              child: ElevatedButton(
                onPressed: _goToDetailScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Color de fondo del botón
                  padding: EdgeInsets.symmetric(vertical: 16), // Aumentar el padding vertical
                ),
                child: Text(
                  'Proceder', // Solo texto "Proceder" en el botón
                  style: TextStyle(fontSize: 20, color: Colors.white), // Tamaño de fuente
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
